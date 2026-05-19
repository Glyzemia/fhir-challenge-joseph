// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PractitionerStruct extends BaseStruct {
  PractitionerStruct({
    String? id,
    String? combinedNames,
    String? prefix,
  })  : _id = id,
        _combinedNames = combinedNames,
        _prefix = prefix;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "combinedNames" field.
  String? _combinedNames;
  String get combinedNames => _combinedNames ?? '';
  set combinedNames(String? val) => _combinedNames = val;

  bool hasCombinedNames() => _combinedNames != null;

  // "prefix" field.
  String? _prefix;
  String get prefix => _prefix ?? '';
  set prefix(String? val) => _prefix = val;

  bool hasPrefix() => _prefix != null;

  static PractitionerStruct fromMap(Map<String, dynamic> data) =>
      PractitionerStruct(
        id: data['id'] as String?,
        combinedNames: data['combinedNames'] as String?,
        prefix: data['prefix'] as String?,
      );

  static PractitionerStruct? maybeFromMap(dynamic data) => data is Map
      ? PractitionerStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'combinedNames': _combinedNames,
        'prefix': _prefix,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'combinedNames': serializeParam(
          _combinedNames,
          ParamType.String,
        ),
        'prefix': serializeParam(
          _prefix,
          ParamType.String,
        ),
      }.withoutNulls;

  static PractitionerStruct fromSerializableMap(Map<String, dynamic> data) =>
      PractitionerStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        combinedNames: deserializeParam(
          data['combinedNames'],
          ParamType.String,
          false,
        ),
        prefix: deserializeParam(
          data['prefix'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PractitionerStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PractitionerStruct &&
        id == other.id &&
        combinedNames == other.combinedNames &&
        prefix == other.prefix;
  }

  @override
  int get hashCode => const ListEquality().hash([id, combinedNames, prefix]);
}

PractitionerStruct createPractitionerStruct({
  String? id,
  String? combinedNames,
  String? prefix,
}) =>
    PractitionerStruct(
      id: id,
      combinedNames: combinedNames,
      prefix: prefix,
    );
