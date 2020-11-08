import 'package:flutter/foundation.dart';

class AuthenticationProvider extends ChangeNotifier{
  bool isLoading = false;

  void updateIsLoading(bool isLoadingGotten){
    isLoading = isLoadingGotten;
    notifyListeners();
  }
}