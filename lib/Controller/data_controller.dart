import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lp_finance/models/wallet_db_model.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:shared_preferences/shared_preferences.dart';
import '../app_bindings.dart';
import '../modules/auth_module/models/login_model.dart';
import 'package:hive_flutter/adapters.dart';

class DataController extends GetxController {
  final TextEditingController popupNameController = TextEditingController();
  final TextEditingController popupPasswordController = TextEditingController();

  var verifFirstname = "".obs;
  var veriflasttname = "".obs;
  var verifemail = "".obs;
  var isverfied = 0.obs;
  var activeAgo = "0 minutes ago".obs;
  RxInt activeWallet = RxInt(-1);
  var walletModelList = <WalletDbModel>[].obs;
  LoginModel? loginModel = LoginModel();
  RxBool isLogin = false.obs;

  RxBool isBiometricEnabled = false.obs;

  final masterKey = encrypt.Key.fromUtf8(
    String.fromEnvironment("secureKey",
        defaultValue: "weAreFloeinAndBatterThanYouBlock"),
  );
  final iv = encrypt.IV.fromLength(16);

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    final _hiveBox = Hive.box('data');
    _hiveBox.clear();

    AppBindings? _appBindings;
    isLogin.value = false;
    Get.reset();
    _appBindings = AppBindings();
    _appBindings.initAll();
    update();
  }
}
