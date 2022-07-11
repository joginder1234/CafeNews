import 'package:flutter/cupertino.dart';

/// User Profile Model
class UserModel {
  String token, name, email, image;
  int roleId, userId;
  UserModel(
      this.token, this.name, this.email, this.roleId, this.userId, this.image);
  UserModel.fromModel(Map<String, dynamic> json, this.token)
      : name = json['name'].toString(),
        email = json['email'].toString(),
        image = json['image'].toString(),
        roleId = int.parse(json['role_id'].toString()),
        userId = int.parse(json['id'].toString());
}

/// User All Activity Handler (Provider)
class UserActivityHandler extends ChangeNotifier {
  UserModel _user = UserModel('', 'Unknown', "Unknown", 0, 0, "");
  UserModel get getUserProfile => _user;
  setUserProfile(UserModel model) {
    _user = model;
    notifyListeners();
  }
}
