import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'conditioon_table_row_component_model.dart';
export 'conditioon_table_row_component_model.dart';

/// inotrope display fix.
class ConditioonTableRowComponentWidget extends StatefulWidget {
  const ConditioonTableRowComponentWidget({
    super.key,
    required this.conditionsRow,
  });

  final ConditionStruct? conditionsRow;

  @override
  State<ConditioonTableRowComponentWidget> createState() =>
      _ConditioonTableRowComponentWidgetState();
}

class _ConditioonTableRowComponentWidgetState
    extends State<ConditioonTableRowComponentWidget> {
  late ConditioonTableRowComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConditioonTableRowComponentModel());

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
              height: 50.0,
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
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AlignedTooltip(
                              content: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    widget.conditionsRow?.conditionName,
                                    'Condition Name',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              offset: 4.0,
                              preferredDirection: AxisDirection.up,
                              borderRadius: BorderRadius.circular(8.0),
                              backgroundColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4.0,
                              tailBaseWidth: 24.0,
                              tailLength: 12.0,
                              waitDuration: Duration(milliseconds: 100),
                              showDuration: Duration(milliseconds: 1500),
                              triggerMode: TooltipTriggerMode.tap,
                              child: FaIcon(
                                FontAwesomeIcons.stethoscope,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 30.0,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(),
                                child: SelectionArea(
                                    child: AutoSizeText(
                                  valueOrDefault<String>(
                                    widget.conditionsRow?.conditionName,
                                    'Condition Name',
                                  ),
                                  minFontSize: 8.0,
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
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ),
                            ),
                          ]
                              .divide(SizedBox(width: 15.0))
                              .addToStart(SizedBox(width: 20.0))
                              .addToEnd(SizedBox(width: 20.0)),
                        ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SelectionArea(
                              child: Text(
                            valueOrDefault<String>(
                              widget.conditionsRow?.conditionCode,
                              'Code',
                            ),
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
                        ]
                            .divide(SizedBox(width: 10.0))
                            .addToStart(SizedBox(width: 100.0)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: SelectionArea(
                          child: Text(
                        dateTimeFormat(
                            "y-MM-dd",
                            functions.convertSingleDateStringtoDateTime(
                                widget.conditionsRow?.onsetDate?.toString())),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                  : FlutterFlowTheme.of(context).primaryText,
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
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              (String status) {
                                return status.toLowerCase() == 'active';
                              }(widget.conditionsRow!.status)
                                  ? FlutterFlowTheme.of(context).cardSuccess
                                  : FlutterFlowTheme.of(context).cardTertiary,
                              FlutterFlowTheme.of(context).cardSuccess,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: valueOrDefault<Color>(
                                (String status) {
                                  return status.toLowerCase() == 'active';
                                }(widget.conditionsRow!.status)
                                    ? FlutterFlowTheme.of(context).success
                                    : FlutterFlowTheme.of(context).tertiary,
                                FlutterFlowTheme.of(context).success,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Builder(
                                builder: (context) {
                                  if ((String status) {
                                    return status.toLowerCase() == 'active';
                                  }(widget.conditionsRow!.status)) {
                                    return Icon(
                                      Icons.check_circle_outline_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).success,
                                      size: 24.0,
                                    );
                                  } else {
                                    return Icon(
                                      Icons.info_outline_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      size: 24.0,
                                    );
                                  }
                                },
                              ),
                              SelectionArea(
                                  child: Text(
                                functions
                                    .capitalizeFirst(valueOrDefault<String>(
                                  widget.conditionsRow?.status,
                                  'Status',
                                )),
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
                                      color: valueOrDefault<Color>(
                                        (String status) {
                                          return status.toLowerCase() ==
                                              'active';
                                        }(widget.conditionsRow!.status)
                                            ? FlutterFlowTheme.of(context)
                                                .success
                                            : FlutterFlowTheme.of(context)
                                                .tertiary,
                                        FlutterFlowTheme.of(context).success,
                                      ),
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
                            ]
                                .divide(SizedBox(width: 30.0))
                                .around(SizedBox(width: 30.0)),
                          ),
                        ),
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
