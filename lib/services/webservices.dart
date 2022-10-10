import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ox21/constants/global_keys.dart';
import 'dart:convert'as convert;

import 'package:ox21/services/api_urls.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/global_functions.dart';
class Webservices{
  static Future<bool> createAccount({
  required String uuid,
    required String password,
    required BuildContext context,
})async{
    var request = {
      "uuid": uuid,
      "password": password,
    };
    try{
      print(ApiUrls.signUpUrl + '?t=1');
      var response = await http.post(
        Uri.parse(ApiUrls.signUpUrl + '?t=1'),
        body: request,
      );
      if(response.statusCode==200){
        print('success');
        print(response.body);
        var jsonResponse = convert.jsonDecode(response.body);
        if(jsonResponse['status']==1){
          await updateSharedPreference(jsonResponse['userdetail']);
          return true;
        }else{
          showSnackbar(context, '${jsonResponse['message']}');
        }


      }
      else{
        print('fail ${response.statusCode} : ${response.body}');
        if(response.statusCode==500){
          try{
            var jsonResponse = convert.jsonDecode(response.body);
            showSnackbar(context, '${jsonResponse['message']}');

          }catch(e){
            print('Error in catch block f4453 $e');
          }

        }
        else{
          showSnackbar(context, 'Some error Occured please try again later');
        }
        // var jsonResponse = conver
        // showSnackbar(context, 'text')
      }
    }catch(e){
      print('Error in Catch block $e');
      showSnackbar(context, 'Some Error occurred.Please try again later.');
    }
    return false;
  }


  static Future<bool> login({
    required String uuid,
    required String password,
    required BuildContext context,
  })async{
    var request = {
      "uuid": uuid,
      "password": password,
    };
    try{
      var response = await http.post(
        Uri.parse(ApiUrls.loginUrl),
        body: request,
      );
      if(response.statusCode==200){
        print('success');
        print(response.body);
        var jsonResponse = convert.jsonDecode(response.body);
        if(jsonResponse['status']==1){
          await updateSharedPreference(jsonResponse['data']);
          return true;
        }else{
          showSnackbar(context, '${jsonResponse['message']}');
        }


      }
      else{
        print('fail ${response.statusCode} : ${response.body}');
        if(response.statusCode==500){
          try{
            var jsonResponse = convert.jsonDecode(response.body);
            showSnackbar(context, '${jsonResponse['message']}');

          }catch(e){
            print('Error in catch block f4453 $e');
          }

        }
        else{
          showSnackbar(context, 'Some error Occured please try again later');
        }
        // var jsonResponse = conver
        // showSnackbar(context, 'text')
      }
    }catch(e){
      print('Error in Catch block $e');
    }
    return false;
  }

  static Future<bool> forgotPassword({
    required String uuid,
    required BuildContext context,
  })async{
    var request = {
      "uuid": uuid,
    };
    try{
      var response = await http.post(
        Uri.parse(ApiUrls.forgotPassword),
        body: request,
      );
      if(response.statusCode==200){
        print('success');
        print(response.body);
        var jsonResponse = convert.jsonDecode(response.body);
        if(jsonResponse['status']==1 || jsonResponse['status']=='1'){
          return true;
        }else{
          showSnackbar(context, jsonResponse['message']);
        }

      }
      else{
        print('fail ${response.statusCode} : ${response.body}');
        if(response.statusCode==500){
          try{
            var jsonResponse = convert.jsonDecode(response.body);
            showSnackbar(context, '${jsonResponse['message']}');

          }catch(e){
            print('Error in catch block f4453 $e');
          }

        }
        else{
          showSnackbar(context, 'Some error Occured please try again later');
        }
        // var jsonResponse = conver
        // showSnackbar(context, 'text')
      }
    }catch(e){
      print('Error in Catch block $e');
    }
    return false;
  }


  static Future<http.Response> getData(String url) async {
    http.Response response =
    http.Response('{"message":"failure","status":0}', 404);
    log('called $url');
    try {
      response = await http.get(
        Uri.parse(url),
      );
      log('The response for url ${url} with status code ${response.statusCode} is ${response.body}');
    } catch (e) {
      // showSnackbar(context, text)
      log('Error in $url : ------ $e');
    }
    return response;
  }

  static Future<Map<String, dynamic>> postData(
      {required String url,
        required Map<String, dynamic> request,
        required BuildContext context, bool showSuccessMessage  = false, bool isGetMethod = false, bool showErrorMessage = true}) async {
    http.Response response =
    http.Response('{"message":"failure","status":0}', 404);
    try {
      log('the requesst for $url is $request');
      String tempGetRequest = '?';
      request.forEach((key, value) {
        tempGetRequest +=key+'=' + value + '&';

      });
      tempGetRequest = tempGetRequest.substring(0,tempGetRequest.length-1);
      print('the url issss $url$tempGetRequest');
      late http.Response response;
      if(isGetMethod){
        response = await http.get(Uri.parse(url + tempGetRequest));
      }else{
        response = await http.post(Uri.parse(url), body: request);
      }
      if (response.statusCode == 200) {
        print('i am here');
        var jsonResponse = convert.jsonDecode(response.body);
        log('the response for $url is $jsonResponse');
        if (jsonResponse['status'] == 1) {
          if(showSuccessMessage){
            showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, jsonResponse['message']);
          }
          return jsonResponse;
        } else {
         if(showErrorMessage){
           showSnackbar(context, jsonResponse['message']);
         }
        }
        return jsonResponse;
      }
      else{
        print('the response is ${response.statusCode} : ${response.body}');
        try{
          if(showErrorMessage){
            var jsonResponse = convert.jsonDecode(response.body);
            showSnackbar(context, jsonResponse['message'] );
          }
        }catch(e){
          print('Error in  catch block 39 $e');
        }
      }
    } catch (e) {
      log('Error in $url : ------ $e');
    }
    return {"status": 0, "message": "api failed"};
  }

  // static Future<http.Response> postMultipartData({required String url, required Map<String, dynamic> request})async{
  //   http.Response response = http.Response('{"message":"failure","status":0}', 404);
  //   try{
  //     log('the request for $url is $request');
  //     response = await http.post(
  //         Uri.parse(url),
  //         body: request
  //     );
  //   }
  //   catch(e){
  //     log('Error in $url : ------ $e');
  //   }
  //   return response;
  // }
  static Future<Map<String, dynamic>> getMap(String url, {Map<String, dynamic>? request}) async {

    Map<String, dynamic> tempRequest = {};
    if(request!=null){
      request.forEach((key, value) {
        if(value!=null){
          tempRequest['$key'] = value;
        }
      });
    }
    try{
      log('the request for url $url is $tempRequest');
      late http.Response response;
      if(request==null){
        response = await http.get(Uri.parse(url));
      }else{
        response = await http.post(Uri.parse(url), body: tempRequest);
      }
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['status'].toString() == '1') {
          log('the respognse for url: $url is ${jsonResponse}');
          return jsonResponse['data'] ?? jsonResponse['content']??jsonResponse;
        } else {
          log('Error in response for url $url -----${response.body}');
        }
      }else{
        print('error in status code ${response.statusCode}');
        log(response.body);
      }
    }catch(e){
      print('inside catch block 546745 $e');
    }

    return {};
  }
  static Future<List> getList(String url) async {
    var response = await getData(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 1) {
        log('the response for url: $url is ${jsonResponse}');
        return jsonResponse['data']??[];
      } else {
        log('Error in response for url $url -----${response.body}');
      }
    }
    return [];
  }
  static Future<List> getListFromRequestParameters(String url, Map<String, dynamic> request,{ bool isGetMethod = true} ) async {

    Map<String, dynamic> tempRequest = {};
    request.forEach((key, value) {
      if(value!=null){
        tempRequest['$key'] = value;
      }
    });
    try{
      log('the request for url $url is $tempRequest');
      String tempGetRequest = '?';
      tempRequest.forEach((key, value) {
        tempGetRequest +=key+'=' + value + '&';

      });
      tempGetRequest = tempGetRequest.substring(0,tempGetRequest.length-1);
      print('the url issss $url$tempGetRequest');
      late http.Response response;
      if(isGetMethod){
        response = await http.get(Uri.parse(url + tempGetRequest));
      }else{
        response = await http.post(Uri.parse(url), body: tempRequest);
      }
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['status'] == 1) {
          log('the respognse for url: $url is ${jsonResponse}');
          return jsonResponse['data'] ?? [];
        } else {
          log('Error in response for url $url -----${response.body}');
        }
      }else{
        print('error in status code ${response.statusCode}');
        log('The response for url ${url} with status code ${response.statusCode} is ${response.body}');
      }
    }catch(e){
      print('inside catch block. Error in getting response for search doctors $e');
    }

    return [];
  }

  static Future<Map<String, dynamic>> postDataWithImageFunction({
    required Map<String, dynamic> body,
    required Map<String, dynamic> files,
    required BuildContext context,

    /// endpoint of the api
    required String endPoint,
    bool successAlert = false,
    bool errorAlert = true,
  }) async {
    print('the request is $body');
    var url = Uri.parse(endPoint);
    //
    log(endPoint);
    print(files);
    try {
      var request = new http.MultipartRequest("POST", url);
      body.forEach((key, value) {
        request.fields[key] = value;
        // log(value2);
      });

      var headers = {
        "content-type": "multipart/form-data",
      };


      if (files != null) {
        (files as Map<dynamic, dynamic>).forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value.path,));
        });
      }


      log(request.fields.toString());
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      log('The response for url ${endPoint} with status code ${response.statusCode} is ${response.body}');
      var jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == 1) {
        if (successAlert) {
          showSnackbar(context, jsonResponse['message']);
        }
      } else {
        if (errorAlert) {
          showSnackbar(context, jsonResponse['message']);
        }
      }
      return jsonResponse;
      // return response;
    } catch (e) {
      print(e);
      try{
        var response = await http.post(
            url,
            body: body
        );
        if(response.statusCode==200){
          var jsonResponse = convert.jsonDecode(response.body);
          return jsonResponse;
        }
      }catch(error){
        print('inside double catch block $error');
      }
      return {'status': 0, 'message': "fail"};
      // return null;
    }
  }



  static Future<Map<String, dynamic>> sampleFunction({
    required Map<String, dynamic> body,
    required Map<String, dynamic> files,
    required List<File> screenshots,
    required BuildContext context,

    /// endpoint of the api
    required String endPoint,
    bool successAlert = false,
    bool errorAlert = true,
  }) async {
    print('the request is $body');
    var url = Uri.parse(endPoint);
    //
    log(endPoint);
    print(files);
    try {
      var request = new http.MultipartRequest("POST", url);
      body.forEach((key, value) {
        request.fields[key] = value;
        // log(value2);
      });

      var headers = {
        "content-type": "multipart/form-data",
      };


      if (files != null) {
        (files as Map<dynamic, dynamic>).forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value.path,));
        });
      }
      if(screenshots.length!=0){
        for(int i = 0; i<screenshots.length;i++) {
          request.files.add(
              await http.MultipartFile.fromPath('screenshots', screenshots[i].path));
        }
        // request.files.add(await http.MultipartFile.fromPath('screenshots', screenshots));
      }


      log(request.fields.toString());
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print('the response of uploading is ');
      print(response.body);
      log('The response for url ${endPoint} with status code ${response.statusCode} is ${response.body}');
      var jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == 1) {
        if (successAlert) {
          showSnackbar(context, jsonResponse['message']);
        }
      } else {
        if (errorAlert) {
          showSnackbar(context, jsonResponse['message']);
        }
      }
      return jsonResponse;
      // return response;
    } catch (e) {
      showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Error in uploading. Please reupload your video');
      print('Error in catch block');
      print(e);
      // try{
      //   var response = await http.post(
      //       url,
      //       body: body
      //   );
      //   if(response.statusCode==200){
      //     var jsonResponse = convert.jsonDecode(response.body);
      //     return jsonResponse;
      //   }
      // }catch(error){
      //   print('inside double catch block $error');
      // }
      return {'status': 0, 'message': "fail"};
      // return null;
    }
  }


  static Future<Map<String, dynamic>> postDataWithFilesNodeJsFunction({
    required Map<String, dynamic> body,
    required BuildContext context,

    required Map<String, List<File>> nodeFiles,
    /// endpoint of the api
    required String apiUrl,
    bool showSuccessMessage = false,
    bool showErrorMessage = true,
  }) async {
    print('the request is $body');
    var url = Uri.parse(apiUrl);
    //
    log(apiUrl);
    print(nodeFiles);
    try {
      var request = new http.MultipartRequest("POST", url);
      body.forEach((key, value) {
        request.fields[key] = value;
        // log(value2);
      });

      var headers = {
        "content-type": "multipart/form-data",
      };

      if(nodeFiles!=null){
        nodeFiles.forEach((key, value) async{
          value.forEach((element) async{
            request.files.add(await http.MultipartFile.fromPath(key, element.path));
          });
        });
      }


      log(request.fields.toString());
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print('the response of uploading is ');
      print(response.body);
      log('The response for url ${apiUrl} with status code ${response.statusCode} is ${response.body}');
      var jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == 1) {
        if (showSuccessMessage) {
          showSnackbar(context, jsonResponse['message']);
        }
      } else {
        if (showErrorMessage) {
          showSnackbar(context, jsonResponse['message']);
        }
      }
      return jsonResponse;
      // return response;
    } catch (e) {
      showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Error in uploading. Please reupload your video');
      print('Error in catch block');
      print(e);
      // try{
      //   var response = await http.post(
      //       url,
      //       body: body
      //   );
      //   if(response.statusCode==200){
      //     var jsonResponse = convert.jsonDecode(response.body);
      //     return jsonResponse;
      //   }
      // }catch(error){
      //   print('inside double catch block $error');
      // }
      return {'status': 0, 'message': "fail"};
      // return null;
    }
  }


  static Future<String> getPoliciesData({
    required String url,
  })async{
    var response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var jsonResponse = convert.jsonDecode(response.body);
      print('url is $url');
      print('the response is $jsonResponse');
      if(jsonResponse['status']==1){
        return jsonResponse['data'];
      }
      else{
        // sho(jsonResponse['message']);
        return "";
      }
    }
    else{
      // presentToast("check your internet connection");
      return "";
    }
  }


  static Future<String> getLiveConversionRateBTCToUSD()async{
    String rate = '0';
    print('Calling ${ApiUrls.bitcoinConversionUrl}');
    var response =  await http.get(Uri.parse(ApiUrls.bitcoinConversionUrl));
    if(response.statusCode==200){
      try{
        var jsonResponse = convert.jsonDecode(response.body);
        // print('the price data is ${jsonResponse[0]}');
        return jsonResponse['data']['rate'].toString();
      }catch(e){
        print('Error in catch block 423 $e');
      }
    }
    return rate;
  }
}

// {id: 17, owner_id: 393, title: test group ,
// groupID: c7d1977e-4733-59f6-9e43-b2cc1125e7134d1dcc71-0c72-54cb-8895-7f46a9608b43,
// image: http://ox21nft.xyz/images/logo.png
// }}
