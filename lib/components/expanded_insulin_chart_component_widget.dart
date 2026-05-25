import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/close_component/close_component_widget.dart';
import '/components/custom_dot_component_page_view/custom_dot_component_page_view_widget.dart';
import '/components/empty_widget/empty_widget_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'expanded_insulin_chart_component_model.dart';
export 'expanded_insulin_chart_component_model.dart';

class ExpandedInsulinChartComponentWidget extends StatefulWidget {
  const ExpandedInsulinChartComponentWidget({
    super.key,
    required this.patientDetails,
    required this.conditions,
    required this.encounter,
    required this.observationsListGiven,
  });

  final PatientStruct? patientDetails;
  final List<ConditionStruct>? conditions;
  final EncounterStruct? encounter;
  final List<ObservationStruct>? observationsListGiven;

  @override
  State<ExpandedInsulinChartComponentWidget> createState() =>
      _ExpandedInsulinChartComponentWidgetState();
}

class _ExpandedInsulinChartComponentWidgetState
    extends State<ExpandedInsulinChartComponentWidget>
    with TickerProviderStateMixin {
  late ExpandedInsulinChartComponentModel _model;

  var hasIconTriggered = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExpandedInsulinChartComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.hideEverything = true;
      _model.ptConditions =
          widget.conditions!.toList().cast<ConditionStruct>();
      _model.selectedPageIdx =
          functions.createDatesList(widget.encounter!.admissionDate!).length -
              1;
      safeSetState(() {});
      unawaited(
        () async {
          await _model.cBGPageViewController?.animateToPage(
            _model.selectedPageIdx,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }(),
      );
      await Future.wait([
        Future(() async {
          _model.allObservations1 =
              await GetAllObservationsByIDForPatientCall.call(
            token: FFAppState().fhirBearerToken,
            id: widget.patientDetails?.identifier,
          );

          if ((_model.allObservations1?.succeeded ?? true)) {
            if (GetAllObservationsByIDForPatientCall.total(
                  (_model.allObservations1?.jsonBody ?? ''),
                )! >
                0) {
              _model.allObservations = functions
                  .parseFhirObservations(
                      GetAllObservationsByIDForPatientCall.entries(
                    (_model.allObservations1?.jsonBody ?? ''),
                  )!
                          .toList())
                  .toList()
                  .cast<ObservationStruct>();
              safeSetState(() {});
            } else {
              _model.allObservations = [];
              safeSetState(() {});
            }
          }
          if (_model.allObservations
                      .where((e) => (String name) {
                            return name.toLowerCase().trim() == 'hba1c';
                          }(e.name))
                      .toList()
                      .sortedList(keyOf: (e) => e.recordedAt!, desc: true)
                      .firstOrNull
                      ?.value !=
                  null &&
              _model.allObservations
                      .where((e) => (String name) {
                            return name.toLowerCase().trim() == 'hba1c';
                          }(e.name))
                      .toList()
                      .sortedList(keyOf: (e) => e.recordedAt!, desc: true)
                      .firstOrNull
                      ?.value !=
                  '') {
            safeSetState(() {
              _model.hbA1cTextController?.text = _model.allObservations
                  .where((e) => (String name) {
                        return name.toLowerCase().trim() == 'hba1c';
                      }(e.name))
                  .toList()
                  .sortedList(keyOf: (e) => e.recordedAt!, desc: true)
                  .firstOrNull!
                  .value;
            });
          }
          if (_model.allObservations
                      .where((e) => (String name) {
                            return name.toLowerCase().trim() == 'creatinine';
                          }(e.name))
                      .toList()
                      .sortedList(keyOf: (e) => e.recordedAt!, desc: true)
                      .firstOrNull
                      ?.value !=
                  null &&
              _model.allObservations
                      .where((e) => (String name) {
                            return name.toLowerCase().trim() == 'creatinine';
                          }(e.name))
                      .toList()
                      .sortedList(keyOf: (e) => e.recordedAt!, desc: true)
                      .firstOrNull
                      ?.value !=
                  '') {
            safeSetState(() {
              _model.creatinineTextController?.text = valueOrDefault<String>(
                double.parse(_model.allObservations
                        .where((e) => (String name) {
                              return name.toLowerCase().trim() == 'creatinine';
                            }(e.name))
                        .toList()
                        .sortedList(keyOf: (e) => e.recordedAt!, desc: true)
                        .firstOrNull!
                        .value)
                    .toStringAsFixed(2),
                'creat',
              );
            });
          }
        }),
        Future(() async {
          _model.medicationStatementQuery1 =
              await GetAllMedicationStatementsByIDForPatientCall.call(
            token: FFAppState().fhirBearerToken,
            id: widget.patientDetails?.identifier,
          );

          if ((_model.medicationStatementQuery1?.succeeded ?? true)) {
            if (GetAllMedicationStatementsByIDForPatientCall.total(
                  (_model.medicationStatementQuery1?.jsonBody ?? ''),
                )! >
                0) {
              _model.medicationStatements = functions
                  .parseFhirMedicationStatement(
                      GetAllMedicationStatementsByIDForPatientCall.entries(
                    (_model.medicationStatementQuery1?.jsonBody ?? ''),
                  )?.toList())
                  .toList()
                  .cast<MedicationStatementStruct>();
              safeSetState(() {});
            } else {
              _model.medicationStatements = [];
              safeSetState(() {});
            }
          } else {
            await showDialog(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: Text('Error'),
                  content:
                      Text((_model.medicationStatementQuery1?.bodyText ?? '')),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: Text('Ok'),
                    ),
                  ],
                );
              },
            );
          }

          safeSetState(() {
            _model.steroidsTextController?.text =
                functions.getSteroidStatusFromMedications(
                    _model.allMedications.toList(),
                    FFAppState().steroidsList.toList());
          });
          safeSetState(() {
            _model.inotropesTextController?.text =
                functions.getInotropeStatusFromMedications(
                    _model.allMedications.toList(),
                    FFAppState().inotropesList.toList());
          });
        }),
        Future(() async {
          _model.allMedicationRequestsQuery =
              await GetPatientMedicationsByIDCall.call(
            token: FFAppState().fhirBearerToken,
            id: widget.patientDetails?.identifier,
            optionalQueries: '_sort=-_lastUpdated',
          );

          if ((_model.allMedicationRequestsQuery?.succeeded ?? true)) {
            if (GetPatientMedicationsByIDCall.total(
                  (_model.allMedicationRequestsQuery?.jsonBody ?? ''),
                )! >
                0) {
              _model.allMedications = functions
                  .parseFhirMedications(GetPatientMedicationsByIDCall.entries(
                    (_model.allMedicationRequestsQuery?.jsonBody ?? ''),
                  )!
                      .toList())
                  .toList()
                  .cast<MedicationStruct>();
              safeSetState(() {});
            } else {
              _model.allMedications = [];
              safeSetState(() {});
            }
          }
        }),
        Future(() async {
          _model.tidChartObservations1 =
              await GetCBGObservationsByIDForPatientCall.call(
            token: FFAppState().fhirBearerToken,
            id: widget.patientDetails?.identifier,
          );

          if ((_model.tidChartObservations1?.succeeded ?? true)) {
            if (GetCBGObservationsByIDForPatientCall.total(
                  (_model.tidChartObservations1?.jsonBody ?? ''),
                )! >
                0) {
              _model.tidChartEntries = functions
                  .parseFhirTidChartEntries(
                      GetCBGObservationsByIDForPatientCall.entries(
                    (_model.tidChartObservations1?.jsonBody ?? ''),
                  )!
                          .toList())
                  .toList()
                  .cast<TidChartEntryStruct>();
              safeSetState(() {});
            }
          }
        }),
        Future(() async {
          _model.insulinAdvice1 =
              await GetAllInsulinAdviceByIDForPatientCall.call(
            token: FFAppState().fhirBearerToken,
            id: widget.patientDetails?.identifier,
          );

          if ((_model.insulinAdvice1?.succeeded ?? true)) {
            if (GetAllInsulinAdviceByIDForPatientCall.total(
                  (_model.insulinAdvice1?.jsonBody ?? ''),
                )! >
                0) {
              _model.insulinAdviceList = functions
                  .parseFhirInsulinAdviceEntries(
                      GetAllInsulinAdviceByIDForPatientCall.entries(
                    (_model.insulinAdvice1?.jsonBody ?? ''),
                  )?.toList())
                  .toList()
                  .cast<InsulinAdviceStruct>();
              safeSetState(() {});
            } else {
              _model.insulinAdviceList = [];
              safeSetState(() {});
            }
          }
        }),
        Future(() async {
          _model.insulinAdministration1 =
              await GetAllInsulinAdministrationByIDCall.call(
            token: FFAppState().fhirBearerToken,
            id: widget.patientDetails?.identifier,
          );

          if ((_model.insulinAdministration1?.succeeded ?? true)) {
            if (GetAllInsulinAdministrationByIDCall.total(
                  (_model.insulinAdministration1?.jsonBody ?? ''),
                )! >
                0) {
              _model.insulinAdministrationList = functions
                  .parseFhirInsulinAdministrations(
                      GetAllInsulinAdministrationByIDCall.entries(
                    (_model.insulinAdministration1?.jsonBody ?? ''),
                  )?.toList())
                  .toList()
                  .cast<InsulinAdministrationStruct>();
              safeSetState(() {});
            } else {
              _model.insulinAdministrationList = [];
              safeSetState(() {});
            }
          }
        }),
      ]);
      _model.hideEverything = false;
      safeSetState(() {});
    });

    _model.diabetesDurationTextController ??= TextEditingController();
    _model.diabetesDurationFocusNode ??= FocusNode();

    _model.insulinNameTextController ??= TextEditingController();
    _model.insulinNameFocusNode ??= FocusNode();

    _model.mornInsulinDoseTextController ??= TextEditingController();
    _model.mornInsulinDoseFocusNode ??= FocusNode();

    _model.aftInsulinDoseTextController ??= TextEditingController();
    _model.aftInsulinDoseFocusNode ??= FocusNode();

    _model.nightInsulinDoseTextController ??= TextEditingController();
    _model.nightInsulinDoseFocusNode ??= FocusNode();

    _model.oHANameTextController ??= TextEditingController();
    _model.oHANameFocusNode ??= FocusNode();

    _model.mornOHADoseTextController ??= TextEditingController();
    _model.mornOHADoseFocusNode ??= FocusNode();

    _model.aftOHADoseTextController ??= TextEditingController();
    _model.aftOHADoseFocusNode ??= FocusNode();

    _model.nightOHADoseTextController ??= TextEditingController();
    _model.nightOHADoseFocusNode ??= FocusNode();

    _model.steroidsTextController ??= TextEditingController();
    _model.steroidsFocusNode ??= FocusNode();

    _model.inotropesTextController ??= TextEditingController();
    _model.inotropesFocusNode ??= FocusNode();

    _model.hbA1cTextController ??= TextEditingController();
    _model.hbA1cFocusNode ??= FocusNode();

    _model.creatinineTextController ??= TextEditingController();
    _model.creatinineFocusNode ??= FocusNode();

    _model.insulinInfusionTextController ??=
        TextEditingController(text: 'NO INFUSION');
    _model.insulinInfusionFocusNode ??= FocusNode();

    _model.nurseNotesTextController ??= TextEditingController();
    _model.nurseNotesFocusNode ??= FocusNode();

    _model.cbgTextController ??= TextEditingController();
    _model.cbgFocusNode ??= FocusNode();

    _model.sAIDoseTextController ??= TextEditingController();
    _model.sAIDoseFocusNode ??= FocusNode();

    _model.lAIDoseTextController ??= TextEditingController();
    _model.lAIDoseFocusNode ??= FocusNode();

    _model.doctorNotesTextController ??= TextEditingController();
    _model.doctorNotesFocusNode ??= FocusNode();

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.2, 1.2),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 200.0.ms,
            begin: Offset(1.2, 1.2),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      alignment: AlignmentDirectional(1.0, -1.0),
      children: [
        Container(
          width: 1900.0,
          height: 950.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(
                      20.0,
                      2.0,
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
              child: SingleChildScrollView(
                primary: false,
                controller: _model.chartColumnMainScrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_model.hideEverything)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            color: FlutterFlowTheme.of(context).tertiary,
                            size: 24.0,
                          ).animateOnPageLoad(
                              animationsMap['iconOnPageLoadAnimation']!),
                          Text(
                            'Fetching Details..!! Please Wait..!!',
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
                        ].divide(SizedBox(width: 20.0)),
                      ),
                    Builder(
                      builder: (context) {
                        if (_model.allObservations.isNotEmpty) {
                          return SingleChildScrollView(
                            primary: false,
                            controller: _model.columnController,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 300.0,
                                        height: 300.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .cardBlue,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Colors.black,
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                              spreadRadius: 0.0,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          22.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.idCard,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        size: 22.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          ' PATIENT  INFO',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.person_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 25.0,
                                                      ),
                                                      Expanded(
                                                        child: SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              widget
                                                                  .patientDetails
                                                                  ?.combinedNames,
                                                              'FIRST NAME LAST NAME',
                                                            ),
                                                          ),
                                                        )),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10.0)),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.idCard,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 25.0,
                                                    ),
                                                    Expanded(
                                                      child: SelectionArea(
                                                          child:
                                                              AnimatedDefaultTextStyle(
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleSmall
                                                            .override(
                                                              font: GoogleFonts
                                                                  .readexPro(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                            ),
                                                        duration: Duration(
                                                            milliseconds: 800),
                                                        curve: Curves.easeInOut,
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            widget
                                                                .patientDetails
                                                                ?.identifier,
                                                            'ID',
                                                          ),
                                                        ),
                                                      )),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 10.0)),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 25.0,
                                                    ),
                                                    Expanded(
                                                      child: SelectionArea(
                                                          child:
                                                              AnimatedDefaultTextStyle(
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleSmall
                                                            .override(
                                                              font: GoogleFonts
                                                                  .readexPro(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                            ),
                                                        duration: Duration(
                                                            milliseconds: 800),
                                                        curve: Curves.easeInOut,
                                                        child: Text(
                                                          'DOA',
                                                        ),
                                                      )),
                                                    ),
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                      desktop: false,
                                                    ))
                                                      AlignedTooltip(
                                                        content: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Text(
                                                            '',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        offset: 4.0,
                                                        preferredDirection:
                                                            AxisDirection.up,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        elevation: 4.0,
                                                        tailBaseWidth: 24.0,
                                                        tailLength: 12.0,
                                                        waitDuration: Duration(
                                                            milliseconds: 100),
                                                        showDuration: Duration(
                                                            milliseconds: 1500),
                                                        triggerMode:
                                                            TooltipTriggerMode
                                                                .tap,
                                                        child: Icon(
                                                          Icons
                                                              .medical_information_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 25.0,
                                                        ),
                                                      ),
                                                  ].divide(
                                                      SizedBox(width: 10.0)),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .stethoscope,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 25.0,
                                                    ),
                                                    Expanded(
                                                      child: SelectionArea(
                                                          child:
                                                              AnimatedDefaultTextStyle(
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleSmall
                                                            .override(
                                                              font: GoogleFonts
                                                                  .readexPro(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                            ),
                                                        duration: Duration(
                                                            milliseconds: 800),
                                                        curve: Curves.easeInOut,
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            'Dr. ${valueOrDefault<String>(
                                                              widget.encounter
                                                                  ?.admittedUnder,
                                                              'Consultant',
                                                            )}',
                                                            'doctor',
                                                          ),
                                                        ),
                                                      )),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 10.0)),
                                                ),
                                              ),
                                              if (responsiveVisibility(
                                                context: context,
                                                phone: false,
                                                tablet: false,
                                                tabletLandscape: false,
                                                desktop: false,
                                              ))
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        Icons.business_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 25.0,
                                                      ),
                                                      Expanded(
                                                        child: SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            'BLOCK NAME',
                                                          ),
                                                        )),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10.0)),
                                                  ),
                                                ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons.house_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 25.0,
                                                    ),
                                                    Expanded(
                                                      child: SelectionArea(
                                                          child:
                                                              AnimatedDefaultTextStyle(
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleSmall
                                                            .override(
                                                              font: GoogleFonts
                                                                  .readexPro(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                            ),
                                                        duration: Duration(
                                                            milliseconds: 800),
                                                        curve: Curves.easeInOut,
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            widget.encounter
                                                                ?.wardName,
                                                            'Ward',
                                                          ),
                                                        ),
                                                      )),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 10.0)),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 15.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 300.0,
                                        height: 300.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .cardBlue,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Colors.black,
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                              spreadRadius: 0.0,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          22.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .laptopMedical,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      size: 22.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        'MEDICAL INFO',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .perm_contact_cal_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 25.0,
                                                  ),
                                                  SelectionArea(
                                                      child:
                                                          AnimatedDefaultTextStyle(
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    curve: Curves.easeInOut,
                                                    child: Text(
                                                      '${functions.calculateAgeFromDOB(functions.convertSingleDateStringtoDateTime(widget.patientDetails?.birthDate)!).toString()}/${(String gender) {
                                                        return gender[0]
                                                            .toUpperCase();
                                                      }(widget.patientDetails!.gender)}',
                                                    ),
                                                  )),
                                                  Builder(
                                                    builder: (context) {
                                                      if (true) {
                                                        return Icon(
                                                          Icons.male_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 25.0,
                                                        );
                                                      } else if (true) {
                                                        return Icon(
                                                          Icons.female_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          size: 25.0,
                                                        );
                                                      } else {
                                                        return Icon(
                                                          Icons
                                                              .transgender_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .success,
                                                          size: 25.0,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: AlignedTooltip(
                                                      content: Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'HbA1c %',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                      offset: 4.0,
                                                      preferredDirection:
                                                          AxisDirection.up,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      elevation: 4.0,
                                                      tailBaseWidth: 24.0,
                                                      tailLength: 12.0,
                                                      waitDuration: Duration(
                                                          milliseconds: 100),
                                                      showDuration: Duration(
                                                          milliseconds: 1500),
                                                      triggerMode:
                                                          TooltipTriggerMode
                                                              .tap,
                                                      child: FaIcon(
                                                        FontAwesomeIcons.vial,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                  SelectionArea(
                                                      child:
                                                          AnimatedDefaultTextStyle(
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    curve: Curves.easeInOut,
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        _model.allObservations
                                                                        .where((e) =>
                                                                            (String
                                                                                name) {
                                                                              return name.toLowerCase().trim() == 'hba1c';
                                                                            }(e
                                                                                .name))
                                                                        .toList()
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .recordedAt!,
                                                                            desc:
                                                                                true)
                                                                        .firstOrNull
                                                                        ?.value !=
                                                                    null &&
                                                                _model
                                                                        .allObservations
                                                                        .where((e) =>
                                                                            (String
                                                                                name) {
                                                                              return name.toLowerCase().trim() == 'hba1c';
                                                                            }(e
                                                                                .name))
                                                                        .toList()
                                                                        .sortedList(
                                                                            keyOf: (e) =>
                                                                                e.recordedAt!,
                                                                            desc: true)
                                                                        .firstOrNull
                                                                        ?.value !=
                                                                    ''
                                                            ? '${_model.allObservations.where((e) => (String name) {
                                                                  return name
                                                                          .toLowerCase()
                                                                          .trim() ==
                                                                      'hba1c';
                                                                }(e.name)).toList().sortedList(keyOf: (e) => e.recordedAt!, desc: true).firstOrNull?.value} %'
                                                            : '-NA-',
                                                        '-NA-',
                                                      ),
                                                    ),
                                                  )),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: AlignedTooltip(
                                                      content: Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'Diabetes Type',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                      offset: 4.0,
                                                      preferredDirection:
                                                          AxisDirection.up,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      elevation: 4.0,
                                                      tailBaseWidth: 24.0,
                                                      tailLength: 12.0,
                                                      waitDuration: Duration(
                                                          milliseconds: 100),
                                                      showDuration: Duration(
                                                          milliseconds: 1500),
                                                      triggerMode:
                                                          TooltipTriggerMode
                                                              .tap,
                                                      child: Icon(
                                                        Icons
                                                            .assignment_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      if (_model.ptConditions
                                                                  .where((e) => FFAppState()
                                                                      .diabetesTypes
                                                                      .map((e) => e
                                                                          .code)
                                                                      .toList()
                                                                      .contains(e
                                                                          .conditionCode))
                                                                  .toList()
                                                                  .firstOrNull
                                                                  ?.conditionName !=
                                                              null &&
                                                          _model.ptConditions
                                                                  .where((e) => FFAppState()
                                                                      .diabetesTypes
                                                                      .map((e) => e
                                                                          .code)
                                                                      .toList()
                                                                      .contains(
                                                                          e.conditionCode))
                                                                  .toList()
                                                                  .firstOrNull
                                                                  ?.conditionName !=
                                                              '') {
                                                        return SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              _model
                                                                  .ptConditions
                                                                  .where((e) => FFAppState()
                                                                      .diabetesTypes
                                                                      .map((e) => e
                                                                          .code)
                                                                      .toList()
                                                                      .contains(
                                                                          e.conditionCode))
                                                                  .toList()
                                                                  .firstOrNull
                                                                  ?.conditionName,
                                                              'Diabetes Type',
                                                            ),
                                                          ),
                                                        ));
                                                      } else {
                                                        return Icon(
                                                          Icons.block,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          size: 24.0,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.access_time_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 25.0,
                                                    ),
                                                    Flexible(
                                                      child: Builder(
                                                        builder: (context) {
                                                          if (_model.ptConditions
                                                                      .where((e) => FFAppState()
                                                                          .diabetesTypes
                                                                          .map((e) => e
                                                                              .code)
                                                                          .toList()
                                                                          .contains(e
                                                                              .conditionCode))
                                                                      .toList()
                                                                      .firstOrNull
                                                                      ?.conditionName !=
                                                                  null &&
                                                              _model.ptConditions
                                                                      .where((e) => FFAppState()
                                                                          .diabetesTypes
                                                                          .map((e) => e
                                                                              .code)
                                                                          .toList()
                                                                          .contains(
                                                                              e.conditionCode))
                                                                      .toList()
                                                                      .firstOrNull
                                                                      ?.conditionName !=
                                                                  '') {
                                                            return SelectionArea(
                                                                child:
                                                                    AnimatedDefaultTextStyle(
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      800),
                                                              curve: Curves
                                                                  .easeInOut,
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  '${functions.calculateAgeFromDOB(functions.convertSingleDateStringtoDateTime(_model.ptConditions.where((e) => FFAppState().diabetesTypes.map((e) => e.code).toList().contains(e.conditionCode)).toList().firstOrNull?.onsetDate?.toString())!).toString()} Y',
                                                                  'dm dur',
                                                                ),
                                                              ),
                                                            ));
                                                          } else {
                                                            return Text(
                                                              '-NA-',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 8.0)),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          Icons.man_3_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 25.0,
                                                        ),
                                                        SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            _model.allObservations
                                                                            .where((e) => (String name) {
                                                                                  return name.toLowerCase().trim() == 'body height';
                                                                                }(e.name))
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.value !=
                                                                        null &&
                                                                    _model.allObservations
                                                                            .where((e) => (String name) {
                                                                                  return name.toLowerCase().trim() == 'body height';
                                                                                }(e.name))
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.value !=
                                                                        ''
                                                                ? valueOrDefault<String>(
                                                                    '${(double.parse(_model.allObservations.where((e) => (String name) {
                                                                          return name.toLowerCase().trim() ==
                                                                              'body height';
                                                                        }(e.name)).toList().firstOrNull!.value).round()).toString()} cm',
                                                                    'Ht. cm',
                                                                  )
                                                                : '-NA-',
                                                          ),
                                                        )),
                                                      ].divide(
                                                          SizedBox(width: 2.0)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .weight,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 25.0,
                                                        ),
                                                        SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            _model.allObservations
                                                                            .where((e) => (String name) {
                                                                                  return name.toLowerCase().trim() == 'body weight';
                                                                                }(e.name))
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.value !=
                                                                        null &&
                                                                    _model.allObservations
                                                                            .where((e) => (String name) {
                                                                                  return name.toLowerCase().trim() == 'body weight';
                                                                                }(e.name))
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.value !=
                                                                        ''
                                                                ? valueOrDefault<String>(
                                                                    '${(double.parse(_model.allObservations.where((e) => (String name) {
                                                                          return name.toLowerCase().trim() ==
                                                                              'body weight';
                                                                        }(e.name)).toList().firstOrNull!.value).round()).toString()}kg',
                                                                    'Ht. cm',
                                                                  )
                                                                : '-NA-',
                                                          ),
                                                        )),
                                                      ].divide(
                                                          SizedBox(width: 4.0)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .ruler,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 22.0,
                                                        ),
                                                        SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              _model.allObservations
                                                                              .where((e) => (String name) {
                                                                                    return name.toLowerCase().trim() == 'bmi';
                                                                                  }(e.name))
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.value !=
                                                                          null &&
                                                                      _model.allObservations
                                                                              .where((e) => (String name) {
                                                                                    return name.toLowerCase().trim() == 'bmi';
                                                                                  }(e.name))
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.value !=
                                                                          ''
                                                                  ? _model.allObservations
                                                                      .where((e) => (String name) {
                                                                            return name.toLowerCase().trim() ==
                                                                                'bmi';
                                                                          }(e.name))
                                                                      .toList()
                                                                      .firstOrNull
                                                                      ?.value
                                                                  : 'NA',
                                                              'NA',
                                                            ),
                                                          ),
                                                        )),
                                                      ].divide(
                                                          SizedBox(width: 4.0)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ].divide(SizedBox(height: 20.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 300.0,
                                        height: 300.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .cardBlue,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Colors.black,
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                              spreadRadius: 0.0,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .syringe,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .info,
                                                          size: 20.0,
                                                        ),
                                                        Text(
                                                          'INSULIN',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Builder(
                                                builder: (context) {
                                                  if (_model
                                                      .medicationStatements
                                                      .isNotEmpty) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              _model
                                                                  .medicationStatements
                                                                  .where((e) =>
                                                                      e.route ==
                                                                      'Subcutaneous')
                                                                  .toList()
                                                                  .firstOrNull
                                                                  ?.medicationName,
                                                              'Insulin Name',
                                                            ),
                                                          ),
                                                        )),
                                                        SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              '${_model.medicationStatements.where((e) => e.route == 'Subcutaneous').toList().firstOrNull?.morningDose.toString()} - ${_model.medicationStatements.where((e) => e.route == 'Subcutaneous').toList().firstOrNull?.afternoonDose.toString()} - ${_model.medicationStatements.where((e) => e.route == 'Subcutaneous').toList().firstOrNull?.nightDose.toString()}',
                                                              'dose',
                                                            ),
                                                          ),
                                                        )),
                                                      ].divide(SizedBox(
                                                          height: 6.0)),
                                                    );
                                                  } else {
                                                    return Text(
                                                      'NO ENTRIES',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  }
                                                },
                                              ),
                                              SizedBox(
                                                width: 200.0,
                                                child: Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                ),
                                              ),
                                              Builder(
                                                builder: (context) {
                                                  if (_model
                                                      .medicationStatements
                                                      .isNotEmpty) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            'No Insulin',
                                                          ),
                                                        )),
                                                        SelectionArea(
                                                            child:
                                                                AnimatedDefaultTextStyle(
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  800),
                                                          curve:
                                                              Curves.easeInOut,
                                                          child: Text(
                                                            ' ',
                                                          ),
                                                        )),
                                                      ].divide(SizedBox(
                                                          height: 6.0)),
                                                    );
                                                  } else {
                                                    return Text(
                                                      'NO ENTRIES',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  }
                                                },
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.pills,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      size: 22.0,
                                                    ),
                                                    Text(
                                                      'OHA DETAILS',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 10.0)),
                                                ),
                                              ),
                                              Builder(
                                                builder: (context) {
                                                  if (_model
                                                      .medicationStatements
                                                      .isNotEmpty) {
                                                    return AlignedTooltip(
                                                      content: Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'Message...',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                      offset: 4.0,
                                                      preferredDirection:
                                                          AxisDirection.up,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      elevation: 4.0,
                                                      tailBaseWidth: 24.0,
                                                      tailLength: 12.0,
                                                      waitDuration: Duration(
                                                          milliseconds: 100),
                                                      showDuration: Duration(
                                                          milliseconds: 1500),
                                                      triggerMode:
                                                          TooltipTriggerMode
                                                              .tap,
                                                      child: SelectionArea(
                                                          child:
                                                              AnimatedDefaultTextStyle(
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleSmall
                                                            .override(
                                                              font: GoogleFonts
                                                                  .readexPro(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                            ),
                                                        duration: Duration(
                                                            milliseconds: 800),
                                                        curve: Curves.easeInOut,
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            '${_model.medicationStatements.where((e) => e.route == 'Oral').toList().firstOrNull?.medicationName} ${_model.medicationStatements.where((e) => e.route == 'Oral').toList().firstOrNull?.morningDose.toString()} - ${_model.medicationStatements.where((e) => e.route == 'Oral').toList().firstOrNull?.afternoonDose.toString()} - ${_model.medicationStatements.where((e) => e.route == 'Oral').toList().firstOrNull?.nightDose.toString()}',
                                                            'ohas',
                                                          ),
                                                        ),
                                                      )),
                                                    );
                                                  } else {
                                                    return Text(
                                                      'NO ENTRIES',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ].divide(SizedBox(height: 10.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 300.0,
                                        height: 300.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .cardBlue,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Colors.black,
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                              spreadRadius: 0.0,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .clipboardList,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      size: 22.0,
                                                    ),
                                                    Text(
                                                      'DIAGNOSIS',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 10.0)),
                                                ),
                                              ),
                                              Expanded(
                                                child: Builder(
                                                  builder: (context) {
                                                    if (widget.conditions !=
                                                            null &&
                                                        (widget.conditions)!
                                                            .isNotEmpty) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final conditions = widget
                                                                .conditions!
                                                                .sortedList(
                                                                    keyOf: (e) =>
                                                                        e.onsetDate!,
                                                                    desc: false)
                                                                .toList();

                                                            return ListView
                                                                .separated(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  conditions
                                                                      .length,
                                                              separatorBuilder: (_,
                                                                      __) =>
                                                                  SizedBox(
                                                                      height:
                                                                          4.0),
                                                              itemBuilder: (context,
                                                                  conditionsIndex) {
                                                                final conditionsItem =
                                                                    conditions[
                                                                        conditionsIndex];
                                                                return RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: valueOrDefault<
                                                                            String>(
                                                                          (conditionsIndex + 1)
                                                                              .toString(),
                                                                          '1',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            ') ',
                                                                        style:
                                                                            TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text: valueOrDefault<
                                                                            String>(
                                                                          conditionsItem
                                                                              .conditionName,
                                                                          'Diagnosis',
                                                                        ),
                                                                        style:
                                                                            TextStyle(),
                                                                      )
                                                                    ],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Colors.black,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .justify,
                                                                );
                                                              },
                                                              controller: _model
                                                                  .listViewController,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                        'NO DIAGNOSIS ENTERED YET',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontStyle,
                                                                ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 16.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (!(_model
                                        .medicationStatements.isNotEmpty))
                                      AlignedTooltip(
                                        content: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text(
                                            'Show Diabetes Details Entry Form',
                                            style: FlutterFlowTheme.of(context)
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
                                        child: FlutterFlowIconButton(
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          borderRadius: 20.0,
                                          buttonSize: 40.0,
                                          hoverColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          hoverIconColor:
                                              FlutterFlowTheme.of(context).info,
                                          hoverBorderColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            _model.showDiabetesEntryForm = true;
                                            safeSetState(() {});
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                                if (_model.showDiabetesEntryForm)
                                  Form(
                                    key: _model.formKey2,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: Visibility(
                                      visible: _model.showDiabetesEntryForm,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Diabetes Type',
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
                                              FlutterFlowDropDown<String>(
                                                controller: _model
                                                        .diabetesTypeValueController ??=
                                                    FormFieldController<String>(
                                                  _model.diabetesTypeValue ??=
                                                      '',
                                                ),
                                                options: List<String>.from(
                                                    FFAppState()
                                                        .diabetesTypes
                                                        .map((e) => e.code)
                                                        .toList()),
                                                optionLabels: FFAppState()
                                                    .diabetesTypes
                                                    .map((e) => e.displayName)
                                                    .toList(),
                                                onChanged: (val) =>
                                                    safeSetState(() => _model
                                                            .diabetesTypeValue =
                                                        val),
                                                width: 200.0,
                                                height: 40.0,
                                                textStyle:
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
                                                hintText: 'Select...',
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 24.0,
                                                ),
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                elevation: 2.0,
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                focusBorderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                borderWidth: 0.0,
                                                borderRadius: 10.0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 12.0, 0.0),
                                                hidesUnderline: true,
                                                isOverButton: false,
                                                isSearchable: false,
                                                isMultiSelect: false,
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Diabetes Duration',
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
                                              Container(
                                                width: 200.0,
                                                child: TextFormField(
                                                  controller: _model
                                                      .diabetesDurationTextController,
                                                  focusNode: _model
                                                      .diabetesDurationFocusNode,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    '_model.diabetesDurationTextController',
                                                    Duration(milliseconds: 200),
                                                    () => safeSetState(() {}),
                                                  ),
                                                  autofocus: false,
                                                  enabled: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                    hintText:
                                                        'Diabetes Duration(Years)..',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    suffixIcon: _model
                                                            .diabetesDurationTextController!
                                                            .text
                                                            .isNotEmpty
                                                        ? InkWell(
                                                            onTap: () async {
                                                              _model
                                                                  .diabetesDurationTextController
                                                                  ?.clear();
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Icon(
                                                              Icons.clear,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              size: 24.0,
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  enableInteractiveSelection:
                                                      true,
                                                  validator: _model
                                                      .diabetesDurationTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                            child: VerticalDivider(
                                              thickness: 2.0,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Insulin Details',
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
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 200.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .insulinNameTextController,
                                                      focusNode: _model
                                                          .insulinNameFocusNode,
                                                      autofocus: false,
                                                      enabled: true,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintText:
                                                            'Insulin Name',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      enableInteractiveSelection:
                                                          true,
                                                      validator: _model
                                                          .insulinNameTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 80.0,
                                                    child: Container(
                                                      width: 200.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .mornInsulinDoseTextController,
                                                        focusNode: _model
                                                            .mornInsulinDoseFocusNode,
                                                        autofocus: false,
                                                        enabled: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          hintText: 'Morning',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        enableInteractiveSelection:
                                                            true,
                                                        validator: _model
                                                            .mornInsulinDoseTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 80.0,
                                                    decoration: BoxDecoration(),
                                                    child: Container(
                                                      width: 200.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .aftInsulinDoseTextController,
                                                        focusNode: _model
                                                            .aftInsulinDoseFocusNode,
                                                        autofocus: false,
                                                        enabled: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          hintText: 'Afternoon',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        enableInteractiveSelection:
                                                            true,
                                                        validator: _model
                                                            .aftInsulinDoseTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 80.0,
                                                    decoration: BoxDecoration(),
                                                    child: Container(
                                                      width: 200.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .nightInsulinDoseTextController,
                                                        focusNode: _model
                                                            .nightInsulinDoseFocusNode,
                                                        autofocus: false,
                                                        enabled: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          hintText: 'Night',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        enableInteractiveSelection:
                                                            true,
                                                        validator: _model
                                                            .nightInsulinDoseTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 4.0)),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                            child: VerticalDivider(
                                              thickness: 2.0,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'OHA Details',
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
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 200.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .oHANameTextController,
                                                      focusNode: _model
                                                          .oHANameFocusNode,
                                                      autofocus: false,
                                                      enabled: true,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintText:
                                                            'OHA Name and Dose',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      enableInteractiveSelection:
                                                          true,
                                                      validator: _model
                                                          .oHANameTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 80.0,
                                                    child: Container(
                                                      width: 200.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .mornOHADoseTextController,
                                                        focusNode: _model
                                                            .mornOHADoseFocusNode,
                                                        autofocus: false,
                                                        enabled: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          hintText: 'Morning',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        enableInteractiveSelection:
                                                            true,
                                                        validator: _model
                                                            .mornOHADoseTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 80.0,
                                                    decoration: BoxDecoration(),
                                                    child: Container(
                                                      width: 200.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .aftOHADoseTextController,
                                                        focusNode: _model
                                                            .aftOHADoseFocusNode,
                                                        autofocus: false,
                                                        enabled: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          hintText: 'Afternoon',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        enableInteractiveSelection:
                                                            true,
                                                        validator: _model
                                                            .aftOHADoseTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 80.0,
                                                    decoration: BoxDecoration(),
                                                    child: Container(
                                                      width: 200.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .nightOHADoseTextController,
                                                        focusNode: _model
                                                            .nightOHADoseFocusNode,
                                                        autofocus: false,
                                                        enabled: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          hintText: 'Night',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        enableInteractiveSelection:
                                                            true,
                                                        validator: _model
                                                            .nightOHADoseTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 4.0)),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                            child: VerticalDivider(
                                              thickness: 2.0,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            borderRadius: 20.0,
                                            buttonSize: 40.0,
                                            hoverColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            hoverIconColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            hoverBorderColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            icon: Icon(
                                              Icons.rocket_launch_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 24.0,
                                            ),
                                            showLoadingIndicator: true,
                                            onPressed: () async {
                                              if (_model.formKey2
                                                          .currentState ==
                                                      null ||
                                                  !_model.formKey2.currentState!
                                                      .validate()) {
                                                return;
                                              }
                                              if (_model.diabetesTypeValue ==
                                                  null) {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Error'),
                                                      content: Text(
                                                          'Diabetes Type must be selected'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                return;
                                              }
                                              _model.diabetesDetailsBundlePost =
                                                  await BundlePOSTDiabetesDetailsCall
                                                      .call(
                                                token: FFAppState()
                                                    .fhirBearerToken,
                                                buildJsonJson: functions.buildDiabetesPOSTJSON(
                                                    widget.patientDetails!
                                                        .identifier,
                                                    widget.patientDetails!
                                                        .identifier,
                                                    FFAppState()
                                                        .diabetesTypes
                                                        .where((e) =>
                                                            e.code ==
                                                            _model
                                                                .diabetesTypeValue)
                                                        .toList()
                                                        .firstOrNull!
                                                        .code,
                                                    FFAppState()
                                                        .diabetesTypes
                                                        .where((e) =>
                                                            e.code ==
                                                            _model
                                                                .diabetesTypeValue)
                                                        .toList()
                                                        .firstOrNull!
                                                        .codeName,
                                                    FFAppState()
                                                        .diabetesTypes
                                                        .where((e) =>
                                                            e.code ==
                                                            _model
                                                                .diabetesTypeValue)
                                                        .toList()
                                                        .firstOrNull!
                                                        .displayName,
                                                    dateTimeFormat(
                                                        "y-MM-dd",
                                                        functions.calculatedDOBFromAgeinYears(
                                                            double.parse(_model
                                                                .diabetesDurationTextController
                                                                .text))),
                                                    functions
                                                        .datetimeToISO8601String(
                                                            getCurrentTimestamp)!,
                                                    _model
                                                        .insulinNameTextController
                                                        .text,
                                                    int.parse(_model.mornInsulinDoseTextController.text),
                                                    int.parse(_model.aftInsulinDoseTextController.text),
                                                    int.parse(_model.nightInsulinDoseTextController.text),
                                                    _model.oHANameTextController.text,
                                                    int.parse(_model.mornOHADoseTextController.text),
                                                    int.tryParse(_model.aftOHADoseTextController.text),
                                                    int.tryParse(_model.nightOHADoseTextController.text)),
                                              );

                                              if ((_model
                                                      .diabetesDetailsBundlePost
                                                      ?.succeeded ??
                                                  true)) {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Success'),
                                                      content: Text(
                                                          'Added Diabetes Details'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                _model.showDiabetesEntryForm =
                                                    false;
                                                safeSetState(() {});
                                                safeSetState(() {
                                                  _model
                                                      .diabetesDurationTextController
                                                      ?.clear();
                                                  _model
                                                      .insulinNameTextController
                                                      ?.clear();
                                                  _model
                                                      .mornInsulinDoseTextController
                                                      ?.clear();
                                                  _model
                                                      .aftInsulinDoseTextController
                                                      ?.clear();
                                                  _model
                                                      .nightInsulinDoseTextController
                                                      ?.clear();
                                                  _model.oHANameTextController
                                                      ?.clear();
                                                  _model
                                                      .mornOHADoseTextController
                                                      ?.clear();
                                                  _model
                                                      .aftOHADoseTextController
                                                      ?.clear();
                                                  _model
                                                      .nightOHADoseTextController
                                                      ?.clear();
                                                });
                                                _model
                                                    .diabetesTypeValueController
                                                    ?.reset();
                                                _model.diabetesTypeValue = null;
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Error'),
                                                      content: Text((_model
                                                              .diabetesDetailsBundlePost
                                                              ?.bodyText ??
                                                          '')),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }

                                              _model.allConditions1 =
                                                  await GetPatientConditionByIDCopyCall
                                                      .call(
                                                token: FFAppState()
                                                    .fhirBearerToken,
                                                id: widget
                                                    .patientDetails?.identifier,
                                                optionalQueries:
                                                    '_sort=-_lastUpdated',
                                              );

                                              if ((_model.allConditions1
                                                      ?.succeeded ??
                                                  true)) {
                                                _model.ptConditions = functions
                                                    .parseFhirConditions(
                                                        GetPatientConditionByIDCopyCall
                                                                .entries(
                                                      (_model.allConditions1
                                                              ?.jsonBody ??
                                                          ''),
                                                    )!
                                                            .toList())
                                                    .toList()
                                                    .cast<ConditionStruct>();
                                                safeSetState(() {});
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Error'),
                                                      content: Text((_model
                                                              .allConditions1
                                                              ?.bodyText ??
                                                          '')),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }

                                              _model.medicationStatements2 =
                                                  await GetAllMedicationStatementsByIDForPatientCall
                                                      .call(
                                                token: FFAppState()
                                                    .fhirBearerToken,
                                                id: widget
                                                    .patientDetails?.identifier,
                                                optionalQueries:
                                                    '_sort=-_lastUpdated',
                                              );

                                              if ((_model.medicationStatements2
                                                      ?.succeeded ??
                                                  true)) {
                                                _model.medicationStatements =
                                                    functions
                                                        .parseFhirMedicationStatement(
                                                            GetAllMedicationStatementsByIDForPatientCall
                                                                .entries(
                                                          (_model.medicationStatements2
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )?.toList())
                                                        .toList()
                                                        .cast<
                                                            MedicationStatementStruct>();
                                                safeSetState(() {});
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Error'),
                                                      content: Text((_model
                                                              .medicationStatements2
                                                              ?.bodyText ??
                                                          '')),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }

                                              safeSetState(() {});
                                            },
                                          ),
                                        ]
                                            .divide(SizedBox(width: 10.0))
                                            .around(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Builder(
                                    builder: (context) {
                                      final datePages = functions
                                          .createDatesList(
                                              widget.encounter!.admissionDate!)
                                          .toList();

                                      return Container(
                                        width: double.infinity,
                                        height: 580.0,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 40.0),
                                          child: PageView.builder(
                                            controller: _model
                                                    .cBGPageViewController ??=
                                                PageController(
                                                    initialPage: max(
                                                        0,
                                                        min(
                                                            valueOrDefault<int>(
                                                              functions
                                                                      .createDatesList(widget
                                                                          .encounter!
                                                                          .admissionDate!)
                                                                      .length -
                                                                  1,
                                                              0,
                                                            ),
                                                            datePages.length -
                                                                1))),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: datePages.length,
                                            itemBuilder:
                                                (context, datePagesIndex) {
                                              final datePagesItem =
                                                  datePages[datePagesIndex];
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x33000000),
                                                          offset: Offset(
                                                            0.0,
                                                            2.0,
                                                          ),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent1,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          dateTimeFormat(
                                                              "dd-MM-y",
                                                              datePagesItem),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleLarge
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final timeSpot =
                                                                  FFAppConstants
                                                                      .timespots
                                                                      .toList()
                                                                      .take(3)
                                                                      .toList();

                                                              return Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: List.generate(
                                                                    timeSpot
                                                                        .length,
                                                                    (timeSpotIndex) {
                                                                  final timeSpotItem =
                                                                      timeSpot[
                                                                          timeSpotIndex];
                                                                  return Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              1.0),
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Container(
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                color: (_model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed') || !(_model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == timeSpotItem)).toList().isNotEmpty) ? FlutterFlowTheme.of(context).cardBlue : FlutterFlowTheme.of(context).cardTertiary,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(10.0),
                                                                                  topRight: Radius.circular(10.0),
                                                                                ),
                                                                                border: Border.all(
                                                                                  color: (_model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed') || !(_model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == timeSpotItem)).toList().isNotEmpty) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).tertiary,
                                                                                  width: 1.0,
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(16.0),
                                                                                child: Text(
                                                                                  valueOrDefault<String>(
                                                                                    timeSpotItem.toUpperCase(),
                                                                                    'MORNING',
                                                                                  ),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                        ),
                                                                                        color: (_model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed') || !(_model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == timeSpotItem)).toList().isNotEmpty) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).tertiary,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Builder(
                                                                              builder: (context) {
                                                                                if (!(_model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().isNotEmpty)) {
                                                                                  return Stack(
                                                                                    alignment: AlignmentDirectional(1.0, -1.0),
                                                                                    children: [
                                                                                      Container(
                                                                                        width: double.infinity,
                                                                                        height: MediaQuery.sizeOf(context).width > kBreakpointLarge ? 430.0 : 405.0,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(10.0),
                                                                                            bottomRight: Radius.circular(10.0),
                                                                                          ),
                                                                                          border: Border.all(
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                          ),
                                                                                        ),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            FlutterFlowIconButton(
                                                                                              borderRadius: 30.0,
                                                                                              buttonSize: 60.0,
                                                                                              hoverColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              hoverIconColor: FlutterFlowTheme.of(context).success,
                                                                                              icon: Icon(
                                                                                                Icons.playlist_add_rounded,
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                size: 40.0,
                                                                                              ),
                                                                                              onPressed: () async {
                                                                                                _model.selectedDate = functions.calculateEffectiveDateTime(datePagesItem, timeSpotItem);
                                                                                                _model.selectedTimespot = timeSpotItem;
                                                                                                _model.showCBGEntryForm = true;
                                                                                                safeSetState(() {});
                                                                                                await _model.chartColumnMainScrollController?.animateTo(
                                                                                                  _model.chartColumnMainScrollController!.position.maxScrollExtent,
                                                                                                  duration: Duration(milliseconds: 100),
                                                                                                  curve: Curves.ease,
                                                                                                );
                                                                                              },
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      if (responsiveVisibility(
                                                                                        context: context,
                                                                                        desktop: false,
                                                                                      ))
                                                                                        AlignedTooltip(
                                                                                          content: Padding(
                                                                                            padding: EdgeInsets.all(4.0),
                                                                                            child: Text(
                                                                                              'Reset',
                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                    ),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          offset: 4.0,
                                                                                          preferredDirection: AxisDirection.right,
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          elevation: 4.0,
                                                                                          tailBaseWidth: 24.0,
                                                                                          tailLength: 12.0,
                                                                                          waitDuration: Duration(milliseconds: 100),
                                                                                          showDuration: Duration(milliseconds: 1500),
                                                                                          triggerMode: TooltipTriggerMode.tap,
                                                                                          child: Visibility(
                                                                                            visible: responsiveVisibility(
                                                                                              context: context,
                                                                                              desktop: false,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                                                                                              child: FlutterFlowIconButton(
                                                                                                borderRadius: 20.0,
                                                                                                buttonSize: 40.0,
                                                                                                fillColor: FlutterFlowTheme.of(context).primary,
                                                                                                icon: Icon(
                                                                                                  Icons.key_sharp,
                                                                                                  color: FlutterFlowTheme.of(context).info,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  print('ResetRowIB pressed ...');
                                                                                                },
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                    ],
                                                                                  );
                                                                                } else {
                                                                                  return Stack(
                                                                                    alignment: AlignmentDirectional(1.0, -1.0),
                                                                                    children: [
                                                                                      Container(
                                                                                        width: double.infinity,
                                                                                        height: 430.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(10.0),
                                                                                            bottomRight: Radius.circular(10.0),
                                                                                          ),
                                                                                          border: Border.all(
                                                                                            color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).tertiary,
                                                                                          ),
                                                                                        ),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).accent2 : FlutterFlowTheme.of(context).cardTertiary,
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  AlignedTooltip(
                                                                                                    content: Padding(
                                                                                                      padding: EdgeInsets.all(4.0),
                                                                                                      child: Text(
                                                                                                        'Message...',
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    offset: 4.0,
                                                                                                    preferredDirection: AxisDirection.up,
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    elevation: 4.0,
                                                                                                    tailBaseWidth: 24.0,
                                                                                                    tailLength: 12.0,
                                                                                                    waitDuration: Duration(milliseconds: 100),
                                                                                                    showDuration: Duration(milliseconds: 1500),
                                                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                                                    child: Builder(
                                                                                                      builder: (context) {
                                                                                                        if (true) {
                                                                                                          return Icon(
                                                                                                            Icons.check_circle_outline_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).success,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else if (true) {
                                                                                                          return Icon(
                                                                                                            Icons.arrow_downward_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else if (true) {
                                                                                                          return Icon(
                                                                                                            Icons.cable_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else if (true) {
                                                                                                          return FaIcon(
                                                                                                            FontAwesomeIcons.fillDrip,
                                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else {
                                                                                                          return Icon(
                                                                                                            Icons.block_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).error,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        }
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.feedStatus,
                                                                                                          'feedstatus',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.start,
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ]
                                                                                                    .divide(SizedBox(
                                                                                                        width: valueOrDefault<double>(
                                                                                                      (MediaQuery.sizeOf(context).width < kBreakpointLarge ? 0 : 4).toDouble(),
                                                                                                      4.0,
                                                                                                    )))
                                                                                                    .around(SizedBox(
                                                                                                        width: valueOrDefault<double>(
                                                                                                      (MediaQuery.sizeOf(context).width < kBreakpointLarge ? 0 : 4).toDouble(),
                                                                                                      4.0,
                                                                                                    ))),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).accent2 : FlutterFlowTheme.of(context).cardTertiary,
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  AlignedTooltip(
                                                                                                    content: Padding(
                                                                                                      padding: EdgeInsets.all(4.0),
                                                                                                      child: Text(
                                                                                                        'Message...',
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    offset: 4.0,
                                                                                                    preferredDirection: AxisDirection.up,
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    elevation: 4.0,
                                                                                                    tailBaseWidth: 24.0,
                                                                                                    tailLength: 12.0,
                                                                                                    waitDuration: Duration(milliseconds: 100),
                                                                                                    showDuration: Duration(milliseconds: 1500),
                                                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                                                    child: Builder(
                                                                                                      builder: (context) {
                                                                                                        if (true) {
                                                                                                          return Icon(
                                                                                                            Icons.check_circle_outline_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).success,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else if (true) {
                                                                                                          return FaIcon(
                                                                                                            FontAwesomeIcons.syringe,
                                                                                                            color: FlutterFlowTheme.of(context).error,
                                                                                                            size: 22.0,
                                                                                                          );
                                                                                                        } else if (true) {
                                                                                                          return FaIcon(
                                                                                                            FontAwesomeIcons.tablets,
                                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                                            size: 22.0,
                                                                                                          );
                                                                                                        } else {
                                                                                                          return Icon(
                                                                                                            Icons.block_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).alternate,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        }
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.steroidStatus,
                                                                                                          'STEROIDS',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.start,
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 4.0)).around(SizedBox(width: 4.0)),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).accent2 : FlutterFlowTheme.of(context).cardTertiary,
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  AlignedTooltip(
                                                                                                    content: Padding(
                                                                                                      padding: EdgeInsets.all(4.0),
                                                                                                      child: Text(
                                                                                                        'Message...',
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    offset: 4.0,
                                                                                                    preferredDirection: AxisDirection.up,
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    elevation: 4.0,
                                                                                                    tailBaseWidth: 24.0,
                                                                                                    tailLength: 12.0,
                                                                                                    waitDuration: Duration(milliseconds: 100),
                                                                                                    showDuration: Duration(milliseconds: 1500),
                                                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                                                    child: Builder(
                                                                                                      builder: (context) {
                                                                                                        if (true) {
                                                                                                          return Icon(
                                                                                                            Icons.check_circle_outline_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).success,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else if (true) {
                                                                                                          return Icon(
                                                                                                            Icons.water_drop_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).error,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else {
                                                                                                          return Icon(
                                                                                                            Icons.block_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).alternate,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        }
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.inotropeStatus,
                                                                                                          'INOTROPES',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.start,
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 4.0)).around(SizedBox(width: 4.0)),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).accent2 : FlutterFlowTheme.of(context).cardTertiary,
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  AlignedTooltip(
                                                                                                    content: Padding(
                                                                                                      padding: EdgeInsets.all(4.0),
                                                                                                      child: Text(
                                                                                                        'Message...',
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    offset: 4.0,
                                                                                                    preferredDirection: AxisDirection.up,
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    elevation: 4.0,
                                                                                                    tailBaseWidth: 24.0,
                                                                                                    tailLength: 12.0,
                                                                                                    waitDuration: Duration(milliseconds: 100),
                                                                                                    showDuration: Duration(milliseconds: 1500),
                                                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                                                    child: Builder(
                                                                                                      builder: (context) {
                                                                                                        if (true) {
                                                                                                          return Icon(
                                                                                                            Icons.check_circle_outline_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).success,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else if (true) {
                                                                                                          return FaIcon(
                                                                                                            FontAwesomeIcons.playCircle,
                                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                                            size: 22.0,
                                                                                                          );
                                                                                                        } else if (true) {
                                                                                                          return Icon(
                                                                                                            Icons.stop_circle_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).error,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else {
                                                                                                          return Icon(
                                                                                                            Icons.block_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).alternate,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        }
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.insulinInfusionStatus,
                                                                                                          'INFUSION',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.start,
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.normal,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 4.0)).around(SizedBox(width: 4.0)),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).accent2 : FlutterFlowTheme.of(context).cardTertiary,
                                                                                                ),
                                                                                              ),
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  AlignedTooltip(
                                                                                                    content: Padding(
                                                                                                      padding: EdgeInsets.all(4.0),
                                                                                                      child: Text(
                                                                                                        'Message...',
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    offset: 4.0,
                                                                                                    preferredDirection: AxisDirection.up,
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    elevation: 4.0,
                                                                                                    tailBaseWidth: 24.0,
                                                                                                    tailLength: 12.0,
                                                                                                    waitDuration: Duration(milliseconds: 100),
                                                                                                    showDuration: Duration(milliseconds: 1500),
                                                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                                                    child: Icon(
                                                                                                      Icons.water_rounded,
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      size: 24.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                  AlignedTooltip(
                                                                                                    content: Text(
                                                                                                      'Creatinine',
                                                                                                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                            font: GoogleFonts.inter(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                    offset: 4.0,
                                                                                                    preferredDirection: AxisDirection.up,
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    elevation: 4.0,
                                                                                                    tailBaseWidth: 24.0,
                                                                                                    tailLength: 12.0,
                                                                                                    waitDuration: Duration(milliseconds: 100),
                                                                                                    showDuration: Duration(milliseconds: 1500),
                                                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.creatinine.toString(),
                                                                                                          'CREATININE',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              fontSize: 16.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 3.0)).around(SizedBox(width: 3.0)),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).accent2 : FlutterFlowTheme.of(context).cardTertiary,
                                                                                                ),
                                                                                              ),
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  AlignedTooltip(
                                                                                                    content: Padding(
                                                                                                      padding: EdgeInsets.all(4.0),
                                                                                                      child: Text(
                                                                                                        'CBG',
                                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    offset: 4.0,
                                                                                                    preferredDirection: AxisDirection.up,
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    elevation: 4.0,
                                                                                                    tailBaseWidth: 24.0,
                                                                                                    tailLength: 12.0,
                                                                                                    waitDuration: Duration(milliseconds: 100),
                                                                                                    showDuration: Duration(milliseconds: 1500),
                                                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.cbg.toString(),
                                                                                                          'CBG',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                              font: GoogleFonts.readexPro(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).error,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).accent2 : FlutterFlowTheme.of(context).cardTertiary,
                                                                                                ),
                                                                                              ),
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 0.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Short Acting Insulin')).toList().firstOrNull?.medicationName,
                                                                                                          'SAI NAME',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.start,
                                                                                                        style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                              font: GoogleFonts.readexPro(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 4.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Short Acting Insulin')).toList().firstOrNull?.dose.toString(),
                                                                                                          'SAI DOSE',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.start,
                                                                                                        style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                              font: GoogleFonts.readexPro(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  if (responsiveVisibility(
                                                                                                    context: context,
                                                                                                    desktop: false,
                                                                                                  ))
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: AlignedTooltip(
                                                                                                        content: Padding(
                                                                                                          padding: EdgeInsets.all(4.0),
                                                                                                          child: Text(
                                                                                                            'Message...',
                                                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        offset: 4.0,
                                                                                                        preferredDirection: AxisDirection.up,
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                        elevation: 4.0,
                                                                                                        tailBaseWidth: 24.0,
                                                                                                        tailLength: 12.0,
                                                                                                        waitDuration: Duration(milliseconds: 100),
                                                                                                        showDuration: Duration(milliseconds: 1500),
                                                                                                        triggerMode: TooltipTriggerMode.tap,
                                                                                                        child: Visibility(
                                                                                                          visible: responsiveVisibility(
                                                                                                            context: context,
                                                                                                            desktop: false,
                                                                                                          ),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 4.0, 4.0),
                                                                                                            child: Text(
                                                                                                              '',
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                                    font: GoogleFonts.readexPro(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                                    ),
                                                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                                                                                    child: Builder(
                                                                                                      builder: (context) {
                                                                                                        if (_model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed') {
                                                                                                          return Icon(
                                                                                                            Icons.check_circle_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).success,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else if (_model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Short Acting Insulin')).toList().firstOrNull?.medicationName != null && _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Short Acting Insulin')).toList().firstOrNull?.medicationName != '') {
                                                                                                          return FaIcon(
                                                                                                            FontAwesomeIcons.syringe,
                                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else {
                                                                                                          return FaIcon(
                                                                                                            FontAwesomeIcons.exclamationTriangle,
                                                                                                            color: FlutterFlowTheme.of(context).error,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        }
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 6.0)),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).accent2 : FlutterFlowTheme.of(context).cardTertiary,
                                                                                                ),
                                                                                              ),
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 0.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Long Acting / Premixed Insulin')).toList().firstOrNull?.medicationName,
                                                                                                          'LAI NAME',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.start,
                                                                                                        style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                              font: GoogleFonts.readexPro(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).success,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 4.0, 4.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Long Acting / Premixed Insulin')).toList().firstOrNull?.dose.toString(),
                                                                                                          'LAI DOSE',
                                                                                                        ),
                                                                                                        textAlign: TextAlign.start,
                                                                                                        style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                              font: GoogleFonts.readexPro(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).success,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  if (responsiveVisibility(
                                                                                                    context: context,
                                                                                                    desktop: false,
                                                                                                  ))
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: AlignedTooltip(
                                                                                                        content: Padding(
                                                                                                          padding: EdgeInsets.all(4.0),
                                                                                                          child: Text(
                                                                                                            'Message...',
                                                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        offset: 4.0,
                                                                                                        preferredDirection: AxisDirection.up,
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                        elevation: 4.0,
                                                                                                        tailBaseWidth: 24.0,
                                                                                                        tailLength: 12.0,
                                                                                                        waitDuration: Duration(milliseconds: 100),
                                                                                                        showDuration: Duration(milliseconds: 1500),
                                                                                                        triggerMode: TooltipTriggerMode.tap,
                                                                                                        child: Visibility(
                                                                                                          visible: responsiveVisibility(
                                                                                                            context: context,
                                                                                                            desktop: false,
                                                                                                          ),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 4.0, 4.0),
                                                                                                            child: Text(
                                                                                                              '-',
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                                    font: GoogleFonts.readexPro(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                                    ),
                                                                                                                    color: FlutterFlowTheme.of(context).success,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                                                                                    child: Builder(
                                                                                                      builder: (context) {
                                                                                                        if (_model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().lastOrNull?.status == 'completed') {
                                                                                                          return Icon(
                                                                                                            Icons.check_circle_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).success,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else if (true) {
                                                                                                          return FaIcon(
                                                                                                            FontAwesomeIcons.syringe,
                                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        } else {
                                                                                                          return FaIcon(
                                                                                                            FontAwesomeIcons.exclamationTriangle,
                                                                                                            color: FlutterFlowTheme.of(context).error,
                                                                                                            size: 24.0,
                                                                                                          );
                                                                                                        }
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 6.0)),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              height: 56.0,
                                                                                              decoration: BoxDecoration(),
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Stack(
                                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                      children: [
                                                                                                        if (responsiveVisibility(
                                                                                                          context: context,
                                                                                                          desktop: false,
                                                                                                        ))
                                                                                                          Text(
                                                                                                            'NO NOTES',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: 14.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        Align(
                                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                          child: Container(
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                            ),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                                                                                              child: SingleChildScrollView(
                                                                                                                scrollDirection: Axis.horizontal,
                                                                                                                controller: _model.rowController1,
                                                                                                                child: Row(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                  children: [
                                                                                                                    if (_model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.nurseNotes != null && _model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.nurseNotes != '')
                                                                                                                      FlutterFlowIconButton(
                                                                                                                        borderRadius: 20.0,
                                                                                                                        borderWidth: 1.0,
                                                                                                                        buttonSize: 40.0,
                                                                                                                        fillColor: FlutterFlowTheme.of(context).error,
                                                                                                                        icon: Icon(
                                                                                                                          Icons.face_2_rounded,
                                                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                                                          size: 24.0,
                                                                                                                        ),
                                                                                                                        onPressed: () async {
                                                                                                                          await showDialog(
                                                                                                                            context: context,
                                                                                                                            builder: (alertDialogContext) {
                                                                                                                              return AlertDialog(
                                                                                                                                title: Text('NURSE NOTES'),
                                                                                                                                content: Text(valueOrDefault<String>(
                                                                                                                                  _model.tidChartEntries.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.nurseNotes,
                                                                                                                                  'feedstatus',
                                                                                                                                )),
                                                                                                                                actions: [
                                                                                                                                  TextButton(
                                                                                                                                    onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                                                    child: Text('Ok'),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              );
                                                                                                                            },
                                                                                                                          );
                                                                                                                        },
                                                                                                                      ),
                                                                                                                    Builder(
                                                                                                                      builder: (context) {
                                                                                                                        if (false) {
                                                                                                                          return AlignedTooltip(
                                                                                                                            content: Padding(
                                                                                                                              padding: EdgeInsets.all(4.0),
                                                                                                                              child: Text(
                                                                                                                                '..',
                                                                                                                                style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                                      font: GoogleFonts.inter(
                                                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                                      ),
                                                                                                                                      letterSpacing: 0.0,
                                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                                    ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                            offset: 4.0,
                                                                                                                            preferredDirection: AxisDirection.up,
                                                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                                                            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                            elevation: 4.0,
                                                                                                                            tailBaseWidth: 24.0,
                                                                                                                            tailLength: 12.0,
                                                                                                                            waitDuration: Duration(milliseconds: 100),
                                                                                                                            showDuration: Duration(milliseconds: 1500),
                                                                                                                            triggerMode: TooltipTriggerMode.tap,
                                                                                                                            child: FlutterFlowIconButton(
                                                                                                                              borderRadius: 20.0,
                                                                                                                              borderWidth: 1.0,
                                                                                                                              buttonSize: 40.0,
                                                                                                                              fillColor: FlutterFlowTheme.of(context).success,
                                                                                                                              icon: Icon(
                                                                                                                                Icons.phone_in_talk,
                                                                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                                                              ),
                                                                                                                              onPressed: () async {
                                                                                                                                await showDialog(
                                                                                                                                  context: context,
                                                                                                                                  builder: (alertDialogContext) {
                                                                                                                                    return AlertDialog(
                                                                                                                                      title: Text('abc says:'),
                                                                                                                                      content: Text('ABCD'),
                                                                                                                                      actions: [
                                                                                                                                        TextButton(
                                                                                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                                                          child: Text('Ok'),
                                                                                                                                        ),
                                                                                                                                      ],
                                                                                                                                    );
                                                                                                                                  },
                                                                                                                                );
                                                                                                                              },
                                                                                                                            ),
                                                                                                                          );
                                                                                                                        } else {
                                                                                                                          return Visibility(
                                                                                                                            visible: _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.doctorNotes != null && _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.doctorNotes != '',
                                                                                                                            child: FlutterFlowIconButton(
                                                                                                                              borderRadius: 20.0,
                                                                                                                              borderWidth: 1.0,
                                                                                                                              buttonSize: 40.0,
                                                                                                                              fillColor: FlutterFlowTheme.of(context).primary,
                                                                                                                              icon: FaIcon(
                                                                                                                                FontAwesomeIcons.stethoscope,
                                                                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                                                              ),
                                                                                                                              onPressed: () async {
                                                                                                                                await showDialog(
                                                                                                                                  context: context,
                                                                                                                                  builder: (alertDialogContext) {
                                                                                                                                    return AlertDialog(
                                                                                                                                      title: Text('DOCTOR NOTES'),
                                                                                                                                      content: Text(_model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull!.doctorNotes),
                                                                                                                                      actions: [
                                                                                                                                        TextButton(
                                                                                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                                                          child: Text('Ok'),
                                                                                                                                        ),
                                                                                                                                      ],
                                                                                                                                    );
                                                                                                                                  },
                                                                                                                                );
                                                                                                                              },
                                                                                                                            ),
                                                                                                                          );
                                                                                                                        }
                                                                                                                      },
                                                                                                                    ),
                                                                                                                    if (responsiveVisibility(
                                                                                                                      context: context,
                                                                                                                      desktop: false,
                                                                                                                    ))
                                                                                                                      Builder(
                                                                                                                        builder: (context) {
                                                                                                                          if (true) {
                                                                                                                            return FlutterFlowIconButton(
                                                                                                                              borderRadius: 20.0,
                                                                                                                              borderWidth: 1.0,
                                                                                                                              buttonSize: 40.0,
                                                                                                                              fillColor: FlutterFlowTheme.of(context).error,
                                                                                                                              icon: Icon(
                                                                                                                                Icons.edit_rounded,
                                                                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                                                                size: 24.0,
                                                                                                                              ),
                                                                                                                              onPressed: () async {
                                                                                                                                await showDialog(
                                                                                                                                  context: context,
                                                                                                                                  builder: (alertDialogContext) {
                                                                                                                                    return AlertDialog(
                                                                                                                                      title: Text('MODIFIED REASON NOTES'),
                                                                                                                                      content: Text('ABCD'),
                                                                                                                                      actions: [
                                                                                                                                        TextButton(
                                                                                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                                                          child: Text('Ok'),
                                                                                                                                        ),
                                                                                                                                      ],
                                                                                                                                    );
                                                                                                                                  },
                                                                                                                                );
                                                                                                                              },
                                                                                                                            );
                                                                                                                          } else {
                                                                                                                            return FlutterFlowIconButton(
                                                                                                                              borderRadius: 20.0,
                                                                                                                              borderWidth: 1.0,
                                                                                                                              buttonSize: 40.0,
                                                                                                                              fillColor: FlutterFlowTheme.of(context).error,
                                                                                                                              icon: Icon(
                                                                                                                                Icons.person_off_rounded,
                                                                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                                                                size: 24.0,
                                                                                                                              ),
                                                                                                                              onPressed: () async {
                                                                                                                                await showDialog(
                                                                                                                                  context: context,
                                                                                                                                  builder: (alertDialogContext) {
                                                                                                                                    return AlertDialog(
                                                                                                                                      title: Text('REJECTED NOTES'),
                                                                                                                                      content: Text('ABCD'),
                                                                                                                                      actions: [
                                                                                                                                        TextButton(
                                                                                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                                                          child: Text('Ok'),
                                                                                                                                        ),
                                                                                                                                      ],
                                                                                                                                    );
                                                                                                                                  },
                                                                                                                                );
                                                                                                                              },
                                                                                                                            );
                                                                                                                          }
                                                                                                                        },
                                                                                                                      ),
                                                                                                                  ].divide(SizedBox(width: 10.0)),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ].addToEnd(SizedBox(width: 10.0)),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(8.0),
                                                                                              child: Container(
                                                                                                width: double.infinity,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).secondary : FlutterFlowTheme.of(context).tertiary,
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                  border: Border.all(
                                                                                                    color: _model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status == 'completed' ? FlutterFlowTheme.of(context).secondary : FlutterFlowTheme.of(context).tertiary,
                                                                                                  ),
                                                                                                ),
                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsets.all(4.0),
                                                                                                  child: SingleChildScrollView(
                                                                                                    scrollDirection: Axis.horizontal,
                                                                                                    controller: _model.rowController2,
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Icon(
                                                                                                          Icons.add_box,
                                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                                          size: 24.0,
                                                                                                        ),
                                                                                                        FaIcon(
                                                                                                          FontAwesomeIcons.syringe,
                                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                                          size: 24.0,
                                                                                                        ),
                                                                                                        if (responsiveVisibility(
                                                                                                          context: context,
                                                                                                          desktop: false,
                                                                                                        ))
                                                                                                          Icon(
                                                                                                            Icons.phone_in_talk,
                                                                                                            color: FlutterFlowTheme.of(context).info,
                                                                                                            size: 24.0,
                                                                                                          ),
                                                                                                        if (responsiveVisibility(
                                                                                                          context: context,
                                                                                                          desktop: false,
                                                                                                        ))
                                                                                                          Icon(
                                                                                                            Icons.mode_edit_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).info,
                                                                                                            size: 24.0,
                                                                                                          ),
                                                                                                        if (responsiveVisibility(
                                                                                                          context: context,
                                                                                                          desktop: false,
                                                                                                        ))
                                                                                                          Icon(
                                                                                                            Icons.person_off_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).info,
                                                                                                            size: 24.0,
                                                                                                          ),
                                                                                                        Icon(
                                                                                                          Icons.check_circle_rounded,
                                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                                          size: 30.0,
                                                                                                        ),
                                                                                                        AlignedTooltip(
                                                                                                          content: Padding(
                                                                                                            padding: EdgeInsets.all(4.0),
                                                                                                            child: Text(
                                                                                                              'Insulin Advise Not marked as Followed..!!',
                                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                  ),
                                                                                                              overflow: TextOverflow.ellipsis,
                                                                                                            ),
                                                                                                          ),
                                                                                                          offset: 4.0,
                                                                                                          preferredDirection: AxisDirection.down,
                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                          elevation: 4.0,
                                                                                                          tailBaseWidth: 24.0,
                                                                                                          tailLength: 12.0,
                                                                                                          waitDuration: Duration(milliseconds: 100),
                                                                                                          showDuration: Duration(milliseconds: 1500),
                                                                                                          triggerMode: TooltipTriggerMode.tap,
                                                                                                          child: Visibility(
                                                                                                            visible: responsiveVisibility(
                                                                                                              context: context,
                                                                                                              desktop: false,
                                                                                                            ),
                                                                                                            child: FlutterFlowIconButton(
                                                                                                              borderRadius: 15.0,
                                                                                                              borderWidth: 1.0,
                                                                                                              buttonSize: 30.0,
                                                                                                              fillColor: FlutterFlowTheme.of(context).info,
                                                                                                              icon: FaIcon(
                                                                                                                FontAwesomeIcons.exclamation,
                                                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                                                size: 15.0,
                                                                                                              ),
                                                                                                              onPressed: () {
                                                                                                                print('IncompleteWarning pressed ...');
                                                                                                              },
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ].divide(SizedBox(width: 20.0)),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 6.0),
                                                                                              child: SingleChildScrollView(
                                                                                                scrollDirection: Axis.horizontal,
                                                                                                controller: _model.rowController3,
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        boxShadow: [
                                                                                                          BoxShadow(
                                                                                                            blurRadius: 4.0,
                                                                                                            color: Color(0x33000000),
                                                                                                            offset: Offset(
                                                                                                              0.0,
                                                                                                              2.0,
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.all(4.0),
                                                                                                        child: Row(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            if (responsiveVisibility(
                                                                                                              context: context,
                                                                                                              desktop: false,
                                                                                                            ))
                                                                                                              AlignedTooltip(
                                                                                                                content: Padding(
                                                                                                                  padding: EdgeInsets.all(4.0),
                                                                                                                  child: Text(
                                                                                                                    'Edit CBG',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                          ),
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                offset: 4.0,
                                                                                                                preferredDirection: AxisDirection.down,
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                elevation: 4.0,
                                                                                                                tailBaseWidth: 24.0,
                                                                                                                tailLength: 12.0,
                                                                                                                waitDuration: Duration(milliseconds: 100),
                                                                                                                showDuration: Duration(milliseconds: 1500),
                                                                                                                triggerMode: TooltipTriggerMode.tap,
                                                                                                                child: FlutterFlowIconButton(
                                                                                                                  borderColor: FlutterFlowTheme.of(context).tertiary,
                                                                                                                  borderRadius: 20.0,
                                                                                                                  buttonSize: 40.0,
                                                                                                                  hoverColor: FlutterFlowTheme.of(context).tertiary,
                                                                                                                  hoverIconColor: FlutterFlowTheme.of(context).info,
                                                                                                                  hoverBorderColor: FlutterFlowTheme.of(context).info,
                                                                                                                  icon: Icon(
                                                                                                                    Icons.edit_rounded,
                                                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                                                    size: 24.0,
                                                                                                                  ),
                                                                                                                  onPressed: () {
                                                                                                                    print('editCBGIB pressed ...');
                                                                                                                  },
                                                                                                                ),
                                                                                                              ),
                                                                                                            if (responsiveVisibility(
                                                                                                              context: context,
                                                                                                              desktop: false,
                                                                                                            ))
                                                                                                              AlignedTooltip(
                                                                                                                content: Padding(
                                                                                                                  padding: EdgeInsets.all(4.0),
                                                                                                                  child: Text(
                                                                                                                    'Phone Advise',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                          ),
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                offset: 4.0,
                                                                                                                preferredDirection: AxisDirection.down,
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                elevation: 4.0,
                                                                                                                tailBaseWidth: 24.0,
                                                                                                                tailLength: 12.0,
                                                                                                                waitDuration: Duration(milliseconds: 100),
                                                                                                                showDuration: Duration(milliseconds: 1500),
                                                                                                                triggerMode: TooltipTriggerMode.tap,
                                                                                                                child: FlutterFlowIconButton(
                                                                                                                  borderColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                  borderRadius: 20.0,
                                                                                                                  buttonSize: 40.0,
                                                                                                                  hoverColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                  hoverIconColor: FlutterFlowTheme.of(context).info,
                                                                                                                  hoverBorderColor: FlutterFlowTheme.of(context).info,
                                                                                                                  icon: Icon(
                                                                                                                    Icons.phone_rounded,
                                                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                                                    size: 24.0,
                                                                                                                  ),
                                                                                                                  onPressed: () {
                                                                                                                    print('phoneAdviceIB pressed ...');
                                                                                                                  },
                                                                                                                ),
                                                                                                              ),
                                                                                                            if ((_model.insulinAdministrationList.where((e) => (dateTimeFormat("d/M/y", e.date) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.status != 'completed') && (_model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.medicationName != null && _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().firstOrNull?.medicationName != ''))
                                                                                                              AlignedTooltip(
                                                                                                                content: Padding(
                                                                                                                  padding: EdgeInsets.all(4.0),
                                                                                                                  child: Text(
                                                                                                                    'Follow',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                          ),
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                offset: 4.0,
                                                                                                                preferredDirection: AxisDirection.down,
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                elevation: 4.0,
                                                                                                                tailBaseWidth: 24.0,
                                                                                                                tailLength: 12.0,
                                                                                                                waitDuration: Duration(milliseconds: 100),
                                                                                                                showDuration: Duration(milliseconds: 1500),
                                                                                                                triggerMode: TooltipTriggerMode.tap,
                                                                                                                child: FlutterFlowIconButton(
                                                                                                                  borderColor: FlutterFlowTheme.of(context).success,
                                                                                                                  borderRadius: 20.0,
                                                                                                                  buttonSize: 40.0,
                                                                                                                  hoverColor: FlutterFlowTheme.of(context).success,
                                                                                                                  hoverIconColor: FlutterFlowTheme.of(context).info,
                                                                                                                  hoverBorderColor: FlutterFlowTheme.of(context).info,
                                                                                                                  icon: Icon(
                                                                                                                    Icons.check_rounded,
                                                                                                                    color: FlutterFlowTheme.of(context).success,
                                                                                                                    size: 24.0,
                                                                                                                  ),
                                                                                                                  onPressed: () async {
                                                                                                                    _model.selectedDate = functions.calculateEffectiveDateTime(datePagesItem, timeSpotItem);
                                                                                                                    _model.selectedTimespot = timeSpotItem;
                                                                                                                    safeSetState(() {});
                                                                                                                    _model.postInsulinAdministration = await BundlePOSTInsulinAdministrationRecordCall.call(
                                                                                                                      token: FFAppState().fhirBearerToken,
                                                                                                                      buildJsonJson: functions.createInsulinAdministrationBundleJson(widget.patientDetails!.identifier, widget.encounter!.encounterID, dateTimeFormat("y-MM-dd", _model.selectedDate), timeSpotItem, functions.getRandomStringFromList(FFAppState().practitioners.map((e) => e.id).toList()), 'Display Administration Nurse', functions.datetimeToISO8601String(getCurrentTimestamp)!, _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Short Acting Insulin')).toList().firstOrNull!.medicationRequestId, _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Short Acting Insulin')).toList().firstOrNull!.medicationName, _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Short Acting Insulin')).toList().firstOrNull!.dose, _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Long Acting / Premixed Insulin')).toList().firstOrNull!.medicationRequestId, _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Long Acting / Premixed Insulin')).toList().firstOrNull!.medicationName, _model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase())) && (e.insulinType == 'Long Acting / Premixed Insulin')).toList().firstOrNull!.dose, ''),
                                                                                                                    );

                                                                                                                    if ((_model.postInsulinAdministration?.succeeded ?? true)) {
                                                                                                                      _model.insulinAdministration2 = await GetAllInsulinAdministrationByIDCall.call(
                                                                                                                        token: FFAppState().fhirBearerToken,
                                                                                                                        id: widget.patientDetails?.identifier,
                                                                                                                      );

                                                                                                                      if ((_model.insulinAdministration2?.succeeded ?? true)) {
                                                                                                                        _model.insulinAdministrationList = functions
                                                                                                                            .parseFhirInsulinAdministrations(GetAllInsulinAdministrationByIDCall.entries(
                                                                                                                              (_model.insulinAdministration2?.jsonBody ?? ''),
                                                                                                                            )?.toList())
                                                                                                                            .toList()
                                                                                                                            .cast<InsulinAdministrationStruct>();
                                                                                                                        safeSetState(() {});
                                                                                                                      }
                                                                                                                    } else {
                                                                                                                      await showDialog(
                                                                                                                        context: context,
                                                                                                                        builder: (alertDialogContext) {
                                                                                                                          return AlertDialog(
                                                                                                                            title: Text('Error'),
                                                                                                                            content: Text((_model.postInsulinAdministration?.bodyText ?? '')),
                                                                                                                            actions: [
                                                                                                                              TextButton(
                                                                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                                                child: Text('Ok'),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          );
                                                                                                                        },
                                                                                                                      );
                                                                                                                    }

                                                                                                                    safeSetState(() {});
                                                                                                                  },
                                                                                                                ),
                                                                                                              ),
                                                                                                            if (responsiveVisibility(
                                                                                                              context: context,
                                                                                                              desktop: false,
                                                                                                            ))
                                                                                                              AlignedTooltip(
                                                                                                                content: Padding(
                                                                                                                  padding: EdgeInsets.all(4.0),
                                                                                                                  child: Text(
                                                                                                                    'Reject / Modify',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                          ),
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                offset: 4.0,
                                                                                                                preferredDirection: AxisDirection.down,
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                elevation: 4.0,
                                                                                                                tailBaseWidth: 24.0,
                                                                                                                tailLength: 12.0,
                                                                                                                waitDuration: Duration(milliseconds: 100),
                                                                                                                showDuration: Duration(milliseconds: 1500),
                                                                                                                triggerMode: TooltipTriggerMode.tap,
                                                                                                                child: FlutterFlowIconButton(
                                                                                                                  borderColor: FlutterFlowTheme.of(context).error,
                                                                                                                  borderRadius: 20.0,
                                                                                                                  buttonSize: 40.0,
                                                                                                                  hoverColor: FlutterFlowTheme.of(context).error,
                                                                                                                  hoverIconColor: FlutterFlowTheme.of(context).info,
                                                                                                                  hoverBorderColor: FlutterFlowTheme.of(context).info,
                                                                                                                  icon: Icon(
                                                                                                                    Icons.block_flipped,
                                                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                                                    size: 24.0,
                                                                                                                  ),
                                                                                                                  onPressed: () {
                                                                                                                    print('RejectModifyIB pressed ...');
                                                                                                                  },
                                                                                                                ),
                                                                                                              ),
                                                                                                          ].divide(SizedBox(width: 4.0)),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        boxShadow: [
                                                                                                          BoxShadow(
                                                                                                            blurRadius: 4.0,
                                                                                                            color: Color(0x33000000),
                                                                                                            offset: Offset(
                                                                                                              0.0,
                                                                                                              2.0,
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.all(4.0),
                                                                                                        child: Row(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            if (!(_model.insulinAdviceList.where((e) => (dateTimeFormat("d/M/y", e.authoredOn) == dateTimeFormat("d/M/y", datePagesItem)) && (e.timespot == (timeSpotItem.toUpperCase()))).toList().isNotEmpty))
                                                                                                              AlignedTooltip(
                                                                                                                content: Padding(
                                                                                                                  padding: EdgeInsets.all(4.0),
                                                                                                                  child: Text(
                                                                                                                    'Advise Insulin',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                          ),
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                offset: 4.0,
                                                                                                                preferredDirection: AxisDirection.down,
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                elevation: 4.0,
                                                                                                                tailBaseWidth: 24.0,
                                                                                                                tailLength: 12.0,
                                                                                                                waitDuration: Duration(milliseconds: 100),
                                                                                                                showDuration: Duration(milliseconds: 1500),
                                                                                                                triggerMode: TooltipTriggerMode.tap,
                                                                                                                child: FlutterFlowIconButton(
                                                                                                                  borderColor: FlutterFlowTheme.of(context).primary,
                                                                                                                  borderRadius: 20.0,
                                                                                                                  buttonSize: 40.0,
                                                                                                                  hoverColor: FlutterFlowTheme.of(context).primary,
                                                                                                                  hoverIconColor: FlutterFlowTheme.of(context).info,
                                                                                                                  hoverBorderColor: FlutterFlowTheme.of(context).info,
                                                                                                                  icon: FaIcon(
                                                                                                                    FontAwesomeIcons.syringe,
                                                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                                                    size: 24.0,
                                                                                                                  ),
                                                                                                                  onPressed: () async {
                                                                                                                    _model.selectedDate = functions.calculateEffectiveDateTime(datePagesItem, timeSpotItem);
                                                                                                                    _model.selectedTimespot = timeSpotItem;
                                                                                                                    _model.showInsulinEntryForm = true;
                                                                                                                    safeSetState(() {});
                                                                                                                  },
                                                                                                                ),
                                                                                                              ),
                                                                                                            if (responsiveVisibility(
                                                                                                              context: context,
                                                                                                              desktop: false,
                                                                                                            ))
                                                                                                              AlignedTooltip(
                                                                                                                content: Padding(
                                                                                                                  padding: EdgeInsets.all(4.0),
                                                                                                                  child: Text(
                                                                                                                    'Edit Insulin',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                          ),
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                offset: 4.0,
                                                                                                                preferredDirection: AxisDirection.down,
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                elevation: 4.0,
                                                                                                                tailBaseWidth: 24.0,
                                                                                                                tailLength: 12.0,
                                                                                                                waitDuration: Duration(milliseconds: 100),
                                                                                                                showDuration: Duration(milliseconds: 1500),
                                                                                                                triggerMode: TooltipTriggerMode.tap,
                                                                                                                child: FlutterFlowIconButton(
                                                                                                                  borderColor: FlutterFlowTheme.of(context).tertiary,
                                                                                                                  borderRadius: 20.0,
                                                                                                                  buttonSize: 40.0,
                                                                                                                  hoverColor: FlutterFlowTheme.of(context).tertiary,
                                                                                                                  hoverIconColor: FlutterFlowTheme.of(context).info,
                                                                                                                  hoverBorderColor: FlutterFlowTheme.of(context).info,
                                                                                                                  icon: Icon(
                                                                                                                    Icons.edit_rounded,
                                                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                                                    size: 24.0,
                                                                                                                  ),
                                                                                                                  onPressed: () {
                                                                                                                    print('editInsulinIB pressed ...');
                                                                                                                  },
                                                                                                                ),
                                                                                                              ),
                                                                                                            if (responsiveVisibility(
                                                                                                              context: context,
                                                                                                              desktop: false,
                                                                                                            ))
                                                                                                              AlignedTooltip(
                                                                                                                content: Padding(
                                                                                                                  padding: EdgeInsets.all(4.0),
                                                                                                                  child: Text(
                                                                                                                    'Delete + Reset Row',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                          ),
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                offset: 4.0,
                                                                                                                preferredDirection: AxisDirection.down,
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                elevation: 4.0,
                                                                                                                tailBaseWidth: 24.0,
                                                                                                                tailLength: 12.0,
                                                                                                                waitDuration: Duration(milliseconds: 100),
                                                                                                                showDuration: Duration(milliseconds: 1500),
                                                                                                                triggerMode: TooltipTriggerMode.tap,
                                                                                                                child: FlutterFlowIconButton(
                                                                                                                  borderColor: FlutterFlowTheme.of(context).error,
                                                                                                                  borderRadius: 20.0,
                                                                                                                  buttonSize: 40.0,
                                                                                                                  hoverColor: FlutterFlowTheme.of(context).error,
                                                                                                                  hoverIconColor: FlutterFlowTheme.of(context).info,
                                                                                                                  hoverBorderColor: FlutterFlowTheme.of(context).info,
                                                                                                                  icon: Icon(
                                                                                                                    Icons.delete,
                                                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                                                    size: 24.0,
                                                                                                                  ),
                                                                                                                  onPressed: () {
                                                                                                                    print('DeleteRowIB pressed ...');
                                                                                                                  },
                                                                                                                ),
                                                                                                              ),
                                                                                                          ].divide(SizedBox(width: 4.0)),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 20.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                }
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }).divide(SizedBox(
                                                                    width:
                                                                        10.0)),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    final datePages2 = functions
                                        .createDatesList(
                                            widget.encounter!.admissionDate!)
                                        .toList();

                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(datePages2.length,
                                          (datePages2Index) {
                                        final datePages2Item =
                                            datePages2[datePages2Index];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.selectedPageIdx =
                                                datePages2Index;
                                            safeSetState(() {});
                                            await _model.cBGPageViewController
                                                ?.animateToPage(
                                              _model.selectedPageIdx,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          child: wrapWithModel(
                                            model: _model
                                                .customDotComponentPageViewModels
                                                .getModel(
                                              datePages2Index.toString(),
                                              datePages2Index,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child:
                                                CustomDotComponentPageViewWidget(
                                              key: Key(
                                                'Key1ic_${datePages2Index.toString()}',
                                              ),
                                              isSelected:
                                                  _model.selectedPageIdx ==
                                                      datePages2Index,
                                              assignedIdx: datePages2Index,
                                              assignedDate: datePages2Item,
                                            ),
                                          ),
                                        );
                                      }).divide(SizedBox(width: 10.0)),
                                    );
                                  },
                                ),
                                if (kDebugMode)
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          _model.selectedDate?.toString(),
                                          'D',
                                        ),
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
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 20.0))
                                        .around(SizedBox(width: 20.0)),
                                  ),
                                if (_model.showCBGEntryForm ||
                                    _model.showInsulinEntryForm)
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dateTimeFormat(
                                            "dd-MM-y", _model.selectedDate),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      Text(
                                        valueOrDefault<String>(
                                          _model.selectedTimespot,
                                          'Timespot',
                                        ).toUpperCase(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.showCBGEntryForm = false;
                                          _model.showInsulinEntryForm = false;
                                          safeSetState(() {});
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.solidEyeSlash,
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          size: 24.0,
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 10.0))
                                        .around(SizedBox(width: 10.0)),
                                  ),
                                if (_model.showCBGEntryForm)
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .cardBlue,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                2.0,
                                                2.0,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'FEED STATUS',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Container(
                                                width: 160.0,
                                                child: FlutterFlowChoiceChips(
                                                  options: [
                                                    ChipData(
                                                        'NORMAL ORAL',
                                                        Icons
                                                            .check_circle_outlined),
                                                    ChipData(
                                                        'REDUCED ORAL',
                                                        Icons
                                                            .arrow_downward_rounded),
                                                    ChipData('RT FEEDS',
                                                        Icons.cable_rounded),
                                                    ChipData(
                                                        'TPN',
                                                        FontAwesomeIcons
                                                            .fillDrip),
                                                    ChipData('NPO',
                                                        Icons.block_rounded)
                                                  ],
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                              .feedStatusCCValue =
                                                          val?.firstOrNull),
                                                  selectedChipStyle: ChipStyle(
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .info,
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
                                                    iconColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                    iconSize: 16.0,
                                                    elevation: 0.0,
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  unselectedChipStyle:
                                                      ChipStyle(
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
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
                                                    iconColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    iconSize: 16.0,
                                                    elevation: 4.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  chipSpacing: 60.0,
                                                  rowSpacing: 8.0,
                                                  multiselect: false,
                                                  alignment:
                                                      WrapAlignment.start,
                                                  controller: _model
                                                          .feedStatusCCValueController ??=
                                                      FormFieldController<
                                                          List<String>>(
                                                    [],
                                                  ),
                                                  wrapped: true,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 10.0)),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .cardBlue,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    2.0,
                                                    2.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'STEROIDS',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(20.0, 0.0,
                                                                20.0, 0.0),
                                                    child: Container(
                                                      width: 140.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .steroidsTextController,
                                                        focusNode: _model
                                                            .steroidsFocusNode,
                                                        autofocus: false,
                                                        enabled: true,
                                                        readOnly: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          hintText: 'Steroids',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        enableInteractiveSelection:
                                                            true,
                                                        validator: _model
                                                            .steroidsTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 10.0)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .cardBlue,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    2.0,
                                                    2.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'INOTROPES',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(20.0, 0.0,
                                                                20.0, 0.0),
                                                    child: Container(
                                                      width: 140.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .inotropesTextController,
                                                        focusNode: _model
                                                            .inotropesFocusNode,
                                                        autofocus: false,
                                                        enabled: true,
                                                        readOnly: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          hintText: 'Inotropes',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        enableInteractiveSelection:
                                                            true,
                                                        validator: _model
                                                            .inotropesTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 10.0)),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 20.0)),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .cardBlue,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    2.0,
                                                    2.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Latest HbA1c',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      if (_model.allObservations
                                                                  .where((e) =>
                                                                      (String
                                                                          name) {
                                                                        return name.toLowerCase().trim() ==
                                                                            'hba1c';
                                                                      }(e.name))
                                                                  .toList()
                                                                  .sortedList(
                                                                      keyOf: (e) => e
                                                                          .recordedAt!,
                                                                      desc:
                                                                          true)
                                                                  .firstOrNull
                                                                  ?.value !=
                                                              null &&
                                                          _model.allObservations
                                                                  .where((e) =>
                                                                      (String
                                                                          name) {
                                                                        return name.toLowerCase().trim() ==
                                                                            'hba1c';
                                                                      }(e.name))
                                                                  .toList()
                                                                  .sortedList(
                                                                      keyOf: (e) =>
                                                                          e.recordedAt!,
                                                                      desc: true)
                                                                  .firstOrNull
                                                                  ?.value !=
                                                              '') {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      20.0,
                                                                      0.0),
                                                          child: Container(
                                                            width: 140.0,
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .hbA1cTextController,
                                                              focusNode: _model
                                                                  .hbA1cFocusNode,
                                                              autofocus: false,
                                                              enabled: true,
                                                              readOnly: true,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                labelStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                hintText:
                                                                    'HbA1c',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              cursorColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              enableInteractiveSelection:
                                                                  true,
                                                              validator: _model
                                                                  .hbA1cTextControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Text(
                                                          '-NA-',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 10.0)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .cardBlue,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    2.0,
                                                    2.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Latest Creatinine',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      if (_model.allObservations
                                                                  .where((e) =>
                                                                      (String
                                                                          name) {
                                                                        return name.toLowerCase().trim() ==
                                                                            'creatinine';
                                                                      }(e.name))
                                                                  .toList()
                                                                  .sortedList(
                                                                      keyOf: (e) => e
                                                                          .recordedAt!,
                                                                      desc:
                                                                          true)
                                                                  .firstOrNull
                                                                  ?.value !=
                                                              null &&
                                                          _model.allObservations
                                                                  .where((e) =>
                                                                      (String
                                                                          name) {
                                                                        return name.toLowerCase().trim() ==
                                                                            'creatinine';
                                                                      }(e.name))
                                                                  .toList()
                                                                  .sortedList(
                                                                      keyOf: (e) =>
                                                                          e.recordedAt!,
                                                                      desc: true)
                                                                  .firstOrNull
                                                                  ?.value !=
                                                              '') {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      20.0,
                                                                      0.0),
                                                          child: Container(
                                                            width: 140.0,
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .creatinineTextController,
                                                              focusNode: _model
                                                                  .creatinineFocusNode,
                                                              autofocus: false,
                                                              enabled: true,
                                                              readOnly: true,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                labelStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                hintText:
                                                                    'Creat',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              cursorColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              enableInteractiveSelection:
                                                                  true,
                                                              validator: _model
                                                                  .creatinineTextControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Text(
                                                          '-NA-',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 10.0)),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 20.0)),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .cardBlue,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    2.0,
                                                    2.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Insulin Infusion',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Container(
                                                    width: 200.0,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20.0,
                                                                  0.0,
                                                                  20.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 140.0,
                                                        child: TextFormField(
                                                          controller: _model
                                                              .insulinInfusionTextController,
                                                          focusNode: _model
                                                              .insulinInfusionFocusNode,
                                                          autofocus: false,
                                                          enabled: true,
                                                          readOnly: true,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                            hintText:
                                                                'Insulin Infusion',
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          cursorColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          enableInteractiveSelection:
                                                              true,
                                                          validator: _model
                                                              .insulinInfusionTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(height: 10.0))
                                                    .around(
                                                        SizedBox(height: 10.0)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 200.0,
                                            child: TextFormField(
                                              controller: _model
                                                  .nurseNotesTextController,
                                              focusNode:
                                                  _model.nurseNotesFocusNode,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.nurseNotesTextController',
                                                Duration(milliseconds: 200),
                                                () => safeSetState(() {}),
                                              ),
                                              autofocus: true,
                                              enabled: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                hintText: 'Nurse Notes',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                suffixIcon: _model
                                                        .nurseNotesTextController!
                                                        .text
                                                        .isNotEmpty
                                                    ? InkWell(
                                                        onTap: () async {
                                                          _model
                                                              .nurseNotesTextController
                                                              ?.clear();
                                                          safeSetState(() {});
                                                        },
                                                        child: Icon(
                                                          Icons.clear,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          size: 24.0,
                                                        ),
                                                      )
                                                    : null,
                                              ),
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
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              enableInteractiveSelection: true,
                                              validator: _model
                                                  .nurseNotesTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ]
                                            .divide(SizedBox(height: 20.0))
                                            .around(SizedBox(height: 20.0)),
                                      ),
                                      Container(
                                        width: 140.0,
                                        child: TextFormField(
                                          controller: _model.cbgTextController,
                                          focusNode: _model.cbgFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.cbgTextController',
                                            Duration(milliseconds: 200),
                                            () => safeSetState(() {}),
                                          ),
                                          autofocus: false,
                                          enabled: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                            hintText: 'CBG',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            suffixIcon: _model
                                                    .cbgTextController!
                                                    .text
                                                    .isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model.cbgTextController
                                                          ?.clear();
                                                      safeSetState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.clear,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      size: 24.0,
                                                    ),
                                                  )
                                                : null,
                                          ),
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
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          maxLength: 3,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          buildCounter: (context,
                                                  {required currentLength,
                                                  required isFocused,
                                                  maxLength}) =>
                                              null,
                                          keyboardType: TextInputType.number,
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          enableInteractiveSelection: true,
                                          validator: _model
                                              .cbgTextControllerValidator
                                              .asValidator(context),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]'))
                                          ],
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        borderRadius: 20.0,
                                        buttonSize: 40.0,
                                        hoverColor: FlutterFlowTheme.of(context)
                                            .primary,
                                        hoverIconColor:
                                            FlutterFlowTheme.of(context).info,
                                        hoverBorderColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        icon: Icon(
                                          Icons.rocket_launch,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                        showLoadingIndicator: true,
                                        onPressed: () async {
                                          var _shouldSetState = false;
                                          if (!(_model.feedStatusCCValue !=
                                                  null &&
                                              _model.feedStatusCCValue != '')) {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text(
                                                      'Feed Status  Must be Chosen'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          }
                                          if (!((int cbg) {
                                            return cbg >= 15 && cbg <= 600;
                                          }(int.parse(_model
                                              .cbgTextController.text)))) {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content:
                                                      Text('Enter a Valid CBG'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          }
                                          _model.postCBGEntry =
                                              await BundlePOSTCBGEntryCall.call(
                                            token: FFAppState().fhirBearerToken,
                                            bundleJsonJson: functions.createTidChartEntryBundleJson(
                                                widget
                                                    .patientDetails!.identifier,
                                                widget.encounter!.encounterID,
                                                dateTimeFormat("y-MM-dd",
                                                    _model.selectedDate),
                                                _model.selectedTimespot!,
                                                functions.datetimeToISO8601String(
                                                    _model.selectedDate)!,
                                                functions.datetimeToISO8601String(
                                                    getCurrentTimestamp)!,
                                                functions.getRandomStringFromList(
                                                    FFAppState()
                                                        .practitioners
                                                        .map((e) => e.id)
                                                        .toList()),
                                                'Display Nurse',
                                                _model.feedStatusCCValue!,
                                                _model.steroidsTextController
                                                    .text,
                                                _model.inotropesTextController
                                                    .text,
                                                _model
                                                    .insulinInfusionTextController
                                                    .text,
                                                double.parse(_model
                                                    .cbgTextController.text),
                                                double.tryParse(_model
                                                    .creatinineTextController
                                                    .text),
                                                double.tryParse(_model
                                                    .hbA1cTextController.text),
                                                _model.nurseNotesTextController
                                                    .text),
                                          );

                                          _shouldSetState = true;
                                          if ((_model.postCBGEntry?.succeeded ??
                                              true)) {
                                            _model.cbgObservations2 =
                                                await GetCBGObservationsByIDForPatientCall
                                                    .call(
                                              token:
                                                  FFAppState().fhirBearerToken,
                                              id: widget
                                                  .patientDetails?.identifier,
                                            );

                                            _shouldSetState = true;
                                            if ((_model.cbgObservations2
                                                    ?.succeeded ??
                                                true)) {
                                              _model.tidChartEntries = functions
                                                  .parseFhirTidChartEntries(
                                                      GetCBGObservationsByIDForPatientCall
                                                              .entries(
                                                    (_model.cbgObservations2
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!
                                                          .toList())
                                                  .toList()
                                                  .cast<TidChartEntryStruct>();
                                              _model.showInsulinEntryForm =
                                                  false;
                                              _model.showCBGEntryForm = false;
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model.nurseNotesTextController
                                                    ?.clear();
                                                _model.cbgTextController
                                                    ?.clear();
                                              });
                                              safeSetState(() {
                                                _model
                                                    .feedStatusCCValueController
                                                    ?.reset();
                                              });
                                            }
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text((_model
                                                          .postCBGEntry
                                                          ?.bodyText ??
                                                      '')),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }

                                          if (_shouldSetState)
                                            safeSetState(() {});
                                        },
                                      ),
                                    ]
                                        .divide(SizedBox(width: 20.0))
                                        .around(SizedBox(width: 20.0)),
                                  ),
                                if (_model.showInsulinEntryForm)
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Container(
                                          width: 350.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFBFFFFFF),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4.0,
                                                color: Color(0x33000000),
                                                offset: Offset(
                                                  2.0,
                                                  2.0,
                                                ),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                  borderRadius: 20.0,
                                                  buttonSize: 40.0,
                                                  hoverColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                  hoverIconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                  hoverBorderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                  icon: Icon(
                                                    Icons.repeat_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    size: 24.0,
                                                  ),
                                                  onPressed: () {
                                                    print(
                                                        'RepeatRequestIB pressed ...');
                                                  },
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.auto_awesome_sharp,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      size: 40.0,
                                                    ),
                                                    GradientText(
                                                      'SIGMA AI SUGGESTS',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                              ),
                                                      colors: [
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tertiary,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                      ],
                                                      gradientDirection:
                                                          GradientDirection.ltr,
                                                      gradientType:
                                                          GradientType.linear,
                                                    ),
                                                    AlignedTooltip(
                                                      content: Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'Message',
                                                          style: TextStyle(),
                                                        ),
                                                      ),
                                                      offset: 4.0,
                                                      preferredDirection:
                                                          AxisDirection.up,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      elevation: 4.0,
                                                      tailBaseWidth: 24.0,
                                                      tailLength: 12.0,
                                                      waitDuration: Duration(
                                                          milliseconds: 100),
                                                      showDuration: Duration(
                                                          milliseconds: 1500),
                                                      triggerMode:
                                                          TooltipTriggerMode
                                                              .tap,
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .infoCircle,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 30.0,
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 10.0)),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'SAI NAME',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'SAI DOSE',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(width: 20.0))
                                                      .addToStart(SizedBox(
                                                          width: 10.0)),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'LAI NAME',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'LAI DOSE',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(width: 20.0))
                                                      .addToStart(SizedBox(
                                                          width: 10.0)),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    FlutterFlowIconButton(
                                                      borderRadius: 8.0,
                                                      buttonSize: 40.0,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      icon: Icon(
                                                        Icons.thumb_up_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        size: 24.0,
                                                      ),
                                                      onPressed: () {
                                                        print(
                                                            'IconButton pressed ...');
                                                      },
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .success,
                                                      size: 30.0,
                                                    ).animateOnActionTrigger(
                                                        animationsMap[
                                                            'iconOnActionTriggerAnimation']!,
                                                        hasBeenTriggered:
                                                            hasIconTriggered),
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      borderRadius: 20.0,
                                                      buttonSize: 40.0,
                                                      hoverColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      hoverIconColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      hoverBorderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      icon: Icon(
                                                        Icons.delete_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        size: 24.0,
                                                      ),
                                                      onPressed: () {
                                                        print(
                                                            'IconButton pressed ...');
                                                      },
                                                    ),
                                                    AlignedTooltip(
                                                      content: Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'Warning: Some rows are missing; Prediction might not be accurate..!!',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                      offset: 4.0,
                                                      preferredDirection:
                                                          AxisDirection.up,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      elevation: 4.0,
                                                      tailBaseWidth: 24.0,
                                                      tailLength: 12.0,
                                                      waitDuration: Duration(
                                                          milliseconds: 100),
                                                      showDuration: Duration(
                                                          milliseconds: 1500),
                                                      triggerMode:
                                                          TooltipTriggerMode
                                                              .tap,
                                                      child: Icon(
                                                        Icons.warning_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        size: 30.0,
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 10.0)),
                                                ),
                                              ].divide(SizedBox(height: 6.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Form(
                                        key: _model.formKey1,
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .sAINameValueController ??=
                                                      FormFieldController<
                                                          String>(null),
                                                  options: [
                                                    'Actrapid',
                                                    'Novorapid',
                                                    'Apidra'
                                                  ],
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                          .sAINameValue = val),
                                                  width: 200.0,
                                                  height: 40.0,
                                                  searchHintTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                  searchTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
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
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
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
                                                  hintText:
                                                      'Short Acting Insulin...',
                                                  searchHintText:
                                                      'Search Insulins...',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  focusBorderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  borderWidth: 2.0,
                                                  borderRadius: 10.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  hidesUnderline: true,
                                                  isOverButton: false,
                                                  isSearchable: true,
                                                  isMultiSelect: false,
                                                ),
                                                Container(
                                                  width: 100.0,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .sAIDoseTextController,
                                                    focusNode:
                                                        _model.sAIDoseFocusNode,
                                                    autofocus: false,
                                                    enabled: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintText: 'Dose',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
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
                                                    maxLength: 3,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .enforced,
                                                    buildCounter: (context,
                                                            {required currentLength,
                                                            required isFocused,
                                                            maxLength}) =>
                                                        null,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    enableInteractiveSelection:
                                                        true,
                                                    validator: _model
                                                        .sAIDoseTextControllerValidator
                                                        .asValidator(context),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]'))
                                                    ],
                                                  ),
                                                ),
                                              ]
                                                  .divide(SizedBox(width: 20.0))
                                                  .around(
                                                      SizedBox(width: 20.0)),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .lAINameValueController ??=
                                                      FormFieldController<
                                                          String>(null),
                                                  options: [
                                                    'Mixtard 30/70',
                                                    'Novomix 30',
                                                    'Huminisulin 30/70'
                                                  ],
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                          .lAINameValue = val),
                                                  width: 200.0,
                                                  height: 40.0,
                                                  searchHintTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                  searchTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
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
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
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
                                                  hintText:
                                                      'Long Acting/Premixed Insulin...',
                                                  searchHintText:
                                                      'Search Insulins...',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  focusBorderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  borderWidth: 2.0,
                                                  borderRadius: 10.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  hidesUnderline: true,
                                                  isOverButton: false,
                                                  isSearchable: true,
                                                  isMultiSelect: false,
                                                ),
                                                Container(
                                                  width: 100.0,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .lAIDoseTextController,
                                                    focusNode:
                                                        _model.lAIDoseFocusNode,
                                                    autofocus: false,
                                                    enabled: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintText: 'Dose',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
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
                                                    maxLength: 3,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .enforced,
                                                    buildCounter: (context,
                                                            {required currentLength,
                                                            required isFocused,
                                                            maxLength}) =>
                                                        null,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    enableInteractiveSelection:
                                                        true,
                                                    validator: _model
                                                        .lAIDoseTextControllerValidator
                                                        .asValidator(context),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]'))
                                                    ],
                                                  ),
                                                ),
                                              ]
                                                  .divide(SizedBox(width: 20.0))
                                                  .around(
                                                      SizedBox(width: 20.0)),
                                            ),
                                          ]
                                              .divide(SizedBox(height: 20.0))
                                              .around(SizedBox(height: 20.0)),
                                        ),
                                      ),
                                      Container(
                                        width: 240.0,
                                        child: TextFormField(
                                          controller:
                                              _model.doctorNotesTextController,
                                          focusNode:
                                              _model.doctorNotesFocusNode,
                                          autofocus: false,
                                          enabled: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                            hintText: 'Doctor Notes',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                          ),
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
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          enableInteractiveSelection: true,
                                          validator: _model
                                              .doctorNotesTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        borderRadius: 20.0,
                                        buttonSize: 40.0,
                                        hoverColor: FlutterFlowTheme.of(context)
                                            .primary,
                                        hoverIconColor:
                                            FlutterFlowTheme.of(context).info,
                                        hoverBorderColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        icon: FaIcon(
                                          FontAwesomeIcons.syringe,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                        showLoadingIndicator: true,
                                        onPressed: () async {
                                          if (_model.formKey1.currentState ==
                                                  null ||
                                              !_model.formKey1.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                          if (_model.sAINameValue == null) {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text(
                                                      'Short Acting Insulin must be selected..!!'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            return;
                                          }
                                          if (_model.lAINameValue == null) {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text(
                                                      'Long Acting Insulin must be selected..!!'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            return;
                                          }
                                          _model.postInsulinEntry =
                                              await BundlePOSTTIDInsulinAdviceCall
                                                  .call(
                                            token: FFAppState().fhirBearerToken,
                                            buildJsonJson: functions.createInsulinAdviceBundleJson(
                                                widget
                                                    .patientDetails!.identifier,
                                                widget.encounter!.encounterID,
                                                dateTimeFormat("y-MM-dd",
                                                    _model.selectedDate),
                                                _model.selectedTimespot!,
                                                _model.tidChartEntries
                                                    .where((e) =>
                                                        (dateTimeFormat("d/M/y", e.date) ==
                                                            dateTimeFormat(
                                                                "d/M/y",
                                                                _model
                                                                    .selectedDate)) &&
                                                        (e.timespot ==
                                                            ((_model.selectedTimespot!)
                                                                .toUpperCase())))
                                                    .toList()
                                                    .firstOrNull!
                                                    .observationId,
                                                functions.getRandomStringFromList(
                                                    FFAppState()
                                                        .practitioners
                                                        .map((e) => e.id)
                                                        .toList()),
                                                'Display Doctor',
                                                functions.datetimeToISO8601String(
                                                    _model.selectedDate)!,
                                                _model.sAINameValue!,
                                                int.parse(_model
                                                    .sAIDoseTextController
                                                    .text),
                                                _model.lAINameValue!,
                                                int.parse(_model.lAIDoseTextController.text),
                                                _model.doctorNotesTextController.text),
                                          );

                                          if ((_model.postInsulinEntry
                                                  ?.succeeded ??
                                              true)) {
                                            _model.insulinAdvice2 =
                                                await GetAllInsulinAdviceByIDForPatientCall
                                                    .call(
                                              token:
                                                  FFAppState().fhirBearerToken,
                                              id: widget
                                                  .patientDetails?.identifier,
                                            );

                                            if ((_model.insulinAdvice2
                                                    ?.succeeded ??
                                                true)) {
                                              _model.insulinAdviceList =
                                                  functions
                                                      .parseFhirInsulinAdviceEntries(
                                                          GetAllInsulinAdviceByIDForPatientCall
                                                              .entries(
                                                        (_model.insulinAdvice2
                                                                ?.jsonBody ??
                                                            ''),
                                                      )?.toList())
                                                      .toList()
                                                      .cast<
                                                          InsulinAdviceStruct>();
                                              _model.showCBGEntryForm = false;
                                              _model.showInsulinEntryForm =
                                                  false;
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model.lAIDoseTextController
                                                    ?.clear();
                                                _model.sAIDoseTextController
                                                    ?.clear();
                                                _model.doctorNotesTextController
                                                    ?.clear();
                                              });
                                              safeSetState(() {
                                                _model.sAINameValueController
                                                    ?.reset();
                                                _model.sAINameValue = null;
                                                _model.lAINameValueController
                                                    ?.reset();
                                                _model.lAINameValue = null;
                                              });
                                            }
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text((_model
                                                          .postInsulinEntry
                                                          ?.bodyText ??
                                                      '')),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }

                                          safeSetState(() {});
                                        },
                                      ),
                                    ]
                                        .divide(SizedBox(width: 20.0))
                                        .around(SizedBox(width: 20.0)),
                                  ),
                              ]
                                  .divide(SizedBox(height: 10.0))
                                  .around(SizedBox(height: 10.0)),
                            ),
                          );
                        } else {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.emptyWidgetModel,
                                updateCallback: () => safeSetState(() {}),
                                child: EmptyWidgetWidget(),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ].divide(SizedBox(height: 30.0)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
          child: wrapWithModel(
            model: _model.closeComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: CloseComponentWidget(),
          ),
        ),
      ],
    );
  }
}
