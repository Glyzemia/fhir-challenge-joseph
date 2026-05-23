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
        lastUpdated: entryLastUpdated);
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

List<DateTime>? sliceDatesListForTablePages(
  List<DateTime>? dates,
  int startIndex,
  int endIndex,
) {
  // I want the function to take in patients list, and return the sublist from startIndex to endIndex. If endIndex is greater that patients length, return only up to the patients length.
  if (dates == null || startIndex >= dates.length) {
    return [];
  }
  endIndex = endIndex > dates.length ? dates.length : endIndex;
  return dates.sublist(startIndex, endIndex);
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

  String normalizeObservationName(String name) {
    final value = name.trim().toLowerCase();

    // Keep chart filtering consistent.
    if (value == 'pulse') return 'Heart rate';
    if (value == 'heart rate') return 'Heart rate';

    if (value == 'temperature') return 'Body temperature';
    if (value == 'body temperature') return 'Body temperature';
    if (value == 'systolic blood pressure') return 'Systolic blood pressure';
    if (value == 'diastolic blood pressure') return 'Diastolic blood pressure';
    if (value == 'consciousness' || value == 'NEWS2 consciousness')
      return 'Consciousness';

    if (value == 'spo2' || value == 'oxygen saturation in arterial blood') {
      return 'SpO2';
    }
    if (value == 'air or oxygen') return 'Air or oxygen';
    if (value == 'any individual news2 parameter scored 3')
      return 'is_individual_3';

    if (value == 'respiratory rate') return 'Respiratory rate';
    if (value == 'body mass index (bmi) [ratio]') return 'BMI';
    if (value == 'hemoglobin a1c/hemoglobin.total in blood') return 'HbA1c';
    if (value == 'hypercapnic respiratory failure')
      return 'Hypercapnic respiratory failure';

    if (value == 'news2 total score' ||
        value == 'royal college of physicians national early warning score 2') {
      return 'NEWS2 total score';
    }

    return name;
  }

  String getCodeName(dynamic codeObj) {
    if (codeObj == null) return '';

    final text = codeObj['text'];
    if (text != null && text.toString().trim().isNotEmpty) {
      return normalizeObservationName(text.toString());
    }

    final coding = codeObj['coding'];
    if (coding is List && coding.isNotEmpty) {
      return normalizeObservationName(
        safeString(coding[0]?['display'] ?? coding[0]?['code']),
      );
    }

    return '';
  }

  String getObservationValue(dynamic obj) {
    if (obj == null) return '';

    if (obj['valueQuantity'] != null) {
      return safeString(obj['valueQuantity']['value']);
    }

    if (obj['valueString'] != null) {
      return safeString(obj['valueString']);
    }

    if (obj['valueInteger'] != null) {
      return safeString(obj['valueInteger']);
    }

    if (obj['valueBoolean'] != null) {
      return safeString(obj['valueBoolean']);
    }

    if (obj['valueCodeableConcept'] != null) {
      final concept = obj['valueCodeableConcept'];

      final conceptText = concept['text'];
      if (conceptText != null && conceptText.toString().trim().isNotEmpty) {
        return safeString(conceptText);
      }

      final coding = concept['coding'];
      if (coding is List && coding.isNotEmpty) {
        return safeString(
          coding[0]?['display'] ?? coding[0]?['code'],
        );
      }
    }

    return '';
  }

  String getObservationUnit(dynamic obj) {
    if (obj == null) return '';

    if (obj['valueQuantity'] != null) {
      return safeString(
        obj['valueQuantity']['unit'] ?? obj['valueQuantity']['code'],
      );
    }

    return '';
  }

  DateTime? getRecordedAt(dynamic resource) {
    final rawDate = resource?['effectiveDateTime'] ??
        resource?['effectivePeriod']?['start'] ??
        resource?['issued'] ??
        resource?['meta']?['lastUpdated'];

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

    // 1. First parse the main Observation value, if it exists.
    //
    // This is important because some Observations, like your NEWS2 total score,
    // have BOTH:
    // - valueQuantity: total NEWS2 score
    // - component[]: single-red-score-present
    //
    // The previous function skipped the parent value whenever component[] existed.
    final mainValue = getObservationValue(resource);

    if (mainValue.trim().isNotEmpty) {
      observations.add(
        ObservationStruct(
          patientID: patientId,
          observationID: observationId,
          category: category,
          name: getCodeName(resource?['code']),
          value: mainValue,
          units: getObservationUnit(resource),
          recordedAt: recordedAt,
        ),
      );
    }

    // 2. Then parse components if they exist.
    //
    // This handles:
    // - Blood pressure: systolic + diastolic components
    // - NEWS2 total score component: single-red-score-present
    if (components is List && components.isNotEmpty) {
      for (int i = 0; i < components.length; i++) {
        final component = components[i];

        final componentValue = getObservationValue(component);

        if (componentValue.trim().isEmpty) {
          continue;
        }

        observations.add(
          ObservationStruct(
            patientID: patientId,
            observationID: '$observationId-component-$i',
            category: category,
            name: getCodeName(component?['code']),
            value: componentValue,
            units: getObservationUnit(component),
            recordedAt: recordedAt,
          ),
        );
      }
    }
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

String getRandomStringFromList(List<String> stringList) {
  // I input a list of strings. The function outputs one string randomly from the given list
  return stringList[math.Random().nextInt(stringList.length)];
}

double celsiusToFahrenheit(double celsius) {
  // Function that takes in the temperature in celsius and computes the temperature in Fahrenheit.
  return (celsius * 9 / 5) + 32;
}

dynamic generateNEWS2ObservationPostJSON(
  String patientID,
  String encounterID,
  String baseIDValue,
  String practitionerID,
  String recordedAt,
  int pulseRate,
  int systolicBp,
  int diastolicBp,
  int spo2value,
  double temperatureValue,
  int respiratoryRate,
  String airOrOxygen,
  int totalScore,
  String avpuValue,
  String temperatureUnits,
  bool isAnyIndividualScoreHigh,
  bool hypercapnicRespiratoryFailure,
) {
  final String observationIdentifierSystem =
      "https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/observation-identifier";

  final String news2CodeSystem =
      "https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/CodeSystem/news2";

  final String news2ConsciousnessCodeSystem =
      "https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/CodeSystem/news2-consciousness";

  final String news2RiskCodeSystem =
      "https://fhir.medblocks.com/fhir/VJb5MbNQ8Ktr1T7Zzqpz0U2eE2JhOilP/CodeSystem/news2-risk";

  final String spo2ScaleDisplay =
      hypercapnicRespiratoryFailure ? "SpO2 Scale 2" : "SpO2 Scale 1";
  final String spo2ScaleCode =
      hypercapnicRespiratoryFailure ? "scale-2" : "scale-1";

  final String hypercapnicDisplay = hypercapnicRespiratoryFailure
      ? "Hypercapnic respiratory failure: Yes"
      : "Hypercapnic respiratory failure: No";

// If encounterID is already "Encounter/abc123", keep it.
// If it is only "abc123", convert it to "Encounter/abc123".
  final String encounterReference = encounterID.startsWith("Encounter/")
      ? encounterID
      : "Encounter/$encounterID";
  final String obsEncounterFullUrl =
      "urn:uuid:enc-news2-observation-session-001";
  final String obsEncounterReference = obsEncounterFullUrl;

// Temperature unit handling
  final String tempUnit = temperatureUnits.trim().isEmpty
      ? "C"
      : temperatureUnits.trim().toUpperCase();
  final String tempDisplay = tempUnit == "F" ? "F" : "C";
  final String tempUcumCode = tempUnit == "F" ? "[degF]" : "Cel";

  Map<String, String> getConsciousnessCoding(String input) {
    final value = input.trim().toLowerCase();

    if (value == "alert" || value == "a") {
      return {
        "code": "alert",
        "display": "Alert",
        "text": "Alert",
      };
    }

    if (value == "voice" || value == "v") {
      return {
        "code": "voice",
        "display": "Responds to voice",
        "text": "Responds to voice",
      };
    }

    if (value == "pain" || value == "p") {
      return {
        "code": "pain",
        "display": "Responds to pain",
        "text": "Responds to pain",
      };
    }

    if (value == "unresponsive" || value == "u") {
      return {
        "code": "unresponsive",
        "display": "Unresponsive",
        "text": "Unresponsive",
      };
    }

    if (value == "new confusion" ||
        value == "confusion" ||
        value == "c" ||
        value == "cvpu") {
      return {
        "code": "new-confusion",
        "display": "New confusion",
        "text": "New confusion",
      };
    }

    return {
      "code": "unknown",
      "display": input,
      "text": input,
    };
  }

  final consciousness = getConsciousnessCoding(avpuValue);
// Air Oxygen Coding
  Map<String, String> getAirOxygenCoding(String input) {
    final value = input.trim().toLowerCase();

    if (value == "oxygen" ||
        value == "supplemental oxygen" ||
        value == "o2" ||
        value == "yes") {
      return {
        "code": "supplemental-oxygen",
        "display": "Supplemental oxygen",
        "text": "Supplemental oxygen",
      };
    }

    return {
      "code": "air",
      "display": "Air",
      "text": "Air",
    };
  }

  final oxygenStatus = getAirOxygenCoding(airOrOxygen);

  // NEW2 Score Clinical Score
  Map<String, String> getNews2ClinicalRiskCoding(
    int totalScore,
    bool isAnyIndividualScoreHigh,
  ) {
    if (totalScore >= 7) {
      return {
        "code": "high",
        "display": "High clinical risk",
        "text": "High clinical risk",
      };
    }

    if (totalScore >= 5) {
      return {
        "code": "medium",
        "display": "Medium clinical risk",
        "text": "Medium clinical risk",
      };
    }

    if (isAnyIndividualScoreHigh) {
      return {
        "code": "low-medium",
        "display": "Low-medium clinical risk",
        "text": "Low-medium clinical risk due to single parameter score of 3",
      };
    }

    if (totalScore >= 1) {
      return {
        "code": "low",
        "display": "Low clinical risk",
        "text": "Low clinical risk",
      };
    }

    return {
      "code": "normal",
      "display": "Normal clinical risk",
      "text": "Normal clinical risk",
    };
  }

  final news2ClinicalRisk = getNews2ClinicalRiskCoding(
    totalScore,
    isAnyIndividualScoreHigh,
  );

  return {
    "resourceType": "Bundle",
    "type": "transaction",
    "timestamp": "${recordedAt}",
    "entry": [
      {
        "fullUrl": obsEncounterFullUrl,
        "resource": {
          "resourceType": "Encounter",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-OBSENC"
            }
          ],
          "status": "finished",
          "class": {
            "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode",
            "code": "OBSENC",
            "display": "observation encounter"
          },
          "type": [
            {
              "coding": [
                {
                  "system": news2CodeSystem,
                  "code": "news2-observation-session",
                  "display": "NEWS2 observation session"
                }
              ],
              "text": "NEWS2 observation session"
            }
          ],
          "subject": {"reference": "Patient/${patientID}"},
          "participant": [
            {
              "individual": {"reference": "Practitioner/${practitionerID}"}
            }
          ],
          "period": {"start": recordedAt, "end": recordedAt},
          "partOf": {"reference": encounterReference}
        },
        "request": {"method": "POST", "url": "Encounter"}
      },
      {
        "fullUrl": "urn:uuid:obs-news2-rr-001",
        "resource": {
          "resourceType": "Observation",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-RR"
            }
          ],
          "status": "final",
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/observation-category",
                  "code": "vital-signs",
                  "display": "Vital Signs"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": "http://loinc.org",
                "code": "9279-1",
                "display": "Respiratory rate"
              }
            ],
            "text": "Respiratory rate"
          },
          "subject": {"reference": "Patient/${patientID}"},
          "encounter": {"reference": obsEncounterReference},
          "effectiveDateTime": "${recordedAt}",
          "performer": [
            {"reference": "Practitioner/${practitionerID}"}
          ],
          "valueQuantity": {
            "value": respiratoryRate,
            "unit": "breaths/minute",
            "system": "http://unitsofmeasure.org",
            "code": "/min"
          }
        },
        "request": {"method": "POST", "url": "Observation"}
      },
      {
        "fullUrl": "urn:uuid:obs-news2-spo2-001",
        "resource": {
          "resourceType": "Observation",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-SPO2"
            }
          ],
          "status": "final",
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/observation-category",
                  "code": "vital-signs",
                  "display": "Vital Signs"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": "http://loinc.org",
                "code": "2708-6",
                "display": "Oxygen saturation in Arterial blood"
              }
            ],
            "text": "SpO2"
          },
          "subject": {"reference": "Patient/${patientID}"},
          "encounter": {"reference": obsEncounterReference},
          "effectiveDateTime": "${recordedAt}",
          "performer": [
            {"reference": "Practitioner/${practitionerID}"}
          ],
          "valueQuantity": {
            "value": spo2value,
            "unit": "%",
            "system": "http://unitsofmeasure.org",
            "code": "%"
          }
        },
        "request": {"method": "POST", "url": "Observation"}
      },
      {
        "fullUrl": "urn:uuid:obs-news2-hypercapnic-rf-001",
        "resource": {
          "resourceType": "Observation",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-HYPERCAPNIC-RF"
            }
          ],
          "status": "final",
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/observation-category",
                  "code": "survey",
                  "display": "Survey"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": news2CodeSystem,
                "code": "hypercapnic-respiratory-failure",
                "display": "Hypercapnic respiratory failure"
              }
            ],
            "text": "Hypercapnic respiratory failure"
          },
          "subject": {"reference": "Patient/${patientID}"},
          "encounter": {"reference": obsEncounterReference},
          "effectiveDateTime": recordedAt,
          "valueBoolean": hypercapnicRespiratoryFailure,
          "interpretation": [
            {
              "coding": [
                {
                  "system": news2CodeSystem,
                  "code": spo2ScaleCode,
                  "display": spo2ScaleDisplay
                }
              ],
              "text": spo2ScaleDisplay
            }
          ],
          "note": [
            {
              "text":
                  "$hypercapnicDisplay. NEWS2 oxygen saturation scoring uses $spo2ScaleDisplay."
            }
          ]
        },
        "request": {"method": "POST", "url": "Observation"}
      },
      {
        "fullUrl": "urn:uuid:obs-news2-air-oxygen-001",
        "resource": {
          "resourceType": "Observation",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-AIR-OXYGEN"
            }
          ],
          "status": "final",
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/observation-category",
                  "code": "survey",
                  "display": "Survey"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": news2CodeSystem,
                "code": "air-or-oxygen",
                "display": "Air or supplemental oxygen"
              }
            ],
            "text": "Air or oxygen"
          },
          "subject": {"reference": "Patient/${patientID}"},
          "encounter": {"reference": obsEncounterReference},
          "effectiveDateTime": "${recordedAt}",
          "valueCodeableConcept": {
            "coding": [
              {
                "system": news2CodeSystem,
                "code": oxygenStatus["code"],
                "display": oxygenStatus["display"]
              }
            ],
            "text": oxygenStatus["text"]
          }
        },
        "request": {"method": "POST", "url": "Observation"}
      },
      {
        "fullUrl": "urn:uuid:obs-news2-bp-001",
        "resource": {
          "resourceType": "Observation",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-BP"
            }
          ],
          "status": "final",
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/observation-category",
                  "code": "vital-signs",
                  "display": "Vital Signs"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": "http://loinc.org",
                "code": "85354-9",
                "display": "Blood pressure panel with all children optional"
              }
            ],
            "text": "Blood pressure"
          },
          "subject": {"reference": "Patient/${patientID}"},
          "encounter": {"reference": obsEncounterReference},
          "effectiveDateTime": "${recordedAt}",
          "performer": [
            {"reference": "Practitioner/${practitionerID}"}
          ],
          "component": [
            {
              "code": {
                "coding": [
                  {
                    "system": "http://loinc.org",
                    "code": "8480-6",
                    "display": "Systolic blood pressure"
                  }
                ],
                "text": "Systolic blood pressure"
              },
              "valueQuantity": {
                "value": systolicBp,
                "unit": "mmHg",
                "system": "http://unitsofmeasure.org",
                "code": "mm[Hg]"
              }
            },
            {
              "code": {
                "coding": [
                  {
                    "system": "http://loinc.org",
                    "code": "8462-4",
                    "display": "Diastolic blood pressure"
                  }
                ],
                "text": "Diastolic blood pressure"
              },
              "valueQuantity": {
                "value": diastolicBp,
                "unit": "mmHg",
                "system": "http://unitsofmeasure.org",
                "code": "mm[Hg]"
              }
            }
          ]
        },
        "request": {"method": "POST", "url": "Observation"}
      },
      {
        "fullUrl": "urn:uuid:obs-news2-pulse-001",
        "resource": {
          "resourceType": "Observation",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-PULSE"
            }
          ],
          "status": "final",
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/observation-category",
                  "code": "vital-signs",
                  "display": "Vital Signs"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": "http://loinc.org",
                "code": "8867-4",
                "display": "Heart rate"
              }
            ],
            "text": "Pulse"
          },
          "subject": {"reference": "Patient/${patientID}"},
          "encounter": {"reference": obsEncounterReference},
          "effectiveDateTime": "${recordedAt}",
          "performer": [
            {"reference": "Practitioner/${practitionerID}"}
          ],
          "valueQuantity": {
            "value": pulseRate,
            "unit": "beats/minute",
            "system": "http://unitsofmeasure.org",
            "code": "/min"
          }
        },
        "request": {"method": "POST", "url": "Observation"}
      },
      {
        "fullUrl": "urn:uuid:obs-news2-consciousness-001",
        "resource": {
          "resourceType": "Observation",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-CONSCIOUSNESS"
            }
          ],
          "status": "final",
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/observation-category",
                  "code": "exam",
                  "display": "Exam"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": news2CodeSystem,
                "code": "consciousness",
                "display": "NEWS2 consciousness"
              }
            ],
            "text": "Consciousness"
          },
          "subject": {"reference": "Patient/${patientID}"},
          "encounter": {"reference": obsEncounterReference},
          "effectiveDateTime": "${recordedAt}",
          "valueCodeableConcept": {
            "coding": [
              {
                "system": news2ConsciousnessCodeSystem,
                "code": consciousness["code"],
                "display": consciousness["display"]
              }
            ],
            "text": consciousness["text"]
          }
        },
        "request": {"method": "POST", "url": "Observation"}
      },
      {
        "fullUrl": "urn:uuid:obs-news2-temperature-001",
        "resource": {
          "resourceType": "Observation",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-TEMP"
            }
          ],
          "status": "final",
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/observation-category",
                  "code": "vital-signs",
                  "display": "Vital Signs"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": "http://loinc.org",
                "code": "8310-5",
                "display": "Body temperature"
              }
            ],
            "text": "Temperature"
          },
          "subject": {"reference": "Patient/${patientID}"},
          "encounter": {"reference": obsEncounterReference},
          "effectiveDateTime": "${recordedAt}",
          "performer": [
            {"reference": "Practitioner/${practitionerID}"}
          ],
          "valueQuantity": {
            "value": temperatureValue,
            "unit": tempDisplay,
            "system": "http://unitsofmeasure.org",
            "code": tempUcumCode
          }
        },
        "request": {"method": "POST", "url": "Observation"}
      },
      {
        "fullUrl": "urn:uuid:obs-news2-total-score-001",
        "resource": {
          "resourceType": "Observation",
          "identifier": [
            {
              "system": observationIdentifierSystem,
              "value": "${baseIDValue}-TOTAL-SCORE"
            }
          ],
          "status": "final",
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/observation-category",
                  "code": "survey",
                  "display": "Survey"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": "http://snomed.info/sct",
                "code": "1104051000000101",
                "display":
                    "Royal College of Physicians National Early Warning Score 2"
              }
            ],
            "text": "NEWS2 total score"
          },
          "subject": {"reference": "Patient/${patientID}"},
          "encounter": {"reference": obsEncounterReference},
          "effectiveDateTime": "${recordedAt}",
          "derivedFrom": [
            {"reference": "urn:uuid:obs-news2-rr-001"},
            {"reference": "urn:uuid:obs-news2-spo2-001"},
            {"reference": "urn:uuid:obs-news2-hypercapnic-rf-001"},
            {"reference": "urn:uuid:obs-news2-air-oxygen-001"},
            {"reference": "urn:uuid:obs-news2-bp-001"},
            {"reference": "urn:uuid:obs-news2-pulse-001"},
            {"reference": "urn:uuid:obs-news2-consciousness-001"},
            {"reference": "urn:uuid:obs-news2-temperature-001"}
          ],
          "valueQuantity": {
            "value": totalScore,
            "unit": "score",
            "system": "http://unitsofmeasure.org",
            "code": "{score}"
          },
          "component": [
            {
              "code": {
                "coding": [
                  {
                    "system": news2CodeSystem,
                    "code": "single-red-score-present",
                    "display": "Single red score present"
                  }
                ],
                "text": "Any individual NEWS2 parameter scored 3"
              },
              "valueBoolean": isAnyIndividualScoreHigh
            }
          ],
          "interpretation": [
            {
              "coding": [
                {
                  "system": news2RiskCodeSystem,
                  "code": news2ClinicalRisk["code"],
                  "display": news2ClinicalRisk["display"]
                }
              ],
              "text": news2ClinicalRisk["text"]
            }
          ],
          "note": [
            {
              "text": "NEWS2 calculated from observations entered at $recordedAt. "
                  "Total score: $totalScore. "
                  "Single parameter score of 3 present: ${isAnyIndividualScoreHigh ? "Yes" : "No"}. "
                  "Clinical risk: ${news2ClinicalRisk["display"]}."
            }
          ]
        },
        "request": {"method": "POST", "url": "Observation"}
      }
    ]
  };
}

String? datetimeToISO8601String(DateTime? date) {
  // convert datetime object to iso8601 string format
  if (date == null) return null;
  return date.toUtc().toIso8601String();
}

NewsScoreDecodeStruct decodeNewsScore(
  int newsScore,
  bool singleRedScore,
) {
  String interpretation = '';
  String assessmentBy = '';
  String action1 = '';
  String action2 = '';

  if (newsScore >= 7) {
    interpretation = 'High Risk';
    assessmentBy = 'Inform RMO and Consultant immediately';
    action1 = 'Monitor Vitals every 15 mins (Continuous)';
    action2 = 'Transfer patient to ICU';
  } else if (newsScore >= 5) {
    interpretation = 'Moderate Risk';
    assessmentBy = 'Inform RMO immediately';
    action1 = 'Monitor Vitals every 1 hour';
    action2 = 'Doctor to decide on ICU transfer';
  } else if (singleRedScore) {
    interpretation = 'Moderate Risk';
    assessmentBy = 'Inform RMO immediately';
    action1 = 'Monitor Vitals every 1 hour (at least)';
    action2 = 'Doctor to decide on ICU transfer';
  } else {
    interpretation = 'Low Risk';
    assessmentBy = 'Continue Monitoring by Nurse.';
    action1 = 'Monitor Vitals every 4 hours';
  }
  return NewsScoreDecodeStruct(
      interpretation: interpretation,
      assessmentBy: assessmentBy,
      action1: action1,
      action2: action2);
}

List<DateTime> convertUTCtoISTDatetime(List<DateTime> utcDatesList) {
  // convert utc datetimes liste to IST datetimes list
  return utcDatesList.map((utcDate) {
    // IST is UTC + 5 hours and 30 minutes
    return utcDate.toUtc().add(Duration(hours: 5, minutes: 30));
  }).toList();
}

int calculateNews2IndividualScores(
  String componentName,
  String componentValue,
  bool? hypercapneicRespiratoryFailure,
  bool? isOnSupplementalO2,
) {
  final String name = componentName.trim().toLowerCase();
  final String value = componentValue.trim().toLowerCase();

  if (value.isEmpty) {
    return 0;
  }

  double? parseNumber(String input) {
    final cleaned = input
        .replaceAll('%', '')
        .replaceAll('°c', '')
        .replaceAll('°f', '')
        .replaceAll('c', '')
        .replaceAll('f', '')
        .trim();

    return double.tryParse(cleaned);
  }

  bool parseOxygenValue(String input) {
    final cleaned = input.trim().toLowerCase();

    return cleaned == 'oxygen' ||
        cleaned == 'o2' ||
        cleaned == 'supplemental oxygen' ||
        cleaned == 'supplemental o2' ||
        cleaned == 'yes' ||
        cleaned == 'true' ||
        cleaned == '1' ||
        cleaned.contains('oxygen') ||
        cleaned.contains('o2');
  }

  final double? numericValue = parseNumber(value);

  switch (name) {
    case 'respiratoryrate':
      if (numericValue == null) return 0;

      if (numericValue <= 8) {
        return 3;
      } else if (numericValue >= 9 && numericValue <= 11) {
        return 1;
      } else if (numericValue >= 12 && numericValue <= 20) {
        return 0;
      } else if (numericValue >= 21 && numericValue <= 24) {
        return 2;
      } else {
        return 3; // >= 25
      }

    case 'pulse':
      if (numericValue == null) return 0;

      if (numericValue <= 40) {
        return 3;
      } else if (numericValue >= 41 && numericValue <= 50) {
        return 1;
      } else if (numericValue >= 51 && numericValue <= 90) {
        return 0;
      } else if (numericValue >= 91 && numericValue <= 110) {
        return 1;
      } else if (numericValue >= 111 && numericValue <= 130) {
        return 2;
      } else {
        return 3; // >= 131
      }

    case 'systolicbp':
      if (numericValue == null) return 0;

      if (numericValue <= 90) {
        return 3;
      } else if (numericValue >= 91 && numericValue <= 100) {
        return 2;
      } else if (numericValue >= 101 && numericValue <= 110) {
        return 1;
      } else if (numericValue >= 111 && numericValue <= 219) {
        return 0;
      } else {
        return 3; // >= 220
      }

    case 'temperature':
      if (numericValue == null) return 0;

      // NEWS2 temperature thresholds are in Celsius.
      // If a Fahrenheit-like value is passed, convert automatically.
      double tempC = numericValue;
      if (tempC > 45) {
        tempC = (tempC - 32) * 5 / 9;
      }

      if (tempC <= 35.0) {
        return 3;
      } else if (tempC >= 35.1 && tempC <= 36.0) {
        return 1;
      } else if (tempC >= 36.1 && tempC <= 38.0) {
        return 0;
      } else if (tempC >= 38.1 && tempC <= 39.0) {
        return 1;
      } else {
        return 2; // >= 39.1
      }

    case 'spo2':
      if (numericValue == null) return 0;

      final bool useScale2 = hypercapneicRespiratoryFailure == true;
      final bool onOxygen = isOnSupplementalO2 == true;

      if (!useScale2) {
        // SpO2 Scale 1
        if (numericValue <= 91) {
          return 3;
        } else if (numericValue >= 92 && numericValue <= 93) {
          return 2;
        } else if (numericValue >= 94 && numericValue <= 95) {
          return 1;
        } else {
          return 0; // >= 96
        }
      } else {
        // SpO2 Scale 2: for hypercapnic respiratory failure / target 88–92%.
        if (numericValue <= 83) {
          return 3;
        } else if (numericValue >= 84 && numericValue <= 85) {
          return 2;
        } else if (numericValue >= 86 && numericValue <= 87) {
          return 1;
        } else if (numericValue >= 88 && numericValue <= 92) {
          return 0;
        } else if (numericValue >= 93 && numericValue <= 94) {
          return onOxygen ? 1 : 0;
        } else if (numericValue >= 95 && numericValue <= 96) {
          return onOxygen ? 2 : 1;
        } else {
          return onOxygen ? 3 : 2; // >= 97
        }
      }

    case 'airoroxygen':
      return parseOxygenValue(value) ? 2 : 0;

    case 'consciousness':
      if (value == 'alert' || value == 'a') {
        return 0;
      }

      if (value == 'new confusion' ||
          value == 'confusion' ||
          value == 'confused' ||
          value == 'c' ||
          value == 'voice' ||
          value == 'v' ||
          value == 'pain' ||
          value == 'p' ||
          value == 'unresponsive' ||
          value == 'u') {
        return 3;
      }

      return 0;

    default:
      return 0;
  }
}

int calculateAgeFromDOB(DateTime dateOfBirth) {
// need to calculate age (as integer) from date of birth.
  DateTime today = DateTime.now();
  int age = today.year - dateOfBirth.year;
  if (today.month < dateOfBirth.month ||
      (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
    age--;
  }
  return age;
}

DateTime calculatedDOBFromAgeinYears(double age) {
  // calculate date of birth from age. If age is given in decimals like 2.5, ensure that the date is  2 years and 6 months ago.
  int years = age.floor();
  int months = ((age - years) * 12).round();
  DateTime today = DateTime.now();
  DateTime dob = DateTime(today.year - years, today.month - months, today.day);
  return dob;
}

dynamic buildDiabetesPOSTJSON(
  String patientID,
  String encounterID,
  String diabetesCode,
  String diabetesCodeName,
  String diabetesDisplayText,
  String diabetesOnsetDate,
  String recordedAt,
  String insulinName,
  int morningInsulinDose,
  int afternoonInsulinDose,
  int nightInsulinDose,
  String ohaName,
  int morningOHADose,
  int? afternoonOHADose,
  int? nightOHADose,
) {
  return {
    "resourceType": "Bundle",
    "type": "transaction",
    "entry": [
      {
        "fullUrl": "urn:uuid:diabetes-condition",
        "resource": {
          "resourceType": "Condition",
          "identifier": [
            {
              "system":
                  "https://glyzemia.app/fhir/identifier/diabetes-condition",
              "value": "Patient-${patientID}-diabetes"
            }
          ],
          "clinicalStatus": {
            "coding": [
              {
                "system":
                    "http://terminology.hl7.org/CodeSystem/condition-clinical",
                "code": "active",
                "display": "Active"
              }
            ]
          },
          "verificationStatus": {
            "coding": [
              {
                "system":
                    "http://terminology.hl7.org/CodeSystem/condition-ver-status",
                "code": "confirmed",
                "display": "Confirmed"
              }
            ]
          },
          "category": [
            {
              "coding": [
                {
                  "system":
                      "http://terminology.hl7.org/CodeSystem/condition-category",
                  "code": "problem-list-item",
                  "display": "Problem List Item"
                }
              ]
            }
          ],
          "code": {
            "coding": [
              {
                "system": "http://snomed.info/sct",
                "code": diabetesCode,
                "display": diabetesCodeName
              }
            ],
            "text": diabetesDisplayText
          },
          "subject": {"reference": "Patient/${patientID}"},
          "onsetDateTime": diabetesOnsetDate
        },
        "request": {
          "method": "POST",
          "url": "Condition",
          "ifNoneExist":
              "identifier=https://glyzemia.app/fhir/identifier/diabetes-condition|Patient-${patientID}-diabetes"
        }
      },
      {
        "fullUrl": "urn:uuid:home-insulin-1",
        "resource": {
          "resourceType": "MedicationStatement",
          "identifier": [
            {
              "system": "https://glyzemia.app/fhir/identifier/home-medication",
              "value": "Encounter-${encounterID}-home-insulin-1"
            }
          ],
          "status": "active",
          "category": {"text": "Home medication"},
          "medicationCodeableConcept": {"text": insulinName},
          "subject": {"reference": "Patient/${patientID}"},
          "context": {"reference": "Encounter/${encounterID}"},
          "effectiveDateTime": recordedAt,
          "dateAsserted": recordedAt,
          "dosage": [
            {
              "sequence": 1,
              "text": "Morning dose",
              "timing": {
                "code": {"text": "Morning"}
              },
              "route": {"text": "Subcutaneous"},
              "doseAndRate": [
                {
                  "doseQuantity": {
                    "value": morningInsulinDose,
                    "unit": "unit",
                    "system": "http://unitsofmeasure.org",
                    "code": "U"
                  }
                }
              ]
            },
            {
              "sequence": 2,
              "text": "Afternoon dose",
              "timing": {
                "code": {"text": "Afternoon"}
              },
              "route": {"text": "Subcutaneous"},
              "doseAndRate": [
                {
                  "doseQuantity": {
                    "value": afternoonInsulinDose,
                    "unit": "unit",
                    "system": "http://unitsofmeasure.org",
                    "code": "U"
                  }
                }
              ]
            },
            {
              "sequence": 3,
              "text": "Night dose",
              "timing": {
                "code": {"text": "Night"}
              },
              "route": {"text": "Subcutaneous"},
              "doseAndRate": [
                {
                  "doseQuantity": {
                    "value": nightInsulinDose,
                    "unit": "unit",
                    "system": "http://unitsofmeasure.org",
                    "code": "U"
                  }
                }
              ]
            }
          ],
          "note": [
            {"text": "Home insulin dose pattern"}
          ]
        },
        "request": {
          "method": "POST",
          "url": "MedicationStatement",
          "ifNoneExist":
              "identifier=https://glyzemia.app/fhir/identifier/home-medication|Encounter-${encounterID}-home-insulin-1"
        }
      },
      {
        "fullUrl": "urn:uuid:home-oha-1",
        "resource": {
          "resourceType": "MedicationStatement",
          "identifier": [
            {
              "system": "https://glyzemia.app/fhir/identifier/home-medication",
              "value": "Encounter-${encounterID}-home-oha-1"
            }
          ],
          "status": "active",
          "category": {"text": "Home medication"},
          "medicationCodeableConcept": {"text": ohaName},
          "subject": {"reference": "Patient/${patientID}"},
          "context": {"reference": "Encounter/${encounterID}"},
          "effectiveDateTime": recordedAt,
          "dateAsserted": recordedAt,
          "dosage": [
            {
              "sequence": 1,
              "text": "Morning dose",
              "timing": {
                "code": {"text": "Morning"}
              },
              "route": {"text": "Oral"},
              "doseAndRate": [
                {
                  "doseQuantity": {"value": morningOHADose, "unit": "tablet"}
                }
              ]
            },
            {
              "sequence": 2,
              "text": "Afternoon dose",
              "timing": {
                "code": {"text": "Afternoon"}
              },
              "route": {"text": "Oral"},
              "doseAndRate": [
                {
                  "doseQuantity": {"value": afternoonOHADose, "unit": "tablet"}
                }
              ]
            },
            {
              "sequence": 3,
              "text": "Night dose",
              "timing": {
                "code": {"text": "Night"}
              },
              "route": {"text": "Oral"},
              "doseAndRate": [
                {
                  "doseQuantity": {"value": nightOHADose, "unit": "tablet"}
                }
              ]
            }
          ],
          "note": [
            {"text": "Home OHA dose pattern"}
          ]
        },
        "request": {
          "method": "POST",
          "url": "MedicationStatement",
          "ifNoneExist":
              "identifier=https://glyzemia.app/fhir/identifier/home-medication|Encounter-${encounterID}-home-oha-1"
        }
      }
    ]
  };
}

List<MedicationStatementStruct> parseFhirMedicationStatement(
    List<dynamic>? entries) {
  final List<MedicationStatementStruct> parsedList = [];

  if (entries == null || entries is! List) {
    return parsedList;
  }

  for (final entry in entries) {
    try {
      final resource = entry?['resource'];

      if (resource == null ||
          resource['resourceType'] != 'MedicationStatement') {
        continue;
      }

      final medicationName =
          resource['medicationCodeableConcept']?['text']?.toString() ?? '';

      int morningDose = 0;
      int afternoonDose = 0;
      int nightDose = 0;
      String route = '';

      final dosageList = resource['dosage'];

      if (dosageList != null && dosageList is List) {
        for (final dosage in dosageList) {
          final sequence = dosage?['sequence'];

          final doseValueRaw =
              dosage?['doseAndRate']?[0]?['doseQuantity']?['value'];

          int doseValue = 0;

          if (doseValueRaw is int) {
            doseValue = doseValueRaw;
          } else if (doseValueRaw is double) {
            doseValue = doseValueRaw.round();
          } else if (doseValueRaw is String) {
            doseValue = int.tryParse(doseValueRaw) ?? 0;
          }

          final routeText = dosage?['route']?['text']?.toString() ?? '';

          if (route.isEmpty && routeText.isNotEmpty) {
            route = routeText;
          }

          if (sequence == 1) {
            morningDose = doseValue;
          } else if (sequence == 2) {
            afternoonDose = doseValue;
          } else if (sequence == 3) {
            nightDose = doseValue;
          }
        }
      }

      parsedList.add(
        MedicationStatementStruct(
          medicationName: medicationName,
          morningDose: morningDose,
          afternoonDose: afternoonDose,
          nightDose: nightDose,
          route: route,
        ),
      );
    } catch (e) {
      continue;
    }
  }

  return parsedList;
}
