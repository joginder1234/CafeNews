import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/handlers/user_activity_handler.dart';
import 'package:cafe_news/helpers/basic_widgets/expanded_flat_button.dart';
import 'package:cafe_news/helpers/basic_widgets/profile_navigation_button.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:cafe_news/screens/auth/signin.dart';
import 'package:cafe_news/screens/profile_and_settings/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPanelScreen extends StatefulWidget {
  const UserPanelScreen({Key? key}) : super(key: key);

  @override
  State<UserPanelScreen> createState() => _UserPanelScreenState();
}

class _UserPanelScreenState extends State<UserPanelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: (prefs.getString("token") == null)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        cautionImage,
                        width: getWidth(context) * 0.4,
                      ),
                      putVarticalSpace(30),
                      Text(
                        "You are not logged in",
                        style: getTheme(context).headline3,
                      ),
                      Text(
                        "Please login to you profile first",
                        style: getTheme(context).headline5,
                      ),
                      putVarticalSpace(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ExpandedFlatButton(
                            buttonColor: defaultColor,
                            titleColor: whiteColor,
                            title: "Login",
                            onPressed: () =>
                                pushTo(const SignInScreen(), context)),
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    putVarticalSpace(30),
                    Consumer<UserActivityHandler>(
                        builder: (context, user, _) => ListTile(
                              leading: const CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(profileLogo),
                              ),
                              title: Text(
                                user.getUserProfile.name,
                                style: getTheme(context).headline3,
                              ),
                              subtitle: Text(
                                user.getUserProfile.email,
                                style: getTheme(context).headline5,
                              ),
                            )),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Divider(
                        thickness: 1.3,
                      ),
                    ),
                    ProfileNavigationButton(
                        title: "User Profile",
                        icon: iconUser,
                        ontap: () => pushTo(const UserProfileview(), context)),
                    const Divider(),
                    ProfileNavigationButton(
                        title: "My Saved News",
                        icon: iconBookMark,
                        ontap: () {}),
                    const Divider(),
                    ProfileNavigationButton(
                        title: "Privacy Policy",
                        icon: iconComments,
                        ontap: () {}),
                    const Divider(),
                    ProfileNavigationButton(
                        title: "Change Password",
                        icon: iconPassword,
                        ontap: () {}),
                    const Divider(),
                    putVarticalSpace(20),
                    ProfileNavigationButton(
                        title: "Logout",
                        icon: iconLogout,
                        ontap: () {
                          setState(() {
                            prefs.clear();
                          });
                          pushAndRemove(const SignInScreen(), context);
                        }),
                  ],
                )),
    );
  }
}
