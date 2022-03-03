import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lp_finance/app_bindings.dart';
import 'package:lp_finance/models/token_list.dart';
import 'package:lp_finance/models/wallet_db_model.dart';
import 'package:lp_finance/pages.dart';
import 'package:lp_finance/styles.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<WalletDbModel>(WalletDbModelAdapter());
  Hive.registerAdapter<TokenList>(TokenListAdapter());
  await Hive.openBox('data');
  await Hive.openBox('settings');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  HttpOverrides.global = new MyHttpOverrides();
  runApp(RestartWidget(child: MyApp()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: <AppTheme>[
        AppTheme(
          id: "light",
          description: "light",
          data: ThemeData(
            // Real theme data
            primaryColor: lightBgColor,

            backgroundColor: lightBgColor,
            fontFamily: 'Sfpro',
          ),
        ),
        AppTheme(
          id: "dark",
          description: "dark",
          data: ThemeData(
            // Real theme data
            primaryColor: darkPrimaryColor,
            backgroundColor: darkBgColor,

            fontFamily: 'Sfpro',
          ),
        )
      ],
      child: ThemeConsumer(
        child: Builder(
            builder: (themeContext) => Sizer(
                  builder: (context, orientation, deviceType) {
                    return GetMaterialApp(
                      theme: ThemeProvider.themeOf(themeContext).data,
                      smartManagement: SmartManagement.keepFactory,
                      initialBinding: AppBindings(),
                      debugShowCheckedModeBanner: false,
                      getPages: pages,
                      initialRoute: "/splash",
                    );
                  },
                )),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
