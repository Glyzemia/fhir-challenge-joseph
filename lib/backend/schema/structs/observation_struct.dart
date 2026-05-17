// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ObservationStruct extends BaseStruct {
  ObservationStruct({
    String? patientID,
    String? observationID,
    String? category,
    String? name,
    String? value,
    String? units,
    DateTime? recordedAt,
  })  : _patientID = patientID,
        _observationID = observationID,
        _category = category,
        _name = name,
        _value = value,
        _units = units,
        _recordedAt = recordedAt;

  // "patientID" field.
  String? _patientID;
  String get patientID => _patientID ?? '';
  set patientID(String? val) => _patientID = val;

  bool hasPatientID() => _patientID != null;

  // "observationID" field.
  String? _observationID;
  String get observationID => _observationID ?? '';
  set observationID(String? val) => _observationID = val;

  bool hasObservationID() => _observationID != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;

  bool hasValue() => _value != null;

  // "units" field.
  String? _units;
  String get units => _units ?? '';
  set units(String? val) => _units = val;

  bool hasUnits() => _units != null;

  // "recordedAt" field.
  DateTime? _recordedAt;
  DateTime? get recordedAt => _recordedAt;
  set recordedAt(DateTime? val) => _recordedAt = val;

  bool hasRecordedAt() => _recordedAt != null;

  static ObservationStruct fromMap(Map<String, dynamic> data) =>
      ObservationStruct(
        patientID: data['patientID'] as String?,
        observationID: data['observationID'] as String?,
        category: data['category'] as String?,
        name: data['name'] as String?,
        value: data['value'] as String?,
        units: data['units'] as String?,
        recordedAt: data['recordedAt'] as DateTime?,
      );

  static ObservationStruct? maybeFromMap(dynamic data) => data is Map
      ? ObservationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'patientID': _patientID,
        'observationID': _observationID,
        'category': _category,
        'name': _name,
        'value': _value,
        'units': _units,
        'recordedAt': _recordedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'patientID': serializeParam(
          _patientID,
          ParamType.String,
        ),
        'observationID': serializeParam(
          _observationID,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.String,
        ),
        'units': serializeParam(
          _units,
          ParamType.String,
        ),
        'recordedAt': serializeParam(
          _recordedAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static ObservationStruct fromSerializableMap(Map<String, dynamic> data) =>
      ObservationStruct(
        patientID: deserializeParam(
          data['patientID'],
          ParamType.String,
          false,
        ),
        observationID: deserializeParam(
          data['observationID'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.String,
          false,
        ),
        units: deserializeParam(
          data['units'],
          ParamType.String,
          false,
        ),
        recordedAt: deserializeParam(
          data['recordedAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'ObservationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ObservationStruct &&
        patientID == other.patientID &&
        observationID == other.observationID &&
        category == other.category &&
        name == other.name &&
        value == other.value &&
        units == other.units &&
        recordedAt == other.recordedAt;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [patientID, observationID, category, name, value, units, recordedAt]);
}

ObservationStruct createObservationStruct({
  String? patientID,
  String? observationID,
  String? category,
  String? name,
  String? value,
  String? units,
  DateTime? recordedAt,
}) =>
    ObservationStruct(
      patientID: patientID,
      observationID: observationID,
      category: category,
      name: name,
      value: value,
      units: units,
      recordedAt: recordedAt,
    );
