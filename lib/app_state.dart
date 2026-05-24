import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _refresh = false;
  bool get refresh => _refresh;
  set refresh(bool value) {
    _refresh = value;
  }

  String _fhirBaseUrl =
      'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP';
  String get fhirBaseUrl => _fhirBaseUrl;
  set fhirBaseUrl(String value) {
    _fhirBaseUrl = value;
  }

  String _fhirBearerToken =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJvZmZpY2lhbEBnbHl6ZW1pYS5jb20iLCJ0ZW5hbnRfaWQiOiJWSmI1TWJOUThLdHIxVDdaenFwejBVMmVFMkpoT2lsUCIsInJvbGUiOiJURU5BTlRfVVNFUiIsImlhdCI6MTc3ODcxNDEzOSwiZXhwIjoxNzgzODk4MTM5fQ.Xmz4uLfcBQ_3CRb0LAGvKTA6UNvQ4IEpUjKkqixR6A8QlHD6DqPvbLacr1LooOLRv22SXgEcpOzIBy7vQsuQMg';
  String get fhirBearerToken => _fhirBearerToken;
  set fhirBearerToken(String value) {
    _fhirBearerToken = value;
  }

  String _selectedPhoneDialCode = '+1';
  String get selectedPhoneDialCode => _selectedPhoneDialCode;
  set selectedPhoneDialCode(String value) {
    _selectedPhoneDialCode = value;
  }

  String _selectedPhoneIsoCode = 'US';
  String get selectedPhoneIsoCode => _selectedPhoneIsoCode;
  set selectedPhoneIsoCode(String value) {
    _selectedPhoneIsoCode = value;
  }

  String _selectedPhoneCountryName = 'United States';
  String get selectedPhoneCountryName => _selectedPhoneCountryName;
  set selectedPhoneCountryName(String value) {
    _selectedPhoneCountryName = value;
  }

  String _selectedPhoneFlagEmoji = '🇺🇸';
  String get selectedPhoneFlagEmoji => _selectedPhoneFlagEmoji;
  set selectedPhoneFlagEmoji(String value) {
    _selectedPhoneFlagEmoji = value;
  }

  List<PractitionerStruct> _practitioners = [];
  List<PractitionerStruct> get practitioners => _practitioners;
  set practitioners(List<PractitionerStruct> value) {
    _practitioners = value;
  }

  void addToPractitioners(PractitionerStruct value) {
    practitioners.add(value);
  }

  void removeFromPractitioners(PractitionerStruct value) {
    practitioners.remove(value);
  }

  void removeAtIndexFromPractitioners(int index) {
    practitioners.removeAt(index);
  }

  void updatePractitionersAtIndex(
    int index,
    PractitionerStruct Function(PractitionerStruct) updateFn,
  ) {
    practitioners[index] = updateFn(_practitioners[index]);
  }

  void insertAtIndexInPractitioners(int index, PractitionerStruct value) {
    practitioners.insert(index, value);
  }

  String _hospitalID = 'bde7e6cc-c868-49ed-83cd-14028a16cfc2';
  String get hospitalID => _hospitalID;
  set hospitalID(String value) {
    _hospitalID = value;
  }

  List<LocationStruct> _hospitalWards = [
    LocationStruct.fromSerializableMap(jsonDecode(
        '{\"locationID\":\"Hello World\",\"locationName\":\"Hello World\",\"locationType\":\"Hello World\"}'))
  ];
  List<LocationStruct> get hospitalWards => _hospitalWards;
  set hospitalWards(List<LocationStruct> value) {
    _hospitalWards = value;
  }

  void addToHospitalWards(LocationStruct value) {
    hospitalWards.add(value);
  }

  void removeFromHospitalWards(LocationStruct value) {
    hospitalWards.remove(value);
  }

  void removeAtIndexFromHospitalWards(int index) {
    hospitalWards.removeAt(index);
  }

  void updateHospitalWardsAtIndex(
    int index,
    LocationStruct Function(LocationStruct) updateFn,
  ) {
    hospitalWards[index] = updateFn(_hospitalWards[index]);
  }

  void insertAtIndexInHospitalWards(int index, LocationStruct value) {
    hospitalWards.insert(index, value);
  }

  List<DiabetesTypesStruct> _diabetesTypes = [
    DiabetesTypesStruct.fromSerializableMap(jsonDecode(
        '{\"code\":\"44054006\",\"codeName\":\"Diabetes mellitus type 2\",\"displayName\":\"Type 2 Diabetes Mellitus\",\"onsetDateTIme\":\"l1779516005465\"}')),
    DiabetesTypesStruct.fromSerializableMap(jsonDecode(
        '{\"code\":\"46635009\",\"codeName\":\"Diabetes mellitus type 1\",\"displayName\":\"Type 1 Diabetes Mellitus\",\"onsetDateTIme\":\"l1779516063740\"}')),
    DiabetesTypesStruct.fromSerializableMap(jsonDecode(
        '{\"code\":\"11687002\",\"codeName\":\"Gestational diabetes mellitus (disorder)\",\"displayName\":\"Gestational Diabetes Mellitus\",\"onsetDateTIme\":\"l1779544016708\"}')),
    DiabetesTypesStruct.fromSerializableMap(jsonDecode(
        '{\"code\":\"609561005\",\"codeName\":\"Maturity-onset diabetes of the young (disorder)\",\"displayName\":\"MODY\",\"onsetDateTIme\":\"l1779544135267\"}')),
    DiabetesTypesStruct.fromSerializableMap(jsonDecode(
        '{\"code\":\"426875007\",\"codeName\":\" Latent autoimmune diabetes mellitus in adult (disorder)\",\"displayName\":\"LADA\",\"onsetDateTIme\":\"l1779544192227\"}'))
  ];
  List<DiabetesTypesStruct> get diabetesTypes => _diabetesTypes;
  set diabetesTypes(List<DiabetesTypesStruct> value) {
    _diabetesTypes = value;
  }

  void addToDiabetesTypes(DiabetesTypesStruct value) {
    diabetesTypes.add(value);
  }

  void removeFromDiabetesTypes(DiabetesTypesStruct value) {
    diabetesTypes.remove(value);
  }

  void removeAtIndexFromDiabetesTypes(int index) {
    diabetesTypes.removeAt(index);
  }

  void updateDiabetesTypesAtIndex(
    int index,
    DiabetesTypesStruct Function(DiabetesTypesStruct) updateFn,
  ) {
    diabetesTypes[index] = updateFn(_diabetesTypes[index]);
  }

  void insertAtIndexInDiabetesTypes(int index, DiabetesTypesStruct value) {
    diabetesTypes.insert(index, value);
  }

  List<MedicationCodesStruct> _steroidsList = [
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"8638\",\"medicationName\":\"Prednisolone\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"8640\",\"medicationName\":\"Prednisone\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"5492\",\"medicationName\":\"Hydrocortisone\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"6902\",\"medicationName\":\"Methylprednisolone\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"3264\",\"medicationName\":\"Dexamethasone\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"1514\",\"medicationName\":\"Betamethasone\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"314225\",\"medicationName\":\"Deflazacort\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"10759\",\"medicationName\":\"Triamcinolone\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"19831\",\"medicationName\":\"Budesonide\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"4452\",\"medicationName\":\"Fludrocortisone\"}'))
  ];
  List<MedicationCodesStruct> get steroidsList => _steroidsList;
  set steroidsList(List<MedicationCodesStruct> value) {
    _steroidsList = value;
  }

  void addToSteroidsList(MedicationCodesStruct value) {
    steroidsList.add(value);
  }

  void removeFromSteroidsList(MedicationCodesStruct value) {
    steroidsList.remove(value);
  }

  void removeAtIndexFromSteroidsList(int index) {
    steroidsList.removeAt(index);
  }

  void updateSteroidsListAtIndex(
    int index,
    MedicationCodesStruct Function(MedicationCodesStruct) updateFn,
  ) {
    steroidsList[index] = updateFn(_steroidsList[index]);
  }

  void insertAtIndexInSteroidsList(int index, MedicationCodesStruct value) {
    steroidsList.insert(index, value);
  }

  List<MedicationCodesStruct> _inotropesList = [
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"3628\",\"medicationName\":\"Dopamine\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"3616\",\"medicationName\":\"Dobutamine\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"7512\",\"medicationName\":\"Norepinephrine\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"3992\",\"medicationName\":\"Epinephrine\"}')),
    MedicationCodesStruct.fromSerializableMap(jsonDecode(
        '{\"medicationCode\":\"11149\",\"medicationName\":\"Vasopressin\"}'))
  ];
  List<MedicationCodesStruct> get inotropesList => _inotropesList;
  set inotropesList(List<MedicationCodesStruct> value) {
    _inotropesList = value;
  }

  void addToInotropesList(MedicationCodesStruct value) {
    inotropesList.add(value);
  }

  void removeFromInotropesList(MedicationCodesStruct value) {
    inotropesList.remove(value);
  }

  void removeAtIndexFromInotropesList(int index) {
    inotropesList.removeAt(index);
  }

  void updateInotropesListAtIndex(
    int index,
    MedicationCodesStruct Function(MedicationCodesStruct) updateFn,
  ) {
    inotropesList[index] = updateFn(_inotropesList[index]);
  }

  void insertAtIndexInInotropesList(int index, MedicationCodesStruct value) {
    inotropesList.insert(index, value);
  }
}
