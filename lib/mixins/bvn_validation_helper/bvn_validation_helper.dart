import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kyc/common_widgets/alerts.dart';
import 'package:kyc/data/validation/bvn_validation_repo.dart';
import 'package:kyc/models/bvn_validation_model/bvn_validation_request.dart';
import 'package:kyc/models/bvn_validation_model/bvn_validation_response.dart';
import 'package:kyc/providers/profile_provider.dart';
import 'package:kyc/utils/operation.dart';
import 'package:provider/provider.dart';

mixin ProfileHelper{
  BuildContext _authContext;

  doBvnValidation(Dio dio, BvnValidationRequest  validationRequest,String baseUrl, BuildContext context){
    _authContext = context;
    Provider.of<ProfileProvider>(_authContext, listen: false).updateIsLoading(true);
    validationRepo.bvnValidate(dio, validationRequest, baseUrl, _completedValidation);
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
      Provider.of<ProfileProvider>(_authContext, listen: false).updateIsLoading(false);

      BvnValidationResponse validationResponse = operation.result;

      if(validationResponse.valid == true){
        AlertDialogs.showDialog(
            _authContext,
            'Verification Successful',
            'Your bvn is valid',
            Icons.done,
            'Okay',
                (){
              Navigator.pop(_authContext);

            }
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
}