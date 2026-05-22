// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EncounterStruct extends BaseStruct {
  EncounterStruct({
    String? patientID,
    String? encounterID,
    String? encounterStatus,
    String? encounterType,
    DateTime? admissionDate,
    String? wardName,
    String? admittedUnder,
  })  : _patientID = patientID,
        _encounterID = encounterID,
        _encounterStatus = encounterStatus,
        _encounterType = encounterType,
        _admissionDate = admissionDate,
        _wardName = wardName,
        _admittedUnder = admittedUnder;

  // "patientID" field.
  String? _patientID;
  String get patientID => _patientID ?? '';
  set patientID(String? val) => _patientID = val;

  bool hasPatientID() => _patientID != null;

  // "encounterID" field.
  String? _encounterID;
  String get encounterID => _encounterID ?? '';
  set encounterID(String? val) => _encounterID = val;

  bool hasEncounterID() => _encounterID != null;

  // "encounterStatus" field.
  String? _encounterStatus;
  String get encounterStatus => _encounterStatus ?? '';
  set encounterStatus(String? val) => _encounterStatus = val;

  bool hasEncounterStatus() => _encounterStatus != null;

  // "encounterType" field.
  String? _encounterType;
  String get encounterType => _encounterType ?? '';
  set encounterType(String? val) => _encounterType = val;

  bool hasEncounterType() => _encounterType != null;

  // "admissionDate" field.
  DateTime? _admissionDate;
  DateTime? get admissionDate => _admissionDate;
  set admissionDate(DateTime? val) => _admissionDate = val;

  bool hasAdmissionDate() => _admissionDate != null;

  // "wardName" field.
  String? _wardName;
  String get wardName => _wardName ?? '';
  set wardName(String? val) => _wardName = val;

  bool hasWardName() => _wardName != null;

  // "admittedUnder" field.
  String? _admittedUnder;
  String get admittedUnder => _admittedUnder ?? '';
  set admittedUnder(String? val) => _admittedUnder = val;

  bool hasAdmittedUnder() => _admittedUnder != null;

  static EncounterStruct fromMap(Map<String, dynamic> data) => EncounterStruct(
        patientID: data['patientID'] as String?,
        encounterID: data['encounterID'] as String?,
        encounterStatus: data['encounterStatus'] as String?,
        encounterType: data['encounterType'] as String?,
        admissionDate: data['admissionDate'] as DateTime?,
        wardName: data['wardName'] as String?,
        admittedUnder: data['admittedUnder'] as String?,
      );

  static EncounterStruct? maybeFromMap(dynamic data) => data is Map
      ? EncounterStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'patientID': _patientID,
        'encounterID': _encounterID,
        'encounterStatus': _encounterStatus,
        'encounterType': _encounterType,
        'admissionDate': _admissionDate,
        'wardName': _wardName,
        'admittedUnder': _admittedUnder,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'patientID': serializeParam(
          _patientID,
          ParamType.String,
        ),
        'encounterID': serializeParam(
          _encounterID,
          ParamType.String,
        ),
        'encounterStatus': serializeParam(
          _encounterStatus,
          ParamType.String,
        ),
        'encounterType': serializeParam(
          _encounterType,
          ParamType.String,
        ),
        'admissionDate': serializeParam(
          _admissionDate,
          ParamType.DateTime,
        ),
        'wardName': serializeParam(
          _wardName,
          ParamType.String,
        ),
        'admittedUnder': serializeParam(
          _admittedUnder,
          ParamType.String,
        ),
      }.withoutNulls;

  static EncounterStruct fromSerializableMap(Map<String, dynamic> data) =>
      EncounterStruct(
        patientID: deserializeParam(
          data['patientID'],
          ParamType.String,
          false,
        ),
        encounterID: deserializeParam(
          data['encounterID'],
          ParamType.String,
          false,
        ),
        encounterStatus: deserializeParam(
          data['encounterStatus'],
          ParamType.String,
          false,
        ),
        encounterType: deserializeParam(
          data['encounterType'],
          ParamType.String,
          false,
        ),
        admissionDate: deserializeParam(
          data['admissionDate'],
          ParamType.DateTime,
          false,
        ),
        wardName: deserializeParam(
          data['wardName'],
          ParamType.String,
          false,
        ),
        admittedUnder: deserializeParam(
          data['admittedUnder'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'EncounterStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EncounterStruct &&
        patientID == other.patientID &&
        encounterID == other.encounterID &&
        encounterStatus == other.encounterStatus &&
        encounterType == other.encounterType &&
        admissionDate == other.admissionDate &&
        wardName == other.wardName &&
        admittedUnder == other.admittedUnder;
  }

  @override
  int get hashCode => const ListEquality().hash([
        patientID,
        encounterID,
        encounterStatus,
        encounterType,
        admissionDate,
        wardName,
        admittedUnder
      ]);
}

EncounterStruct createEncounterStruct({
  String? patientID,
  String? encounterID,
  String? encounterStatus,
  String? encounterType,
  DateTime? admissionDate,
  String? wardName,
  String? admittedUnder,
}) =>
    EncounterStruct(
      patientID: patientID,
      encounterID: encounterID,
      encounterStatus: encounterStatus,
      encounterType: encounterType,
      admissionDate: admissionDate,
      wardName: wardName,
      admittedUnder: admittedUnder,
    );
