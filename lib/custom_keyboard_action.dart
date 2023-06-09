import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'custom_keyboard_action_platform_interface.dart';

class CustomKeyboardAction {
  CustomKeyboardAction._();
  TextInputType? type;
  static CustomKeyboardAction get instance => CustomKeyboardAction._();
  Stream<bool> actionKeyboard() =>
      CustomKeyboardActionPlatform.instance.actionKeyboard();
}

class KeyboardAction extends StatelessWidget {
  const KeyboardAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffd1d4d9),
      ),
      child: Row(
        children: [
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => FocusScope.of(context).previousFocus(),
            child: const Icon(
              Icons.keyboard_arrow_up,
              color: Colors.lightBlue,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => FocusScope.of(context).nextFocus(),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.lightBlue,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.lightBlue,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class ScaffoldKeyboard extends StatefulWidget {
  const ScaffoldKeyboard({
    super.key,
    this.keyScaffold,
    this.padding = 40,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.drawerScrimColor,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.customKeyboard,
  });

  final bool extendBody;
  final Key? keyScaffold;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  final Widget? customKeyboard;
  final double padding;

  @override
  State<ScaffoldKeyboard> createState() => _ScaffoldKeyboardState();
}

class _ScaffoldKeyboardState extends State<ScaffoldKeyboard> {
  late StreamSubscription controller;
  late StreamController<(Widget?, double)> widgetController;
  @override
  void initState() {
    super.initState();
    widgetController = StreamController.broadcast();
    widgetController.sink.add((widget.bottomSheet, 0));
    controller = CustomKeyboardAction.instance.actionKeyboard().listen((event) {
      if (mounted) {
        if (event) {
          widgetController.sink.add((
            widget.customKeyboard ?? const KeyboardAction(),
            widget.padding
          ));
        } else {
          widgetController.sink.add((widget.bottomSheet, 0));
        }
      }
    });
  }

  @override
  void dispose() {
    controller.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: Column(
        children: [
          Expanded(child: widget.body ?? const SizedBox.shrink()),
          StreamBuilder<(Widget?, double)>(
            stream: widgetController.stream,
            builder: (context, snapshot) => Padding(
              padding: EdgeInsets.only(bottom: snapshot.data?.$2 ?? 0),
            ),
          ),
        ],
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: StreamBuilder<(Widget?, double)>(
        stream: widgetController.stream,
        builder: (context, snapshot) =>
            snapshot.data?.$1 ?? const SizedBox.shrink(),
      ),
      drawer: widget.drawer,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      drawerScrimColor: widget.drawerScrimColor,
      endDrawer: widget.endDrawer,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      key: widget.keyScaffold,
      onDrawerChanged: widget.onDrawerChanged,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      persistentFooterAlignment: widget.persistentFooterAlignment,
      persistentFooterButtons: widget.persistentFooterButtons,
      primary: widget.primary,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      restorationId: widget.restorationId,
    );
  }
}
