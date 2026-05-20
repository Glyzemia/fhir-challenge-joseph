import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'n_e_w_s_row_component_model.dart';
export 'n_e_w_s_row_component_model.dart';

class NEWSRowComponentWidget extends StatefulWidget {
  const NEWSRowComponentWidget({
    super.key,
    required this.observationsRow,
    bool? isLatest,
  }) : this.isLatest = isLatest ?? false;

  final List<ObservationStruct>? observationsRow;
  final bool isLatest;

  @override
  State<NEWSRowComponentWidget> createState() => _NEWSRowComponentWidgetState();
}

class _NEWSRowComponentWidgetState extends State<NEWSRowComponentWidget> {
  late NEWSRowComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NEWSRowComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      cursor: MouseCursor.defer ?? MouseCursor.defer,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              height: _model.isRowHovered ? 210.0 : 50.0,
              decoration: BoxDecoration(
                color: _model.isRowHovered
                    ? FlutterFlowTheme.of(context).cardBlue
                    : FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.only(),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: AutoSizeText(
                            dateTimeFormat(
                                "d/M",
                                functions
                                    .convertUTCtoISTDatetime(widget
                                        .observationsRow!
                                        .take(1)
                                        .toList()
                                        .map((e) => e.recordedAt)
                                        .withoutNulls
                                        .toList())
                                    .firstOrNull),
                            minFontSize: 8.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: _model.isRowHovered
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  fontSize: _model.isRowHovered ? 15.0 : 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )),
                          SelectionArea(
                              child: AutoSizeText(
                            dateTimeFormat(
                                "jm",
                                functions
                                    .convertUTCtoISTDatetime(widget
                                        .observationsRow!
                                        .take(1)
                                        .toList()
                                        .map((e) => e.recordedAt)
                                        .withoutNulls
                                        .toList())
                                    .firstOrNull),
                            minFontSize: 8.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: _model.isRowHovered
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  fontSize: _model.isRowHovered ? 15.0 : 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: AutoSizeText(
                            valueOrDefault<String>(
                              widget.observationsRow
                                  ?.where((e) => e.name == 'Heart rate')
                                  .toList()
                                  .firstOrNull
                                  ?.value,
                              'PR',
                            ),
                            minFontSize: 8.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: _model.isRowHovered
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  fontSize: _model.isRowHovered ? 15.0 : 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )),
                          SelectionArea(
                              child: AutoSizeText(
                            ' (${functions.calculateNews2IndividualScores('pulse', valueOrDefault<String>(
                                  widget.observationsRow
                                      ?.where((e) => e.name == 'Heart rate')
                                      .toList()
                                      .firstOrNull
                                      ?.value,
                                  'PR',
                                ), false, false).toString()})',
                            minFontSize: 8.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: () {
                                    if (functions
                                            .calculateNews2IndividualScores(
                                                'pulse',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Heart rate')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'PR',
                                                ),
                                                false,
                                                false) ==
                                        3) {
                                      return FlutterFlowTheme.of(context).error;
                                    } else if (functions
                                            .calculateNews2IndividualScores(
                                                'pulse',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Heart rate')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'PR',
                                                ),
                                                false,
                                                false) ==
                                        0) {
                                      return FlutterFlowTheme.of(context)
                                          .success;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .tertiary;
                                    }
                                  }(),
                                  fontSize: _model.isRowHovered ? 12.0 : 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: Text(
                            '${valueOrDefault<String>(
                              widget.observationsRow
                                  ?.where((e) =>
                                      e.name == 'Systolic blood pressure')
                                  .toList()
                                  .firstOrNull
                                  ?.value,
                              'SBP',
                            )} / ${valueOrDefault<String>(
                              widget.observationsRow
                                  ?.where((e) =>
                                      e.name == 'Diastolic blood pressure')
                                  .toList()
                                  .firstOrNull
                                  ?.value,
                              'DBP',
                            )}',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: _model.isRowHovered
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  fontSize: _model.isRowHovered ? 15.0 : 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          )),
                          SelectionArea(
                              child: AutoSizeText(
                            ' (${functions.calculateNews2IndividualScores('systolicBp', valueOrDefault<String>(
                                  widget.observationsRow
                                      ?.where((e) =>
                                          e.name == 'Systolic blood pressure')
                                      .toList()
                                      .firstOrNull
                                      ?.value,
                                  'SBP',
                                ), false, false).toString()})',
                            minFontSize: 8.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: () {
                                    if (functions
                                            .calculateNews2IndividualScores(
                                                'systolicBp',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Systolic blood pressure')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'SBP',
                                                ),
                                                false,
                                                false) ==
                                        3) {
                                      return FlutterFlowTheme.of(context).error;
                                    } else if (functions
                                            .calculateNews2IndividualScores(
                                                'systolicBp',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Systolic blood pressure')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'SBP',
                                                ),
                                                false,
                                                false) ==
                                        0) {
                                      return FlutterFlowTheme.of(context)
                                          .success;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .tertiary;
                                    }
                                  }(),
                                  fontSize: _model.isRowHovered ? 12.0 : 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: Text(
                            valueOrDefault<String>(
                              widget.observationsRow
                                  ?.where((e) => e.name == 'Respiratory rate')
                                  .toList()
                                  .firstOrNull
                                  ?.value,
                              'RR',
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: _model.isRowHovered
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  fontSize: _model.isRowHovered ? 15.0 : 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          )),
                          SelectionArea(
                              child: AutoSizeText(
                            ' (${functions.calculateNews2IndividualScores('respiratoryRate', valueOrDefault<String>(
                                  widget.observationsRow
                                      ?.where(
                                          (e) => e.name == 'Respiratory rate')
                                      .toList()
                                      .firstOrNull
                                      ?.value,
                                  'RR',
                                ), false, false).toString()})',
                            minFontSize: 8.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: () {
                                    if (functions
                                            .calculateNews2IndividualScores(
                                                'systolicBp',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Respiratory rate')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'RR',
                                                ),
                                                false,
                                                false) ==
                                        3) {
                                      return FlutterFlowTheme.of(context).error;
                                    } else if (functions
                                            .calculateNews2IndividualScores(
                                                'systolicBp',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Respiratory rate')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'RR',
                                                ),
                                                false,
                                                false) ==
                                        0) {
                                      return FlutterFlowTheme.of(context)
                                          .success;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .tertiary;
                                    }
                                  }(),
                                  fontSize: _model.isRowHovered ? 12.0 : 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: Text(
                            valueOrDefault<String>(
                              widget.observationsRow
                                  ?.where((e) => e.name == 'Body temperature')
                                  .toList()
                                  .firstOrNull
                                  ?.value,
                              'Temp',
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: _model.isRowHovered
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  fontSize: _model.isRowHovered ? 15.0 : 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          )),
                          SelectionArea(
                              child: AutoSizeText(
                            ' (${functions.calculateNews2IndividualScores('temperature', valueOrDefault<String>(
                                  widget.observationsRow
                                      ?.where(
                                          (e) => e.name == 'Body temperature')
                                      .toList()
                                      .firstOrNull
                                      ?.value,
                                  'Temp',
                                ), false, false).toString()})',
                            minFontSize: 8.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: () {
                                    if (functions
                                            .calculateNews2IndividualScores(
                                                'temperature',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Body temperature')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'Temp',
                                                ),
                                                false,
                                                false) ==
                                        3) {
                                      return FlutterFlowTheme.of(context).error;
                                    } else if (functions
                                            .calculateNews2IndividualScores(
                                                'temperature',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Body temperature')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'Temp',
                                                ),
                                                false,
                                                false) ==
                                        0) {
                                      return FlutterFlowTheme.of(context)
                                          .success;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .tertiary;
                                    }
                                  }(),
                                  fontSize: _model.isRowHovered ? 12.0 : 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: Text(
                            valueOrDefault<String>(
                                      widget.observationsRow
                                          ?.where(
                                              (e) => e.name == 'Air or oxygen')
                                          .toList()
                                          .firstOrNull
                                          ?.value,
                                      'Air/O2',
                                    ) ==
                                    'Supplemental oxygen'
                                ? 'Oxygen'
                                : 'Air',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: _model.isRowHovered
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  fontSize: _model.isRowHovered ? 15.0 : 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          )),
                          SelectionArea(
                              child: AutoSizeText(
                            ' (${functions.calculateNews2IndividualScores('airOrOxygen', valueOrDefault<String>(
                                  widget.observationsRow
                                      ?.where((e) => e.name == 'Air or oxygen')
                                      .toList()
                                      .firstOrNull
                                      ?.value,
                                  'Air/O2',
                                ) == 'Supplemental oxygen' ? 'Oxygen' : 'Air', false, false).toString()})',
                            minFontSize: 8.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: () {
                                    if (functions
                                            .calculateNews2IndividualScores(
                                                'airOrOxygen',
                                                valueOrDefault<String>(
                                                          widget
                                                              .observationsRow
                                                              ?.where((e) =>
                                                                  e.name ==
                                                                  'Air or oxygen')
                                                              .toList()
                                                              .firstOrNull
                                                              ?.value,
                                                          'Air/O2',
                                                        ) ==
                                                        'Supplemental oxygen'
                                                    ? 'Oxygen'
                                                    : 'Air',
                                                false,
                                                false) ==
                                        3) {
                                      return FlutterFlowTheme.of(context).error;
                                    } else if (functions
                                            .calculateNews2IndividualScores(
                                                'airOrOxygen',
                                                valueOrDefault<String>(
                                                          widget
                                                              .observationsRow
                                                              ?.where((e) =>
                                                                  e.name ==
                                                                  'Air or oxygen')
                                                              .toList()
                                                              .firstOrNull
                                                              ?.value,
                                                          'Air/O2',
                                                        ) ==
                                                        'Supplemental oxygen'
                                                    ? 'Oxygen'
                                                    : 'Air',
                                                false,
                                                false) ==
                                        0) {
                                      return FlutterFlowTheme.of(context)
                                          .success;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .tertiary;
                                    }
                                  }(),
                                  fontSize: _model.isRowHovered ? 12.0 : 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: _model.isRowHovered ? 210.0 : 50.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SelectionArea(
                                    child: Text(
                                  valueOrDefault<String>(
                                    widget.observationsRow
                                        ?.where((e) => e.name == 'SpO2')
                                        .toList()
                                        .firstOrNull
                                        ?.value,
                                    'SpO2',
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: _model.isRowHovered
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                        fontSize:
                                            _model.isRowHovered ? 15.0 : 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                )),
                                SelectionArea(
                                    child: AutoSizeText(
                                  ' (${functions.calculateNews2IndividualScores('spo2', valueOrDefault<String>(
                                        widget.observationsRow
                                            ?.where((e) => e.name == 'SpO2')
                                            .toList()
                                            .firstOrNull
                                            ?.value,
                                        'SpO2',
                                      ), (valueOrDefault<String>(
                                            widget.observationsRow
                                                ?.where((e) =>
                                                    e.name ==
                                                    'Hypercapnic respiratory failure')
                                                .toList()
                                                .firstOrNull
                                                ?.value,
                                            'SpO2',
                                          ) == 'True') || (valueOrDefault<String>(
                                            widget.observationsRow
                                                ?.where((e) =>
                                                    e.name ==
                                                    'Hypercapnic respiratory failure')
                                                .toList()
                                                .firstOrNull
                                                ?.value,
                                            'SpO2',
                                          ) == 'true') || (valueOrDefault<String>(
                                            widget.observationsRow
                                                ?.where((e) =>
                                                    e.name ==
                                                    'Hypercapnic respiratory failure')
                                                .toList()
                                                .firstOrNull
                                                ?.value,
                                            'SpO2',
                                          ) == 'Yes') || (valueOrDefault<String>(
                                            widget.observationsRow
                                                ?.where((e) =>
                                                    e.name ==
                                                    'Hypercapnic respiratory failure')
                                                .toList()
                                                .firstOrNull
                                                ?.value,
                                            'SpO2',
                                          ) == 'yes'), valueOrDefault<String>(
                                            widget.observationsRow
                                                ?.where((e) =>
                                                    e.name == 'Air or oxygen')
                                                .toList()
                                                .firstOrNull
                                                ?.value,
                                            'Air/O2',
                                          ) == 'Supplemental oxygen').toString()})',
                                  minFontSize: 8.0,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: () {
                                          if (functions
                                                  .calculateNews2IndividualScores(
                                                      'spo2',
                                                      valueOrDefault<String>(
                                                        widget.observationsRow
                                                            ?.where((e) =>
                                                                e.name ==
                                                                'SpO2')
                                                            .toList()
                                                            .firstOrNull
                                                            ?.value,
                                                        'SpO2',
                                                      ),
                                                      (valueOrDefault<String>(
                                                                widget
                                                                    .observationsRow
                                                                    ?.where((e) =>
                                                                        e.name ==
                                                                        'Hypercapnic respiratory failure')
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.value,
                                                                'SpO2',
                                                              ) ==
                                                              'True') ||
                                                          (valueOrDefault<
                                                                  String>(
                                                                widget
                                                                    .observationsRow
                                                                    ?.where((e) =>
                                                                        e.name ==
                                                                        'Hypercapnic respiratory failure')
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.value,
                                                                'SpO2',
                                                              ) ==
                                                              'true') ||
                                                          (valueOrDefault<
                                                                  String>(
                                                                widget
                                                                    .observationsRow
                                                                    ?.where((e) =>
                                                                        e.name ==
                                                                        'Hypercapnic respiratory failure')
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.value,
                                                                'SpO2',
                                                              ) ==
                                                              'Yes') ||
                                                          (valueOrDefault<
                                                                  String>(
                                                                widget
                                                                    .observationsRow
                                                                    ?.where((e) =>
                                                                        e.name ==
                                                                        'Hypercapnic respiratory failure')
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.value,
                                                                'SpO2',
                                                              ) ==
                                                              'yes'),
                                                      valueOrDefault<String>(
                                                            widget
                                                                .observationsRow
                                                                ?.where((e) =>
                                                                    e.name ==
                                                                    'Air or oxygen')
                                                                .toList()
                                                                .firstOrNull
                                                                ?.value,
                                                            'Air/O2',
                                                          ) ==
                                                          'Supplemental oxygen') ==
                                              3) {
                                            return FlutterFlowTheme.of(context)
                                                .error;
                                          } else if (functions
                                                  .calculateNews2IndividualScores(
                                                      'spo2',
                                                      valueOrDefault<String>(
                                                        widget.observationsRow
                                                            ?.where((e) =>
                                                                e.name ==
                                                                'SpO2')
                                                            .toList()
                                                            .firstOrNull
                                                            ?.value,
                                                        'SpO2',
                                                      ),
                                                      (valueOrDefault<String>(
                                                                widget
                                                                    .observationsRow
                                                                    ?.where((e) =>
                                                                        e.name ==
                                                                        'Hypercapnic respiratory failure')
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.value,
                                                                'SpO2',
                                                              ) ==
                                                              'True') ||
                                                          (valueOrDefault<
                                                                  String>(
                                                                widget
                                                                    .observationsRow
                                                                    ?.where((e) =>
                                                                        e.name ==
                                                                        'Hypercapnic respiratory failure')
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.value,
                                                                'SpO2',
                                                              ) ==
                                                              'true') ||
                                                          (valueOrDefault<
                                                                  String>(
                                                                widget
                                                                    .observationsRow
                                                                    ?.where((e) =>
                                                                        e.name ==
                                                                        'Hypercapnic respiratory failure')
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.value,
                                                                'SpO2',
                                                              ) ==
                                                              'Yes') ||
                                                          (valueOrDefault<
                                                                  String>(
                                                                widget
                                                                    .observationsRow
                                                                    ?.where((e) =>
                                                                        e.name ==
                                                                        'Hypercapnic respiratory failure')
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.value,
                                                                'SpO2',
                                                              ) ==
                                                              'yes'),
                                                      valueOrDefault<String>(
                                                            widget
                                                                .observationsRow
                                                                ?.where((e) =>
                                                                    e.name ==
                                                                    'Air or oxygen')
                                                                .toList()
                                                                .firstOrNull
                                                                ?.value,
                                                            'Air/O2',
                                                          ) ==
                                                          'Supplemental oxygen') ==
                                              0) {
                                            return FlutterFlowTheme.of(context)
                                                .success;
                                          } else {
                                            return FlutterFlowTheme.of(context)
                                                .tertiary;
                                          }
                                        }(),
                                        fontSize:
                                            _model.isRowHovered ? 12.0 : 10.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ].divide(SizedBox(height: 6.0)),
                            ),
                          ),
                          if (_model.isRowHovered)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 20.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      if (valueOrDefault<String>(
                                            widget.observationsRow
                                                ?.where((e) =>
                                                    e.name == 'Air or oxygen')
                                                .toList()
                                                .firstOrNull
                                                ?.value,
                                            'Air/O2',
                                          ) ==
                                          'Supplemental oxygen') {
                                        return AlignedTooltip(
                                          content: Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              'Supplemental Oxygen',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                          offset: 4.0,
                                          preferredDirection: AxisDirection.up,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          elevation: 4.0,
                                          tailBaseWidth: 24.0,
                                          tailLength: 12.0,
                                          waitDuration:
                                              Duration(milliseconds: 100),
                                          showDuration:
                                              Duration(milliseconds: 1500),
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: Icon(
                                            Icons.masks_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 30.0,
                                          ),
                                        );
                                      } else {
                                        return AlignedTooltip(
                                          content: Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              'Room Air',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                          offset: 4.0,
                                          preferredDirection: AxisDirection.up,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          elevation: 4.0,
                                          tailBaseWidth: 24.0,
                                          tailLength: 12.0,
                                          waitDuration:
                                              Duration(milliseconds: 100),
                                          showDuration:
                                              Duration(milliseconds: 1500),
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: Icon(
                                            Icons.check_circle_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .success,
                                            size: 30.0,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if ((valueOrDefault<String>(
                                                widget.observationsRow
                                                    ?.where((e) =>
                                                        e.name ==
                                                        'Hypercapnic respiratory failure')
                                                    .toList()
                                                    .firstOrNull
                                                    ?.value,
                                                'SpO2',
                                              ) ==
                                              'True') ||
                                          (valueOrDefault<String>(
                                                widget.observationsRow
                                                    ?.where((e) =>
                                                        e.name ==
                                                        'Hypercapnic respiratory failure')
                                                    .toList()
                                                    .firstOrNull
                                                    ?.value,
                                                'SpO2',
                                              ) ==
                                              'true') ||
                                          (valueOrDefault<String>(
                                                widget.observationsRow
                                                    ?.where((e) =>
                                                        e.name ==
                                                        'Hypercapnic respiratory failure')
                                                    .toList()
                                                    .firstOrNull
                                                    ?.value,
                                                'SpO2',
                                              ) ==
                                              'Yes') ||
                                          (valueOrDefault<String>(
                                                widget.observationsRow
                                                    ?.where((e) =>
                                                        e.name ==
                                                        'Hypercapnic respiratory failure')
                                                    .toList()
                                                    .firstOrNull
                                                    ?.value,
                                                'SpO2',
                                              ) ==
                                              'yes')) {
                                        return AlignedTooltip(
                                          content: Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              'Hypercapnic Respiratory Failure',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                          offset: 4.0,
                                          preferredDirection: AxisDirection.up,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          elevation: 4.0,
                                          tailBaseWidth: 24.0,
                                          tailLength: 12.0,
                                          waitDuration:
                                              Duration(milliseconds: 100),
                                          showDuration:
                                              Duration(milliseconds: 1500),
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: FaIcon(
                                            FontAwesomeIcons.lungsVirus,
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            size: 26.0,
                                          ),
                                        );
                                      } else {
                                        return AlignedTooltip(
                                          content: Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              'No Hypercapnic Respiratory Failure',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                          offset: 4.0,
                                          preferredDirection: AxisDirection.up,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          elevation: 4.0,
                                          tailBaseWidth: 24.0,
                                          tailLength: 12.0,
                                          waitDuration:
                                              Duration(milliseconds: 100),
                                          showDuration:
                                              Duration(milliseconds: 1500),
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: Icon(
                                            Icons.check_circle_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .success,
                                            size: 30.0,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ].divide(SizedBox(height: 6.0)),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: Text(
                            valueOrDefault<String>(
                              widget.observationsRow
                                  ?.where((e) => e.name == 'Consciousness')
                                  .toList()
                                  .firstOrNull
                                  ?.value,
                              'AVPU',
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: _model.isRowHovered
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  fontSize: _model.isRowHovered ? 15.0 : 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          )),
                          SelectionArea(
                              child: AutoSizeText(
                            ' (${functions.calculateNews2IndividualScores('consciousness', valueOrDefault<String>(
                                  widget.observationsRow
                                      ?.where((e) => e.name == 'Consciousness')
                                      .toList()
                                      .firstOrNull
                                      ?.value,
                                  'AVPU',
                                ), false, false).toString()})',
                            minFontSize: 8.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: () {
                                    if (functions
                                            .calculateNews2IndividualScores(
                                                'consciousness',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Consciousness')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'AVPU',
                                                ),
                                                false,
                                                false) ==
                                        3) {
                                      return FlutterFlowTheme.of(context).error;
                                    } else if (functions
                                            .calculateNews2IndividualScores(
                                                'consciousness',
                                                valueOrDefault<String>(
                                                  widget.observationsRow
                                                      ?.where((e) =>
                                                          e.name ==
                                                          'Consciousness')
                                                      .toList()
                                                      .firstOrNull
                                                      ?.value,
                                                  'AVPU',
                                                ),
                                                false,
                                                false) ==
                                        0) {
                                      return FlutterFlowTheme.of(context)
                                          .success;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .tertiary;
                                    }
                                  }(),
                                  fontSize: _model.isRowHovered ? 12.0 : 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: _model.isRowHovered ? 210.0 : 50.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: Text(
                            valueOrDefault<String>(
                              widget.observationsRow
                                  ?.where((e) => e.name == 'NEWS2 total score')
                                  .toList()
                                  .firstOrNull
                                  ?.value,
                              'NEWS2',
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: () {
                                    if ((String score) {
                                      return int.parse(score) >= 7;
                                    }(widget.observationsRow!
                                        .where((e) =>
                                            e.name == 'NEWS2 total score')
                                        .toList()
                                        .firstOrNull!
                                        .value)) {
                                      return FlutterFlowTheme.of(context).error;
                                    } else if ((String score,
                                            String issHighStr) {
                                      return int.parse(score) <= 4 &&
                                          issHighStr.toLowerCase().trim() ==
                                              'false';
                                    }(
                                        widget.observationsRow!
                                            .where((e) =>
                                                e.name == 'NEWS2 total score')
                                            .toList()
                                            .firstOrNull!
                                            .value,
                                        widget.observationsRow!
                                            .where((e) =>
                                                e.name == 'is_individual_3')
                                            .toList()
                                            .firstOrNull!
                                            .value)) {
                                      return FlutterFlowTheme.of(context)
                                          .success;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .tertiary;
                                    }
                                  }(),
                                  fontSize: _model.isRowHovered ? 15.0 : 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          )),
                          if (widget.isLatest || _model.isRowHovered)
                            Text(
                              functions
                                  .decodeNewsScore(
                                      int.parse(widget.observationsRow!
                                          .where((e) =>
                                              e.name == 'NEWS2 total score')
                                          .toList()
                                          .firstOrNull!
                                          .value),
                                      valueOrDefault<String>(
                                            widget.observationsRow
                                                ?.where((e) =>
                                                    e.name == 'is_individual_3')
                                                .toList()
                                                .firstOrNull
                                                ?.value,
                                            'NEWS2',
                                          ) ==
                                          'true')
                                  .interpretation,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          if (_model.isRowHovered)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.person_search,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            functions
                                                .decodeNewsScore(
                                                    int.parse(widget
                                                        .observationsRow!
                                                        .where((e) =>
                                                            e.name ==
                                                            'NEWS2 total score')
                                                        .toList()
                                                        .firstOrNull!
                                                        .value),
                                                    valueOrDefault<String>(
                                                          widget
                                                              .observationsRow
                                                              ?.where((e) =>
                                                                  e.name ==
                                                                  'latestSingleRedScore')
                                                              .toList()
                                                              .firstOrNull
                                                              ?.value,
                                                          'NEWS2',
                                                        ) ==
                                                        'true')
                                                .assessmentBy,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 4.0))
                                        .addToEnd(SizedBox(width: 4.0)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.looks_one_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 4.0, 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              functions
                                                  .decodeNewsScore(
                                                      int.parse(widget
                                                          .observationsRow!
                                                          .where((e) =>
                                                              e.name ==
                                                              'NEWS2 total score')
                                                          .toList()
                                                          .firstOrNull!
                                                          .value),
                                                      valueOrDefault<String>(
                                                            widget
                                                                .observationsRow
                                                                ?.where((e) =>
                                                                    e.name ==
                                                                    'latestSingleRedScore')
                                                                .toList()
                                                                .firstOrNull
                                                                ?.value,
                                                            'NEWS2',
                                                          ) ==
                                                          'true')
                                                  .action1,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 4.0))
                                        .addToEnd(SizedBox(width: 4.0)),
                                  ),
                                  if (functions
                                              .decodeNewsScore(
                                                  int.parse(widget
                                                      .observationsRow!
                                                      .where((e) =>
                                                          e.name ==
                                                          'NEWS2 total score')
                                                      .toList()
                                                      .firstOrNull!
                                                      .value),
                                                  valueOrDefault<String>(
                                                        widget.observationsRow
                                                            ?.where((e) =>
                                                                e.name ==
                                                                'latestSingleRedScore')
                                                            .toList()
                                                            .firstOrNull
                                                            ?.value,
                                                        'NEWS2',
                                                      ) ==
                                                      'true')
                                              .action2 !=
                                          '')
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.looks_two_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 4.0, 0.0),
                                            child: Container(
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                functions
                                                    .decodeNewsScore(
                                                        int.parse(widget
                                                            .observationsRow!
                                                            .where((e) =>
                                                                e.name ==
                                                                'NEWS2 total score')
                                                            .toList()
                                                            .firstOrNull!
                                                            .value),
                                                        valueOrDefault<String>(
                                                              widget
                                                                  .observationsRow
                                                                  ?.where((e) =>
                                                                      e.name ==
                                                                      'latestSingleRedScore')
                                                                  .toList()
                                                                  .firstOrNull
                                                                  ?.value,
                                                              'NEWS2',
                                                            ) ==
                                                            'true')
                                                    .action2,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                            ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ].addToStart(SizedBox(width: 20.0)).addToEnd(SizedBox(width: 20.0)),
      ),
      onEnter: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = true);
        _model.isRowHovered = true;
        safeSetState(() {});
      }),
      onExit: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = false);
        _model.isRowHovered = false;
        safeSetState(() {});
      }),
    );
  }
}
