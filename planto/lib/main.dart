import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:planto/Model/diseaseProvider.dart';
import 'package:planto/screens/home.dart';
import 'package:provider/provider.dart';
import '../widgets/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Disease()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Poppins',
            accentColor: HexColor('#031D07'),
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              bodyText1: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
        title: 'plantO',
        home: AnimatedSplashScreen(
          splashIconSize: 900,
          splash: Splash(),
          backgroundColor: HexColor('#031D07'),
          splashTransition: SplashTransition.scaleTransition,
          nextScreen: Home(),
        ),
      ),
    );
  }
}
