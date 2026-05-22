import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetAllObservationsByIDForPatientCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? optionalQueries = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get All Observations by ID for Patient',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Observation?patient=${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        '_total': "accurate",
      },
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
  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
      ));
}

class GetPatientConditionByIDCopyCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? optionalQueries = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Patient Condition by ID Copy',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Condition?subject=Patient/${id}&${optionalQueries}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        '_total': "accurate",
      },
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
  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
      ));
}

class GetAdmissionEncounterByPatientIDCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Admission Encounter by Patient ID',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Encounter?subject=Patient/${id}&status=in-progress&class=IMP',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        '_total': "accurate",
      },
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
  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
      ));
  static String? encounterID(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[0].resource.id''',
      ));
  static String? encounterStatus(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[0].resource.status''',
      ));
  static String? encounterType(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[:].resource.class.code''',
      ));
  static String? admissionDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[:].resource.period.start''',
      ));
  static String? wardName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.entry[:].resource.location[:].location.display''',
      ));
  static String? admittedUnder(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[:].resource.participant[:].individual.display''',
      ));
}

class PatchAdmissionEncountersForGlyzemiaCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? encounterId = '',
    String? practitionerId = '',
    String? practitionerDisplay = '',
  }) async {
    final ffApiRequestBody = '''
[
  {
    "op": "add",
    "path": "/participant",
    "value": [
      {
        "type": [
          {
            "text": "Admitted under"
          }
        ],
        "individual": {
          "reference": "Practitioner/${escapeStringForJson(practitionerId)}",
          "display": "${escapeStringForJson(practitionerDisplay)}"
        }
      }
    ]
  },
  {
    "op": "add",
    "path": "/location",
    "value": [
      {
        "location": {
          "reference": "Location/871835e2-6d49-4891-a1f9-af53e5cd927f",
          "display": "FIRST FLOOR"
        },
        "status": "active"
      }
    ]
  }
]''';
    return ApiManager.instance.makeApiCall(
      callName: 'Patch Admission Encounters for Glyzemia',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Encounter/${encounterId}',
      callType: ApiCallType.PATCH,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json-patch+json',
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

  static List? entries(dynamic response) => getJsonField(
        response,
        r'''$.entry''',
        true,
      ) as List?;
  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
      ));
  static String? encounterID(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[0].resource.id''',
      ));
  static String? encounterStatus(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[0].resource.status''',
      ));
  static String? encounterType(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[:].resource.class.code''',
      ));
  static String? admissionDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[:].resource.period.start''',
      ));
}

class GetPatientMedicationsByIDCopyCopyCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? optionalQueries = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Patient Medications by ID Copy Copy',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/MedicationRequest?subject=Patient/${id}&${optionalQueries}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        '_total': "accurate",
      },
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
  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
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
  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
      ));
}

class GetAllPractitionersCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get All Practitioners',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Practitioner',
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
  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total''',
      ));
  static List<String>? id(dynamic response) => (getJsonField(
        response,
        r'''$.entry[:].resource.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? familyName(dynamic response) => (getJsonField(
        response,
        r'''$.entry[:].resource.name[:].family''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? givenName(dynamic response) => (getJsonField(
        response,
        r'''$.entry[:].resource.name[:].given[0]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? prefix(dynamic response) => (getJsonField(
        response,
        r'''$.entry[:].resource.name[:].prefix[0]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class SearchPatientsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? searchTerm = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Search Patients',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Patient',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        '_total': "accurate",
        'name': searchTerm,
      },
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

  static String? createdPatientID(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
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

class PatientBundleRequestsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
  }) async {
    final ffApiRequestBody = '''
{
  "resourceType": "Bundle",
  "type": "batch",
  "entry": [
    {
      "request": {
        "method": "GET",
        "url": "Observation?subject=Patient/${escapeStringForJson(id)}&_total=accurate&date=ge2026-05-18"
      }
    },
    {
      "request": {
        "method": "GET",
        "url": "Condition?subject=Patient/${escapeStringForJson(id)}&clinical-status=active&_total=accurate"
      }
    },
    {
      "request": {
        "method": "GET",
        "url": "MedicationRequest?subject=Patient/${escapeStringForJson(id)}&_total=accurate&status=active"
      }
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Patient Bundle Requests',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/',
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

  static List? observationEntries(dynamic response) => getJsonField(
        response,
        r'''$.entry[0].resource.entry''',
        true,
      ) as List?;
  static List? conditionEntries(dynamic response) => getJsonField(
        response,
        r'''$.entry[1].resource.entry''',
        true,
      ) as List?;
  static List? medicationEntries(dynamic response) => getJsonField(
        response,
        r'''$.entry[2].resource.entry''',
        true,
      ) as List?;
  static int? observationTotal(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.entry[0].resource.total''',
      ));
  static int? conditionTotal(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.entry[1].resource.total''',
      ));
  static int? medicationTotal(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.entry[2].resource.total''',
      ));
}

class BundlePOSTNEWSObservationsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    dynamic bundleJsonJson,
  }) async {
    final bundleJson = _serializeJson(bundleJsonJson);
    final ffApiRequestBody = '''
${bundleJson}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Bundle POST NEWS Observations',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/',
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

  static List? observationEntries(dynamic response) => getJsonField(
        response,
        r'''$.entry[0].resource.entry''',
        true,
      ) as List?;
  static List? conditionEntries(dynamic response) => getJsonField(
        response,
        r'''$.entry[1].resource.entry''',
        true,
      ) as List?;
  static List? medicationEntries(dynamic response) => getJsonField(
        response,
        r'''$.entry[2].resource.entry''',
        true,
      ) as List?;
  static int? observationTotal(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.entry[0].resource.total''',
      ));
  static int? conditionTotal(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.entry[1].resource.total''',
      ));
  static int? medicationTotal(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.entry[2].resource.total''',
      ));
}

class AdmitPatientCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? startPeriod = '',
    String? encounterID = '',
  }) async {
    final ffApiRequestBody = '''
{
  "resourceType": "Encounter",
  "identifier": [
    {
      "system": "https://your-news2-app.example/fhir/admission-id",
      "value": "${escapeStringForJson(encounterID)}"
    }
  ],
  "status": "in-progress",
  "class": {
    "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode",
    "code": "IMP",
    "display": "inpatient encounter"
  },
  "subject": {
    "reference": "Patient/${escapeStringForJson(id)}"
  },
  "period": {
    "start": "${escapeStringForJson(startPeriod)}"
  },
  "reasonCode": [
    {
      "text": "Inpatient admission for NEWS2 monitoring"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Admit Patient',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Encounter',
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

class GetLatestNEWSScoreCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Latest NEWS Score',
      apiUrl:
          'https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/Observation?patient=${id}&code=1104051000000101&_sort=-date&_count=1&_total=accurate',
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

  static String? recordedAtString(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.entry[0].resource.effectiveDateTime''',
      ));
  static int? news2Score(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.entry[0].resource.valueQuantity.value''',
      ));
  static bool? isSingleRedScorePresent(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.entry[0].resource.component[0].valueBoolean''',
      ));
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
