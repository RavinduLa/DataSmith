import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class JsonCombinerService {
  static Future<void> combineTwoJSONS(String? firstFilePath,
      String? secondFilePath, String? outputFilePath) async {
    var firstObjectList = [];
    var secondObjectList = [];

    if (firstFilePath != null) {
      await File(firstFilePath)
          .openRead()
          .map(utf8.decode)
          .transform(const LineSplitter())
          .forEach((element) {
        //need to decode the object
        var decodedObject = json.decode(element);
        firstObjectList.add(decodedObject);
        /*if (kDebugMode) {
          print(element);
        }*/
      });
    }
    if (secondFilePath != null) {
      await File(secondFilePath)
          .openRead()
          .map(utf8.decode)
          .transform(const LineSplitter())
          .forEach((element) {
        //need to decode the object
        var decodedObject = json.decode(element);
        secondObjectList.add(decodedObject);
        /*if (kDebugMode) {
          print(element);
        }*/
      });
    }

    var combinedList = [];

    //when getting item from the list a single array object is returned. Therefore we have to iterate through that too
    for (var objArray in firstObjectList) {
      for (var element in objArray) {
        var encodedObject = json.encode(element);
        combinedList.add(encodedObject);
      }
    }
    for (var objArray in secondObjectList) {
      for (var element in objArray) {
        var encodedObject = json.encode(element);
        combinedList.add(encodedObject);
      }
    }

    /*if (kDebugMode) {
      print('Combined List : $combinedList');
    }*/

    File file = File(outputFilePath!);
    file.openWrite();
    file.writeAsString(combinedList.toString());
  }
}
