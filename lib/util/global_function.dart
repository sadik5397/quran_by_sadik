import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'print.dart';

randomNumber(int max) {
  Random random = Random();
  return random.nextInt(max);
}

randomNumberBetween(int min, int max) {
  Random random = Random();
  return random.nextInt(max) + min;
}

String currencyDigit(num num) => NumberFormat("##,##,##,###.##", "en").format(num);

String capitalizeAllWord(var value) {
  value = value.toString();
  if (value == "") {
    return value;
  } else {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      (value[i - 1] == " ") ? result = result + value[i].toUpperCase() : result = result + value[i];
    }
    return result;
  }
}

String capitalizeFirstCharacterOfSentence(var value) {
  value = value.toString();
  if (value == "") {
    return value;
  } else {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      result = result + value[i];
    }
    return result;
  }
}

String cleanedString(var input) => capitalizeAllWord(input.toString().replaceAll("_", " ").replaceAll("{", "").replaceAll("}", "").replaceAll("[", "").replaceAll("]", "").replaceAll(", ", "\n"));

String? findValueToKey({required dynamic object, required String? string, required String inputKey, required String outputKey}) {
  if (string == null) return null;
  try {
    final matchingResult = object.firstWhere((entry) => entry[inputKey] == string);
    return matchingResult != null ? matchingResult[outputKey].toString() : null;
  } on Exception catch (e) {
    Print.debug(e.toString());
    return null;
  }
}

String? findKeyToValue({required dynamic object, required String? string, required String inputKey, required String outputKey}) {
  if (string == null) return null;
  List list = (object as List).map((item) => item).toList();
  for (int i = 0; i < list.length; i++) {
    if (list[i][inputKey] == string) return list[i][outputKey];
  }
  return null;
}

String prettyJson(dynamic map) {
  var encoder = const JsonEncoder.withIndent("     ");
  return encoder.convert(map);
}

String? extractBase64FromBase64ImageData(String? dataUri) => dataUri?.split(',').last;

Future<String> extractBase64FromImageUrl(String imageUrl) async => base64Encode((await http.get(Uri.parse(imageUrl))).bodyBytes);

bool isEnglish(String? str) {
  if (str == null) return true;
  for (int i = 0; i < str.length; i++) {
    int charCode = str.codeUnitAt(i);
    if ((charCode < 65 || charCode > 90) && // A-Z
        (charCode < 97 || charCode > 122) && // a-z
        (charCode < 48 || charCode > 57) && // 0-9
        (charCode != 32) && // space
        (charCode < 33 || charCode > 47) && // basic punctuations
        (charCode < 58 || charCode > 64) && // more basic punctuations
        (charCode < 91 || charCode > 96) && // more basic punctuations
        (charCode < 123 || charCode > 126)) // more basic punctuations
    {
      return false;
    }
  }
  return true;
}

// Future<Size> getImageDimensions(Uint8List uInt8ListImage) async {
//   // Decode the uInt8List into an Image
//   final ui.Codec codec = await ui.instantiateImageCodec(uInt8ListImage);
//   final ui.FrameInfo frameInfo = await codec.getNextFrame();
//   final ui.Image image = frameInfo.image;
//
//   // Get the width and height of the image
//   final double width = image.width.toDouble();
//   final double height = image.height.toDouble();
//
//   return Size(width, height);
// }
