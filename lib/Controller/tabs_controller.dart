import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lp_finance/Screens/lp_saving.dart';
import 'package:lp_finance/Screens/settings.dart';
import 'package:lp_finance/modules/alerts/screen/alerts_screen.dart';
import 'package:lp_finance/modules/wallet/wallet_views%20.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class TabsController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var on = "Uključeno".obs;
  var off = "Isključeno".obs;

  var selected = 0.obs;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  RxInt index = 0.obs;
  var lastindex = 0.obs;
  var lat = 0.0.obs;
  var long = 0.0.obs;

  List items = [
    WalletView(),
    LpSavingView(),
    AlertScreen(),
    AlertScreen(),
    Settings()
  ].obs;

  changeIndex(RxInt val) {
    index.value = val.value;

    update();
  }

  @override
  void onInit() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    chekPref().then((value) {
      _determinePosition();
    });
    super.onInit();
  }

  Future chekPref() async {
    if (await Permission.location.request().isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      print(statuses[Permission.location]);
    }
    //await RemoteServices.stationApi();
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print("1");
      permission = await Geolocator.requestPermission();

      print(permission.index);
      if (permission == LocationPermission.denied) {
        print("2");

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    lat.value = position.latitude;
    long.value = position.longitude;
    print(lat.value);
    print(long.value);
    // DataController dataController = Get.find();
    // StationModel stationModel = StationModel(
    //     title: "Your Location",
    //     Latitude: lat.value.toString(),
    //     Longitude: long.value.toString());
    // dataController.stationList.insert(0, stationModel);
  }
}
