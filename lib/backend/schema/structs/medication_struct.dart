// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MedicationStruct extends BaseStruct {
  MedicationStruct({
    String? patientID,
    String? medicationName,
    String? medicationDose,
    String? frequency,
    String? route,
    String? status,
  })  : _patientID = patientID,
        _medicationName = medicationName,
        _medicationDose = medicationDose,
        _frequency = frequency,
        _route = route,
        _status = status;

  // "patientID" field.
  String? _patientID;
  String get patientID => _patientID ?? '';
  set patientID(String? val) => _patientID = val;

  bool hasPatientID() => _patientID != null;

  // "medicationName" field.
  String? _medicationName;
  String get medicationName => _medicationName ?? '';
  set medicationName(String? val) => _medicationName = val;

  bool hasMedicationName() => _medicationName != null;

  // "medicationDose" field.
  String? _medicationDose;
  String get medicationDose => _medicationDose ?? '';
  set medicationDose(String? val) => _medicationDose = val;

  bool hasMedicationDose() => _medicationDose != null;

  // "frequency" field.
  String? _frequency;
  String get frequency => _frequency ?? '';
  set frequency(String? val) => _frequency = val;

  bool hasFrequency() => _frequency != null;

  // "route" field.
  String? _route;
  String get route => _route ?? '';
  set route(String? val) => _route = val;

  bool hasRoute() => _route != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static MedicationStruct fromMap(Map<String, dynamic> data) =>
      MedicationStruct(
        patientID: data['patientID'] as String?,
        medicationName: data['medicationName'] as String?,
        medicationDose: data['medicationDose'] as String?,
        frequency: data['frequency'] as String?,
        route: data['route'] as String?,
        status: data['status'] as String?,
      );

  static MedicationStruct? maybeFromMap(dynamic data) => data is Map
      ? MedicationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'patientID': _patientID,
        'medicationName': _medicationName,
        'medicationDose': _medicationDose,
        'frequency': _frequency,
        'route': _route,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'patientID': serializeParam(
          _patientID,
          ParamType.String,
        ),
        'medicationName': serializeParam(
          _medicationName,
          ParamType.String,
        ),
        'medicationDose': serializeParam(
          _medicationDose,
          ParamType.String,
        ),
        'frequency': serializeParam(
          _frequency,
          ParamType.String,
        ),
        'route': serializeParam(
          _route,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static MedicationStruct fromSerializableMap(Map<String, dynamic> data) =>
      MedicationStruct(
        patientID: deserializeParam(
          data['patientID'],
          ParamType.String,
          false,
        ),
        medicationName: deserializeParam(
          data['medicationName'],
          ParamType.String,
          false,
        ),
        medicationDose: deserializeParam(
          data['medicationDose'],
          ParamType.String,
          false,
        ),
        frequency: deserializeParam(
          data['frequency'],
          ParamType.String,
          false,
        ),
        route: deserializeParam(
          data['route'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MedicationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MedicationStruct &&
        patientID == other.patientID &&
        medicationName == other.medicationName &&
        medicationDose == other.medicationDose &&
        frequency == other.frequency &&
        route == other.route &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [patientID, medicationName, medicationDose, frequency, route, status]);
}

MedicationStruct createMedicationStruct({
  String? patientID,
  String? medicationName,
  String? medicationDose,
  String? frequency,
  String? route,
  String? status,
}) =>
    MedicationStruct(
      patientID: patientID,
      medicationName: medicationName,
      medicationDose: medicationDose,
      frequency: frequency,
      route: route,
      status: status,
    );
