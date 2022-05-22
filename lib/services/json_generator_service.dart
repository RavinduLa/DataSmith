import 'dart:convert';
import 'dart:io';
import 'package:data_smith/models/input_model.dart';
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
        //initialize input model object
        InputModel inputModel = InputModel(
            inputFromFile: element,
            keyForInputRecord: keyForRecords,
            otherKeyOne: otherKey,
            otherValueOne: otherValue,
            dataTypeForOtherValue: dataTypeForValue);

        var jsonObject = inputModel.getJsonObject();
        if (kDebugMode) {
          print(jsonObject);
        }
      });
    } else {
      if (kDebugMode) {
        print("File path is null in json generator service");
      }
    }
  }
}
