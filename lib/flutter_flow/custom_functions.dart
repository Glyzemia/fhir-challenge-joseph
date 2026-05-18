import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

List<PatientStruct>? parseFhirPatients(
  List<dynamic>? entries,
  List<DateTime> lastUpdatedList,
) {
  if (entries == null || entries is! List) {
    return [];
  }

  return entries.asMap().entries.map<PatientStruct>((mapEntry) {
    final int index = mapEntry.key;
    final entry = mapEntry.value;

    final resource = entry['resource'] ?? {};

    final nameList = resource['name'];
    final firstName =
        nameList is List && nameList.isNotEmpty ? nameList.first : {};

    final givenRaw = firstName['given'];

    final String firstNameOnly = givenRaw is List && givenRaw.isNotEmpty
        ? givenRaw.first.toString()
        : '';

    final String parsedGivenNames =
        givenRaw is List ? givenRaw.map((e) => e.toString()).join(' ') : '';

    final telecomList = resource['telecom'];
    final firstTelecom =
        telecomList is List && telecomList.isNotEmpty ? telecomList.first : {};

    final familyName = firstName['family']?.toString() ?? '';
    final combinedNames = '$firstNameOnly $familyName'.trim();

    final DateTime? entryLastUpdated = lastUpdatedList[index];

    return createPatientStruct(
      identifier: resource['id']?.toString() ?? '',
      givenNames: parsedGivenNames,
      familyName: familyName,
      telecomSystem: firstTelecom['system']?.toString() ?? '',
      telecomValue: firstTelecom['value']?.toString() ?? '',
      gender: resource['gender']?.toString() ?? '',
      birthDate: resource['birthDate']?.toString() ?? '',
      firstName: firstNameOnly,
      combinedNames: combinedNames,
      lastUpdated: entryLastUpdated,
    );
  }).toList();
}

String getInitials(
  String firstName,
  String lastName,
) {
  // i want a custom function that takes in first name and family name and return only the initials in uppercase
  return '${firstName.isNotEmpty ? firstName[0].toUpperCase() : ''}${lastName.isNotEmpty ? lastName[0].toUpperCase() : ''}';
}

String capitalizeFirst(String text) {
  // take in a string and capitalize only the first letter.
  if (text.isEmpty) return text; // Return the original string if it's empty
  return text[0].toUpperCase() +
      text.substring(
          1); // Capitalize the first letter and concatenate with the rest of the string
}

bool isValidPhoneNumberForCountry(
  String phoneNumber,
  String isoCode,
) {
  // Remove spaces, hyphens, brackets, plus signs, etc.
  final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
  final country = isoCode.toUpperCase().trim();

  switch (country) {
    case 'IN':
      // India mobile number: 10 digits, usually starts with 6,7,8,9
      return RegExp(r'^[6-9]\d{9}$').hasMatch(digits);

    case 'US':
    case 'CA':
      // US / Canada: 10 digits without country code
      return RegExp(r'^\d{10}$').hasMatch(digits);

    case 'SG':
      // Singapore: commonly 8 digits
      return RegExp(r'^\d{8}$').hasMatch(digits);

    case 'AE':
      // UAE: commonly 9 digits without country code
      return RegExp(r'^\d{9}$').hasMatch(digits);

    case 'GB':
      // UK numbers vary; allow 10 or 11 digits without +44
      return RegExp(r'^\d{10,11}$').hasMatch(digits);

    default:
      // General fallback.
      // E.164 full phone numbers can be up to 15 digits including country code.
      // Since this field excludes country code, keep a broad but reasonable range.
      return digits.length >= 6 && digits.length <= 14;
  }
}

List<String> splitWords(String wordsString) {
  // I want a function that takes in a single sentence, and split the words based on " " and return words list.
  return wordsString.split(" ");
}

List<DateTime> convertDateStringListtoDateTimeList(List<String>? dateString) {
  // A function that converts date string into a datetime object
  if (dateString == null) return [];
  return dateString.map((date) => DateTime.parse(date)).toList();
}

DateTime? convertSingleDateStringtoDateTime(String? dateString) {
  // need a function that takes in a date string and converts it into a Datetime object
  if (dateString == null || dateString.isEmpty) {
    return null;
  }
  try {
    return DateTime.parse(dateString);
  } catch (e) {
    return null;
  }
}

List<int> createPageIndices(
  int items,
  int itemsPerPage,
) {
  final int numPages = ((items - 1) ~/ itemsPerPage) + 1;
  List<int> pages = List.generate(numPages, (index) => index);
  return pages;
}

List<PatientStruct>? slicePatientsListForTablePages(
  List<PatientStruct>? patients,
  int startIndex,
  int endIndex,
) {
  // I want the function to take in patients list, and return the sublist from startIndex to endIndex. If endIndex is greater that patients length, return only up to the patients length.
  if (patients == null || startIndex >= patients.length) {
    return [];
  }
  endIndex = endIndex > patients.length ? patients.length : endIndex;
  return patients.sublist(startIndex, endIndex);
}

List<ConditionStruct>? sliceConditionsListForTablePages(
  List<ConditionStruct>? conditions,
  int startIndex,
  int endIndex,
) {
  // I want the function to take in patients list, and return the sublist from startIndex to endIndex. If endIndex is greater that patients length, return only up to the patients length.
  if (conditions == null || startIndex >= conditions.length) {
    return [];
  }
  endIndex = endIndex > conditions.length ? conditions.length : endIndex;
  return conditions.sublist(startIndex, endIndex);
}

List<MedicationStruct>? sliceMedicationsListForTablePages(
  List<MedicationStruct>? medications,
  int startIndex,
  int endIndex,
) {
  // I want the function to take in patients list, and return the sublist from startIndex to endIndex. If endIndex is greater that patients length, return only up to the patients length.
  if (medications == null || startIndex >= medications.length) {
    return [];
  }
  endIndex = endIndex > medications.length ? medications.length : endIndex;
  return medications.sublist(startIndex, endIndex);
}

List<ObservationStruct> parseFhirObservations(List<dynamic> entries) {
  if (entries == null || entries is! List) {
    return <ObservationStruct>[];
  }

  String safeString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  String getPatientId(dynamic resource) {
    final subjectRef = resource?['subject']?['reference'];

    if (subjectRef == null) return '';

    final ref = subjectRef.toString(); // Example: Patient/12345

    if (ref.contains('/')) {
      return ref.split('/').last;
    }

    return ref;
  }

  String getCategory(dynamic resource) {
    final categories = resource?['category'];

    if (categories is List && categories.isNotEmpty) {
      final coding = categories[0]?['coding'];

      if (coding is List && coding.isNotEmpty) {
        return safeString(
          coding[0]?['display'] ?? coding[0]?['code'],
        );
      }

      return safeString(categories[0]?['text']);
    }

    return '';
  }

  String getCodeName(dynamic codeObj) {
    if (codeObj == null) return '';

    final text = codeObj['text'];
    if (text != null && text.toString().isNotEmpty) {
      return text.toString();
    }

    final coding = codeObj['coding'];
    if (coding is List && coding.isNotEmpty) {
      return safeString(
        coding[0]?['display'] ?? coding[0]?['code'],
      );
    }

    return '';
  }

  String getObservationValue(dynamic obj) {
    if (obj?['valueQuantity'] != null) {
      return safeString(obj?['valueQuantity']?['value']);
    }

    if (obj?['valueString'] != null) {
      return safeString(obj?['valueString']);
    }

    if (obj?['valueInteger'] != null) {
      return safeString(obj?['valueInteger']);
    }

    if (obj?['valueBoolean'] != null) {
      return safeString(obj?['valueBoolean']);
    }

    if (obj?['valueCodeableConcept'] != null) {
      final concept = obj?['valueCodeableConcept'];

      if (concept?['text'] != null) {
        return safeString(concept?['text']);
      }

      final coding = concept?['coding'];
      if (coding is List && coding.isNotEmpty) {
        return safeString(
          coding[0]?['display'] ?? coding[0]?['code'],
        );
      }
    }

    return '';
  }

  String getObservationUnit(dynamic obj) {
    if (obj?['valueQuantity'] != null) {
      return safeString(
        obj?['valueQuantity']?['unit'] ?? obj?['valueQuantity']?['code'],
      );
    }

    return '';
  }

  DateTime? getRecordedAt(dynamic resource) {
    final rawDate = resource?['effectiveDateTime'] ??
        resource?['effectivePeriod']?['start'] ??
        resource?['issued'];

    if (rawDate == null) return null;

    return DateTime.tryParse(rawDate.toString());
  }

  final List<ObservationStruct> observations = [];

  for (final entry in entries) {
    final resource = entry?['resource'];

    if (resource == null) {
      continue;
    }

    final patientId = getPatientId(resource);
    final observationId = safeString(resource?['id']);
    final category = getCategory(resource);
    final recordedAt = getRecordedAt(resource);

    final components = resource?['component'];

    // Case 1: Panel observation, e.g. Blood Pressure
    // The actual values are inside component[]
    if (components is List && components.isNotEmpty) {
      for (int i = 0; i < components.length; i++) {
        final component = components[i];

        observations.add(
          ObservationStruct(
            patientID: patientId,
            observationID: '$observationId-component-$i',
            category: category,
            name: getCodeName(component?['code']),
            value: getObservationValue(component),
            units: getObservationUnit(component),
            recordedAt: recordedAt,
          ),
        );
      }

      continue;
    }

    // Case 2: Normal observation, e.g. Heart rate, Temperature, SpO2
    observations.add(
      ObservationStruct(
        patientID: patientId,
        observationID: observationId,
        category: category,
        name: getCodeName(resource?['code']),
        value: getObservationValue(resource),
        units: getObservationUnit(resource),
        recordedAt: recordedAt,
      ),
    );
  }

  return observations;
}

List<ConditionStruct> parseFhirConditions(List<dynamic> entries) {
  if (entries.isEmpty) {
    return <ConditionStruct>[];
  }

  String safeString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  String getPatientId(dynamic resource) {
    final subjectRef = resource?['subject']?['reference'];

    if (subjectRef == null) return '';

    final ref = subjectRef.toString(); // Example: Patient/12345

    if (ref.contains('/')) {
      return ref.split('/').last;
    }

    return ref;
  }

  String getConditionName(dynamic resource) {
    final code = resource?['code'];

    if (code == null) return '';

    final text = code['text'];
    if (text != null && text.toString().isNotEmpty) {
      return text.toString();
    }

    final coding = code['coding'];
    if (coding is List && coding.isNotEmpty) {
      return safeString(
        coding[0]?['display'] ?? coding[0]?['code'],
      );
    }

    return '';
  }

  String getConditionCode(dynamic resource) {
    final coding = resource?['code']?['coding'];

    if (coding is List && coding.isNotEmpty) {
      return safeString(coding[0]?['code']);
    }

    return '';
  }

  DateTime? getOnsetDate(dynamic resource) {
    final rawDate = resource?['onsetDateTime'] ??
        resource?['onsetPeriod']?['start'] ??
        resource?['recordedDate'];

    if (rawDate == null) return null;

    return DateTime.tryParse(rawDate.toString());
  }

  String getStatus(dynamic resource) {
    final clinicalStatus = resource?['clinicalStatus'];

    if (clinicalStatus == null) return '';

    final text = clinicalStatus['text'];
    if (text != null && text.toString().isNotEmpty) {
      return text.toString();
    }

    final coding = clinicalStatus['coding'];
    if (coding is List && coding.isNotEmpty) {
      return safeString(
        coding[0]?['display'] ?? coding[0]?['code'],
      );
    }

    return '';
  }

  final List<ConditionStruct> conditions = [];

  for (final entry in entries) {
    final resource = entry?['resource'];

    if (resource == null) {
      continue;
    }

    conditions.add(
      ConditionStruct(
        patientID: getPatientId(resource),
        conditionName: getConditionName(resource),
        conditionCode: getConditionCode(resource),
        onsetDate: getOnsetDate(resource),
        status: getStatus(resource),
      ),
    );
  }

  return conditions;
}

List<MedicationStruct> parseFhirMedications(List<dynamic> entries) {
  if (entries.isEmpty) {
    return <MedicationStruct>[];
  }

  String safeString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  String getPatientId(dynamic resource) {
    final subjectRef = resource?['subject']?['reference'];
    if (subjectRef == null) return '';

    final ref = subjectRef.toString();
    return ref.contains('/') ? ref.split('/').last : ref;
  }

  String getMedicationName(dynamic resource) {
    final medConcept = resource?['medicationCodeableConcept'];

    if (medConcept != null) {
      final text = medConcept['text'];
      if (text != null && text.toString().trim().isNotEmpty) {
        return text.toString();
      }

      final coding = medConcept['coding'];
      if (coding is List && coding.isNotEmpty) {
        final display = coding[0]?['display'];
        if (display != null && display.toString().trim().isNotEmpty) {
          return display.toString();
        }

        return safeString(coding[0]?['code']);
      }
    }

    final medRef = resource?['medicationReference'];
    if (medRef != null) {
      final display = medRef['display'];
      if (display != null && display.toString().trim().isNotEmpty) {
        return display.toString();
      }

      return safeString(medRef['reference']);
    }

    return '';
  }

  String cleanMedicationDisplayName(String medicationName) {
    if (medicationName.trim().isEmpty) {
      return '';
    }

    var name = medicationName.trim();

    // Remove strength, e.g. 81 MG, 10 MG, 0.01 MG, 500 MCG
    name = name.replaceAll(
      RegExp(
        r'\b\d+(?:\.\d+)?\s*(MG|MCG|G|ML|UNIT|UNITS|IU|MEQ|%)\b',
        caseSensitive: false,
      ),
      '',
    );

    // Remove common route / form words.
    // Add more words here if your FHIR server uses other formulation names.
    name = name.replaceAll(
      RegExp(
        r'\b(Oral|Tablet|Tablets|Capsule|Capsules|Caplet|Caplets|Injection|Injectable|Solution|Suspension|Syrup|Cream|Ointment|Gel|Patch|Spray|Drops|Extended Release|Delayed Release|Chewable|Sublingual)\b',
        caseSensitive: false,
      ),
      '',
    );

    // Remove extra separators and spaces
    name = name.replaceAll(RegExp(r'[-_/]+'), ' ');
    name = name.replaceAll(RegExp(r'\s+'), ' ').trim();

    if (name.isEmpty) {
      return medicationName.trim();
    }

    // Title case
    return name.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  String inferDoseFromMedicationName(String medicationName) {
    final regex = RegExp(
      r'(\d+(?:\.\d+)?)\s*(MG|MCG|G|ML|UNIT|UNITS|IU|MEQ|%)',
      caseSensitive: false,
    );

    final match = regex.firstMatch(medicationName);
    if (match == null) return '';

    final value = match.group(1) ?? '';
    final unit = match.group(2) ?? '';

    return '$value ${unit.toUpperCase()}'.trim();
  }

  String inferRouteFromMedicationName(String medicationName) {
    final lower = medicationName.toLowerCase();

    if (lower.contains('oral') ||
        lower.contains('tablet') ||
        lower.contains('capsule') ||
        lower.contains('caplet')) {
      return 'Oral';
    }

    if (lower.contains('injection') || lower.contains('injectable')) {
      return 'Injection';
    }

    if (lower.contains('subcutaneous')) {
      return 'Subcutaneous';
    }

    if (lower.contains('intravenous') || lower.contains(' iv ')) {
      return 'Intravenous';
    }

    if (lower.contains('inhalation') || lower.contains('inhaler')) {
      return 'Inhalation';
    }

    if (lower.contains('topical') ||
        lower.contains('cream') ||
        lower.contains('ointment') ||
        lower.contains('gel')) {
      return 'Topical';
    }

    if (lower.contains('drops')) {
      return 'Drops';
    }

    if (lower.contains('patch')) {
      return 'Transdermal';
    }

    return '';
  }

  String getDose(dynamic resource, String medicationNameRaw) {
    final dosageInstructions = resource?['dosageInstruction'];

    if (dosageInstructions is List && dosageInstructions.isNotEmpty) {
      final dosage = dosageInstructions[0];
      final doseAndRate = dosage?['doseAndRate'];

      if (doseAndRate is List && doseAndRate.isNotEmpty) {
        final doseQuantity = doseAndRate[0]?['doseQuantity'];

        if (doseQuantity != null) {
          final value = safeString(doseQuantity['value']);
          final unit = safeString(
            doseQuantity['unit'] ?? doseQuantity['code'],
          );

          if (value.isNotEmpty && unit.isNotEmpty) {
            return '$value $unit';
          }

          if (value.isNotEmpty) {
            return value;
          }
        }

        final doseRange = doseAndRate[0]?['doseRange'];
        if (doseRange != null) {
          final low = doseRange['low'];
          final high = doseRange['high'];

          final lowValue = safeString(low?['value']);
          final lowUnit = safeString(low?['unit'] ?? low?['code']);

          final highValue = safeString(high?['value']);
          final highUnit = safeString(high?['unit'] ?? high?['code']);

          if (lowValue.isNotEmpty && highValue.isNotEmpty) {
            final unit = highUnit.isNotEmpty ? highUnit : lowUnit;
            return '$lowValue - $highValue $unit'.trim();
          }
        }
      }
    }

    return inferDoseFromMedicationName(medicationNameRaw);
  }

  String getFrequency(dynamic resource) {
    final dosageInstructions = resource?['dosageInstruction'];

    if (dosageInstructions is List && dosageInstructions.isNotEmpty) {
      final dosage = dosageInstructions[0];

      final timing = dosage?['timing'];

      final timingCode = timing?['code'];
      if (timingCode != null) {
        final text = timingCode['text'];
        if (text != null && text.toString().trim().isNotEmpty) {
          return text.toString();
        }

        final coding = timingCode['coding'];
        if (coding is List && coding.isNotEmpty) {
          final display = coding[0]?['display'];
          if (display != null && display.toString().trim().isNotEmpty) {
            return display.toString();
          }

          final code = coding[0]?['code'];
          if (code != null && code.toString().trim().isNotEmpty) {
            return code.toString();
          }
        }
      }

      final repeat = timing?['repeat'];
      if (repeat != null) {
        final frequency = repeat['frequency'];
        final period = repeat['period'];
        final periodUnit = repeat['periodUnit'];

        if (frequency != null && period != null && periodUnit != null) {
          if (safeString(frequency) == '1' &&
              safeString(period) == '1' &&
              safeString(periodUnit) == 'd') {
            return 'Once daily';
          }

          if (safeString(frequency) == '2' &&
              safeString(period) == '1' &&
              safeString(periodUnit) == 'd') {
            return 'Twice daily';
          }

          if (safeString(frequency) == '3' &&
              safeString(period) == '1' &&
              safeString(periodUnit) == 'd') {
            return 'Three times daily';
          }

          if (safeString(frequency) == '4' &&
              safeString(period) == '1' &&
              safeString(periodUnit) == 'd') {
            return 'Four times daily';
          }

          return '${safeString(frequency)} time(s) every ${safeString(period)} ${safeString(periodUnit)}';
        }

        if (frequency != null && periodUnit != null) {
          return '${safeString(frequency)} time(s) per ${safeString(periodUnit)}';
        }

        if (frequency != null) {
          return '${safeString(frequency)} time(s)';
        }
      }

      final asNeeded = dosage?['asNeededBoolean'];
      if (asNeeded == true) {
        return 'As needed';
      }

      final text = dosage?['text'];
      if (text != null && text.toString().trim().isNotEmpty) {
        return text.toString();
      }
    }

    return '';
  }

  String getRoute(dynamic resource, String medicationNameRaw) {
    final dosageInstructions = resource?['dosageInstruction'];

    if (dosageInstructions is List && dosageInstructions.isNotEmpty) {
      final route = dosageInstructions[0]?['route'];

      if (route != null) {
        final text = route['text'];
        if (text != null && text.toString().trim().isNotEmpty) {
          return text.toString();
        }

        final coding = route['coding'];
        if (coding is List && coding.isNotEmpty) {
          final display = coding[0]?['display'];
          if (display != null && display.toString().trim().isNotEmpty) {
            return display.toString();
          }

          return safeString(coding[0]?['code']);
        }
      }
    }

    return inferRouteFromMedicationName(medicationNameRaw);
  }

  final List<MedicationStruct> medications = [];

  for (final entry in entries) {
    final resource = entry?['resource'];

    if (resource == null) {
      continue;
    }

    final medicationNameRaw = getMedicationName(resource);
    final medicationNameDisplay = cleanMedicationDisplayName(medicationNameRaw);

    medications.add(
      MedicationStruct(
        patientID: getPatientId(resource),
        medicationName: medicationNameDisplay,
        medicationDose: getDose(resource, medicationNameRaw),
        frequency: getFrequency(resource),
        route: getRoute(resource, medicationNameRaw),
        status: safeString(resource?['status']),
      ),
    );
  }

  return medications;
}
