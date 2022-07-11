import 'package:cafe_news/handlers/news_handler.dart';
import 'package:cafe_news/handlers/user_activity_handler.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:cafe_news/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/stylesheet.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsHandler()),
        ChangeNotifierProvider(create: (context) => UserActivityHandler()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: TextTheme(
          headline1: GoogleFonts.raleway(
              fontSize: 24, fontWeight: FontWeight.w600, color: blackColor),
          headline2: GoogleFonts.raleway(
              fontSize: 20, fontWeight: FontWeight.w600, color: blackColor),
          headline3: GoogleFonts.raleway(
              fontSize: 18, fontWeight: FontWeight.w600, color: blackColor),
          headline4: GoogleFonts.raleway(
              fontSize: 15, fontWeight: FontWeight.w600, color: blackColor),
          headline5: GoogleFonts.raleway(
              fontSize: 12, fontWeight: FontWeight.w600, color: blackColor),
        )),
        home: const SplashScreen(),
      ),
    );
  }
}
