import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomListTileView extends StatelessWidget {
  String title, subtitle, leading;
  double leadingRadius;
  List<Widget> trailing;
  Function? ontap;
  CustomListTileView(
      {Key? key,
      this.title = '',
      this.subtitle = '',
      this.leading = profileLogo,
      this.leadingRadius = 20,
      this.ontap,
      this.trailing = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => ontap!(),
      leading: CircleAvatar(
        radius: leadingRadius,
        backgroundImage: AssetImage(leading),
      ),
      title: Text(title, style: getTheme(context).headline3),
      subtitle: Text(
        subtitle,
        style: getTheme(context)
            .headline4!
            .copyWith(fontSize: 12, color: blackColor.withOpacity(0.4)),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: trailing,
      ),
    );
  }
}
