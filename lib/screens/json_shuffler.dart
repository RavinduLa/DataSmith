import 'package:data_smith/services/json_shuffler_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JSONShuffler extends StatefulWidget {
  const JSONShuffler({Key? key}) : super(key: key);

  @override
  _JSONShufflerState createState() => _JSONShufflerState();
}

class _JSONShufflerState extends State<JSONShuffler> {
  PlatformFile? inputFile;
  String? outputFilePath;
  bool isInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'JSON Shuffler',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Row(
            children: [
              const Text('Input File'),
              ElevatedButton(
                  onPressed: () {
                    pickInputFile();
                  },
                  child: const Text('Select File'))
            ],
          ),
          inputFile != null
              ? Text(inputFile!.path.toString())
              : const Text('No file selected'),
          Row(
            children: [
              const Text('Output File'),
              ElevatedButton(
                  onPressed: () {
                    selectOutputFilePath();
                  },
                  child: const Text('Select Path'))
            ],
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isInProgress = true;
                });
                shuffleJson();
              },
              child: const Text('Shuffle'))
        ],
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
      fileName: 'shuffled-file.json',
    );

    setState(() => outputFilePath = outputFile);

    if (kDebugMode) {
      print(outputFile);
    }

    if (outputFile == null) {
      // User canceled the picker
    }
  }

  void shuffleJson() async {
    if (validateFiles()) {
      await JSONShufflerService.generateJSONWithOneExtraField(
          inputFile?.path, outputFilePath);
      setState(() {
        isInProgress = false;
      });
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
