// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InsulinAdministrationStruct extends BaseStruct {
  InsulinAdministrationStruct({
    String? medicationAdministrationId,
    String? medicationRequestId,
    String? patientId,
    String? encounterId,
    String? medicationName,
    int? dose,
    String? status,
    String? nurseId,
    String? nurseName,
    DateTime? completedAt,
    String? nurseNotes,
    String? route,
    DateTime? date,
    String? timespot,
    String? tidIdentifier,
  })  : _medicationAdministrationId = medicationAdministrationId,
        _medicationRequestId = medicationRequestId,
        _patientId = patientId,
        _encounterId = encounterId,
        _medicationName = medicationName,
        _dose = dose,
        _status = status,
        _nurseId = nurseId,
        _nurseName = nurseName,
        _completedAt = completedAt,
        _nurseNotes = nurseNotes,
        _route = route,
        _date = date,
        _timespot = timespot,
        _tidIdentifier = tidIdentifier;

  // "medicationAdministrationId" field.
  String? _medicationAdministrationId;
  String get medicationAdministrationId => _medicationAdministrationId ?? '';
  set medicationAdministrationId(String? val) =>
      _medicationAdministrationId = val;

  bool hasMedicationAdministrationId() => _medicationAdministrationId != null;

  // "medicationRequestId" field.
  String? _medicationRequestId;
  String get medicationRequestId => _medicationRequestId ?? '';
  set medicationRequestId(String? val) => _medicationRequestId = val;

  bool hasMedicationRequestId() => _medicationRequestId != null;

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

  // "nurseId" field.
  String? _nurseId;
  String get nurseId => _nurseId ?? '';
  set nurseId(String? val) => _nurseId = val;

  bool hasNurseId() => _nurseId != null;

  // "nurseName" field.
  String? _nurseName;
  String get nurseName => _nurseName ?? '';
  set nurseName(String? val) => _nurseName = val;

  bool hasNurseName() => _nurseName != null;

  // "completedAt" field.
  DateTime? _completedAt;
  DateTime? get completedAt => _completedAt;
  set completedAt(DateTime? val) => _completedAt = val;

  bool hasCompletedAt() => _completedAt != null;

  // "nurseNotes" field.
  String? _nurseNotes;
  String get nurseNotes => _nurseNotes ?? '';
  set nurseNotes(String? val) => _nurseNotes = val;

  bool hasNurseNotes() => _nurseNotes != null;

  // "route" field.
  String? _route;
  String get route => _route ?? '';
  set route(String? val) => _route = val;

  bool hasRoute() => _route != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "timespot" field.
  String? _timespot;
  String get timespot => _timespot ?? '';
  set timespot(String? val) => _timespot = val;

  bool hasTimespot() => _timespot != null;

  // "tidIdentifier" field.
  String? _tidIdentifier;
  String get tidIdentifier => _tidIdentifier ?? '';
  set tidIdentifier(String? val) => _tidIdentifier = val;

  bool hasTidIdentifier() => _tidIdentifier != null;

  static InsulinAdministrationStruct fromMap(Map<String, dynamic> data) =>
      InsulinAdministrationStruct(
        medicationAdministrationId:
            data['medicationAdministrationId'] as String?,
        medicationRequestId: data['medicationRequestId'] as String?,
        patientId: data['patientId'] as String?,
        encounterId: data['encounterId'] as String?,
        medicationName: data['medicationName'] as String?,
        dose: castToType<int>(data['dose']),
        status: data['status'] as String?,
        nurseId: data['nurseId'] as String?,
        nurseName: data['nurseName'] as String?,
        completedAt: data['completedAt'] as DateTime?,
        nurseNotes: data['nurseNotes'] as String?,
        route: data['route'] as String?,
        date: data['date'] as DateTime?,
        timespot: data['timespot'] as String?,
        tidIdentifier: data['tidIdentifier'] as String?,
      );

  static InsulinAdministrationStruct? maybeFromMap(dynamic data) => data is Map
      ? InsulinAdministrationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'medicationAdministrationId': _medicationAdministrationId,
        'medicationRequestId': _medicationRequestId,
        'patientId': _patientId,
        'encounterId': _encounterId,
        'medicationName': _medicationName,
        'dose': _dose,
        'status': _status,
        'nurseId': _nurseId,
        'nurseName': _nurseName,
        'completedAt': _completedAt,
        'nurseNotes': _nurseNotes,
        'route': _route,
        'date': _date,
        'timespot': _timespot,
        'tidIdentifier': _tidIdentifier,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'medicationAdministrationId': serializeParam(
          _medicationAdministrationId,
          ParamType.String,
        ),
        'medicationRequestId': serializeParam(
          _medicationRequestId,
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
        'nurseId': serializeParam(
          _nurseId,
          ParamType.String,
        ),
        'nurseName': serializeParam(
          _nurseName,
          ParamType.String,
        ),
        'completedAt': serializeParam(
          _completedAt,
          ParamType.DateTime,
        ),
        'nurseNotes': serializeParam(
          _nurseNotes,
          ParamType.String,
        ),
        'route': serializeParam(
          _route,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'timespot': serializeParam(
          _timespot,
          ParamType.String,
        ),
        'tidIdentifier': serializeParam(
          _tidIdentifier,
          ParamType.String,
        ),
      }.withoutNulls;

  static InsulinAdministrationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      InsulinAdministrationStruct(
        medicationAdministrationId: deserializeParam(
          data['medicationAdministrationId'],
          ParamType.String,
          false,
        ),
        medicationRequestId: deserializeParam(
          data['medicationRequestId'],
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
        nurseId: deserializeParam(
          data['nurseId'],
          ParamType.String,
          false,
        ),
        nurseName: deserializeParam(
          data['nurseName'],
          ParamType.String,
          false,
        ),
        completedAt: deserializeParam(
          data['completedAt'],
          ParamType.DateTime,
          false,
        ),
        nurseNotes: deserializeParam(
          data['nurseNotes'],
          ParamType.String,
          false,
        ),
        route: deserializeParam(
          data['route'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        timespot: deserializeParam(
          data['timespot'],
          ParamType.String,
          false,
        ),
        tidIdentifier: deserializeParam(
          data['tidIdentifier'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'InsulinAdministrationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InsulinAdministrationStruct &&
        medicationAdministrationId == other.medicationAdministrationId &&
        medicationRequestId == other.medicationRequestId &&
        patientId == other.patientId &&
        encounterId == other.encounterId &&
        medicationName == other.medicationName &&
        dose == other.dose &&
        status == other.status &&
        nurseId == other.nurseId &&
        nurseName == other.nurseName &&
        completedAt == other.completedAt &&
        nurseNotes == other.nurseNotes &&
        route == other.route &&
        date == other.date &&
        timespot == other.timespot &&
        tidIdentifier == other.tidIdentifier;
  }

  @override
  int get hashCode => const ListEquality().hash([
        medicationAdministrationId,
        medicationRequestId,
        patientId,
        encounterId,
        medicationName,
        dose,
        status,
        nurseId,
        nurseName,
        completedAt,
        nurseNotes,
        route,
        date,
        timespot,
        tidIdentifier
      ]);
}

InsulinAdministrationStruct createInsulinAdministrationStruct({
  String? medicationAdministrationId,
  String? medicationRequestId,
  String? patientId,
  String? encounterId,
  String? medicationName,
  int? dose,
  String? status,
  String? nurseId,
  String? nurseName,
  DateTime? completedAt,
  String? nurseNotes,
  String? route,
  DateTime? date,
  String? timespot,
  String? tidIdentifier,
}) =>
    InsulinAdministrationStruct(
      medicationAdministrationId: medicationAdministrationId,
      medicationRequestId: medicationRequestId,
      patientId: patientId,
      encounterId: encounterId,
      medicationName: medicationName,
      dose: dose,
      status: status,
      nurseId: nurseId,
      nurseName: nurseName,
      completedAt: completedAt,
      nurseNotes: nurseNotes,
      route: route,
      date: date,
      timespot: timespot,
      tidIdentifier: tidIdentifier,
    );
