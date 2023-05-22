// import 'package:flutter_test/flutter_test.dart';
// import 'package:custom_keyboard_action/custom_keyboard_action.dart';
// import 'package:custom_keyboard_action/custom_keyboard_action_platform_interface.dart';
// import 'package:custom_keyboard_action/custom_keyboard_action_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockKeyboardActionPlatform
//     with MockPlatformInterfaceMixin
//     implements KeyboardActionPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final KeyboardActionPlatform initialPlatform = KeyboardActionPlatform.instance;

//   test('$MethodChannelKeyboardAction is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelKeyboardAction>());
//   });

//   test('getPlatformVersion', () async {
//     KeyboardAction keyboardActionPlugin = KeyboardAction();
//     MockKeyboardActionPlatform fakePlatform = MockKeyboardActionPlatform();
//     KeyboardActionPlatform.instance = fakePlatform;

//     expect(await keyboardActionPlugin.getPlatformVersion(), '42');
//   });
// }
