import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lp_finance/Controller/data_controller.dart';
import '../Controller/settings_controller.dart';
import '../styles.dart';
import 'package:lp_finance/utils/exports.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final DataController dataController = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: walletBg,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: walletBg,
      body: GetX<SettingsController>(
        init: SettingsController(),
        initState: (_) {},
        builder: (settingsController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, right: 3.w, left: 3.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            padding: EdgeInsets.zero,
                            iconSize: 20,
                            splashRadius: 28,
                            splashColor: walletBg,
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 22.sp,
                              color: Color(0xff0896D3),
                            ),
                          ),
                          SizedBox(
                            width: 27.w,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              settingsController.screenSettings.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Sfpro",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xff864998), walletBg],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Enable biometric auth:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Sfpro",
                                  ),
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: MergeSemantics(
                                    child: CupertinoSwitch(
                                  activeColor: Color(0xff0896D3),
                                  value:
                                      dataController.isBiometricEnabled.value,
                                  onChanged: (bool value) async {
                                    if (value) {
                                      if (settingsController.supportState ==
                                          SupportState.supported) {
                                        bool result = await settingsController
                                            .authenticateWithBiometrics();
                                        if (result) {
                                          dataController
                                              .isBiometricEnabled.value = value;
                                          settingsController
                                              .updateSettingsDb(value);
                                        } else {
                                          Get.snackbar('Oops!',
                                              'You are not authorized try again',
                                              margin: EdgeInsets.only(
                                                  bottom: 50.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText: Colors.white,
                                              backgroundColor:
                                                  Colors.grey[900]);
                                        }
                                      } else {
                                        Get.snackbar('Oops!',
                                            'Your device dose\'t support Biometric Auth',
                                            margin: EdgeInsets.only(
                                                bottom: 50.0,
                                                left: 20.0,
                                                right: 20.0),
                                            snackPosition: SnackPosition.BOTTOM,
                                            colorText: Colors.white,
                                            backgroundColor: Colors.grey[900]);
                                      }
                                    } else {
                                      dataController.isBiometricEnabled.value =
                                          value;
                                    }
                                  },
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
