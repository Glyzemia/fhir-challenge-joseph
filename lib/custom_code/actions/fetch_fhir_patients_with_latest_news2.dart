// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<PatientStruct>> fetchFhirPatientsWithLatestNews2(
  String fhirURL,
  String fhirToken,
  String observationFromDate,
) async {
  final String baseUrl = fhirURL.endsWith('/')
      ? fhirURL.substring(0, fhirURL.length - 1)
      : fhirURL;

  Map<String, String> buildHeaders() {
    final token = fhirToken.trim();

    return {
      'Accept': 'application/fhir+json',
      if (token.isNotEmpty)
        'Authorization':
            token.toLowerCase().startsWith('bearer ') ? token : 'Bearer $token',
    };
  }

  DateTime? parseDateTime(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  int? parseNullableInt(dynamic value) {
    if (value == null) return null;

    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.round();
    }

    return int.tryParse(value.toString());
  }

  bool? parseNullableBool(dynamic value) {
    if (value == null) return null;

    if (value is bool) {
      return value;
    }

    final stringValue = value.toString().toLowerCase().trim();

    if (stringValue == 'true') return true;
    if (stringValue == 'false') return false;

    return null;
  }

  Future<List<dynamic>> fetchAllPatientEntries() async {
    final List<dynamic> allEntries = [];

    String? nextUrl = '$baseUrl/Patient';

    while (nextUrl != null && nextUrl.isNotEmpty) {
      final response = await http.get(
        Uri.parse(nextUrl),
        headers: buildHeaders(),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception(
          'Failed to fetch patients. Status: ${response.statusCode}. Body: ${response.body}',
        );
      }

      final decoded = jsonDecode(response.body);

      final entries = decoded['entry'];
      if (entries is List) {
        allEntries.addAll(entries);
      }

      nextUrl = null;

      final links = decoded['link'];
      if (links is List) {
        for (final link in links) {
          if (link is Map && link['relation']?.toString() == 'next') {
            nextUrl = link['url']?.toString();
            break;
          }
        }
      }
    }

    return allEntries;
  }

  Future<Map<String, dynamic>> fetchLatestNews2ForPatient(
    String patientId,
  ) async {
    if (patientId.isEmpty) {
      return {
        'latestNEWS2Score': null,
        'latestSingleRedScore': null,
        'hasLatestNEWS2Score': false,
      };
    }

    try {
      final uri = Uri.parse('$baseUrl/Observation').replace(
        queryParameters: {
          'patient': patientId,
          'code': '1104051000000101',
          '_sort': '-date',
          '_count': '1',
        },
      );

      final response = await http.get(
        uri,
        headers: buildHeaders(),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return {
          'latestNEWS2Score': null,
          'latestSingleRedScore': null,
          'hasLatestNEWS2Score': false,
        };
      }

      final decoded = jsonDecode(response.body);

      final entryList = decoded['entry'];
      if (entryList is! List || entryList.isEmpty) {
        return {
          'latestNEWS2Score': null,
          'latestSingleRedScore': null,
          'hasLatestNEWS2Score': false,
        };
      }

      final firstEntry = entryList.first;
      if (firstEntry is! Map) {
        return {
          'latestNEWS2Score': null,
          'latestSingleRedScore': null,
          'hasLatestNEWS2Score': false,
        };
      }

      final resource = firstEntry['resource'];
      if (resource is! Map) {
        return {
          'latestNEWS2Score': null,
          'latestSingleRedScore': null,
          'hasLatestNEWS2Score': false,
        };
      }

      final latestNEWS2Score = parseNullableInt(
        resource['valueQuantity']?['value'],
      );

      bool? latestSingleRedScore;

      final componentList = resource['component'];
      if (componentList is List && componentList.isNotEmpty) {
        final firstComponent = componentList.first;

        if (firstComponent is Map) {
          latestSingleRedScore = parseNullableBool(
            firstComponent['valueBoolean'],
          );
        }
      }

      return {
        'latestNEWS2Score': latestNEWS2Score,
        'latestSingleRedScore': latestSingleRedScore,
        'hasLatestNEWS2Score': latestNEWS2Score != null,
      };
    } catch (e) {
      return {
        'latestNEWS2Score': null,
        'latestSingleRedScore': null,
        'hasLatestNEWS2Score': false,
      };
    }
  }

  PatientStruct parsePatientEntry(
    dynamic entry,
    int? latestNEWS2Score,
    bool? latestSingleRedScore,
    bool hasLatestNEWS2Score,
  ) {
    final resource = entry is Map ? entry['resource'] : null;
    final patientResource = resource is Map ? resource : <String, dynamic>{};

    final String patientId = patientResource['id']?.toString() ?? '';

    final nameList = patientResource['name'];
    final firstNameObject =
        nameList is List && nameList.isNotEmpty && nameList.first is Map
            ? nameList.first as Map
            : <String, dynamic>{};

    final givenRaw = firstNameObject['given'];

    final String firstNameOnly = givenRaw is List && givenRaw.isNotEmpty
        ? givenRaw.first.toString()
        : '';

    final String parsedGivenNames =
        givenRaw is List ? givenRaw.map((e) => e.toString()).join(' ') : '';

    final String familyName = firstNameObject['family']?.toString() ?? '';

    final String combinedNames = '$firstNameOnly $familyName'.trim();

    final telecomList = patientResource['telecom'];
    final firstTelecom = telecomList is List &&
            telecomList.isNotEmpty &&
            telecomList.first is Map
        ? telecomList.first as Map
        : <String, dynamic>{};

    final DateTime? lastUpdated = parseDateTime(
      patientResource['meta']?['lastUpdated'],
    );

    return createPatientStruct(
      identifier: patientId,
      givenNames: parsedGivenNames,
      familyName: familyName,
      telecomSystem: firstTelecom['system']?.toString() ?? '',
      telecomValue: firstTelecom['value']?.toString() ?? '',
      gender: patientResource['gender']?.toString() ?? '',
      birthDate: patientResource['birthDate']?.toString() ?? '',
      firstName: firstNameOnly,
      combinedNames: combinedNames,
      lastUpdated: lastUpdated,
      latestNEWS2Score: latestNEWS2Score,
      latestSingleRedScore: latestSingleRedScore,
      hasLatestNEWS2Score: hasLatestNEWS2Score,
    );
  }

  final patientEntries = await fetchAllPatientEntries();

  final List<PatientStruct> patients = [];

  const int batchSize = 5;

  for (int i = 0; i < patientEntries.length; i += batchSize) {
    final batch = patientEntries.skip(i).take(batchSize).toList();

    final batchResults = await Future.wait(
      batch.map((entry) async {
        final resource = entry is Map ? entry['resource'] : null;
        final patientResource =
            resource is Map ? resource : <String, dynamic>{};

        final String patientId = patientResource['id']?.toString() ?? '';

        final latestNewsData = await fetchLatestNews2ForPatient(patientId);

        return parsePatientEntry(
          entry,
          latestNewsData['latestNEWS2Score'] as int?,
          latestNewsData['latestSingleRedScore'] as bool?,
          latestNewsData['hasLatestNEWS2Score'] as bool? ?? false,
        );
      }),
    );

    patients.addAll(batchResults);
  }

  return patients;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
