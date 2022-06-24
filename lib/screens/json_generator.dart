import 'package:data_smith/alert_dialogs/single_button_generic_alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:data_smith/services/json_generator_service.dart';

class JSONGenerator extends StatefulWidget {
  const JSONGenerator({Key? key}) : super(key: key);

  @override
  _JSONGeneratorState createState() => _JSONGeneratorState();
}

class _JSONGeneratorState extends State<JSONGenerator> {
  final _formKey = GlobalKey<FormState>();
  final _controllerInputRecordKey = TextEditingController();
  final _controllerOtherKey1 = TextEditingController();
  final _controllerOtherValue1 = TextEditingController();
  PlatformFile? inputFile;
  String? outputFilePath;
  String dataTypeValue = 'int';
  bool isInProgress = false;

  var dataTypes = ['int', 'string', 'double'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: isInProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'JSON Generator',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Row(
                      children: [
                        const Text('Input File'),
                        ElevatedButton(
                          onPressed: () async {
                            pickInputFile();
                          },
                          child: const Text('Select file'),
                        ),
                      ],
                    ),
                    inputFile != null
                        ? Text(inputFile!.path.toString())
                        : const Text('No file selected'),
                    Row(
                      children: [
                        const Text('Key for input records'),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            controller: _controllerInputRecordKey,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill this field';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Ex: input',
                              focusColor: Colors.green,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const Text('Other Keys and Values'),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              controller: _controllerOtherKey1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill this field';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Ex: Key',
                                focusColor: Colors.green,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              controller: _controllerOtherValue1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill this field';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Ex: Value',
                                focusColor: Colors.green,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Text('Data Type for the Value'),
                        ),
                        DropdownButton(
                            //default data type
                            value: dataTypeValue,
                            icon: const Icon(Icons.keyboard_arrow_down),

                            //get all the data types to drop down
                            items: dataTypes.map(
                              (String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dataTypeValue = newValue!;
                              });
                            })
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('Plus Button pressed');
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Output File Path'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              selectOutputFilePath();
                            },
                            child: const Text('Choose'),
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isInProgress = true;
                        });
                        generateJson();
                      },
                      child: const Text('Generate'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future pickInputFile() async {
    //pick the file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() => inputFile = file);
      if (kDebugMode) {
        print(file.name);
        print(file.bytes);
        print(file.size);
        print(file.extension);
        print(file.path);
      }
    } else {
      // User canceled the picker
    }
  }

  Future selectOutputFilePath() async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'output-file.json',
    );

    setState(() => outputFilePath = outputFile);

    //File file = File(outputFile!);
    //file.openWrite();
    //file.writeAsString('contents');

    if (kDebugMode) {
      print(outputFile);
    }

    if (outputFile == null) {
      // User canceled the picker
    }
  }

  void generateJson() async {
    if (validateFiles()) {
      if (_formKey.currentState!.validate()) {
        if (kDebugMode) {
          print("Validated");
          print('Data type value: $dataTypeValue');
        }
        await JSONGeneratorService.generateJSONWithOneExtraField(
            inputFile?.path,
            _controllerInputRecordKey.text,
            _controllerOtherKey1.text,
            _controllerOtherValue1.text,
            dataTypeValue,
            outputFilePath);

        //stop showing the circular progress indicator
        setState(() {
          isInProgress = false;
        });

        //display success dialog
        showDialog(context: context, builder: (BuildContext context){
          return const SingleButtonGenericAlertDialog(title: 'Success', content: 'The file has been created', buttonText: 'OK');
        });

      }
    } else {
      setState(() {
        isInProgress = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("One or More files not found"),
              content: const Text(
                  "Please select an input file and an output file path"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                )
              ],
            );
          });
    }
  }

  bool validateFiles() {
    if (inputFile != null && outputFilePath != null) {
      return true;
    } else {
      return false;
    }
  }
}
