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

List<PatientStruct>? parseFhirPatients(List<dynamic>? entries) {
  if (entries == null || entries is! List) {
    return [];
  }

  return entries.map<PatientStruct>((entry) {
    final resource = entry['resource'] ?? {};

    final nameList = resource['name'];
    final firstName =
        nameList is List && nameList.isNotEmpty ? nameList.first : {};

    final givenRaw = firstName['given'];
    final firstNameOnly = givenRaw.first;
    final String parsedGivenNames =
        givenRaw is List ? givenRaw.map((e) => e.toString()).join(' ') : '';

    final telecomList = resource['telecom'];
    final firstTelecom =
        telecomList is List && telecomList.isNotEmpty ? telecomList.first : {};

    return createPatientStruct(
        identifier: resource['id']?.toString() ?? '',
        givenNames: parsedGivenNames,
        familyName: firstName['family']?.toString() ?? '',
        telecomSystem: firstTelecom['system']?.toString() ?? '',
        telecomValue: firstTelecom['value']?.toString() ?? '',
        gender: resource['gender']?.toString() ?? '',
        birthDate: resource['birthDate']?.toString() ?? '',
        firstName: firstNameOnly);
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
