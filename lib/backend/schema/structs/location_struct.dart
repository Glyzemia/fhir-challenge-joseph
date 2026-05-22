// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LocationStruct extends BaseStruct {
  LocationStruct({
    String? locationID,
    String? locationName,
    String? locationType,
  })  : _locationID = locationID,
        _locationName = locationName,
        _locationType = locationType;

  // "locationID" field.
  String? _locationID;
  String get locationID => _locationID ?? '';
  set locationID(String? val) => _locationID = val;

  bool hasLocationID() => _locationID != null;

  // "locationName" field.
  String? _locationName;
  String get locationName => _locationName ?? '';
  set locationName(String? val) => _locationName = val;

  bool hasLocationName() => _locationName != null;

  // "locationType" field.
  String? _locationType;
  String get locationType => _locationType ?? '';
  set locationType(String? val) => _locationType = val;

  bool hasLocationType() => _locationType != null;

  static LocationStruct fromMap(Map<String, dynamic> data) => LocationStruct(
        locationID: data['locationID'] as String?,
        locationName: data['locationName'] as String?,
        locationType: data['locationType'] as String?,
      );

  static LocationStruct? maybeFromMap(dynamic data) =>
      data is Map ? LocationStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'locationID': _locationID,
        'locationName': _locationName,
        'locationType': _locationType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'locationID': serializeParam(
          _locationID,
          ParamType.String,
        ),
        'locationName': serializeParam(
          _locationName,
          ParamType.String,
        ),
        'locationType': serializeParam(
          _locationType,
          ParamType.String,
        ),
      }.withoutNulls;

  static LocationStruct fromSerializableMap(Map<String, dynamic> data) =>
      LocationStruct(
        locationID: deserializeParam(
          data['locationID'],
          ParamType.String,
          false,
        ),
        locationName: deserializeParam(
          data['locationName'],
          ParamType.String,
          false,
        ),
        locationType: deserializeParam(
          data['locationType'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LocationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LocationStruct &&
        locationID == other.locationID &&
        locationName == other.locationName &&
        locationType == other.locationType;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([locationID, locationName, locationType]);
}

LocationStruct createLocationStruct({
  String? locationID,
  String? locationName,
  String? locationType,
}) =>
    LocationStruct(
      locationID: locationID,
      locationName: locationName,
      locationType: locationType,
    );
