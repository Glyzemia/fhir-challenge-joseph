// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MedicationStatementStruct extends BaseStruct {
  MedicationStatementStruct({
    String? medicationName,
    int? morningDose,
    int? afternoonDose,
    int? nightDose,
    String? route,
  })  : _medicationName = medicationName,
        _morningDose = morningDose,
        _afternoonDose = afternoonDose,
        _nightDose = nightDose,
        _route = route;

  // "medicationName" field.
  String? _medicationName;
  String get medicationName => _medicationName ?? '';
  set medicationName(String? val) => _medicationName = val;

  bool hasMedicationName() => _medicationName != null;

  // "morningDose" field.
  int? _morningDose;
  int get morningDose => _morningDose ?? 0;
  set morningDose(int? val) => _morningDose = val;

  void incrementMorningDose(int amount) => morningDose = morningDose + amount;

  bool hasMorningDose() => _morningDose != null;

  // "afternoonDose" field.
  int? _afternoonDose;
  int get afternoonDose => _afternoonDose ?? 0;
  set afternoonDose(int? val) => _afternoonDose = val;

  void incrementAfternoonDose(int amount) =>
      afternoonDose = afternoonDose + amount;

  bool hasAfternoonDose() => _afternoonDose != null;

  // "nightDose" field.
  int? _nightDose;
  int get nightDose => _nightDose ?? 0;
  set nightDose(int? val) => _nightDose = val;

  void incrementNightDose(int amount) => nightDose = nightDose + amount;

  bool hasNightDose() => _nightDose != null;

  // "route" field.
  String? _route;
  String get route => _route ?? '';
  set route(String? val) => _route = val;

  bool hasRoute() => _route != null;

  static MedicationStatementStruct fromMap(Map<String, dynamic> data) =>
      MedicationStatementStruct(
        medicationName: data['medicationName'] as String?,
        morningDose: castToType<int>(data['morningDose']),
        afternoonDose: castToType<int>(data['afternoonDose']),
        nightDose: castToType<int>(data['nightDose']),
        route: data['route'] as String?,
      );

  static MedicationStatementStruct? maybeFromMap(dynamic data) => data is Map
      ? MedicationStatementStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'medicationName': _medicationName,
        'morningDose': _morningDose,
        'afternoonDose': _afternoonDose,
        'nightDose': _nightDose,
        'route': _route,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'medicationName': serializeParam(
          _medicationName,
          ParamType.String,
        ),
        'morningDose': serializeParam(
          _morningDose,
          ParamType.int,
        ),
        'afternoonDose': serializeParam(
          _afternoonDose,
          ParamType.int,
        ),
        'nightDose': serializeParam(
          _nightDose,
          ParamType.int,
        ),
        'route': serializeParam(
          _route,
          ParamType.String,
        ),
      }.withoutNulls;

  static MedicationStatementStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      MedicationStatementStruct(
        medicationName: deserializeParam(
          data['medicationName'],
          ParamType.String,
          false,
        ),
        morningDose: deserializeParam(
          data['morningDose'],
          ParamType.int,
          false,
        ),
        afternoonDose: deserializeParam(
          data['afternoonDose'],
          ParamType.int,
          false,
        ),
        nightDose: deserializeParam(
          data['nightDose'],
          ParamType.int,
          false,
        ),
        route: deserializeParam(
          data['route'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MedicationStatementStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MedicationStatementStruct &&
        medicationName == other.medicationName &&
        morningDose == other.morningDose &&
        afternoonDose == other.afternoonDose &&
        nightDose == other.nightDose &&
        route == other.route;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([medicationName, morningDose, afternoonDose, nightDose, route]);
}

MedicationStatementStruct createMedicationStatementStruct({
  String? medicationName,
  int? morningDose,
  int? afternoonDose,
  int? nightDose,
  String? route,
}) =>
    MedicationStatementStruct(
      medicationName: medicationName,
      morningDose: morningDose,
      afternoonDose: afternoonDose,
      nightDose: nightDose,
      route: route,
    );
