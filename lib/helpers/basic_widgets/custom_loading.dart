import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../config/stylesheet.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context),
      width: getWidth(context),
      color: blackColor.withOpacity(0.4),
      child: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: whiteColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: defaultColor,
                ),
                putVarticalSpace(10),
                Text(
                  "Please Wait",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: blackColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
