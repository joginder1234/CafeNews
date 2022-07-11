import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import '../config/stylesheet.dart';
import 'basic_widgets/custom_text_button.dart';

dynamic prefs;

// Helper to get device max-Height
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

// Helper to get device max-Width
double getWidth(BuildContext context) => MediaQuery.of(context).size.width;

// Helper to get height of appbar
double getAppbarHeight(BuildContext context) => AppBar().preferredSize.height;

// Helper to put horizontal space
SizedBox putHorizontalSpace(double space) => SizedBox(width: space);

// Helper to put horizontal space
SizedBox putVarticalSpace(double space) => SizedBox(height: space);

// Helper to get text Theme
TextTheme getTheme(BuildContext context) => Theme.of(context).textTheme;

// unfocus Keyboard
unfocus(BuildContext context) => FocusScope.of(context).unfocus();

// Helper to push to new screen
pushTo(
  Widget child,
  BuildContext context,
) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => child));
pushAndRemove(Widget child, BuildContext context) =>
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => child), (route) => false);

// helper to perform share action in app
Future<void> share() async {
  await Share.share("Hello, This is share data test from BHM NGO");
}

TextButton staticIcon(BuildContext context, String value, String icon) {
  return TextButton.icon(
      onPressed: null,
      icon: SvgPicture.asset(
        icon,
        color: defaultColor.withOpacity(0.2),
      ),
      label: Text(
        value,
        style: getTheme(context).headline4!.copyWith(fontSize: 12),
      ));
}

// to create rectangular icon_button
Widget createIconButton(String icon, Function ontap) => IconButton(
    padding: EdgeInsets.zero,
    splashRadius: 30,
    onPressed: () => ontap(),
    icon: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: defaultColor.withOpacity(0.1)),
      child: SvgPicture.asset(
        icon,
        width: 20,
        color: defaultColor,
      ),
    ));

Widget setSectionDivider(
        {required BuildContext context,
        required String heading,
        bool showButton = false,
        String buttonTitle = '',
        Color buttonColor = defaultColor,
        Function? ontap}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: Theme.of(context).textTheme.headline3,
        ),
        showButton
            ? CustomTextButton(
                text: buttonTitle,
                textColor: buttonColor,
                ontap: ontap != null ? () => ontap() : null,
              )
            : const SizedBox()
      ],
    );
