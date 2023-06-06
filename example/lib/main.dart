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
        padding: 80,
        body: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              TextField(
                scrollPadding: EdgeInsets.all(100),
              ),
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
