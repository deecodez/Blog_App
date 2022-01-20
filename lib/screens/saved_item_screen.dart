import 'package:flutter/material.dart';

class SavedItemScreen extends StatelessWidget {
  const SavedItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('Saved Item'),
      )),
    );
  }
}
