import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class JSONShufflerService {
  static Future<void> generateJSONWithOneExtraField(
      String? inputFilePath, String? outputFilePath) async {

    if (inputFilePath != null && outputFilePath != null){
      var originalList = [];
      var shuffledList = [];
      //needs to be async
      await File(inputFilePath).openRead()
          .map(utf8.decode)
          .transform(const LineSplitter())
      .forEach((element) {
        var decodedObject = json.decode(element);
        originalList.add(decodedObject);
      });

      originalList[0].shuffle();

      for (var objArray in originalList){
        for (var element in objArray) {
          var encodedObject = json.encode(element);
          shuffledList.add(encodedObject);
        }
      }

      File file = File(outputFilePath);
      file.openWrite();
      file.writeAsString(shuffledList.toString());

      if (kDebugMode) {
        print('Shuffled list : $shuffledList');
      }
    }
  }
}
