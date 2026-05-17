// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConditionStruct extends BaseStruct {
  ConditionStruct({
    String? patientID,
    String? conditionName,
    String? conditionCode,
    DateTime? onsetDate,
    String? status,
  })  : _patientID = patientID,
        _conditionName = conditionName,
        _conditionCode = conditionCode,
        _onsetDate = onsetDate,
        _status = status;

  // "patientID" field.
  String? _patientID;
  String get patientID => _patientID ?? '';
  set patientID(String? val) => _patientID = val;

  bool hasPatientID() => _patientID != null;

  // "conditionName" field.
  String? _conditionName;
  String get conditionName => _conditionName ?? '';
  set conditionName(String? val) => _conditionName = val;

  bool hasConditionName() => _conditionName != null;

  // "conditionCode" field.
  String? _conditionCode;
  String get conditionCode => _conditionCode ?? '';
  set conditionCode(String? val) => _conditionCode = val;

  bool hasConditionCode() => _conditionCode != null;

  // "onsetDate" field.
  DateTime? _onsetDate;
  DateTime? get onsetDate => _onsetDate;
  set onsetDate(DateTime? val) => _onsetDate = val;

  bool hasOnsetDate() => _onsetDate != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static ConditionStruct fromMap(Map<String, dynamic> data) => ConditionStruct(
        patientID: data['patientID'] as String?,
        conditionName: data['conditionName'] as String?,
        conditionCode: data['conditionCode'] as String?,
        onsetDate: data['onsetDate'] as DateTime?,
        status: data['status'] as String?,
      );

  static ConditionStruct? maybeFromMap(dynamic data) => data is Map
      ? ConditionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'patientID': _patientID,
        'conditionName': _conditionName,
        'conditionCode': _conditionCode,
        'onsetDate': _onsetDate,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'patientID': serializeParam(
          _patientID,
          ParamType.String,
        ),
        'conditionName': serializeParam(
          _conditionName,
          ParamType.String,
        ),
        'conditionCode': serializeParam(
          _conditionCode,
          ParamType.String,
        ),
        'onsetDate': serializeParam(
          _onsetDate,
          ParamType.DateTime,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static ConditionStruct fromSerializableMap(Map<String, dynamic> data) =>
      ConditionStruct(
        patientID: deserializeParam(
          data['patientID'],
          ParamType.String,
          false,
        ),
        conditionName: deserializeParam(
          data['conditionName'],
          ParamType.String,
          false,
        ),
        conditionCode: deserializeParam(
          data['conditionCode'],
          ParamType.String,
          false,
        ),
        onsetDate: deserializeParam(
          data['onsetDate'],
          ParamType.DateTime,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ConditionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ConditionStruct &&
        patientID == other.patientID &&
        conditionName == other.conditionName &&
        conditionCode == other.conditionCode &&
        onsetDate == other.onsetDate &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([patientID, conditionName, conditionCode, onsetDate, status]);
}

ConditionStruct createConditionStruct({
  String? patientID,
  String? conditionName,
  String? conditionCode,
  DateTime? onsetDate,
  String? status,
}) =>
    ConditionStruct(
      patientID: patientID,
      conditionName: conditionName,
      conditionCode: conditionCode,
      onsetDate: onsetDate,
      status: status,
    );
