import 'package:flutter/material.dart';

import '../../config/stylesheet.dart';



class ExpandedFlatButton extends StatelessWidget {
  String title;
  Function onPressed;
  Color buttonColor;
  Color titleColor;
  bool showBorder;
  Color borderColor;
  ExpandedFlatButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.buttonColor = whiteColor,
      this.titleColor = blackColor,
      this.showBorder = false,
      this.borderColor = defaultColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
            child: FlatButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: showBorder ? borderColor : Colors.transparent,
                        width: 1),
                    borderRadius: BorderRadius.circular(10)),
                color: buttonColor,
                height: 50,
                onPressed: () => onPressed(),
                child: Text(
                  title,
                  style: theme.headline4!.copyWith(color: titleColor),
                )))
      ],
    );
  }
}
