// import 'dart:async';
// import 'package:lp_finance/models/wallet_model.dart';
// import 'package:solana/dto.dart';
// import 'package:solana/solana.dart';
// import 'package:solana/metaplex.dart';
//
// class BaseAccount {
//   // final NetworkUrl url;
//   late String name;
//   late bool isLoaded = true;
//   late SolanaClient client;
//   late String address;
//   late double balance = 0;
//   late double usdBalance = 0;
//   late TokenTrackers tokensTracker;
//   late List<TransactionDetails> transactions = [];
//   // late List<Token> tokens = [];
//   final itemsLoaded = <AccountItem, bool>{};
//
//   BaseAccount(this.balance, this.name);
//
//   /*
//    * Determine if an item of this account, e.g, if token are loaded
//    */
//   bool isItemLoaded(AccountItem item) {
//     return itemsLoaded[item] != null;
//   }
//
//   /*
//    * Get a token by it's mint address
//    */
//   // Token getTokenByMint(String mint) {
//   //   return tokens.firstWhere((token) => token.mint == mint);
//   // }
//
//   /*
//    * Refresh the account balance
//    */
//   Future<void> refreshBalance() async {
//     int balance = await client.rpcClient
//         .getBalance(address, commitment: Commitment.confirmed);
//
//     this.balance = balance.toDouble() / lamportsPerSol;
//     itemsLoaded[AccountItem.solBalance] = true;
//
//     usdBalance =
//         this.balance * tokensTracker.getTokenValue(SystemProgram.programId);
//
//     itemsLoaded[AccountItem.usdBalance] = true;
//
//     // for (final token in tokens) {}
//   }
//
//   /*
//    * Loads all the tokens (spl-program mints) owned by this account
//    */
//   Future<void> loadTokens() async {
//     tokens = [];
//
//     final completer = Completer();
//
//     // Get all the tokens owned by the account
//     final tokenAccounts = await client.rpcClient.getTokenAccountsByOwner(
//       address,
//       const TokenAccountsFilter.byProgramId(TokenProgram.programId),
//       commitment: Commitment.confirmed,
//       encoding: Encoding.jsonParsed,
//     );
//
//     int unknownN = 0;
//     int notOwnedNFTs = 0;
//
//     for (final tokenAccount in tokenAccounts) {
//       ParsedAccountData? data = tokenAccount.account.data as ParsedAccountData?;
//
//       if (data != null) {
//         data.when(
//           splToken: (data) {
//             data.when(
//                 account: (mintData, type, accountType) {
//                   String tokenMint = mintData.mint;
//                   String? uiBalance = mintData.tokenAmount.uiAmountString;
//                   double balance = double.parse(uiBalance ?? "0");
//
//                   String defaultName = "Unknown $unknownN";
//                   TokenInfo defaultTokenInfo = TokenInfo(
//                     name: defaultName,
//                     symbol: defaultName,
//                   );
//
//                   // // Start tracking the token
//                   // TokenInfo tokenInfo = tokensTracker.addTrackerByProgramMint(
//                   //   tokenMint,
//                   //   defaultValue: defaultTokenInfo,
//                   // );
//                   //
//                   // if (defaultTokenInfo.name != tokenInfo.name) {
//                   //   unknownN++;
//                   // }
//
//                   // Add the token to this account
//                   client.rpcClient
//                       .getMetadata(mint: tokenMint)
//                       .then((value) async {
//                     try {
//                       // ImageInfo imageInfo =
//                       //     await getImageFromUri(value!.uri) as ImageInfo;
//                       if (balance > 0) {
//                         // tokens
//                         //     .add(NFT(balance, tokenMint, tokenInfo, imageInfo));
//                       } else {
//                         notOwnedNFTs++;
//                       }
//                     } catch (_) {
//                       // tokens.add(Token(balance, tokenMint, tokenInfo));
//                     } finally {
//                       if (tokens.length + notOwnedNFTs ==
//                           tokenAccounts.length) {
//                         itemsLoaded[AccountItem.tokens] = true;
//                         completer.complete();
//                       }
//                     }
//                   });
//                 },
//                 mint: (_, __, ___) {},
//                 unknown: (_) {});
//           },
//           unsupported: (_) {},
//           stake: (_) {},
//         );
//       }
//     }
//
//     if (tokenAccounts.isEmpty) {
//       itemsLoaded[AccountItem.tokens] = true;
//       completer.complete();
//     }
//
//     return completer.future;
//   }
//
//   /*
//    * Load the Address's transactions into the account
//    */
//   // Future<void> loadTransactions() async {
//   //   transactions = [];
//   //
//   //   try {
//   //     final response = await client.rpcClient.getTransactionsList(
//   //       address,
//   //       commitment: Commitment.confirmed,
//   //     );
//   //
//   //     for (final tx in response) {
//   //       final message = tx.transaction.message;
//   //
//   //       for (final instruction in message.instructions) {
//   //         if (instruction is ParsedInstruction) {
//   //           instruction.map(
//   //             system: (data) {
//   //               data.parsed.map(
//   //                 transfer: (data) {
//   //                   ParsedSystemTransferInformation transfer = data.info;
//   //                   bool receivedOrNot = transfer.destination == address;
//   //                   double ammount =
//   //                       transfer.lamports.toDouble() / lamportsPerSol;
//   //
//   //                   transactions.add(
//   //                     TransactionDetails(
//   //                       transfer.source,
//   //                       transfer.destination,
//   //                       ammount,
//   //                       receivedOrNot,
//   //                       SystemProgram.programId,
//   //                       tx.blockTime!,
//   //                     ),
//   //                   );
//   //                 },
//   //                 transferChecked: (_) {},
//   //                 unsupported: (_) {
//   //                   transactions.add(UnsupportedTransaction(tx.blockTime!));
//   //                 },
//   //               );
//   //             },
//   //             splToken: (data) {
//   //               data.parsed.map(
//   //                 transfer: (data) {},
//   //                 transferChecked: (data) {},
//   //                 generic: (data) {},
//   //               );
//   //             },
//   //             memo: (_) {},
//   //             unsupported: (a) {
//   //               transactions.add(UnsupportedTransaction(tx.blockTime!));
//   //             },
//   //           );
//   //         }
//   //       }
//   //     }
//   //   } catch (err) {}
//   //
//   //   itemsLoaded[AccountItem.transactions] = true;
//   // }
// }
//
// enum AccountItem {
//   tokens,
//   usdBalance,
//   solBalance,
//   transactions,
// }
//
// /*
//  * Centralized token trackers list
//  */
// class TokenTrackers {
//   // List of Token trackers
//   late Map<String, Tracker> trackers = {
//     SystemProgram.programId: Tracker('solana', SystemProgram.programId, "SOL"),
//   };
//
//   //late Map<String, TokenInfo> tokensList = {};
//
//   // Future<void> loadTokenList() async {
//   //   var tokensFile = await rootBundle.loadString('assets/tokens_list.json');
//   //   Map tokensList = json.decode(tokensFile);
//   //   for (final token in tokensList["tokens"]) {
//   //     this.tokensList[token['address']] = TokenInfo.withInfo(
//   //         token["address"], token["name"], token["logoURI"], token["symbol"]);
//   //   }
//   // }
//
//   double getTokenValue(String programMint) {
//     Tracker? token = trackers[programMint];
//     if (token != null) {
//       return token.usdValue;
//     } else {
//       return 0;
//     }
//   }
//
//   Tracker? getTracker(String programMint) {
//     return trackers[programMint];
//   }
//
//   void setTokenValue(String programMint, double usdValue) {
//     Tracker? token = trackers[programMint];
//     if (token != null) {
//       token.usdValue = usdValue;
//     }
//   }
//
//   // TokenInfo? getTokenInfo(String programId) {
//   //   if (tokensList.containsKey(programId)) {
//   //     return tokensList[programId]!;
//   //   }
//   //   return null;
//   // }
//
//   // TokenInfo addTrackerByProgramMint(String programMint,
//   //     {required TokenInfo defaultValue}) {
//   //   TokenInfo tokenInfo = getTokenInfo(programMint) ?? defaultValue;
//   //
//   //   // Add tracker if doesn't exist yet
//   //   if (!trackers.containsKey(programMint)) {
//   //     trackers[programMint] =
//   //         Tracker(tokenInfo.name, programMint, tokenInfo.symbol);
//   //   }
//   //
//   //   return tokenInfo;
//   // }
// }
//
// class Tracker {
//   String name;
//   String programMint;
//   double usdValue = 0;
//   String symbol;
//
//   Tracker(this.name, this.programMint, this.symbol);
// }
