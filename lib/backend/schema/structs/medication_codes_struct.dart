// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MedicationCodesStruct extends BaseStruct {
  MedicationCodesStruct({
    String? medicationCode,
    String? medicationName,
  })  : _medicationCode = medicationCode,
        _medicationName = medicationName;

  // "medicationCode" field.
  String? _medicationCode;
  String get medicationCode => _medicationCode ?? '';
  set medicationCode(String? val) => _medicationCode = val;

  bool hasMedicationCode() => _medicationCode != null;

  // "medicationName" field.
  String? _medicationName;
  String get medicationName => _medicationName ?? '';
  set medicationName(String? val) => _medicationName = val;

  bool hasMedicationName() => _medicationName != null;

  static MedicationCodesStruct fromMap(Map<String, dynamic> data) =>
      MedicationCodesStruct(
        medicationCode: data['medicationCode'] as String?,
        medicationName: data['medicationName'] as String?,
      );

  static MedicationCodesStruct? maybeFromMap(dynamic data) => data is Map
      ? MedicationCodesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'medicationCode': _medicationCode,
        'medicationName': _medicationName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'medicationCode': serializeParam(
          _medicationCode,
          ParamType.String,
        ),
        'medicationName': serializeParam(
          _medicationName,
          ParamType.String,
        ),
      }.withoutNulls;

  static MedicationCodesStruct fromSerializableMap(Map<String, dynamic> data) =>
      MedicationCodesStruct(
        medicationCode: deserializeParam(
          data['medicationCode'],
          ParamType.String,
          false,
        ),
        medicationName: deserializeParam(
          data['medicationName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MedicationCodesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MedicationCodesStruct &&
        medicationCode == other.medicationCode &&
        medicationName == other.medicationName;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([medicationCode, medicationName]);
}

MedicationCodesStruct createMedicationCodesStruct({
  String? medicationCode,
  String? medicationName,
}) =>
    MedicationCodesStruct(
      medicationCode: medicationCode,
      medicationName: medicationName,
    );
