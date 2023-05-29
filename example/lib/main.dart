import 'package:custom_keyboard_action/custom_keyboard_action.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScaffoldKeyboard(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              // const Stack(
              //   children: [
              //     TextField(
              //       keyboardType: TextInputType.number,
              //     ),
              //     Positioned.fill(
              //       child: TextFormFieldActions(),
              //     ),
              //   ],
              // ),
              SizedBox(height: 500),
              TextField(),
              // TextFormFieldCustomKeyboard(
              //   key: key,
              //   controller: TextEditingController(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
