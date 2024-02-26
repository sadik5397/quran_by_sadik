import 'dart:convert';

import 'package:http/http.dart' as http;

import 'global_function.dart';
import 'page_navigation.dart';
import 'print.dart';
import 'show_alert.dart';

class Http {
  static _beforeCall(String apiRoute, Map? body) {
    Print.warning("-----------$apiRoute-----------");
    Print.warning("-----------body-----------");
    Print.debug(prettyJson(body));
  }

  static _gotResult(dynamic result) {
    Print.warning("-----------result-----------");
    Print.info(prettyJson(result));
    Print.warning("----------------------");
  }

  static _ifSuccess(dynamic result, Function(String?)? onSuccess) {
    Print.success("Success");
    onSuccess?.call("Success");
  }

  static _ifFails(dynamic result, Function(String?)? onError) {
    Print.error(cleanedString(result));
    Alert.error(context: navigatorKey.currentState!.context, label: cleanedString(result));
    onError?.call(cleanedString(result));
  }

  static _onException(dynamic e, Function(String?)? onError) {
    Print.error(e.toString());
    Alert.error(context: navigatorKey.currentState!.context, label: e.toString());
    onError?.call(e.toString());
  }

  static Future<dynamic> get(String apiRoute, {Function(String?)? onSuccess, Function(String?)? onError}) async {
    try {
      // String accessToken = await LocalSave.get(key: "accessToken") ?? "";
      _beforeCall(apiRoute, null);
      var response = await http.get(Uri.parse(apiRoute), headers: {"Access-Control-Allow-Origin": "*", 'Content-Type': 'application/json', 'Accept': '*/*'});
      dynamic result = jsonDecode(response.body);
      _gotResult(result);
      if (response.statusCode == 200) {
        _ifSuccess(result, (p0) => onSuccess?.call(p0));
        return result;
      } else {
        _ifFails(result, (p0) => onError?.call(p0));
      }
    } on Exception catch (e) {
      _onException(e, (p0) => onError?.call(p0));
    }
    return null;
  }

  // static Future<dynamic> post(String apiRoute, {Map? body, Function(String?)? onSuccess, Function(String?)? onError}) async {
  //   try {
  //     // String accessToken = await LocalSave.get(key: "accessToken") ?? "";
  //     _beforeCall(apiRoute, body);
  //     var response = await http.post(Uri.parse(apiRoute), body: body == null ? null : jsonEncode(body));
  //     List result = jsonDecode(response.body);
  //     _gotResult(result);
  //     if (result["statusCode"] == 200 || result["statusCode"] == 201) {
  //       _ifSuccess(result, (p0) => onSuccess?.call(p0));
  //       return result["data"];
  //     } else {
  //       _ifFails(result, (p0) => onError?.call(p0));
  //     }
  //   } on Exception catch (e) {
  //     _onException(e, (p0) => onError?.call(p0));
  //   }
  //   return null;
  // }
}
