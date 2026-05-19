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
    String? combinedNames,
    DateTime? lastUpdated,
    int? latestNEWS2Score,
    bool? latestSingleRedScore,
    bool? hasLatestNEWS2Score,
  })  : _identifier = identifier,
        _givenNames = givenNames,
        _familyName = familyName,
        _telecomSystem = telecomSystem,
        _telecomValue = telecomValue,
        _gender = gender,
        _birthDate = birthDate,
        _firstName = firstName,
        _combinedNames = combinedNames,
        _lastUpdated = lastUpdated,
        _latestNEWS2Score = latestNEWS2Score,
        _latestSingleRedScore = latestSingleRedScore,
        _hasLatestNEWS2Score = hasLatestNEWS2Score;

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

  // "combinedNames" field.
  String? _combinedNames;
  String get combinedNames => _combinedNames ?? '';
  set combinedNames(String? val) => _combinedNames = val;

  bool hasCombinedNames() => _combinedNames != null;

  // "lastUpdated" field.
  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _lastUpdated;
  set lastUpdated(DateTime? val) => _lastUpdated = val;

  bool hasLastUpdated() => _lastUpdated != null;

  // "latestNEWS2Score" field.
  int? _latestNEWS2Score;
  int get latestNEWS2Score => _latestNEWS2Score ?? 0;
  set latestNEWS2Score(int? val) => _latestNEWS2Score = val;

  void incrementLatestNEWS2Score(int amount) =>
      latestNEWS2Score = latestNEWS2Score + amount;

  bool hasLatestNEWS2ScoreField() => _latestNEWS2Score != null;

  // "latestSingleRedScore" field.
  bool? _latestSingleRedScore;
  bool get latestSingleRedScore => _latestSingleRedScore ?? false;
  set latestSingleRedScore(bool? val) => _latestSingleRedScore = val;

  bool hasLatestSingleRedScore() => _latestSingleRedScore != null;

  // "hasLatestNEWS2Score" field.
  bool? _hasLatestNEWS2Score;
  bool get hasLatestNEWS2Score => _hasLatestNEWS2Score ?? false;
  set hasLatestNEWS2Score(bool? val) => _hasLatestNEWS2Score = val;

  bool hasHasLatestNEWS2Score() => _hasLatestNEWS2Score != null;

  static PatientStruct fromMap(Map<String, dynamic> data) => PatientStruct(
        identifier: data['identifier'] as String?,
        givenNames: data['givenNames'] as String?,
        familyName: data['familyName'] as String?,
        telecomSystem: data['telecomSystem'] as String?,
        telecomValue: data['telecomValue'] as String?,
        gender: data['gender'] as String?,
        birthDate: data['birthDate'] as String?,
        firstName: data['firstName'] as String?,
        combinedNames: data['combinedNames'] as String?,
        lastUpdated: data['lastUpdated'] as DateTime?,
        latestNEWS2Score: castToType<int>(data['latestNEWS2Score']),
        latestSingleRedScore: data['latestSingleRedScore'] as bool?,
        hasLatestNEWS2Score: data['hasLatestNEWS2Score'] as bool?,
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
        'combinedNames': _combinedNames,
        'lastUpdated': _lastUpdated,
        'latestNEWS2Score': _latestNEWS2Score,
        'latestSingleRedScore': _latestSingleRedScore,
        'hasLatestNEWS2Score': _hasLatestNEWS2Score,
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
        'combinedNames': serializeParam(
          _combinedNames,
          ParamType.String,
        ),
        'lastUpdated': serializeParam(
          _lastUpdated,
          ParamType.DateTime,
        ),
        'latestNEWS2Score': serializeParam(
          _latestNEWS2Score,
          ParamType.int,
        ),
        'latestSingleRedScore': serializeParam(
          _latestSingleRedScore,
          ParamType.bool,
        ),
        'hasLatestNEWS2Score': serializeParam(
          _hasLatestNEWS2Score,
          ParamType.bool,
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
        combinedNames: deserializeParam(
          data['combinedNames'],
          ParamType.String,
          false,
        ),
        lastUpdated: deserializeParam(
          data['lastUpdated'],
          ParamType.DateTime,
          false,
        ),
        latestNEWS2Score: deserializeParam(
          data['latestNEWS2Score'],
          ParamType.int,
          false,
        ),
        latestSingleRedScore: deserializeParam(
          data['latestSingleRedScore'],
          ParamType.bool,
          false,
        ),
        hasLatestNEWS2Score: deserializeParam(
          data['hasLatestNEWS2Score'],
          ParamType.bool,
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
        firstName == other.firstName &&
        combinedNames == other.combinedNames &&
        lastUpdated == other.lastUpdated &&
        latestNEWS2Score == other.latestNEWS2Score &&
        latestSingleRedScore == other.latestSingleRedScore &&
        hasLatestNEWS2Score == other.hasLatestNEWS2Score;
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
        firstName,
        combinedNames,
        lastUpdated,
        latestNEWS2Score,
        latestSingleRedScore,
        hasLatestNEWS2Score
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
  String? combinedNames,
  DateTime? lastUpdated,
  int? latestNEWS2Score,
  bool? latestSingleRedScore,
  bool? hasLatestNEWS2Score,
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
      combinedNames: combinedNames,
      lastUpdated: lastUpdated,
      latestNEWS2Score: latestNEWS2Score,
      latestSingleRedScore: latestSingleRedScore,
      hasLatestNEWS2Score: hasLatestNEWS2Score,
    );
