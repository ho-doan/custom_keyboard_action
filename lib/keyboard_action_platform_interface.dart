import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'keyboard_action_method_channel.dart';
import 'src/generated/keyboard_action.pb.dart';

enum Action {
  done,
  up,
  down,
}

abstract class KeyboardActionPlatform extends PlatformInterface {
  /// Constructs a KeyboardActionPlatform.
  KeyboardActionPlatform() : super(token: _token);

  static final Object _token = Object();

  static KeyboardActionPlatform _instance = MethodChannelKeyboardAction();

  /// The default instance of [KeyboardActionPlatform] to use.
  ///
  /// Defaults to [MethodChannelKeyboardAction].
  static KeyboardActionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KeyboardActionPlatform] when
  /// they register themselves.
  static set instance(KeyboardActionPlatform instance) {
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
