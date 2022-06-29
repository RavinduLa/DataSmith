class JSONGeneratorServiceParametersModel {
  String? inputFilePath;
  String? keyForRecords;
  String? otherKey;
  String? otherValue;
  String? dataTypeForValue;
  String? outputFilePath;

  JSONGeneratorServiceParametersModel(
      {required inputFilePath,
      required keyForRecords,
      required otherKey,
      required otherValue,
      required dataTypeForValue,
      required outputFilePath});
}
