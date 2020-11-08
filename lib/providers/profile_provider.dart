import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class ProfileProvider extends ChangeNotifier{
  bool isLoading = false;
  bool uploadingPassportLoading = false;
  Uint8List profile;
  bool userValidated = false;


  void updateIsLoading(bool isLoadingGotten){
    isLoading = isLoadingGotten;
    notifyListeners();
  }

  void updatePassportLoading(bool isPassportLoadingGotten){
    uploadingPassportLoading = isPassportLoadingGotten;
    notifyListeners();
  }

  void updateUserValidated(bool userValidatedGotten){
    userValidated = userValidatedGotten;
    notifyListeners();
  }

  void updateProfilePic(Uint8List uint8list){
    if(uint8list != null){
      profile = uint8list;
      notifyListeners();
    }else{
      profile = null;
      notifyListeners();
    }

  }
}