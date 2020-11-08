import 'package:dio/dio.dart';
import 'package:kyc/data/validation/bvn_validation_data.dart';
import 'package:kyc/models/bvn_validation_model/bvn_validation_request.dart';
import 'package:kyc/utils/operation.dart';

class _BvnValidationRepo{

  bvnValidate(Dio dio, BvnValidationRequest  validationRequest,String baseUrl, OperationCompleted validationCompleted){
    bvnValidationData.bvnValidation(dio, validationRequest, baseUrl).then((data) => validationCompleted(data));
  }
}

_BvnValidationRepo validationRepo = _BvnValidationRepo();