import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  Color textColor;
  String text;
  Function? ontap;
  bool showMultiThemeText;
  String text2;
  CustomTextButton(
      {Key? key, this.textColor = blackColor, required this.text, this.ontap, this.showMultiThemeText= false, this.text2=''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: ontap != null ? () => ontap!() : null,
        child: showMultiThemeText? Text.rich(TextSpan(
          text: text, style: getTheme(context).headline4!.copyWith(fontWeight: FontWeight.w300, color: blackColor.withOpacity(0.3)), children: [
            TextSpan(text: text2, style: getTheme(context).headline4!.copyWith(fontWeight: FontWeight.bold))
          ]
        )) :Text(
          text,
          style:
              Theme.of(context).textTheme.headline4!.copyWith(color: textColor),
        ));
  }
}
