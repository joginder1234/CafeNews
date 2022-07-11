import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileNavigationButton extends StatelessWidget {
  String icon, title;
  Function? ontap;

  ProfileNavigationButton(
      {Key? key, this.ontap, this.icon = '', required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon.isEmpty
          ? null
          : IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                icon,
                width: 20,
              )),
      title: Text(
        title,
        style: getTheme(context).headline4,
      ),
      onTap: ontap != null ? () => ontap!() : null,
    );
  }
}
