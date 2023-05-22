///
//  Generated code. Do not modify.
//  source: keyboard_action.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ActionKeyboard extends $pb.ProtobufEnum {
  static const ActionKeyboard done = ActionKeyboard._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'done');
  static const ActionKeyboard up = ActionKeyboard._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'up');
  static const ActionKeyboard down = ActionKeyboard._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'down');

  static const $core.List<ActionKeyboard> values = <ActionKeyboard> [
    done,
    up,
    down,
  ];

  static final $core.Map<$core.int, ActionKeyboard> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ActionKeyboard? valueOf($core.int value) => _byValue[value];

  const ActionKeyboard._($core.int v, $core.String n) : super(v, n);
}

