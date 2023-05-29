import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_keyboard_action_platform_interface.dart';

/// An implementation of [CustomKeyboardActionPlatform] that uses method channels.
class MethodChannelCustomKeyboardAction extends CustomKeyboardActionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_keyboard_action');

  static EventChannel actionChannel =
      const EventChannel('custom_keyboard_action_event');

  @override
  Stream<bool> actionKeyboard() => actionChannel.receiveBroadcastStream().map(
        (event) => event ?? false,
      );
}
