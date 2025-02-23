import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Customers.dart';

class SharedServices {
  Future<SharedPreferences> sharedPreferences() async =>
      await SharedPreferences.getInstance();

  isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("login_details") != null ? true : false;
  }

  Future<Customers?> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    // print("as+${prefs.getString("login_details")})");
    return prefs.getString("login_details") != null
        ? Customers.fromJson(jsonDecode(prefs.getString("login_details")!))
        : null;
  }

  Future<Future<bool>> setLoginDetails(Customers? loginResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    // print(prefs.getString("login_details"));
    // print('loginResponseModel: ${loginResponseModel.username}');
    return prefs.setString(
      "login_details",
      loginResponseModel != null
          ? jsonEncode(loginResponseModel.toJson())
          : "",
    );
    // return prefs.setString(
    //     "login_details",
    //     loginResponseModel != null
    //         ? jsonEncode(loginResponseModel.toJson())
    //         : null);
  }

  Future logOut() async {
    await setLoginDetails(null);
  }
}


