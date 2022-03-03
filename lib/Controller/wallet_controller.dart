import 'dart:async';

import 'package:get/get.dart';
import 'package:lp_finance/Controller/data_controller.dart';
import 'package:lp_finance/models/wallet_db_model.dart';
import 'package:lp_finance/models/wallet_model.dart';
import 'package:solana/dto.dart' show Commitment, ProgramAccount;
import 'package:solana/encoder.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana/metaplex.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:worker_manager/worker_manager.dart';
import 'package:encrypt/encrypt.dart';

import '../models/token_list.dart';

class WalletController extends GetxController {
  var screenTitle = "Hey, Good morning !".obs;
  RxBool isFocus = false.obs;

  late Wallet wallet;
  late String address;
  late var balance;
  late var usdBalance;
  late List<TransactionDetail> transactions = [];
  late TokenTrackers tokensTracker;
  late List<TokenList> tokens = [];
  late SolanaClient client;
  late Ed25519HDKeyPair keyPair;
  late String encryptedMnemonic;
  DataController dataController = Get.find();

  Future<void> loadKeyPair({
    required String mnemonic,
  }) async {
    keyPair = await Executor().execute(
      arg1: mnemonic,
      fun1: createKeyPair,
    );

    wallet = keyPair;
    address = wallet.address;
    encryptedMnemonic = encryptMnemonic(mnemonic);
  }

  Future<void> makeActiveWallet({
    required String mnemonic,
  }) async {
    keyPair = await Executor().execute(
      arg1: decryptMnemonic(mnemonic),
      fun1: createKeyPair,
    );

    wallet = keyPair;
    address = wallet.address;
  }

  String encryptMnemonic(String mnemonic) {
    final encrypter = Encrypter(AES(dataController.masterKey));

    return encrypter.encrypt(mnemonic, iv: dataController.iv).base64;
  }

  String decryptMnemonic(String mnemonic) {
    final encrypter = Encrypter(AES(dataController.masterKey));

    return encrypter.decrypt(
      Encrypted.fromBase64(mnemonic),
      iv: dataController.iv,
    );
  }

  Future<void> refreshBalance({required String address}) async {
    int _balance = await client.rpcClient
        .getBalance(address, commitment: Commitment.confirmed);

    this.balance = _balance.toDouble() / lamportsPerSol;
    usdBalance = 0;

    //client.rpcClient.getTokenAccountBalance(pubKey)
  }

  Future<void> refreshBalanceByPull({required String address}) async {
    int _balance = await client.rpcClient
        .getBalance(address, commitment: Commitment.confirmed);

    this.balance = _balance.toDouble() / lamportsPerSol;
    usdBalance = 0;
    print(balance);

    final tokenAccounts = await client.rpcClient.getTokenAccountsByOwner(
      address,
      const TokenAccountsFilter.byProgramId(TokenProgram.programId),
      commitment: Commitment.confirmed,
      encoding: Encoding.jsonParsed,
    );

    ParsedAccountData? data =
        tokenAccounts[0].account.data as ParsedAccountData?;

    if (data != null) {
      data.when(
          splToken: (data) {
            data.when(
                account: (mintData, type, accountType) {
                  String tokenMint = mintData.mint;
                  String? uiBalance = mintData.tokenAmount.uiAmountString;
                  double balanceToken = double.parse(uiBalance ?? "0");
                  print("lpCad Balance  " + balanceToken.toString());

                  dataController
                      .walletModelList[dataController.activeWallet.value]
                      .balance = this.balance.toString();
                  dataController
                      .walletModelList[dataController.activeWallet.value]
                      .token![0]
                      .balance = balanceToken;
                  dataController.walletModelList.refresh();
                },
                unknown: (String type) {},
                mint: (MintAccountDataInfo info, String type,
                    String? accountType) {});
          },
          stake: (StakeProgramAccountData parsed) {},
          unsupported: (Map<String, dynamic> parsed) {});
    }
  }

  // Future<void> loadUSDValues() async {
  //   List<String> tokenNames = tokensTracker.trackers.values
  //       .where((e) => !e.name.contains("Unknown"))
  //       .map((e) => e.name.toLowerCase())
  //       .toList();
  //
  //   Map<String, double> usdValues = await getTokenUsdValue(tokenNames);
  //
  //   for (var tracker in tokensTracker.trackers.values) {
  //     double? usdValue = usdValues[tracker.name.toLowerCase()];
  //
  //     if (usdValue != null) {
  //       tokensTracker.setTokenValue(tracker.programMint, usdValue);
  //     }
  //   }
  //
  //   // for (final account in state.values) {
  //   //   await account.refreshBalance();
  //   // }
  // }

  Future<String> sendTransaction({
    required bool isSol,
    required double amount,
    required WalletDbModel senderWallet,
    required String destination,
  }) async {
    if (isSol) {
      // Convert SOL to lamport
      int lamports = (amount * lamportsPerSol).toInt();

      return await sendLamportsTo(
        destination,
        senderWallet,
        lamports,
      );
    } else {
      // Input by the user
      int userAmount = amount.toInt();
      // Token's configured decimals
      int tokenDecimals = 9;
      int _amount = int.parse('$userAmount${'0' * tokenDecimals}');

      return await sendSPLTokenTo(
        destination,
        senderWallet,
        senderWallet.token![0].mint,
        _amount,
        references: [],
      );
    }
  }

  Future<String> sendLamportsTo(
    String destinationAddress,
    WalletDbModel senderWallet,
    int amount, {
    List<String> references = const [],
  }) async {
    final instruction = SystemInstruction.transfer(
      source: senderWallet.address!,
      destination: destinationAddress,
      lamports: amount,
    );

    for (final reference in references) {
      instruction.accounts.add(
        AccountMeta(
          pubKey: reference,
          isWriteable: false,
          isSigner: false,
        ),
      );
    }

    final message = Message(
      instructions: [instruction],
    );

    final signature =
        await client.rpcClient.signAndSendTransaction(message, [wallet]);
    await refreshBalanceByPull(
      address: senderWallet.address!,
    );
    print(signature);
    return signature;
  }

  Future<String> sendSPLTokenTo(
    String destinationAddress,
    WalletDbModel senderWallet,
    String tokenMint,
    int amount, {
    List<String> references = const [],
  }) async {
    final associatedRecipientAccount = await client.getAssociatedTokenAccount(
      owner: destinationAddress,
      mint: tokenMint,
    );

    final associatedSenderAccount = await client.getAssociatedTokenAccount(
      owner: senderWallet.address!,
      mint: tokenMint,
    ) as ProgramAccount;

    final message = TokenProgram.transfer(
      source: associatedSenderAccount.pubkey,
      destination: associatedRecipientAccount!.pubkey,
      amount: amount,
      owner: senderWallet.address!,
    );

    for (final reference in references) {
      message.instructions.first.accounts.add(
        AccountMeta(
          pubKey: reference,
          isWriteable: false,
          isSigner: false,
        ),
      );
    }

    final signature =
        await client.rpcClient.signAndSendTransaction(message, [wallet]);
    await refreshBalanceByPull(
      address: senderWallet.address!,
    );
    return signature;
  }

  Future<void> loadTransactions() async {
    transactions = [];

    try {
      final response = await client.rpcClient.getTransactionsList(
        address,
        commitment: Commitment.confirmed,
      );

      for (final tx in response) {
        final message = tx.transaction.message;
        print(message);
        for (final instruction in message.instructions) {
          if (instruction is ParsedInstruction) {
            instruction.map(
              system: (data) {
                data.parsed.map(
                  transfer: (data) {
                    ParsedSystemTransferInformation transfer = data.info;
                    bool receivedOrNot = transfer.destination == address;
                    double ammount = transfer.lamports.toDouble() / 1000000000;

                    transactions.add(
                      TransactionDetail(
                        transfer.source,
                        transfer.destination,
                        ammount,
                        receivedOrNot,
                        SystemProgram.programId,
                        tx.blockTime!,
                      ),
                    );
                  },
                  transferChecked: (_) {},
                  unsupported: (_) {},
                );
              },
              splToken: (data) {
                data.parsed.map(
                  transfer: (data) {},
                  transferChecked: (data) {},
                  generic: (data) {},
                );
              },
              memo: (_) {},
              unsupported: (a) {
                //  transactions.add(UnsupportedTransaction(tx.blockTime!));
              },
            );
          }
        }
      }
    } catch (err) {}

    /*
   * Create the keys pair in Isolate to prevent blocking the main thread
   */
  }

  /*
   * Loads all the tokens (spl-program mints) owned by this account
   */
  Future<void> loadTokens() async {
    tokens.clear();
    final completer = Completer();
    // Get all the tokens owned by the account
    final tokenAccounts = await client.rpcClient.getTokenAccountsByOwner(
      address,
      const TokenAccountsFilter.byProgramId(TokenProgram.programId),
      commitment: Commitment.confirmed,
      encoding: Encoding.jsonParsed,
    );

    for (final tokenAccount in tokenAccounts) {
      ParsedAccountData? data = tokenAccount.account.data as ParsedAccountData?;

      if (data != null) {
        data.when(
          splToken: (data) {
            data.when(
                account: (mintData, type, accountType) {
                  String tokenMint = mintData.mint;
                  String? uiBalance = mintData.tokenAmount.uiAmountString;
                  double balance = double.parse(uiBalance ?? "0");
                  print("lpCad Balance  " + balance.toString());

                  print(mintData.mint);

                  client.rpcClient
                      .getMetadata(mint: tokenMint)
                      .then((value) async {
                    try {
                      tokens.add(TokenList(
                        usdBalance: 0,
                        balance: balance,
                        mint: tokenMint,
                      ));
                    } catch (_) {
                      tokens.add(TokenList(
                        usdBalance: 0,
                        balance: balance,
                        mint: tokenMint,
                      ));
                    } finally {
                      completer.complete();
                      // if (tokens.length + notOwnedNFTs ==
                      //     tokenAccounts.length) {
                      //   itemsLoaded[AccountItem.tokens] = true;
                      //   completer.complete();
                      // }
                    }
                  });
                },
                mint: (_, __, ___) {},
                unknown: (_) {});
          },
          unsupported: (_) {},
          stake: (_) {},
        );
      }
    }

    if (tokenAccounts.isEmpty) {
      completer.complete();
    }
    return completer.future;
  }

  static Future<Ed25519HDKeyPair> createKeyPair(String mnemonic) async {
    final Ed25519HDKeyPair keyPair =
        await Ed25519HDKeyPair.fromMnemonic(mnemonic);
    return keyPair;
  }
}

class TokenTrackers {
  // List of Token trackers
  late Map<String, Tracker> trackers = {
    SystemProgram.programId: Tracker('solana', SystemProgram.programId, "SOL"),
  };

  late Map<String, TokenInfo> tokensList = {};

  double getTokenValue(String programMint) {
    Tracker? token = trackers[programMint];
    if (token != null) {
      return token.usdValue;
    } else {
      return 0;
    }
  }

  Tracker? getTracker(String programMint) {
    return trackers[programMint];
  }

  void setTokenValue(String programMint, double usdValue) {
    Tracker? token = trackers[programMint];
    if (token != null) {
      token.usdValue = usdValue;
    }
  }

  TokenInfo? getTokenInfo(String programId) {
    if (tokensList.containsKey(programId)) {
      return tokensList[programId]!;
    }
    return null;
  }

  TokenInfo addTrackerByProgramMint(String programMint,
      {required TokenInfo defaultValue}) {
    TokenInfo tokenInfo = getTokenInfo(programMint) ?? defaultValue;

    // Add tracker if doesn't exist yet
    if (!trackers.containsKey(programMint)) {
      trackers[programMint] =
          Tracker(tokenInfo.name, programMint, tokenInfo.symbol);
    }

    return tokenInfo;
  }
}

class Tracker {
  String name;
  String programMint;
  double usdValue = 0;
  String symbol;

  Tracker(this.name, this.programMint, this.symbol);
}
