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
