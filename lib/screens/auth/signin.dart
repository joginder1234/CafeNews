import 'dart:developer';

import 'package:cafe_news/handlers/api_handler.dart';
import 'package:cafe_news/handlers/functions.dart';
import 'package:cafe_news/handlers/request_handler.dart';
import 'package:cafe_news/helpers/basic_widgets/custom_loading.dart';
import 'package:cafe_news/screens/auth/signup.dart';
import 'package:cafe_news/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import '../../config/icons_and_images.dart';
import '../../config/stylesheet.dart';
import '../../helpers/basic_widgets/basic_checkbox.dart';
import '../../helpers/basic_widgets/custom_text_button.dart';
import '../../helpers/basic_widgets/custom_textfield.dart';
import '../../helpers/basic_widgets/expanded_flat_button.dart';
import '../../helpers/helper_functions.dart';
import '../../helpers/toast.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
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
                      loginVector,
                      width: getWidth(context),
                    ),
                  ),
                  putVarticalSpace(20),
                  Text(
                    "Let's sign you In",
                    style: getTheme(context)
                        .headline1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome back! You have been missed.",
                    style: getTheme(context)
                        .headline5!
                        .copyWith(color: blackColor.withOpacity(0.3)),
                  ),
                  putVarticalSpace(30),
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
                  putVarticalSpace(30),
                  Text(
                    "Password",
                    style: getTheme(context).headline4,
                  ),
                  putVarticalSpace(10),
                  ExpandedTextField(
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
                  putVarticalSpace(30),
                  ExpandedFlatButton(
                      title: "SIGN IN",
                      onPressed: () {
                        if (validateData()) {
                          login();
                        } else {
                          null;
                        }
                      },
                      buttonColor: defaultColor,
                      titleColor: whiteColor),
                  putVarticalSpace(10),
                  Center(
                      child: CustomTextButton(
                    text: "Don't have an account ",
                    text2: "Sign up",
                    showMultiThemeText: true,
                    ontap: () => pushTo(const SignUpScreen(), context),
                  )),
                  Center(
                      child: CustomTextButton(
                    text: "forgot password",
                    ontap: () {},
                  ))
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
    } else {
      return true;
    }
  }

  login() async {
    setState(() => _loading = true);
    var response = await RequestHandler.SEND_REQUEST(
        apiCall: LOGIN_API,
        body: {"email": _email.text, "password": _pass.text});
    if (response != null) {
      log(response.toString());
      toast("Welcome Back");
      prefs.setString("token", '');
      isLoggedIn = true;
      setState(() => _loading = false);
      pushAndRemove(BottomNavigationBarScreen(), context);
    } else {
      null;
      setState(() => _loading = false);
    }
  }
}
