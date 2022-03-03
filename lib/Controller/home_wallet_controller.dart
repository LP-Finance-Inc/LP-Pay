import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lp_finance/Controller/wallet_controller.dart';
import 'package:lp_finance/modules/wallet/common/scan_qr.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
export 'package:sizer/sizer.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'data_controller.dart';

class HomeWalletController extends GetxController {
  var lpCADBalance = "lpCAD Balance:".obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingForActive = false.obs;
  var select = false.obs;
  var passwordError = "".obs;
  var qrError = "".obs;
  var initialOpacity = 0.5.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController txtController =
      TextEditingController(text: bip39.generateMnemonic());
  DataController dataController = Get.find();
  final WalletController walletController = Get.find();

  var qrData = "".obs;

  var dropdownValue = 'lpCAD,assets/icons/lpcad.svg'.obs;

  @override
  void onInit() {
    super.onInit();
    // walletController.client = SolanaClient(
    //   rpcUrl: Uri.parse("https://api.devnet.solana.com"),
    //   websocketUrl: Uri.parse("ws://api.devnet.solana.com"),
    // );
    // walletController.client.requestAirdrop(
    //     lamports: 1000000000,
    //     address: "xAVZxeMF7Wihi7nYippFoNuG5MwbfzXvfYYzP6H5b3E");
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onRefresh() async {
    print("refresh called");
    await refreshAccount(walletController.wallet.address);
    refreshController.refreshCompleted();
  }

  // void onLoading() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   refreshController.loadComplete();
  // }

  Future<Barcode> scanQrPay() async {
    return await Get.to(ScanQrPage());
  }

  Future<bool?> makeQr(String amount, String type) async {
    qrData.value = amount +
        "," +
        type +
        "," +
        dataController
            .walletModelList[dataController.activeWallet.value].address! +
        "," +
        dataController
            .walletModelList[dataController.activeWallet.value].token![0].mint;

    return false;
  }

  Future<bool?> makeTransaction({required String qrData}) async {
    isLoading(true);
    walletController.client = SolanaClient(
      rpcUrl: Uri.parse("https://api.devnet.solana.com"),
      websocketUrl: Uri.parse("ws://api.devnet.solana.com"),
    );

    bool addressIsOk =
        transactionAddressValidator(qrData.split(',')[2]) == null;
    bool amountIsOK = transactionAmountValidator(qrData.split(',')[0]) == null;

    if (addressIsOk && amountIsOK) {
      await walletController.sendTransaction(
        amount: double.parse(qrData.split(',')[0]),
        isSol: qrData.split(',')[1] == "Solana" ? true : false,
        destination: qrData.split(',')[2],
        senderWallet:
            dataController.walletModelList[dataController.activeWallet.value],
      );
      isLoading(false);
      Get.back();
      print("done");
      Get.snackbar('Congrats', "Payment Successful",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(bottom: 100),
          backgroundColor: Colors.grey[900]);

      return true;
    }
    isLoading(false);

    return true;
  }

  activeWallet(String mnemonic) async {
    walletController.makeActiveWallet(mnemonic: mnemonic);
  }

  Future<bool> refreshAccount(String address) async {
    walletController.client = SolanaClient(
      rpcUrl: Uri.parse("https://api.devnet.solana.com"),
      websocketUrl: Uri.parse("ws://api.devnet.solana.com"),
    );
    await walletController.refreshBalanceByPull(address: address);

    return true;
  }

  // Verify the amount sent
  String? transactionAmountValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty ammount';
    }
    try {
      if (double.parse(value) <= 0) {
        return 'You must send at least 0.000000001';
      } else {
        return null;
      }
    } on FormatException {
      return 'Invalid amount';
    }
  }

  // Verify the amount receive QR
  String? qrAmountValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'amount cannot be empty';
    }

    if (double.parse(value) <= 0) {
      return 'You must receive at least 0.000000001';
    }
    return "";
  }

  String? transactionAddressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty address';
    }
    if (value.length < 43 || value.length > 50) {
      return 'Address length is not correct';
    } else {
      return null;
    }
  }
}
