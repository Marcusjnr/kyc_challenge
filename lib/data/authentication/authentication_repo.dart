import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kyc/data/authentication/authentication_data.dart';
import 'package:kyc/models/login_model/login_request_model.dart';
import 'package:kyc/models/signup_model/signup_request_model.dart';
import 'package:kyc/utils/operation.dart';

class _AuthenticationRepo{

  signUp(Dio dio, SignUpRequest signUpRequest,String baseUrl, OperationCompleted signUpCompleted){
    authenticationData.registerUser(dio, signUpRequest, baseUrl).then((data) => signUpCompleted(data));
  }

  login(Dio dio, LoginRequest loginRequest,String baseUrl, OperationCompleted loginCompleted){
    authenticationData.loginUser(dio, loginRequest, baseUrl).then((data) => loginCompleted(data));
  }
}

_AuthenticationRepo authenticationRepo = _AuthenticationRepo();