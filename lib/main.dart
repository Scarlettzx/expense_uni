import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_expense/injection.dart';
import 'package:upgrader/upgrader.dart';
import 'src/core/features/splash/splash.page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'src/features/user/home/presentation/pages/Homepage.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting('th');
  await di.init();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const Injection(router: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      debugShowCheckedModeBanner: false,
      title: 'Uni Expense',
      theme: ThemeData(
        fontFamily: 'kanit',
        cardTheme: CardTheme(color: Colors.white),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        dialogTheme: const DialogTheme(backgroundColor: Colors.white),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
        useMaterial3: true,
        // colorScheme: ColorScheme.light(primary: Colors.white)
      ),
      home: UpgradeAlert(child: const SplashPage()),
    );
  }
}
