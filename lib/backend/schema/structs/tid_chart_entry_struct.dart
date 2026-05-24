// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TidChartEntryStruct extends BaseStruct {
  TidChartEntryStruct({
    String? observationId,
    String? patientId,
    String? encounterId,
    String? tidIdentifier,
    DateTime? date,
    String? timespot,
    int? cbg,
    String? feedStatus,
    String? steroidStatus,
    String? inotropeStatus,
    String? insulinInfusionStatus,
    double? creatinine,
    double? hba1c,
    String? nurseNotes,
    String? nursePractitionerId,
    String? nurseDisplayName,
    DateTime? effectiveDateTime,
    DateTime? issuedDateTime,
  })  : _observationId = observationId,
        _patientId = patientId,
        _encounterId = encounterId,
        _tidIdentifier = tidIdentifier,
        _date = date,
        _timespot = timespot,
        _cbg = cbg,
        _feedStatus = feedStatus,
        _steroidStatus = steroidStatus,
        _inotropeStatus = inotropeStatus,
        _insulinInfusionStatus = insulinInfusionStatus,
        _creatinine = creatinine,
        _hba1c = hba1c,
        _nurseNotes = nurseNotes,
        _nursePractitionerId = nursePractitionerId,
        _nurseDisplayName = nurseDisplayName,
        _effectiveDateTime = effectiveDateTime,
        _issuedDateTime = issuedDateTime;

  // "observationId" field.
  String? _observationId;
  String get observationId => _observationId ?? '';
  set observationId(String? val) => _observationId = val;

  bool hasObservationId() => _observationId != null;

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

  // "tidIdentifier" field.
  String? _tidIdentifier;
  String get tidIdentifier => _tidIdentifier ?? '';
  set tidIdentifier(String? val) => _tidIdentifier = val;

  bool hasTidIdentifier() => _tidIdentifier != null;

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

  // "cbg" field.
  int? _cbg;
  int get cbg => _cbg ?? 0;
  set cbg(int? val) => _cbg = val;

  void incrementCbg(int amount) => cbg = cbg + amount;

  bool hasCbg() => _cbg != null;

  // "feedStatus" field.
  String? _feedStatus;
  String get feedStatus => _feedStatus ?? '';
  set feedStatus(String? val) => _feedStatus = val;

  bool hasFeedStatus() => _feedStatus != null;

  // "steroidStatus" field.
  String? _steroidStatus;
  String get steroidStatus => _steroidStatus ?? '';
  set steroidStatus(String? val) => _steroidStatus = val;

  bool hasSteroidStatus() => _steroidStatus != null;

  // "inotropeStatus" field.
  String? _inotropeStatus;
  String get inotropeStatus => _inotropeStatus ?? '';
  set inotropeStatus(String? val) => _inotropeStatus = val;

  bool hasInotropeStatus() => _inotropeStatus != null;

  // "insulinInfusionStatus" field.
  String? _insulinInfusionStatus;
  String get insulinInfusionStatus => _insulinInfusionStatus ?? '';
  set insulinInfusionStatus(String? val) => _insulinInfusionStatus = val;

  bool hasInsulinInfusionStatus() => _insulinInfusionStatus != null;

  // "creatinine" field.
  double? _creatinine;
  double get creatinine => _creatinine ?? 0.0;
  set creatinine(double? val) => _creatinine = val;

  void incrementCreatinine(double amount) => creatinine = creatinine + amount;

  bool hasCreatinine() => _creatinine != null;

  // "hba1c" field.
  double? _hba1c;
  double get hba1c => _hba1c ?? 0.0;
  set hba1c(double? val) => _hba1c = val;

  void incrementHba1c(double amount) => hba1c = hba1c + amount;

  bool hasHba1c() => _hba1c != null;

  // "nurseNotes" field.
  String? _nurseNotes;
  String get nurseNotes => _nurseNotes ?? '';
  set nurseNotes(String? val) => _nurseNotes = val;

  bool hasNurseNotes() => _nurseNotes != null;

  // "nursePractitionerId" field.
  String? _nursePractitionerId;
  String get nursePractitionerId => _nursePractitionerId ?? '';
  set nursePractitionerId(String? val) => _nursePractitionerId = val;

  bool hasNursePractitionerId() => _nursePractitionerId != null;

  // "nurseDisplayName" field.
  String? _nurseDisplayName;
  String get nurseDisplayName => _nurseDisplayName ?? '';
  set nurseDisplayName(String? val) => _nurseDisplayName = val;

  bool hasNurseDisplayName() => _nurseDisplayName != null;

  // "effectiveDateTime" field.
  DateTime? _effectiveDateTime;
  DateTime? get effectiveDateTime => _effectiveDateTime;
  set effectiveDateTime(DateTime? val) => _effectiveDateTime = val;

  bool hasEffectiveDateTime() => _effectiveDateTime != null;

  // "issuedDateTime" field.
  DateTime? _issuedDateTime;
  DateTime? get issuedDateTime => _issuedDateTime;
  set issuedDateTime(DateTime? val) => _issuedDateTime = val;

  bool hasIssuedDateTime() => _issuedDateTime != null;

  static TidChartEntryStruct fromMap(Map<String, dynamic> data) =>
      TidChartEntryStruct(
        observationId: data['observationId'] as String?,
        patientId: data['patientId'] as String?,
        encounterId: data['encounterId'] as String?,
        tidIdentifier: data['tidIdentifier'] as String?,
        date: data['date'] as DateTime?,
        timespot: data['timespot'] as String?,
        cbg: castToType<int>(data['cbg']),
        feedStatus: data['feedStatus'] as String?,
        steroidStatus: data['steroidStatus'] as String?,
        inotropeStatus: data['inotropeStatus'] as String?,
        insulinInfusionStatus: data['insulinInfusionStatus'] as String?,
        creatinine: castToType<double>(data['creatinine']),
        hba1c: castToType<double>(data['hba1c']),
        nurseNotes: data['nurseNotes'] as String?,
        nursePractitionerId: data['nursePractitionerId'] as String?,
        nurseDisplayName: data['nurseDisplayName'] as String?,
        effectiveDateTime: data['effectiveDateTime'] as DateTime?,
        issuedDateTime: data['issuedDateTime'] as DateTime?,
      );

  static TidChartEntryStruct? maybeFromMap(dynamic data) => data is Map
      ? TidChartEntryStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'observationId': _observationId,
        'patientId': _patientId,
        'encounterId': _encounterId,
        'tidIdentifier': _tidIdentifier,
        'date': _date,
        'timespot': _timespot,
        'cbg': _cbg,
        'feedStatus': _feedStatus,
        'steroidStatus': _steroidStatus,
        'inotropeStatus': _inotropeStatus,
        'insulinInfusionStatus': _insulinInfusionStatus,
        'creatinine': _creatinine,
        'hba1c': _hba1c,
        'nurseNotes': _nurseNotes,
        'nursePractitionerId': _nursePractitionerId,
        'nurseDisplayName': _nurseDisplayName,
        'effectiveDateTime': _effectiveDateTime,
        'issuedDateTime': _issuedDateTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'observationId': serializeParam(
          _observationId,
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
        'tidIdentifier': serializeParam(
          _tidIdentifier,
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
        'cbg': serializeParam(
          _cbg,
          ParamType.int,
        ),
        'feedStatus': serializeParam(
          _feedStatus,
          ParamType.String,
        ),
        'steroidStatus': serializeParam(
          _steroidStatus,
          ParamType.String,
        ),
        'inotropeStatus': serializeParam(
          _inotropeStatus,
          ParamType.String,
        ),
        'insulinInfusionStatus': serializeParam(
          _insulinInfusionStatus,
          ParamType.String,
        ),
        'creatinine': serializeParam(
          _creatinine,
          ParamType.double,
        ),
        'hba1c': serializeParam(
          _hba1c,
          ParamType.double,
        ),
        'nurseNotes': serializeParam(
          _nurseNotes,
          ParamType.String,
        ),
        'nursePractitionerId': serializeParam(
          _nursePractitionerId,
          ParamType.String,
        ),
        'nurseDisplayName': serializeParam(
          _nurseDisplayName,
          ParamType.String,
        ),
        'effectiveDateTime': serializeParam(
          _effectiveDateTime,
          ParamType.DateTime,
        ),
        'issuedDateTime': serializeParam(
          _issuedDateTime,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static TidChartEntryStruct fromSerializableMap(Map<String, dynamic> data) =>
      TidChartEntryStruct(
        observationId: deserializeParam(
          data['observationId'],
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
        tidIdentifier: deserializeParam(
          data['tidIdentifier'],
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
        cbg: deserializeParam(
          data['cbg'],
          ParamType.int,
          false,
        ),
        feedStatus: deserializeParam(
          data['feedStatus'],
          ParamType.String,
          false,
        ),
        steroidStatus: deserializeParam(
          data['steroidStatus'],
          ParamType.String,
          false,
        ),
        inotropeStatus: deserializeParam(
          data['inotropeStatus'],
          ParamType.String,
          false,
        ),
        insulinInfusionStatus: deserializeParam(
          data['insulinInfusionStatus'],
          ParamType.String,
          false,
        ),
        creatinine: deserializeParam(
          data['creatinine'],
          ParamType.double,
          false,
        ),
        hba1c: deserializeParam(
          data['hba1c'],
          ParamType.double,
          false,
        ),
        nurseNotes: deserializeParam(
          data['nurseNotes'],
          ParamType.String,
          false,
        ),
        nursePractitionerId: deserializeParam(
          data['nursePractitionerId'],
          ParamType.String,
          false,
        ),
        nurseDisplayName: deserializeParam(
          data['nurseDisplayName'],
          ParamType.String,
          false,
        ),
        effectiveDateTime: deserializeParam(
          data['effectiveDateTime'],
          ParamType.DateTime,
          false,
        ),
        issuedDateTime: deserializeParam(
          data['issuedDateTime'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'TidChartEntryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TidChartEntryStruct &&
        observationId == other.observationId &&
        patientId == other.patientId &&
        encounterId == other.encounterId &&
        tidIdentifier == other.tidIdentifier &&
        date == other.date &&
        timespot == other.timespot &&
        cbg == other.cbg &&
        feedStatus == other.feedStatus &&
        steroidStatus == other.steroidStatus &&
        inotropeStatus == other.inotropeStatus &&
        insulinInfusionStatus == other.insulinInfusionStatus &&
        creatinine == other.creatinine &&
        hba1c == other.hba1c &&
        nurseNotes == other.nurseNotes &&
        nursePractitionerId == other.nursePractitionerId &&
        nurseDisplayName == other.nurseDisplayName &&
        effectiveDateTime == other.effectiveDateTime &&
        issuedDateTime == other.issuedDateTime;
  }

  @override
  int get hashCode => const ListEquality().hash([
        observationId,
        patientId,
        encounterId,
        tidIdentifier,
        date,
        timespot,
        cbg,
        feedStatus,
        steroidStatus,
        inotropeStatus,
        insulinInfusionStatus,
        creatinine,
        hba1c,
        nurseNotes,
        nursePractitionerId,
        nurseDisplayName,
        effectiveDateTime,
        issuedDateTime
      ]);
}

TidChartEntryStruct createTidChartEntryStruct({
  String? observationId,
  String? patientId,
  String? encounterId,
  String? tidIdentifier,
  DateTime? date,
  String? timespot,
  int? cbg,
  String? feedStatus,
  String? steroidStatus,
  String? inotropeStatus,
  String? insulinInfusionStatus,
  double? creatinine,
  double? hba1c,
  String? nurseNotes,
  String? nursePractitionerId,
  String? nurseDisplayName,
  DateTime? effectiveDateTime,
  DateTime? issuedDateTime,
}) =>
    TidChartEntryStruct(
      observationId: observationId,
      patientId: patientId,
      encounterId: encounterId,
      tidIdentifier: tidIdentifier,
      date: date,
      timespot: timespot,
      cbg: cbg,
      feedStatus: feedStatus,
      steroidStatus: steroidStatus,
      inotropeStatus: inotropeStatus,
      insulinInfusionStatus: insulinInfusionStatus,
      creatinine: creatinine,
      hba1c: hba1c,
      nurseNotes: nurseNotes,
      nursePractitionerId: nursePractitionerId,
      nurseDisplayName: nurseDisplayName,
      effectiveDateTime: effectiveDateTime,
      issuedDateTime: issuedDateTime,
    );
