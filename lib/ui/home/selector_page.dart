import 'package:flutter/material.dart';

class SelectorPage extends StatefulWidget {
  const SelectorPage({super.key});

  @override
  State<StatefulWidget> createState() => _SelectorPageState();
}

class _SelectorPageState extends State<SelectorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: const Text('SelectorPage'),
    );
  }
}
