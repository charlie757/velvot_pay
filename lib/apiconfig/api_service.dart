import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:velvot_pay/apiconfig/api_url.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:velvot_pay/utils/utils.dart';
import '../utils/Constants.dart';

enum httpMethod { post, get, delete, put }

checkApiMethod(type) {
  switch (type) {
    case httpMethod.post:
      return 'POST';
    case httpMethod.get:
      return 'GET';
    case httpMethod.delete:
      return 'DELETE';
    case httpMethod.put:
      return 'PUT';
    default:
      print('Unknown color');
  }
}

class ApiService {
  static Future apiMethod(
      {required String url,
      required var body,
      required String method,
      bool isErrorMessageShow = true,
      bool isBodyNotRequired = false}) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final request = http.Request(
            method,
            Uri.parse(url),
          );
          request.body = body;
          print(body);
          request.headers['Content-Type'] = 'application/json';
          request.headers['x-access-token'] = SessionManager.token;
          final client = http.Client();
          final streamedResponse = await client.send(request);
          final response = await http.Response.fromStream(streamedResponse);
          print(response.request);
          log(response.body);
          print(response.statusCode);
          return _handleResponse(response, isErrorMessageShow, url);
        } on Exception catch (_) {
          rethrow;
        }
      } else {}
    } on SocketException catch (_) {
      Utils.internetSnackBar(navigatorKey.currentContext!);
      // print('not connected');
    }
  }

  // Helper method to handle API response
  static _handleResponse(http.Response response, isErrorMessageShow, String url) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      print('object');
      var dataAll = json.decode(response.body);
      if(Constants.is401Error==false){
        print('objectdsffdsdfsd');
        Future.delayed(const Duration(milliseconds: 300),(){
          Utils.logOut();
          Constants.is401Error=true;
        });
      }
      isErrorMessageShow
          ? Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext)
          : null;
      return null;
    } else {
      print('object');
      var dataAll = json.decode(response.body);
      isErrorMessageShow
          ? Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext)
          : null;
      return url==ApiUrl.checkPinUrl||url==ApiUrl.buyDataSubscriptionPlanUrl
          ||url==ApiUrl.electricityBillPaymentUrl||url==ApiUrl.buyEducationalPlanUrl ||url== ApiUrl.buyEducationalPlanUrl
         ||url==ApiUrl.buyVehiclePlanUrl||url==ApiUrl.buyPersonalPlanUrl|| url==ApiUrl.buyHealthPlanUrl
          ?json.decode(response.body): null;
    }
  }
}
