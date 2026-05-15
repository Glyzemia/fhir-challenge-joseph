import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetPatientByIDCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Patient by ID',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Patient/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? givenNames(dynamic response) => (getJsonField(
        response,
        r'''$.name[:].given''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? familyName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.name[:].family''',
      ));
  static String? telecomSystem(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.telecom[:].system''',
      ));
  static String? telecomValue(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.telecom[:].value''',
      ));
  static String? gender(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.gender''',
      ));
  static String? birthDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.birthDate''',
      ));
}

class GetAllPatientsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get All Patients',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Patient',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? entries(dynamic response) => getJsonField(
        response,
        r'''$.entry''',
        true,
      ) as List?;
  static List<String>? lastUpdated(dynamic response) => (getJsonField(
        response,
        r'''$.entry[:].resource.meta.lastUpdated''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class CreateNewPatientCall {
  static Future<ApiCallResponse> call({
    List<String>? givenNameList,
    String? familyName = '',
    String? birthDate = '',
    String? phoneNumber = '',
    String? gender = '',
    String? token = '',
  }) async {
    final givenName = _serializeList(givenNameList);

    final ffApiRequestBody = '''
{
  "resourceType": "Patient",
  "active": "true",
  "name": [
    {
      "use": "official",
      "family": "${escapeStringForJson(familyName)}",
      "given": ${givenName}
    }
  ],
  "telecom": [
    {
      "system": "phone",
      "value": "${escapeStringForJson(phoneNumber)}",
      "use": "mobile"
    }
  ],
  "gender": "${escapeStringForJson(gender)}",
  "birthDate": "${escapeStringForJson(birthDate)}",
  "deceasedBoolean": "false",
  "multipleBirthBoolean": "false"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create New Patient',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Patient',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EditPatientCall {
  static Future<ApiCallResponse> call({
    List<String>? givenNameList,
    String? familyName = '',
    String? birthDate = '',
    String? phoneNumber = '',
    String? gender = '',
    String? token = '',
    String? id = '',
  }) async {
    final givenName = _serializeList(givenNameList);

    final ffApiRequestBody = '''
[
  {
    "op": "replace",
    "path": "/name/0/given",
    "value": ${givenName}
  },
  {
    "op": "replace",
    "path": "/name/0/family",
    "value": "${escapeStringForJson(familyName)}"
  },
  {
    "op": "replace",
    "path": "/gender",
    "value": "${escapeStringForJson(gender)}"
  },
  {
    "op": "replace",
    "path": "/birthDate",
    "value": "${escapeStringForJson(birthDate)}"
  },
  {
    "op": "replace",
    "path": "/telecom/0/value",
    "value": "${escapeStringForJson(phoneNumber)}"
  }
]''';
    return ApiManager.instance.makeApiCall(
      callName: 'Edit Patient',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Patient/${id}',
      callType: ApiCallType.PATCH,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json-patch+json',
        'Accept': 'application/fhir+json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeletePatientCall {
  static Future<ApiCallResponse> call({
    String? id = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Patient',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Patient/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
