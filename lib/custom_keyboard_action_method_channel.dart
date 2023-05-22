import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_keyboard_action_platform_interface.dart';
import 'src/generated/custom_keyboard_action.pb.dart';

/// An implementation of [CustomKeyboardActionPlatform] that uses method channels.
class MethodChannelCustomKeyboardAction extends CustomKeyboardActionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_keyboard_action');

  static EventChannel actionChannel =
      const EventChannel('custom_keyboard_action_event');

  @override
  Future<bool> initial() => methodChannel.invokeMethod<bool>('initial').then(
        (_) => _ ?? false,
      );

  @override
  Stream<ActionKeyboard> actionKeyboard() =>
      actionChannel.receiveBroadcastStream().map(
            (event) => ActionKeyboard.values[event],
          );
}
