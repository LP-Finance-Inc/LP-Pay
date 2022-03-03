import 'package:get/get.dart';
import 'package:lp_finance/Controller/data_controller.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class SettingsController extends GetxController {
  final DataController dataController = Get.find();
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  bool? canCheckBiometrics;
  List<BiometricType>? availableBiometrics;
  var authorized = 'Not Authorized'.obs;
  var isAuthenticating = false.obs;
  var screenSettings = "Settings".obs;

  final _hiveBox = Hive.box('settings');

  @override
  void onInit() {
    auth.isDeviceSupported().then((supportedStatus) {
      supportState =
          supportedStatus ? SupportState.supported : SupportState.unsupported;

      print(supportState);
    });

    super.onInit();
  }

  updateSettingsDb(bool val) {
    _hiveBox.put("isBiometricEnabled", val);
  }

  Future<bool> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      isAuthenticating.value = true;
      authorized.value = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true,
      );

      isAuthenticating.value = false;
      authorized.value = 'Authenticating';
    } on PlatformException catch (e) {
      print(e);

      isAuthenticating.value = false;
      authorized.value = 'Error - ${e.message}';

      return false;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    authorized.value = message;
    if (authenticated) {
      return true;
    } else {
      return false;
    }
  }
}

enum SupportState {
  unknown,
  supported,
  unsupported,
}
