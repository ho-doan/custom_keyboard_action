import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_keyboard_action_platform_interface.dart';
import 'src/generated/custom_keyboard_action.pb.dart';

class CustomKeyboardAction {
  CustomKeyboardAction._();
  TextInputType? type;
  static CustomKeyboardAction get instance => CustomKeyboardAction._();
  Future<bool> initial() => CustomKeyboardActionPlatform.instance.initial();
  Stream<ActionKeyboard> actionKeyboard() =>
      CustomKeyboardActionPlatform.instance.actionKeyboard();
}

class TextFormFieldCustomKeyboard extends StatefulWidget {
  const TextFormFieldCustomKeyboard({
    super.key,
    required this.controller,
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlignVertical,
    this.toolbarOptions,
    this.showCursor,
    this.smartDashesType,
    this.smartQuotesType,
    this.maxLengthEnforcement,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.mouseCursor,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.contextMenuBuilder,
    this.cursorWidth = 2.0,
    this.textAlign = TextAlign.start,
    this.decoration,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.expands = false,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableIMEPersonalizedLearning = true,
    this.maxLines,
  });

  final TextEditingController controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  @Deprecated(
    'Use `contextMenuBuilder` instead. '
    'This feature was deprecated after v3.3.0-0.5.pre.',
  )
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final String obscuringCharacter = '•';
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;

  @override
  State<TextFormFieldCustomKeyboard> createState() =>
      _TextFormFieldCustomKeyboardState();
}

class _TextFormFieldCustomKeyboardState
    extends State<TextFormFieldCustomKeyboard> {
  late StreamSubscription<ActionKeyboard> controller;
  late TextInputType keyboardType;
  late FocusNode focusNode;
  @override
  void initState() {
    CustomKeyboardActionPlatform.instance.initial();
    keyboardType = widget.keyboardType ?? TextInputType.text;
    focusNode = widget.focusNode ?? FocusNode();
    controller = CustomKeyboardAction.instance.actionKeyboard().listen((data) {
      switch (data) {
        case ActionKeyboard.done:
          FocusScope.of(context).unfocus();
          break;
        case ActionKeyboard.down:
          // setState(() => keyboardType = TextInputType.number);
          // focusNode.unfocus();
          // Future.delayed(const Duration(microseconds: 3), () {
          //   focusNode.requestFocus();
          // });
          // if (FocusScope.of(context).isFirstFocus) return;
          FocusScope.of(context).nextFocus();
          break;
        case ActionKeyboard.up:
          // setState(
          //   () => keyboardType = widget.keyboardType ?? TextInputType.text,
          // );
          // focusNode.unfocus();
          // Future.delayed(const Duration(microseconds: 3), () {
          //   focusNode.requestFocus();
          // });
          FocusScope.of(context).previousFocus();
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        autocorrect: widget.autocorrect,
        autofillHints: widget.autofillHints,
        autofocus: widget.autofocus,
        autovalidateMode: widget.autovalidateMode,
        buildCounter: widget.buildCounter,
        contextMenuBuilder: widget.contextMenuBuilder,
        controller: widget.controller,
        cursorColor: widget.cursorColor,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth,
        decoration: widget.decoration,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        enableSuggestions: widget.enableSuggestions,
        enabled: widget.enabled,
        expands: widget.expands,
        focusNode: focusNode,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        keyboardAppearance: widget.keyboardAppearance,
        keyboardType: keyboardType,
        magnifierConfiguration: widget.magnifierConfiguration,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        mouseCursor: widget.mouseCursor,
        obscureText: widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        onTap: widget.onTap,
        onTapOutside: widget.onTapOutside,
        readOnly: widget.readOnly,
        restorationId: widget.restorationId,
        scrollController: widget.scrollController,
        scrollPadding: widget.scrollPadding,
        scrollPhysics: widget.scrollPhysics,
        selectionControls: widget.selectionControls,
        showCursor: widget.showCursor,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        strutStyle: widget.strutStyle,
        style: widget.style,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textCapitalization: widget.textCapitalization,
        textDirection: widget.textDirection,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
      );
}
