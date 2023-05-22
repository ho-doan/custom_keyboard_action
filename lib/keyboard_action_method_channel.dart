import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'keyboard_action_platform_interface.dart';
import 'src/generated/keyboard_action.pb.dart';

/// An implementation of [KeyboardActionPlatform] that uses method channels.
class MethodChannelKeyboardAction extends KeyboardActionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('keyboard_action');

  static EventChannel actionChannel =
      const EventChannel('keyboard_action_event');

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
