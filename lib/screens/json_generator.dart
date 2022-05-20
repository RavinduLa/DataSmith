import 'package:flutter/material.dart';

class JSONGenerator extends StatefulWidget {
  const JSONGenerator({Key? key}) : super(key: key);

  @override
  _JSONGeneratorState createState() => _JSONGeneratorState();
}

class _JSONGeneratorState extends State<JSONGenerator> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('JSON Geny'),
    );
  }
}
