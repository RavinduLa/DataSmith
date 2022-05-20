import 'package:data_smith/screens/json_combiner.dart';
import 'package:data_smith/screens/json_generator.dart';
import 'package:data_smith/screens/json_shuffler.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Smith'),
      ),
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            selectedIndex: _selectedIndex,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.build),
                label: Text('JSON Generator'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shuffle),
                label: Text('JSON Shuffler'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.attach_file),
                label: Text('JSON Combiner'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                JSONGenerator(),
                JSONShuffler(),
                JSONCombiner(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
