import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JSONCombiner extends StatefulWidget {
  const JSONCombiner({Key? key}) : super(key: key);

  @override
  _JSONCombinerState createState() => _JSONCombinerState();
}

class _JSONCombinerState extends State<JSONCombiner> {
  PlatformFile? inputFileOne;
  PlatformFile? inputFileTwo;
  String? outputFilePath;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'JSON Combiner',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Row(
              children: [
                const Text('First File'),
                ElevatedButton(
                    onPressed: () {
                      pickInputFileOne();
                    },
                    child: const Text('Select File'))
              ],
            ),
            const Text('First File :  Not Selected'),
            Row(
              children: [
                const Text('Second File'),
                ElevatedButton(
                    onPressed: () {
                      pickInputFileTwo();
                    },
                    child: const Text('Select File'))
              ],
            ),
            const Text('Second File :  Not Selected'),
            Row(
              children: [
                const Text('Output File'),
                ElevatedButton(
                    onPressed: () {
                      selectOutputFilePath();
                    },
                    child: const Text('Select Location'))
              ],
            ),
            ElevatedButton(onPressed: (){}, child: const Text('Combine')),
          ],
        ),
      ),
    );
  }

  Future pickInputFileOne() async {
    //pick the file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() => inputFileOne = file);
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

  Future pickInputFileTwo() async {
    //pick the file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() => inputFileTwo = file);
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
      fileName: 'combined-file.json',
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

  void combineJson(){

    if(validateFiles()){

    }
    else{
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
    if (inputFileOne != null && inputFileTwo != null && outputFilePath != null) {
      return true;
    } else {
      return false;
    }
  }
}
