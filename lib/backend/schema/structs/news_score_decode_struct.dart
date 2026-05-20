// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewsScoreDecodeStruct extends BaseStruct {
  NewsScoreDecodeStruct({
    String? interpretation,
    String? assessmentBy,
    String? action1,
    String? action2,
  })  : _interpretation = interpretation,
        _assessmentBy = assessmentBy,
        _action1 = action1,
        _action2 = action2;

  // "interpretation" field.
  String? _interpretation;
  String get interpretation => _interpretation ?? '';
  set interpretation(String? val) => _interpretation = val;

  bool hasInterpretation() => _interpretation != null;

  // "assessmentBy" field.
  String? _assessmentBy;
  String get assessmentBy => _assessmentBy ?? '';
  set assessmentBy(String? val) => _assessmentBy = val;

  bool hasAssessmentBy() => _assessmentBy != null;

  // "action1" field.
  String? _action1;
  String get action1 => _action1 ?? '';
  set action1(String? val) => _action1 = val;

  bool hasAction1() => _action1 != null;

  // "action2" field.
  String? _action2;
  String get action2 => _action2 ?? '';
  set action2(String? val) => _action2 = val;

  bool hasAction2() => _action2 != null;

  static NewsScoreDecodeStruct fromMap(Map<String, dynamic> data) =>
      NewsScoreDecodeStruct(
        interpretation: data['interpretation'] as String?,
        assessmentBy: data['assessmentBy'] as String?,
        action1: data['action1'] as String?,
        action2: data['action2'] as String?,
      );

  static NewsScoreDecodeStruct? maybeFromMap(dynamic data) => data is Map
      ? NewsScoreDecodeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'interpretation': _interpretation,
        'assessmentBy': _assessmentBy,
        'action1': _action1,
        'action2': _action2,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'interpretation': serializeParam(
          _interpretation,
          ParamType.String,
        ),
        'assessmentBy': serializeParam(
          _assessmentBy,
          ParamType.String,
        ),
        'action1': serializeParam(
          _action1,
          ParamType.String,
        ),
        'action2': serializeParam(
          _action2,
          ParamType.String,
        ),
      }.withoutNulls;

  static NewsScoreDecodeStruct fromSerializableMap(Map<String, dynamic> data) =>
      NewsScoreDecodeStruct(
        interpretation: deserializeParam(
          data['interpretation'],
          ParamType.String,
          false,
        ),
        assessmentBy: deserializeParam(
          data['assessmentBy'],
          ParamType.String,
          false,
        ),
        action1: deserializeParam(
          data['action1'],
          ParamType.String,
          false,
        ),
        action2: deserializeParam(
          data['action2'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NewsScoreDecodeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NewsScoreDecodeStruct &&
        interpretation == other.interpretation &&
        assessmentBy == other.assessmentBy &&
        action1 == other.action1 &&
        action2 == other.action2;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([interpretation, assessmentBy, action1, action2]);
}

NewsScoreDecodeStruct createNewsScoreDecodeStruct({
  String? interpretation,
  String? assessmentBy,
  String? action1,
  String? action2,
}) =>
    NewsScoreDecodeStruct(
      interpretation: interpretation,
      assessmentBy: assessmentBy,
      action1: action1,
      action2: action2,
    );
