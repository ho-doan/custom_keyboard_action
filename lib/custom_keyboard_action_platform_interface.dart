import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_keyboard_action_method_channel.dart';

abstract class CustomKeyboardActionPlatform extends PlatformInterface {
  CustomKeyboardActionPlatform() : super(token: _token);
  static final Object _token = Object();
  static CustomKeyboardActionPlatform _instance =
      MethodChannelCustomKeyboardAction();
  static CustomKeyboardActionPlatform get instance => _instance;
  static set instance(CustomKeyboardActionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<bool> actionKeyboard() {
    throw UnimplementedError('actionKeyboard() has not been implemented.');
  }
}
