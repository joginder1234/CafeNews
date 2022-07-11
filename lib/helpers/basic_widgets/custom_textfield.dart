import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/stylesheet.dart';

class ExpandedTextField extends StatelessWidget {
  String hint;
  TextEditingController? controller;
  String prefixIcon;
  String sufixIcon;
  bool showPrefix;
  Color filledColor;
  Color sufixColor;
  bool showBorder;
  bool readonly;
  bool isNumberKeyboard;
  bool isobsecure;
  int maxline;
  Function? ontap;
  Function(String?)? onChanged;
  ExpandedTextField(
      {Key? key,
      this.hint = '',
      this.prefixIcon = '',
      this.sufixIcon = '',
      this.showPrefix = false,
      this.filledColor = whiteColor,
      this.sufixColor = blackColor,
      this.showBorder = false,
      this.readonly = false,
      this.isNumberKeyboard = false,
      this.isobsecure=false,
      this.ontap,
      this.maxline = 1,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: showBorder
                  ? blackColor.withOpacity(0.2)
                  : Colors.transparent)),
      child: TextField(
        obscureText: isobsecure,
        onChanged: onChanged!=null? (v)=> onChanged!(v) : null,
        keyboardType: isNumberKeyboard
            ? TextInputType.number
            : TextInputType.emailAddress,
        maxLines: maxline,
        onTap: () => ontap != null ? ontap!() : null,
        readOnly: readonly,
        controller: controller,
        decoration: InputDecoration(
            fillColor: filledColor,
            filled: true,
            prefixIcon: showPrefix
                ? IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(
                      prefixIcon,
                      width: 15,
                      color: defaultColor,
                    ))
                : null,
            suffixIcon: sufixIcon != ''
                ? IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(
                      sufixIcon,
                      width: 15,
                      color: sufixColor,
                    ))
                : null,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 15, vertical: maxline > 1 ? 15 : 5),
            hintText: hint,
            hintStyle: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: blackColor.withOpacity(0.4)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: defaultColor))),
      ),
    );
  }
}
