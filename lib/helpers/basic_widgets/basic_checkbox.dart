import 'package:flutter/material.dart';

import '../../config/stylesheet.dart';
import '../helper_functions.dart';

class CustomCheckbox extends StatelessWidget {
  bool ischecked;
  Function(bool?)? onValueChange;
  bool showTextButton;
  Function? onButtonPressed;
  String text;
  CustomCheckbox(
      {Key? key,
      required this.ischecked,
      this.onValueChange,
      this.onButtonPressed,
     required this.text,
      this.showTextButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Checkbox(
          shape:const CircleBorder(),
            value: ischecked,
            onChanged: onValueChange != null ? (v) => onValueChange!(v) : null),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: getTheme(context)
                  .headline5!
                  .copyWith(color: blackColor.withOpacity(0.5)),
            ),
           showTextButton? TextButton(
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
              onPressed: onButtonPressed!=null? ()=> onButtonPressed!(): null, child: Text("Terms & Conditions")): SizedBox(),
          ],
        )
      ],
    );
  }
}
