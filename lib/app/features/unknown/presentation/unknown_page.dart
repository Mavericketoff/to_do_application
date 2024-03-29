import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknown Screen'),
      ),
      body: const Center(
        child: Text(
          'Unknown Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
