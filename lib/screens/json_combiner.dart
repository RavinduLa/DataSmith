import 'package:flutter/material.dart';

class JSONCombiner extends StatefulWidget {
  const JSONCombiner({Key? key}) : super(key: key);

  @override
  _JSONCombinerState createState() => _JSONCombinerState();
}

class _JSONCombinerState extends State<JSONCombiner> {
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
                    onPressed: () {}, child: const Text('Select File'))
              ],
            ),
            const Text('First File :  Not Selected'),
            Row(
              children: [
                const Text('Second File'),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Select File'))
              ],
            ),
            const Text('Second File :  Not Selected'),
            Row(
              children: [
                const Text('Output File'),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Select Location'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
