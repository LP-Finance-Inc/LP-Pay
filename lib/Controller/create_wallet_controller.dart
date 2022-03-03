import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lp_finance/Controller/data_controller.dart';

import 'package:lp_finance/Controller/wallet_controller.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana/metaplex.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hive_flutter/adapters.dart';
import '../models/wallet_db_model.dart';

class CreateWalletController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var screenTitle = "Hey, Good morning !".obs;
  RxBool isLoading = false.obs;
  var select = false.obs;
  final TextEditingController txtController =
      TextEditingController(text: bip39.generateMnemonic());
  AnimationController? controller;
  late Animation<double> offsetAnimation;
  final WalletController walletController = Get.find();
  DataController dataController = Get.find();

  void onClickRadioButton() {
    select.value = !select.value;
    update();
  }

  final _hiveBox = Hive.box('data');
  @override
  void onInit() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller!.reverse();
        }
      });

    super.onInit();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Future<void> createWallet(String secretPhrase) async {
    walletController.client = SolanaClient(
      rpcUrl: Uri.parse("https://api.devnet.solana.com"),
      websocketUrl: Uri.parse("ws://api.devnet.solana.com"),
    );

    print(secretPhrase);
    await walletController.loadKeyPair(mnemonic: secretPhrase);
    print(walletController.address);

    await walletController.client.requestAirdrop(
        lamports: 1000000000, address: walletController.address);

    await walletController.client.createAssociatedTokenAccount(
        mint: "ECUdbMpm7z1Z6G32hNRctjVPP8DcSq2NheuVErR3qZt3",
        funder: walletController.keyPair);

    await walletController.refreshBalance(address: walletController.address);

    await walletController.loadTokens();
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

    await _hiveBox.put("wallet_" + walletController.address, walletDbModel);

    return true;
  }
}
