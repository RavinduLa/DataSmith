import 'dart:convert';
import 'dart:io';
import 'package:data_smith/models/input_model.dart';
import 'package:flutter/foundation.dart';

class JSONGeneratorService {
  static Future<void> generateJSONWithOneExtraField(
      String? inputFilePath,
      String keyForRecords,
      String otherKey,
      String otherValue,
      String dataTypeForValue,
      String? outputFilePath) async {



    String? filePath = inputFilePath;
    if (filePath != null) {
      var objectList = [];
      //needs to be async
      await File(filePath)
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
        objectList.add(jsonObject);
      });
      File file = File(outputFilePath!);
      file.openWrite();
      file.writeAsString(objectList.toString());
      /*
      if (kDebugMode) {
        print(objectList.isEmpty);
        print(objectList);
      }
      */
    } else {
      if (kDebugMode) {
        print("File path is null in json generator service");
      }
    }
  }
}
