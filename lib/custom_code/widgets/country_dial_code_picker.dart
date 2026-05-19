// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:country_picker/country_picker.dart';

class CountryDialCodePicker extends StatefulWidget {
  const CountryDialCodePicker({
    super.key,
    this.width,
    this.height,
    required this.initialDialCode,
    required this.initialIsoCode,
    this.borderRadius = 8.0,
  });

  final double? width;
  final double? height;
  final String initialDialCode;
  final String initialIsoCode;
  final double borderRadius;

  @override
  State<CountryDialCodePicker> createState() => _CountryDialCodePickerState();
}

class _CountryDialCodePickerState extends State<CountryDialCodePicker> {
  late String dialCode;
  late String isoCode;
  late String countryName;
  late String flagEmoji;

  @override
  void initState() {
    super.initState();

    dialCode =
        widget.initialDialCode.isNotEmpty ? widget.initialDialCode : '+91';

    isoCode = widget.initialIsoCode.isNotEmpty
        ? widget.initialIsoCode.toUpperCase()
        : 'IN';

    countryName = FFAppState().selectedPhoneCountryName.isNotEmpty
        ? FFAppState().selectedPhoneCountryName
        : 'India';

    flagEmoji = FFAppState().selectedPhoneFlagEmoji.isNotEmpty
        ? FFAppState().selectedPhoneFlagEmoji
        : _countryCodeToEmoji(isoCode);
  }

  String _countryCodeToEmoji(String countryCode) {
    final String upperCode = countryCode.toUpperCase();

    if (upperCode.length != 2) {
      return '🏳️';
    }

    final int firstLetter = upperCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = upperCode.codeUnitAt(1) - 0x41 + 0x1F1E6;

    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: const ['IN', 'SG', 'AE', 'GB', 'US'],
      countryListTheme: CountryListThemeData(
        flagSize: 24,
        bottomSheetHeight: 520,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search country',
          hintText: 'Start typing country name or code',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onSelect: (Country country) {
        final String newDialCode = '+${country.phoneCode}';
        final String newIsoCode = country.countryCode;
        final String newCountryName = country.name;
        final String newFlagEmoji = _countryCodeToEmoji(country.countryCode);

        setState(() {
          dialCode = newDialCode;
          isoCode = newIsoCode;
          countryName = newCountryName;
          flagEmoji = newFlagEmoji;
        });

        FFAppState().update(() {
          FFAppState().selectedPhoneDialCode = newDialCode;
          FFAppState().selectedPhoneIsoCode = newIsoCode;
          FFAppState().selectedPhoneCountryName = newCountryName;
          FFAppState().selectedPhoneFlagEmoji = newFlagEmoji;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return InkWell(
      onTap: _openCountryPicker,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        width: widget.width ?? 110,
        height: widget.height ?? 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: theme.alternate,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              flagEmoji,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                dialCode,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.bodyMedium.override(
                  fontFamily: theme.bodyMediumFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
