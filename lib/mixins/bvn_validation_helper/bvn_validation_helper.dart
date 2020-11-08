import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kyc/common_widgets/alerts.dart';
import 'package:kyc/data/level_upgrade/level_upgrade_repo.dart';
import 'package:kyc/data/validation/bvn_validation_repo.dart';
import 'package:kyc/models/bvn_validation_model/bvn_validation_request.dart';
import 'package:kyc/models/bvn_validation_model/bvn_validation_response.dart';
import 'package:kyc/models/level_upgrade/level_upgrade_request.dart';
import 'package:kyc/models/level_upgrade/level_upgrade_response.dart';
import 'package:kyc/providers/app_provider.dart';
import 'package:kyc/providers/profile_provider.dart';
import 'package:kyc/storage/shared_preferences_helper.dart';
import 'package:kyc/utils/operation.dart';
import 'package:provider/provider.dart';

mixin ProfileHelper{
  BuildContext _authContext;
  String _email;

  doBvnValidation(Dio dio, BvnValidationRequest  validationRequest,String baseUrl, BuildContext context){
    _authContext = context;
    Provider.of<ProfileProvider>(_authContext, listen: false).updateIsLoading(true);
    validationRepo.bvnValidate(dio, validationRequest, baseUrl, _completedValidation);
  }

  doLevelUpgrade(Dio dio, LevelUpgradeRequest  upgradeRequest,String baseUrl, BuildContext context) async{
    _authContext = context;
    _email = await SharedHelper.getUserDetailsSpecific('email', context);
    Provider.of<ProfileProvider>(_authContext, listen: false).updateIsLoading(true);
    levelUpgradeRepo.levelUpgrade(dio, upgradeRequest, baseUrl, _completedLevelUpgrade);
  }

  _completedValidation(Operation operation){
    if(operation.code == 508 || operation.code == 408){
      Provider.of<ProfileProvider>(_authContext, listen: false).updateIsLoading(false);
      AlertDialogs.showDialog(
          _authContext,
          'Check Internet Connection',
          'Could Not validate bvn',
          Icons.close,
          'Okay',
              (){
            Navigator.pop(_authContext);

          }
      );
    }else{
      BvnValidationResponse validationResponse = operation.result;
      Provider.of<ProfileProvider>(_authContext, listen: false).updateIsLoading(false);
      if(validationResponse.valid == true){

        doLevelUpgrade(
            Provider.of<AppProvider>(_authContext, listen: false).dio,
            LevelUpgradeRequest(
              email: _email,
              level: '1'
            ),
            Provider.of<AppProvider>(_authContext, listen: false).baseUrl,
            _authContext
        );

      }else{
        AlertDialogs.showDialog(
            _authContext,
            'Verification Successful',
            'Your bvn is not valid',
            Icons.close,
            'Okay',
                (){
              Navigator.pop(_authContext);

            }
        );
      }
    }
  }

  _completedLevelUpgrade(Operation operation){
    if(operation.code == 508 || operation.code == 408){
      Provider.of<ProfileProvider>(_authContext, listen: false).updateIsLoading(false);
      AlertDialogs.showDialog(
          _authContext,
          'Check Internet Connection',
          'Could Not upgrade account',
          Icons.close,
          'Okay',
              (){
            Navigator.pop(_authContext);

          }
      );
    }else{
      LevelUpgradeResponse upgradeResponse = operation.result;
      Provider.of<ProfileProvider>(_authContext, listen: false).updateIsLoading(false);
      if(upgradeResponse.success == true){
        Provider.of<ProfileProvider>(_authContext, listen: false).updateUserLevel('1');
        AlertDialogs.showDialog(
            _authContext,
            'Successful',
            'You have upgraded your account to level 1',
            Icons.done,
            'Okay',
                (){
              Navigator.pop(_authContext);

            }
        );
      }else{
        AlertDialogs.showDialog(
            _authContext,
            'Failed',
            'Could Not upgrade account',
            Icons.close,
            'Okay',
                (){
              Navigator.pop(_authContext);

            }
        );
      }
    }
  }

}