import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/handlers/news_handler.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _loading = false;
  navigate_to() async {
    setState(() => _loading = true);
    final db = Provider.of<NewsHandler>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    navigate_to();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(appLogo2),
            ),
          ),
          Positioned(
              bottom: getHeight(context) * 0.1,
              child: SizedBox(
                width: getWidth(context),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: whiteColor,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
