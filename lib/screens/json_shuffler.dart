import 'package:flutter/material.dart';


class JSONShuffler extends StatefulWidget {
  const JSONShuffler({Key? key}) : super(key: key);

  @override
  _JSONShufflerState createState() => _JSONShufflerState();
}

class _JSONShufflerState extends State<JSONShuffler> {
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
              ElevatedButton(onPressed: (){}, child: const Text('Select File'))
            ],
          ),
          const Text('No file selected'),
          Row(
            children: [
              const Text('Output File'),
              ElevatedButton(onPressed: (){}, child: const Text('Select Path'))
            ],
          ),
          ElevatedButton(onPressed: (){}, child: const Text('Shuffle'))
        ],
      ),
    );
  }
}
