import 'package:flutter/material.dart';
import 'package:kyc/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{
  static Future<void> putUserDetails(BuildContext context, String userEmail, String userName, String userFirstName, String userLastName) async{
    final SharedPreferences pref = await Provider.of<AppProvider>(context, listen: false).prefs;

    pref.setString('username', userName);
    pref.setString('email', userEmail);
    pref.setString('firstname', userFirstName);
    pref.setString('lastname', userLastName);
  }


  static Future<String> getUserDetailsSpecific(String key, BuildContext context) async{
    final SharedPreferences pref = await Provider.of<AppProvider>(context, listen: false).prefs;

    if(key == 'username'){
      return pref.getString('username');
    }else if(key == 'email'){
      return pref.getString('email');
    }else if(key == 'firstname'){
      return pref.getString('firstname');
    }else if(key == 'lastname'){
      return pref.getString('lastname');
    }else{
      return 'No key specified';
    }
  }
}