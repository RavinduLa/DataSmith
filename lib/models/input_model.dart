import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class InputModel{
  String inputFromFile;
  String keyForInputRecord;
  String otherKeyOne;
  String otherValueOne;
  String dataTypeForOtherValue;

  InputModel({required this.inputFromFile, required this.keyForInputRecord, required this.otherKeyOne, required this.otherValueOne, required this.dataTypeForOtherValue});

  Map<String,dynamic> toJson() => {
    keyForInputRecord : inputFromFile,
    otherKeyOne : otherValueOne
  };

  getJsonObject(){
    if(dataTypeForOtherValue == 'int'){
      var otherValueOneInt = int.parse(otherValueOne);
      Map<String,dynamic> inputObj = {
        keyForInputRecord : inputFromFile,
        otherKeyOne : otherValueOneInt
      };
      var jsonObject = json.encode(inputObj);
      return jsonObject;
    }
    else if(dataTypeForOtherValue == 'string'){
      Map<String,dynamic> inputObj = {
        keyForInputRecord : inputFromFile,
        otherKeyOne : otherValueOne
      };
      var jsonObject = json.encode(inputObj);
      return jsonObject;
    }
    else if(dataTypeForOtherValue == 'double'){
      var otherValueOneDouble = double.parse(otherValueOne);
      Map<String,dynamic> inputObj = {
        keyForInputRecord : inputFromFile,
        otherKeyOne : otherValueOneDouble
      };
      var jsonObject = json.encode(inputObj);
      return jsonObject;
    }
    else{
      if (kDebugMode) {
        print('Unsupported data type');
      }
    }
  }
}