import 'dart:developer';

import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/handlers/api_handler.dart';
import 'package:cafe_news/handlers/request_handler.dart';
import 'package:cafe_news/handlers/user_activity_handler.dart';
import 'package:cafe_news/helpers/basic_widgets/basic_checkbox.dart';
import 'package:cafe_news/helpers/basic_widgets/custom_loading.dart';
import 'package:cafe_news/helpers/basic_widgets/custom_text_button.dart';
import 'package:cafe_news/helpers/basic_widgets/custom_textfield.dart';
import 'package:cafe_news/helpers/basic_widgets/expanded_flat_button.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:cafe_news/helpers/toast.dart';
import 'package:cafe_news/screens/auth/signin.dart';
import 'package:cafe_news/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../handlers/functions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _name = TextEditingController();
  final _username = TextEditingController();
  bool _showemailCompletion = false;
  bool ischeck = false;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(context),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      signUpVector,
                      width: getWidth(context),
                    ),
                  ),
                  putVarticalSpace(20),
                  Text(
                    "Get Started",
                    style: getTheme(context)
                        .headline1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Create an account to continue.",
                    style: getTheme(context)
                        .headline5!
                        .copyWith(color: blackColor.withOpacity(0.3)),
                  ),
                  putVarticalSpace(30),
                  Text(
                    "Name",
                    style: getTheme(context).headline4,
                  ),
                  putVarticalSpace(10),
                  ExpandedTextField(
                    controller: _name,
                    showBorder: true,
                    hint: "abc",
                  ),
                  putVarticalSpace(20),
                  Text(
                    "Username",
                    style: getTheme(context).headline4,
                  ),
                  putVarticalSpace(10),
                  ExpandedTextField(
                    controller: _username,
                    showBorder: true,
                    hint: "User456",
                  ),
                  putVarticalSpace(20),
                  Text(
                    "Email Address",
                    style: getTheme(context).headline4,
                  ),
                  putVarticalSpace(10),
                  ExpandedTextField(
                    sufixColor: defaultColor,
                    sufixIcon: _showemailCompletion ? checkIcon : '',
                    controller: _email,
                    showBorder: true,
                    hint: "xxxx@email.com",
                    onChanged: (v) {
                      if (v!.endsWith(".com") || v.endsWith(".in")) {
                        setState(() => _showemailCompletion = true);
                        unfocus(context);
                      } else {
                        setState(() => _showemailCompletion = false);
                      }
                    },
                  ),
                  putVarticalSpace(20),
                  Text(
                    "Password",
                    style: getTheme(context).headline4,
                  ),
                  putVarticalSpace(10),
                  ExpandedTextField(
                    isobsecure: true,
                    controller: _pass,
                    showBorder: true,
                    hint: "********",
                  ),
                  putVarticalSpace(15),
                  CustomCheckbox(
                    ischecked: ischeck,
                    text: "By creating account, you agreed to our",
                    onValueChange: (v) => setState(() => ischeck = !ischeck),
                    showTextButton: true,
                  ),
                  putVarticalSpace(20),
                  ExpandedFlatButton(
                      title: "SIGN UP",
                      onPressed: () {
                        if (ischeck) {
                          if (validateData()) {
                            registerUser();
                          } else {
                            null;
                          }
                        } else {
                          toast("Please accept our terms and conditions");
                        }
                      },
                      buttonColor: defaultColor,
                      titleColor: whiteColor),
                  putVarticalSpace(10),
                  Center(
                      child: CustomTextButton(
                    text: "Already have an account ",
                    text2: "Sign in",
                    showMultiThemeText: true,
                    ontap: () {
                      pushTo(const SignInScreen(), context);
                    },
                  )),
                ],
              ),
            ))),
            _loading ? const CustomLoadingWidget() : const SizedBox()
          ],
        ),
      ),
    );
  }

  bool validateData() {
    if (_email.text.isEmpty && _pass.text.isEmpty) {
      toast("Please enter above fields carefully");
      return false;
    } else if (_email.text.isEmpty) {
      toast("Email field can not be empty");
      return false;
    } else if (!_email.text.contains("@") &&
        (!_email.text.contains(".com") || !_email.text.contains(".in"))) {
      toast("Invalid Email address");
      return false;
    } else if (_pass.text.isEmpty) {
      toast("Please enter your password");
      return false;
    } else if (_pass.text.length < 6) {
      toast("Password must be atleast 6 charactor long");
      return false;
    } else if (_name.text.isEmpty) {
      toast("Please enter your name");
      return false;
    } else if (_username.text.isEmpty) {
      toast("Please enter your username");
      return false;
    } else {
      return true;
    }
  }

  registerUser() async {
    final user = Provider.of<UserActivityHandler>(context, listen: false);
    setState(() => _loading = true);
    Map<String, String> body = {
      "name": _name.text.toString(),
      "username": _username.text.toString(),
      "email": _email.text.toString(),
      "password": _pass.text.toString()
    };
    try {
      await RequestHandler.SEND_REQUEST(apiCall: SIGN_UP_API, body: body)
          .then((value) {
        log(value.toString());
        final data = value['data'];
        if (value != null) {
          user.setUserProfile(UserModel.fromModel(data['user'], data['token']));
          toast("User Successfully Registered");
          prefs.setString("token", data['token']);
          isLoggedIn = true;
          setState(() => _loading = false);
          pushAndRemove(BottomNavigationBarScreen(), context);
        } else {
          null;
          setState(() => _loading = false);
        }
      });
    } catch (e) {
      toast(e.toString());
      setState(() => _loading = false);
    }
  }
}
