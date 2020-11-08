import 'package:flutter/foundation.dart';

class AuthenticationProvider extends ChangeNotifier{
  bool isLoading = false;
  String fullName;
  String userName;
  String email;

  void updateUserDetails(String fullNameGotten, String userNameGotten, String emailGotten){
    fullName = fullNameGotten;
    userName = userNameGotten;
    email = emailGotten;
  }
  void updateIsLoading(bool isLoadingGotten){
    isLoading = isLoadingGotten;
    notifyListeners();
  }
}