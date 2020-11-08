import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kyc/common_widgets/alerts.dart';
import 'package:kyc/data/authentication/authentication_repo.dart';
import 'package:kyc/models/email_validation_model/email_validation_request.dart';
import 'package:kyc/models/email_validation_model/email_validation_response.dart';
import 'package:kyc/models/login_model/login_request_model.dart';
import 'package:kyc/models/login_model/login_response_model.dart';
import 'package:kyc/models/signup_model/signup_request_model.dart';
import 'package:kyc/models/signup_model/signup_response_model.dart';
import 'package:kyc/providers/authentication_provider.dart';
import 'package:kyc/providers/profile_provider.dart';
import 'package:kyc/screens/profile.dart';
import 'package:kyc/storage/shared_preferences_helper.dart';
import 'package:kyc/utils/operation.dart';
import 'package:provider/provider.dart';

mixin AuthenticationHelper{
  BuildContext _authContext;


  doSignUp(Dio dio, SignUpRequest signUpRequest,String baseUrl, BuildContext context){
    _authContext = context;
    Provider.of<AuthenticationProvider>(_authContext, listen: false).updateIsLoading(true);
    authenticationRepo.signUp(dio, signUpRequest, baseUrl, _completedSignUp);
  }

  doSignIn(Dio dio, LoginRequest loginRequest,String baseUrl, BuildContext context){
    _authContext = context;
    Provider.of<AuthenticationProvider>(_authContext, listen: false).updateIsLoading(true);
    authenticationRepo.login(dio, loginRequest, baseUrl, _completedLogin);
  }

  doEmailValidation(Dio dio, EmailValidationRequest validationRequest,String baseUrl, BuildContext context) async{
    _authContext = context;
    Provider.of<AuthenticationProvider>(_authContext, listen: false).updateIsLoading(true);
    authenticationRepo.validateEmail(dio, validationRequest, baseUrl, _completedValidation);
  }


  _completedSignUp(Operation operation){
    if(operation.code == 508 || operation.code == 408){
      Provider.of<AuthenticationProvider>(_authContext, listen: false).updateIsLoading(false);
      AlertDialogs.showDialog(
          _authContext,
          'Check Internet Connection',
          'Could Not Login',
          Icons.close,
          'Okay',
              (){
            Navigator.pop(_authContext);

          }
      );
    }else{
      SignUpResponse signUpResponse = operation.result;

      if(signUpResponse.success == true){
        SharedHelper.putUserDetails(
            _authContext,
            signUpResponse.result.email,
            signUpResponse.result.username,
            signUpResponse.result.firstname,
            signUpResponse.result.lastname
        );

        Provider.of<ProfileProvider>(_authContext, listen: false).updateUserValidated(signUpResponse.result.emailVerification);
        Provider.of<AuthenticationProvider>(_authContext, listen: false).updateUserDetails(
            '${signUpResponse.result.lastname} ${signUpResponse.result.firstname}',
            signUpResponse.result.username,
            signUpResponse.result.email
        );
        Navigator.pushReplacement(
          _authContext,
          MaterialPageRoute(builder: (context) => ProfileScreen(
            fullName: '${signUpResponse.result.lastname} ${signUpResponse.result.firstname}',
            userName: signUpResponse.result.username,
            email: signUpResponse.result.email,
          )),
        );
      }else{
        Provider.of<AuthenticationProvider>(_authContext, listen: false).updateIsLoading(false);

        AlertDialogs.showDialog(
            _authContext,
            'Sign up failed',
            signUpResponse.message,
            Icons.close,
            'Okay',
                (){
              Navigator.pop(_authContext);

            }
        );
      }
    }
  }

  _completedLogin(Operation operation){
    if(operation.code == 508 || operation.code == 408){
      Provider.of<AuthenticationProvider>(_authContext, listen: false).updateIsLoading(false);
      AlertDialogs.showDialog(
          _authContext,
          'Check Internet Connection',
          'Could Not Login',
          Icons.close,
          'Okay',
              (){
            Navigator.pop(_authContext);

          }
      );
    }else{
      LoginResponse loginResponse = operation.result;

      if(loginResponse.success == true){
        SharedHelper.putUserDetails(
            _authContext,
            loginResponse.result.user.email,
            loginResponse.result.user.username,
            loginResponse.result.user.firstname,
            loginResponse.result.user.lastname
        );

        Provider.of<ProfileProvider>(_authContext, listen: false).updateUserValidated(loginResponse.result.validated);
        Provider.of<AuthenticationProvider>(_authContext, listen: false).updateUserDetails(
            '${loginResponse.result.user.lastname} ${loginResponse.result.user.firstname}',
            loginResponse.result.user.username,
            loginResponse.result.user.email
        );
        Navigator.pushReplacement(
          _authContext,
          MaterialPageRoute(builder: (context) => ProfileScreen(
            fullName: '${loginResponse.result.user.lastname} ${loginResponse.result.user.firstname}',
            userName: loginResponse.result.user.username,
            email: loginResponse.result.user.email,
          )),
        );
      }else{
        Provider.of<AuthenticationProvider>(_authContext, listen: false).updateIsLoading(false);

        AlertDialogs.showDialog(
            _authContext,
            'Login failed',
            loginResponse.message,
            Icons.close,
            'Okay',
                (){
              Navigator.pop(_authContext);

            }
        );
      }
    }
  }

  _completedValidation(Operation operation){
    if(operation.code == 508 || operation.code == 408){
      Provider.of<AuthenticationProvider>(_authContext, listen: false).updateIsLoading(false);
      AlertDialogs.showDialog(
          _authContext,
          'Check Internet Connection',
          'Could Not Login',
          Icons.close,
          'Okay',
              (){
            Navigator.pop(_authContext);

          }
      );
    }else{
      EmailValidationResponse validationResponse = operation.result;
      if(validationResponse.success == true){
        Provider.of<ProfileProvider>(_authContext, listen: false).updateUserValidated(true);
        AlertDialogs.showDialog(
            _authContext,
            'Successful',
            validationResponse.message,
            Icons.close,
            'Okay',
                (){
                  Navigator.push(
                    _authContext,
                    MaterialPageRoute(builder: (context) => ProfileScreen(
                      fullName: Provider.of<AuthenticationProvider>(_authContext, listen: false).fullName,
                      userName: Provider.of<AuthenticationProvider>(_authContext, listen: false).userName,
                      email: Provider.of<AuthenticationProvider>(_authContext, listen: false).email,
                    )),
                  );
            }
        );

      }else{
        Provider.of<ProfileProvider>(_authContext, listen: false).updateUserValidated(false);
        AlertDialogs.showDialog(
            _authContext,
            'Failed',
            validationResponse.message,
            Icons.close,
            'Okay',
                (){
              Navigator.push(
                _authContext,
                MaterialPageRoute(builder: (context) => ProfileScreen(
                  fullName: Provider.of<AuthenticationProvider>(_authContext, listen: false).fullName,
                  userName: Provider.of<AuthenticationProvider>(_authContext, listen: false).userName,
                  email: Provider.of<AuthenticationProvider>(_authContext, listen: false).email,
                )),
              );
            }
        );
      }
    }
  }
}