// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PatientStruct extends BaseStruct {
  PatientStruct({
    String? identifier,
    String? givenNames,
    String? familyName,
    String? telecomSystem,
    String? telecomValue,
    String? gender,
    String? birthDate,
    String? firstName,
  })  : _identifier = identifier,
        _givenNames = givenNames,
        _familyName = familyName,
        _telecomSystem = telecomSystem,
        _telecomValue = telecomValue,
        _gender = gender,
        _birthDate = birthDate,
        _firstName = firstName;

  // "identifier" field.
  String? _identifier;
  String get identifier => _identifier ?? '';
  set identifier(String? val) => _identifier = val;

  bool hasIdentifier() => _identifier != null;

  // "givenNames" field.
  String? _givenNames;
  String get givenNames => _givenNames ?? '';
  set givenNames(String? val) => _givenNames = val;

  bool hasGivenNames() => _givenNames != null;

  // "familyName" field.
  String? _familyName;
  String get familyName => _familyName ?? '';
  set familyName(String? val) => _familyName = val;

  bool hasFamilyName() => _familyName != null;

  // "telecomSystem" field.
  String? _telecomSystem;
  String get telecomSystem => _telecomSystem ?? '';
  set telecomSystem(String? val) => _telecomSystem = val;

  bool hasTelecomSystem() => _telecomSystem != null;

  // "telecomValue" field.
  String? _telecomValue;
  String get telecomValue => _telecomValue ?? '';
  set telecomValue(String? val) => _telecomValue = val;

  bool hasTelecomValue() => _telecomValue != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  set gender(String? val) => _gender = val;

  bool hasGender() => _gender != null;

  // "birthDate" field.
  String? _birthDate;
  String get birthDate => _birthDate ?? '';
  set birthDate(String? val) => _birthDate = val;

  bool hasBirthDate() => _birthDate != null;

  // "firstName" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) => _firstName = val;

  bool hasFirstName() => _firstName != null;

  static PatientStruct fromMap(Map<String, dynamic> data) => PatientStruct(
        identifier: data['identifier'] as String?,
        givenNames: data['givenNames'] as String?,
        familyName: data['familyName'] as String?,
        telecomSystem: data['telecomSystem'] as String?,
        telecomValue: data['telecomValue'] as String?,
        gender: data['gender'] as String?,
        birthDate: data['birthDate'] as String?,
        firstName: data['firstName'] as String?,
      );

  static PatientStruct? maybeFromMap(dynamic data) =>
      data is Map ? PatientStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'identifier': _identifier,
        'givenNames': _givenNames,
        'familyName': _familyName,
        'telecomSystem': _telecomSystem,
        'telecomValue': _telecomValue,
        'gender': _gender,
        'birthDate': _birthDate,
        'firstName': _firstName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'identifier': serializeParam(
          _identifier,
          ParamType.String,
        ),
        'givenNames': serializeParam(
          _givenNames,
          ParamType.String,
        ),
        'familyName': serializeParam(
          _familyName,
          ParamType.String,
        ),
        'telecomSystem': serializeParam(
          _telecomSystem,
          ParamType.String,
        ),
        'telecomValue': serializeParam(
          _telecomValue,
          ParamType.String,
        ),
        'gender': serializeParam(
          _gender,
          ParamType.String,
        ),
        'birthDate': serializeParam(
          _birthDate,
          ParamType.String,
        ),
        'firstName': serializeParam(
          _firstName,
          ParamType.String,
        ),
      }.withoutNulls;

  static PatientStruct fromSerializableMap(Map<String, dynamic> data) =>
      PatientStruct(
        identifier: deserializeParam(
          data['identifier'],
          ParamType.String,
          false,
        ),
        givenNames: deserializeParam(
          data['givenNames'],
          ParamType.String,
          false,
        ),
        familyName: deserializeParam(
          data['familyName'],
          ParamType.String,
          false,
        ),
        telecomSystem: deserializeParam(
          data['telecomSystem'],
          ParamType.String,
          false,
        ),
        telecomValue: deserializeParam(
          data['telecomValue'],
          ParamType.String,
          false,
        ),
        gender: deserializeParam(
          data['gender'],
          ParamType.String,
          false,
        ),
        birthDate: deserializeParam(
          data['birthDate'],
          ParamType.String,
          false,
        ),
        firstName: deserializeParam(
          data['firstName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PatientStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PatientStruct &&
        identifier == other.identifier &&
        givenNames == other.givenNames &&
        familyName == other.familyName &&
        telecomSystem == other.telecomSystem &&
        telecomValue == other.telecomValue &&
        gender == other.gender &&
        birthDate == other.birthDate &&
        firstName == other.firstName;
  }

  @override
  int get hashCode => const ListEquality().hash([
        identifier,
        givenNames,
        familyName,
        telecomSystem,
        telecomValue,
        gender,
        birthDate,
        firstName
      ]);
}

PatientStruct createPatientStruct({
  String? identifier,
  String? givenNames,
  String? familyName,
  String? telecomSystem,
  String? telecomValue,
  String? gender,
  String? birthDate,
  String? firstName,
}) =>
    PatientStruct(
      identifier: identifier,
      givenNames: givenNames,
      familyName: familyName,
      telecomSystem: telecomSystem,
      telecomValue: telecomValue,
      gender: gender,
      birthDate: birthDate,
      firstName: firstName,
    );
