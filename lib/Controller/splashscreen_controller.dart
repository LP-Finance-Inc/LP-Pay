import 'dart:convert';
import 'package:get/get.dart';
import 'package:lp_finance/Controller/data_controller.dart';
import 'package:lp_finance/Widgets/drawer.dart';
import 'package:hive_flutter/adapters.dart';
import '../Widgets/time_ago.dart';
import '../modules/auth_module/models/login_model.dart';
import '../modules/auth_module/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  final DataController dataController = Get.find();
  final _hiveBox = Hive.box('data');
  final _hiveBoxSettings = Hive.box('settings');
  checkStartUpLogic() {
    checkLogin();

    Future.delayed(Duration(seconds: 2), () {
      checkDb();

      if (dataController.isLogin.isTrue) {
        Get.offAll(MyDrawer());
      } else {
        Get.offAll(Login());
      }
    });
  }

  Future<bool> checkDb() async {
    DataController dataController = Get.find();
    if (_hiveBoxSettings.containsKey('isBiometricEnabled')) {
      dataController.isBiometricEnabled.value =
          _hiveBoxSettings.get('isBiometricEnabled');
    }

    final results = _hiveBox.values;
    for (var result in results) {
      dataController.walletModelList.add(result);
    }
    if (results.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void onInit() {
    checkStartUpLogic();
    super.onInit();
  }

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("islogin")) {
      dataController.isLogin(true);
      fetchSpData();
      return true;
    }

    return false;
  }

  Future<LoginModel> fetchSpData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userStr = prefs.getString('user')!;
    dataController.loginModel = LoginModel.fromJson(jsonDecode(userStr));
    if (prefs.containsKey('ago')) {
      dataController.activeAgo.value = prefs.getString('ago')!;
    }
    prefs.setString(
        'ago',
        CustomStringExtension.displayTimeAgoFromTimestamp(
            DateTime.now().toString()));
    return dataController.loginModel!;
  }
}
