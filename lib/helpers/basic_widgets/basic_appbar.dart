import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/stylesheet.dart';
import '../helper_functions.dart';

class BasicAppBar extends StatefulWidget {
  String title, actionButton;
  bool imageTitle;

  BasicAppBar(
      {Key? key,
      this.imageTitle = false,
      this.title = '',
      this.actionButton = ''})
      : super(key: key);

  @override
  State<BasicAppBar> createState() => _BasicAppBarState();
}

class _BasicAppBarState extends State<BasicAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: whiteColor,
      elevation: 0,
      title: widget.imageTitle
          ? Image.asset(
              widget.title,
              height: getAppbarHeight(context) * 0.8,
              fit: BoxFit.fitHeight,
            )
          : Text(
              widget.title,
            ),
      actions: [
        IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 30,
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: defaultColor.withOpacity(0.1)),
              child: SvgPicture.asset(
                widget.actionButton,
                color: defaultColor,
              ),
            ))
      ],
    );
  }
}
