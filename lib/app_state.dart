import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';

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
}
