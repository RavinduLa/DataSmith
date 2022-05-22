import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

class JSONGeneratorService {
  static void generateJSONWithOneExtraField(
      String? inputFilePath,
      String keyForRecords,
      String otherKey,
      String otherValue,
      String dataTypeForValue) {
    Map<String, dynamic> object;
    var objectList = [];

    String? filePath = inputFilePath;
    if (filePath != null) {
      File(filePath)
          .openRead()
          .map(utf8.decode)
          .transform(const LineSplitter())
          .forEach((element) {
        if (kDebugMode) {
          print('line: $element');
        }
      });
    }
    else{
      if (kDebugMode) {
        print("File path is null in json generator service");
      }
    }
  }
}
