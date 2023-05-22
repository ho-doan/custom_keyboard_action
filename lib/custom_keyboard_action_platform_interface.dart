import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_keyboard_action_method_channel.dart';
import 'src/generated/custom_keyboard_action.pb.dart';

enum Action {
  done,
  up,
  down,
}

abstract class CustomKeyboardActionPlatform extends PlatformInterface {
  /// Constructs a KeyboardActionPlatform.
  CustomKeyboardActionPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomKeyboardActionPlatform _instance =
      MethodChannelCustomKeyboardAction();

  /// The default instance of [CustomKeyboardActionPlatform] to use.
  ///
  /// Defaults to [MethodChannelKeyboardAction].
  static CustomKeyboardActionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomKeyboardActionPlatform] when
  /// they register themselves.
  static set instance(CustomKeyboardActionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> initial() {
    throw UnimplementedError('initial() has not been implemented.');
  }

  Stream<ActionKeyboard> actionKeyboard() {
    throw UnimplementedError('actionKeyboard() has not been implemented.');
  }
}
