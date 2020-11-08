import 'package:dio/dio.dart';
import 'package:kyc/models/login_model/login_request_model.dart';
import 'package:kyc/models/login_model/login_response_model.dart';
import 'package:kyc/models/signup_model/signup_request_model.dart';
import 'package:kyc/models/signup_model/signup_response_model.dart';
import 'package:kyc/utils/operation.dart';

class AuthenticationData{
  Future<Operation> registerUser(Dio dio, SignUpRequest signUpRequest,String baseUrl) async{

    try{
      var response = await dio.post(
        '$baseUrl/api/user/signup',
        data: signUpRequest.toJson(),

      ).timeout(Duration(minutes: 2), onTimeout: () async{
        return Response(
            data: {"message": "Connection Timed out. Please try again"},
            statusCode: 408);
      }).catchError((error) {
        return Response(
            data: {"message": "Error occurred while connecting to server"},
            statusCode: 508);
      });

      print('response.data is ${response.data}');
      if(response.statusCode == 508 || response.statusCode == 408){
        return Operation(response.statusCode, response.data);
      }else{
        SignUpResponse data = SignUpResponse.fromJson(response.data);
        return Operation(response.statusCode, data);

      }

    }catch(err){
      print(err);
      if(err.response != null){
        print("err data : ${err.response.data}: error code ${err.response.statusCode} error : ${err.response}");
        return Operation(err.response.statusCode, err.response.data);
      }else{
        print("err data : ${err.message}: error ${err.error}");
        return Operation(500,'Network Error: please check your internet connect');
      }
    }

  }

  Future<Operation> loginUser(Dio dio, LoginRequest loginRequest,String baseUrl) async{

    try{
      var response = await dio.post(
        '$baseUrl/api/user/login',
        data: loginRequest.toJson(),

      ).timeout(Duration(minutes: 2), onTimeout: () async{
        return Response(
            data: {"message": "Connection Timed out. Please try again"},
            statusCode: 408);
      }).catchError((error) {
        return Response(
            data: {"message": "Error occurred while connecting to server"},
            statusCode: 508);
      });

      print('response.data is ${response.data}');
      if(response.statusCode == 508 || response.statusCode == 408){
        return Operation(response.statusCode, response.data);
      }else{
        LoginResponse data = LoginResponse.fromJson(response.data);
        return Operation(response.statusCode, data);

      }

    }catch(err){
      print(err);
      if(err.response != null){
        print("err data : ${err.response.data}: error code ${err.response.statusCode} error : ${err.response}");
        return Operation(err.response.statusCode, err.response.data);
      }else{
        print("err data : ${err.message}: error ${err.error}");
        return Operation(500,'Network Error: please check your internet connect');
      }
    }

  }

}

final authenticationData = AuthenticationData();