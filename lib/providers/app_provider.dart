import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider {
  Dio dio = Dio();
  String baseUrl = 'https://us-central1-kyc-challenge.cloudfunctions.net';
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
}