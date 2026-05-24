// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InsulinAdviceStruct extends BaseStruct {
  InsulinAdviceStruct({
    String? medicationRequestId,
    String? tidObservationId,
    String? patientId,
    String? encounterId,
    String? medicationName,
    int? dose,
    String? status,
    String? doctorId,
    String? doctorName,
    String? doctorNotes,
    DateTime? authoredOn,
    String? timespot,
    String? insulinType,
  })  : _medicationRequestId = medicationRequestId,
        _tidObservationId = tidObservationId,
        _patientId = patientId,
        _encounterId = encounterId,
        _medicationName = medicationName,
        _dose = dose,
        _status = status,
        _doctorId = doctorId,
        _doctorName = doctorName,
        _doctorNotes = doctorNotes,
        _authoredOn = authoredOn,
        _timespot = timespot,
        _insulinType = insulinType;

  // "medicationRequestId" field.
  String? _medicationRequestId;
  String get medicationRequestId => _medicationRequestId ?? '';
  set medicationRequestId(String? val) => _medicationRequestId = val;

  bool hasMedicationRequestId() => _medicationRequestId != null;

  // "tidObservationId" field.
  String? _tidObservationId;
  String get tidObservationId => _tidObservationId ?? '';
  set tidObservationId(String? val) => _tidObservationId = val;

  bool hasTidObservationId() => _tidObservationId != null;

  // "patientId" field.
  String? _patientId;
  String get patientId => _patientId ?? '';
  set patientId(String? val) => _patientId = val;

  bool hasPatientId() => _patientId != null;

  // "encounterId" field.
  String? _encounterId;
  String get encounterId => _encounterId ?? '';
  set encounterId(String? val) => _encounterId = val;

  bool hasEncounterId() => _encounterId != null;

  // "medicationName" field.
  String? _medicationName;
  String get medicationName => _medicationName ?? '';
  set medicationName(String? val) => _medicationName = val;

  bool hasMedicationName() => _medicationName != null;

  // "dose" field.
  int? _dose;
  int get dose => _dose ?? 0;
  set dose(int? val) => _dose = val;

  void incrementDose(int amount) => dose = dose + amount;

  bool hasDose() => _dose != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "doctorId" field.
  String? _doctorId;
  String get doctorId => _doctorId ?? '';
  set doctorId(String? val) => _doctorId = val;

  bool hasDoctorId() => _doctorId != null;

  // "doctorName" field.
  String? _doctorName;
  String get doctorName => _doctorName ?? '';
  set doctorName(String? val) => _doctorName = val;

  bool hasDoctorName() => _doctorName != null;

  // "doctorNotes" field.
  String? _doctorNotes;
  String get doctorNotes => _doctorNotes ?? '';
  set doctorNotes(String? val) => _doctorNotes = val;

  bool hasDoctorNotes() => _doctorNotes != null;

  // "authoredOn" field.
  DateTime? _authoredOn;
  DateTime? get authoredOn => _authoredOn;
  set authoredOn(DateTime? val) => _authoredOn = val;

  bool hasAuthoredOn() => _authoredOn != null;

  // "timespot" field.
  String? _timespot;
  String get timespot => _timespot ?? '';
  set timespot(String? val) => _timespot = val;

  bool hasTimespot() => _timespot != null;

  // "insulinType" field.
  String? _insulinType;
  String get insulinType => _insulinType ?? '';
  set insulinType(String? val) => _insulinType = val;

  bool hasInsulinType() => _insulinType != null;

  static InsulinAdviceStruct fromMap(Map<String, dynamic> data) =>
      InsulinAdviceStruct(
        medicationRequestId: data['medicationRequestId'] as String?,
        tidObservationId: data['tidObservationId'] as String?,
        patientId: data['patientId'] as String?,
        encounterId: data['encounterId'] as String?,
        medicationName: data['medicationName'] as String?,
        dose: castToType<int>(data['dose']),
        status: data['status'] as String?,
        doctorId: data['doctorId'] as String?,
        doctorName: data['doctorName'] as String?,
        doctorNotes: data['doctorNotes'] as String?,
        authoredOn: data['authoredOn'] as DateTime?,
        timespot: data['timespot'] as String?,
        insulinType: data['insulinType'] as String?,
      );

  static InsulinAdviceStruct? maybeFromMap(dynamic data) => data is Map
      ? InsulinAdviceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'medicationRequestId': _medicationRequestId,
        'tidObservationId': _tidObservationId,
        'patientId': _patientId,
        'encounterId': _encounterId,
        'medicationName': _medicationName,
        'dose': _dose,
        'status': _status,
        'doctorId': _doctorId,
        'doctorName': _doctorName,
        'doctorNotes': _doctorNotes,
        'authoredOn': _authoredOn,
        'timespot': _timespot,
        'insulinType': _insulinType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'medicationRequestId': serializeParam(
          _medicationRequestId,
          ParamType.String,
        ),
        'tidObservationId': serializeParam(
          _tidObservationId,
          ParamType.String,
        ),
        'patientId': serializeParam(
          _patientId,
          ParamType.String,
        ),
        'encounterId': serializeParam(
          _encounterId,
          ParamType.String,
        ),
        'medicationName': serializeParam(
          _medicationName,
          ParamType.String,
        ),
        'dose': serializeParam(
          _dose,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'doctorId': serializeParam(
          _doctorId,
          ParamType.String,
        ),
        'doctorName': serializeParam(
          _doctorName,
          ParamType.String,
        ),
        'doctorNotes': serializeParam(
          _doctorNotes,
          ParamType.String,
        ),
        'authoredOn': serializeParam(
          _authoredOn,
          ParamType.DateTime,
        ),
        'timespot': serializeParam(
          _timespot,
          ParamType.String,
        ),
        'insulinType': serializeParam(
          _insulinType,
          ParamType.String,
        ),
      }.withoutNulls;

  static InsulinAdviceStruct fromSerializableMap(Map<String, dynamic> data) =>
      InsulinAdviceStruct(
        medicationRequestId: deserializeParam(
          data['medicationRequestId'],
          ParamType.String,
          false,
        ),
        tidObservationId: deserializeParam(
          data['tidObservationId'],
          ParamType.String,
          false,
        ),
        patientId: deserializeParam(
          data['patientId'],
          ParamType.String,
          false,
        ),
        encounterId: deserializeParam(
          data['encounterId'],
          ParamType.String,
          false,
        ),
        medicationName: deserializeParam(
          data['medicationName'],
          ParamType.String,
          false,
        ),
        dose: deserializeParam(
          data['dose'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        doctorId: deserializeParam(
          data['doctorId'],
          ParamType.String,
          false,
        ),
        doctorName: deserializeParam(
          data['doctorName'],
          ParamType.String,
          false,
        ),
        doctorNotes: deserializeParam(
          data['doctorNotes'],
          ParamType.String,
          false,
        ),
        authoredOn: deserializeParam(
          data['authoredOn'],
          ParamType.DateTime,
          false,
        ),
        timespot: deserializeParam(
          data['timespot'],
          ParamType.String,
          false,
        ),
        insulinType: deserializeParam(
          data['insulinType'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'InsulinAdviceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InsulinAdviceStruct &&
        medicationRequestId == other.medicationRequestId &&
        tidObservationId == other.tidObservationId &&
        patientId == other.patientId &&
        encounterId == other.encounterId &&
        medicationName == other.medicationName &&
        dose == other.dose &&
        status == other.status &&
        doctorId == other.doctorId &&
        doctorName == other.doctorName &&
        doctorNotes == other.doctorNotes &&
        authoredOn == other.authoredOn &&
        timespot == other.timespot &&
        insulinType == other.insulinType;
  }

  @override
  int get hashCode => const ListEquality().hash([
        medicationRequestId,
        tidObservationId,
        patientId,
        encounterId,
        medicationName,
        dose,
        status,
        doctorId,
        doctorName,
        doctorNotes,
        authoredOn,
        timespot,
        insulinType
      ]);
}

InsulinAdviceStruct createInsulinAdviceStruct({
  String? medicationRequestId,
  String? tidObservationId,
  String? patientId,
  String? encounterId,
  String? medicationName,
  int? dose,
  String? status,
  String? doctorId,
  String? doctorName,
  String? doctorNotes,
  DateTime? authoredOn,
  String? timespot,
  String? insulinType,
}) =>
    InsulinAdviceStruct(
      medicationRequestId: medicationRequestId,
      tidObservationId: tidObservationId,
      patientId: patientId,
      encounterId: encounterId,
      medicationName: medicationName,
      dose: dose,
      status: status,
      doctorId: doctorId,
      doctorName: doctorName,
      doctorNotes: doctorNotes,
      authoredOn: authoredOn,
      timespot: timespot,
      insulinType: insulinType,
    );
