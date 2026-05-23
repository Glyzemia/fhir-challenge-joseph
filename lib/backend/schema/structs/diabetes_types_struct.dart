// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DiabetesTypesStruct extends BaseStruct {
  DiabetesTypesStruct({
    String? code,
    String? codeName,
    String? displayName,
    DateTime? onsetDateTIme,
  })  : _code = code,
        _codeName = codeName,
        _displayName = displayName,
        _onsetDateTIme = onsetDateTIme;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  set code(String? val) => _code = val;

  bool hasCode() => _code != null;

  // "codeName" field.
  String? _codeName;
  String get codeName => _codeName ?? '';
  set codeName(String? val) => _codeName = val;

  bool hasCodeName() => _codeName != null;

  // "displayName" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  set displayName(String? val) => _displayName = val;

  bool hasDisplayName() => _displayName != null;

  // "onsetDateTIme" field.
  DateTime? _onsetDateTIme;
  DateTime? get onsetDateTIme => _onsetDateTIme;
  set onsetDateTIme(DateTime? val) => _onsetDateTIme = val;

  bool hasOnsetDateTIme() => _onsetDateTIme != null;

  static DiabetesTypesStruct fromMap(Map<String, dynamic> data) =>
      DiabetesTypesStruct(
        code: data['code'] as String?,
        codeName: data['codeName'] as String?,
        displayName: data['displayName'] as String?,
        onsetDateTIme: data['onsetDateTIme'] as DateTime?,
      );

  static DiabetesTypesStruct? maybeFromMap(dynamic data) => data is Map
      ? DiabetesTypesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'code': _code,
        'codeName': _codeName,
        'displayName': _displayName,
        'onsetDateTIme': _onsetDateTIme,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'code': serializeParam(
          _code,
          ParamType.String,
        ),
        'codeName': serializeParam(
          _codeName,
          ParamType.String,
        ),
        'displayName': serializeParam(
          _displayName,
          ParamType.String,
        ),
        'onsetDateTIme': serializeParam(
          _onsetDateTIme,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static DiabetesTypesStruct fromSerializableMap(Map<String, dynamic> data) =>
      DiabetesTypesStruct(
        code: deserializeParam(
          data['code'],
          ParamType.String,
          false,
        ),
        codeName: deserializeParam(
          data['codeName'],
          ParamType.String,
          false,
        ),
        displayName: deserializeParam(
          data['displayName'],
          ParamType.String,
          false,
        ),
        onsetDateTIme: deserializeParam(
          data['onsetDateTIme'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'DiabetesTypesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DiabetesTypesStruct &&
        code == other.code &&
        codeName == other.codeName &&
        displayName == other.displayName &&
        onsetDateTIme == other.onsetDateTIme;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([code, codeName, displayName, onsetDateTIme]);
}

DiabetesTypesStruct createDiabetesTypesStruct({
  String? code,
  String? codeName,
  String? displayName,
  DateTime? onsetDateTIme,
}) =>
    DiabetesTypesStruct(
      code: code,
      codeName: codeName,
      displayName: displayName,
      onsetDateTIme: onsetDateTIme,
    );
