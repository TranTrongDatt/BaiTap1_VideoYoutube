import 'package:flutter/material.dart';

class UnitConverterScreen extends StatelessWidget {
  const UnitConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: const Center(
        child: Text('Unit Converter Screen'),
      ),
    );
  }
}
