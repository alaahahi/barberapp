import 'package:barber/data/api.dart';
import 'package:barber/services/activation.dart';
import 'package:barber/services/likes.dart';
import 'package:barber/services/cartService.dart';
import 'package:barber/widgets/Layouts/BottomNavBarApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // setupLocater();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    Phoenix(
      child: EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
          Locale('fa'),
        ],
        useOnlyLangCode: true,
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MainApp(prefs: prefs),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key key, this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final appContent = BottomedNavBarApp();
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor:  Color.fromRGBO(0, 0, 0, 1)),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          Provider<Api>(
            create: (_) => Api(
              baseUrl: 'https://www.intellijapp.com/barber/public/api',
              langFunc: () => EasyLocalization.of(context).locale.languageCode,
            ),
          ),
          //Provider<AuthService>(create: (_) => AuthService()),
          Provider<SharedPreferences>(create: (_) => prefs),
          ListenableProvider<Activation>(create: (_) => Activation()),
          ListenableProvider<ProductLikeService>(
            create: (_) => ProductLikeService(prefs: prefs),
          ),
          ListenableProvider<CompanyLikeService>(
            create: (_) => CompanyLikeService(prefs: prefs),
          ),
          ListenableProvider<CartService>(
              create: (_) => CartService(prefs: prefs)),
        ],
        builder: (context, child) => StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            //return appContent;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child:  Splash()));

            }
            return appContent;
          },
        ),
      ),
    );
  }
}
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Image.asset(
                                'assets/images/Saving-logo.png',
                                fit: BoxFit.cover,
                                width: double.infinity ,
                              ),
      ),
    );
  }
}
