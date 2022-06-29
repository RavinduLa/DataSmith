class JSONGeneratorServiceParametersModel {
  String? inputFilePath;
  String? keyForRecords;
  String? otherKey;
  String? otherValue;
  String? dataTypeForValue;
  String? outputFilePath;

  JSONGeneratorServiceParametersModel(
      {required this.inputFilePath,
      required this.keyForRecords,
      required this.otherKey,
      required this.otherValue,
      required this.dataTypeForValue,
      required this.outputFilePath});
}
