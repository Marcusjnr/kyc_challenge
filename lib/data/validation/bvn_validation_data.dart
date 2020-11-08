import 'package:dio/dio.dart';
import 'package:kyc/models/bvn_validation_model/bvn_validation_request.dart';
import 'package:kyc/models/bvn_validation_model/bvn_validation_response.dart';
import 'package:kyc/utils/operation.dart';

class BvnValidationData{
  Future<Operation> bvnValidation(Dio dio, BvnValidationRequest  validationRequest,String baseUrl) async{

    print(validationRequest.toJson());
    print(baseUrl);
    try{
      var response = await dio.post(
        '$baseUrl/user/bvn/validate',
        data: validationRequest.toJson(),

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
        BvnValidationResponse data = BvnValidationResponse.fromJson(response.data);
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

final bvnValidationData = BvnValidationData();