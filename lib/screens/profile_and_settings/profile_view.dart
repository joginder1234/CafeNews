import 'dart:io';

import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/handlers/user_activity_handler.dart';
import 'package:cafe_news/helpers/basic_widgets/custom_textfield.dart';
import 'package:cafe_news/helpers/basic_widgets/expanded_flat_button.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserProfileview extends StatefulWidget {
  const UserProfileview({Key? key}) : super(key: key);

  @override
  State<UserProfileview> createState() => _UserProfileviewState();
}

class _UserProfileviewState extends State<UserProfileview> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final _picker = ImagePicker();
  XFile? _pickedImage;
  String _profileImage = '';

  @override
  void initState() {
    super.initState();
    setprofile();
  }

  setprofile() {
    final db =
        Provider.of<UserActivityHandler>(context, listen: false).getUserProfile;
    setState(() {
      _nameCtrl.text = db.name;
      _emailCtrl.text = db.email;
      _profileImage = db.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          "User Profile",
          style: getTheme(context).headline3,
        ),
        backgroundColor: whiteColor,
        foregroundColor: blackColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () async => await _picker
                      .pickImage(source: ImageSource.gallery)
                      .then((value) {
                    if (value != null) {
                      setState(() => _pickedImage = value);
                    } else {
                      null;
                    }
                  }),
                  child: CircleAvatar(
                    radius: 60,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: _pickedImage == null
                              ? Image.asset(
                                  profileLogo,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(File(_pickedImage!.path)),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: blackColor),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.add,
                              color: whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              putVarticalSpace(40),
              ExpandedTextField(
                controller: _nameCtrl,
                showPrefix: true,
                prefixIcon: iconUser,
                showBorder: true,
              ),
              putVarticalSpace(20),
              ExpandedTextField(
                showBorder: true,
                controller: _emailCtrl,
                readonly: true,
                showPrefix: true,
                prefixIcon: iconEmail,
              ),
              putVarticalSpace(getHeight(context) * 0.2),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getWidth(context) * 0.2),
                child: ExpandedFlatButton(
                    buttonColor: defaultColor,
                    titleColor: whiteColor,
                    title: "SAVE",
                    onPressed: () {}),
              )
            ],
          ),
        ),
      )),
    );
  }
}
