import 'package:flutter/material.dart';

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
}
