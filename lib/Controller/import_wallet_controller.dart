import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lp_finance/Controller/data_controller.dart';
import 'package:lp_finance/Controller/wallet_controller.dart';
import 'package:lp_finance/models/wallet_db_model.dart';
import 'package:solana/solana.dart';
import 'package:hive_flutter/adapters.dart';

class ImportWalletController extends GetxController {
  String secretPhrase = "";
  final TextEditingController txtController = TextEditingController();

  DataController dataController = Get.find();
  RxBool isLoading = false.obs;
  final WalletController walletController = Get.find();

  final _hiveBox = Hive.box('data');

  Future<bool> importWallet(String mnemonic) async {
    print(mnemonic);

    walletController.client = SolanaClient(
      rpcUrl: Uri.parse("https://api.devnet.solana.com"),
      websocketUrl: Uri.parse("ws://api.devnet.solana.com"),
    );

    await walletController.loadKeyPair(mnemonic: mnemonic);
    await _hiveBox.delete('wallet_' + walletController.address);

    if (await checkDb()) {
      isLoading(false);
      update();
      return false;
    }

    print(walletController.address);

    await walletController.loadTokens();

    print(walletController.tokens.length);

    if (walletController.tokens.length < 1) {
      await walletController.client.requestAirdrop(
          lamports: 1000000000, address: walletController.address);

      await walletController.client.createAssociatedTokenAccount(
          mint: "ECUdbMpm7z1Z6G32hNRctjVPP8DcSq2NheuVErR3qZt3",
          funder: walletController.keyPair);
    }

    print(walletController.tokens.length);

    await walletController.refreshBalance(address: walletController.address);
    await walletController.loadTransactions();
    isLoading(false);
    update();
    return true;
  }

  Future<bool> checkDb() async {
    WalletDbModel? wallet =
        await _hiveBox.get('wallet_' + walletController.address);
    if (wallet == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> saveToDb(
      {required String name, required String password}) async {
    print(walletController.tokens.length);
    final walletDbModel = WalletDbModel(
      name: name,
      password: password,
      address: walletController.address,
      balance: walletController.balance.toString(),
      usdBalance: walletController.usdBalance.toString(),
      token: walletController.tokens,
      wallet: walletController.encryptedMnemonic,
    );

    dataController.walletModelList.add(walletDbModel);

    print(json.encode(walletDbModel));

    await _hiveBox.put("wallet_" + walletController.address, walletDbModel);

    return true;
  }
}
