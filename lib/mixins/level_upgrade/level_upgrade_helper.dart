import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kyc/common_widgets/alerts.dart';
import 'package:kyc/data/level_upgrade/level_upgrade_repo.dart';
import 'package:kyc/models/level_upgrade/level_upgrade_request.dart';
import 'package:kyc/models/level_upgrade/level_upgrade_response.dart';
import 'package:kyc/providers/profile_provider.dart';
import 'package:kyc/utils/operation.dart';
import 'package:provider/provider.dart';

mixin LevelUpgradeHelper{
  BuildContext _authContext;
  String level;

  doLevelUpgrade(Dio dio, LevelUpgradeRequest  upgradeRequest,String baseUrl, BuildContext context){
    _authContext = context;
    level = upgradeRequest.level;
    levelUpgradeRepo.levelUpgrade(dio, upgradeRequest, baseUrl, _completedLevelUpgrade);
  }

  _completedLevelUpgrade(Operation operation){
    if(operation.code == 508 || operation.code == 408){
      Provider.of<ProfileProvider>(_authContext, listen: false).updatePassportLoading(false);
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
      Provider.of<ProfileProvider>(_authContext, listen: false).updatePassportLoading(false);
      if(upgradeResponse.success == true){
        Provider.of<ProfileProvider>(_authContext, listen: false).updateUserLevel('2');
        AlertDialogs.showDialog(
            _authContext,
            'Successful',
            'You have upgraded your account to level $level',
            Icons.done,
            'Okay',
                (){
              Navigator.pop(_authContext);
              Navigator.pop(_authContext);

            }
        );
      }else{
        AlertDialogs.showDialog(
            _authContext,
            'Failed',
            upgradeResponse.message,
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