import 'package:lp_finance/Controller/data_controller.dart';
import 'package:lp_finance/Controller/drawer_controller.dart';
import 'package:lp_finance/Controller/wallet_controller.dart';
import 'package:lp_finance/modules/auth_module/controllers/signup_controller.dart';

import 'modules/auth_module/exports.dart';
import 'utils/exports.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    initAll();
  }

  void initAll() {
    //PUT
    Get.put(DataController(), permanent: true);
    Get.put(MyDrawerController(), permanent: true);
    Get.put(WalletController(), permanent: true);
    Get.put(LoginController(), permanent: true);
    Get.put(SignupController(), permanent: true);
  }
}
