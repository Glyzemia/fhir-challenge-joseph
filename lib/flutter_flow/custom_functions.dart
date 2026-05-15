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
