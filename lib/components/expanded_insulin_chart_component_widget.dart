import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/close_component/close_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
      safeSetState(() {});
      _model.allObservations = await GetAllObservationsByIDForPatientCall.call(
        token: FFAppState().fhirBearerToken,
        id: widget.patientDetails?.identifier,
      );

      if ((_model.allObservations?.succeeded ?? true)) {
        _model.insChartObservations = functions
            .parseFhirObservations(GetAllObservationsByIDForPatientCall.entries(
              (_model.allObservations?.jsonBody ?? ''),
            )!
                .toList())
            .toList()
            .cast<ObservationStruct>();
        safeSetState(() {});
      }
      _model.hideEverything = false;
      safeSetState(() {});
    });

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        loop: true,
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
    });

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
          child: Visibility(
            visible: !_model.hideEverything,
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
                                color: FlutterFlowTheme.of(context).cardBlue,
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.idCard,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              size: 22.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text(
                                                ' PATIENT  INFO',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .headlineMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
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
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.person_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 25.0,
                                            ),
                                            Expanded(
                                              child: SelectionArea(
                                                  child:
                                                      AnimatedDefaultTextStyle(
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
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
                                                duration:
                                                    Duration(milliseconds: 800),
                                                curve: Curves.easeInOut,
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    widget.patientDetails
                                                        ?.combinedNames,
                                                    'FIRST NAME LAST NAME',
                                                  ),
                                                ),
                                              )),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.idCard,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 25.0,
                                          ),
                                          Expanded(
                                            child: SelectionArea(
                                                child: AnimatedDefaultTextStyle(
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font: GoogleFonts.readexPro(
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
                                              duration:
                                                  Duration(milliseconds: 800),
                                              curve: Curves.easeInOut,
                                              child: Text(
                                                valueOrDefault<String>(
                                                  widget.patientDetails
                                                      ?.identifier,
                                                  'ID',
                                                ),
                                              ),
                                            )),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.calendar_month_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 25.0,
                                          ),
                                          Expanded(
                                            child: SelectionArea(
                                                child: AnimatedDefaultTextStyle(
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font: GoogleFonts.readexPro(
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
                                              duration:
                                                  Duration(milliseconds: 800),
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
                                                padding: EdgeInsets.all(4.0),
                                                child: Text(
                                                  '',
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                              preferredDirection:
                                                  AxisDirection.up,
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
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: Icon(
                                                Icons
                                                    .medical_information_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 25.0,
                                              ),
                                            ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.stethoscope,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 25.0,
                                          ),
                                          Expanded(
                                            child: SelectionArea(
                                                child: AnimatedDefaultTextStyle(
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font: GoogleFonts.readexPro(
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
                                              duration:
                                                  Duration(milliseconds: 800),
                                              curve: Curves.easeInOut,
                                              child: Text(
                                                valueOrDefault<String>(
                                                  widget
                                                      .encounter?.admittedUnder,
                                                  'Consultant',
                                                ),
                                              ),
                                            )),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
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
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.business_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 25.0,
                                            ),
                                            Expanded(
                                              child: SelectionArea(
                                                  child:
                                                      AnimatedDefaultTextStyle(
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
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
                                                duration:
                                                    Duration(milliseconds: 800),
                                                curve: Curves.easeInOut,
                                                child: Text(
                                                  'BLOCK NAME',
                                                ),
                                              )),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.house_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 25.0,
                                          ),
                                          Expanded(
                                            child: SelectionArea(
                                                child: AnimatedDefaultTextStyle(
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font: GoogleFonts.readexPro(
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
                                              duration:
                                                  Duration(milliseconds: 800),
                                              curve: Curves.easeInOut,
                                              child: Text(
                                                valueOrDefault<String>(
                                                  widget.encounter?.wardName,
                                                  'Ward',
                                                ),
                                              ),
                                            )),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
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
                                color: FlutterFlowTheme.of(context).cardBlue,
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.laptopMedical,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 22.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              'MEDICAL INFO',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineMedium
                                                  .override(
                                                    font: GoogleFonts.readexPro(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
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
                                          Icons.perm_contact_cal_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 25.0,
                                        ),
                                        SelectionArea(
                                            child: AnimatedDefaultTextStyle(
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          duration: Duration(milliseconds: 800),
                                          curve: Curves.easeInOut,
                                          child: Text(
                                            '${functions.calculateAgeFromDOB(functions.convertSingleDateStringtoDateTime(widget.patientDetails?.birthDate)!).toString()}/${(String gender) {
                                              return gender[0].toUpperCase();
                                            }(widget.patientDetails!.gender)}',
                                          ),
                                        )),
                                        Builder(
                                          builder: (context) {
                                            if (true) {
                                              return Icon(
                                                Icons.male_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 25.0,
                                              );
                                            } else if (true) {
                                              return Icon(
                                                Icons.female_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                size: 25.0,
                                              );
                                            } else {
                                              return Icon(
                                                Icons.transgender_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                              padding: EdgeInsets.all(4.0),
                                              child: Text(
                                                'HbA1c %',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                            preferredDirection:
                                                AxisDirection.up,
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
                                              FontAwesomeIcons.vial,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 25.0,
                                            ),
                                          ),
                                        ),
                                        SelectionArea(
                                            child: AnimatedDefaultTextStyle(
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          duration: Duration(milliseconds: 800),
                                          curve: Curves.easeInOut,
                                          child: Text(
                                            valueOrDefault<String>(
                                              '${valueOrDefault<String>(
                                                _model.insChartObservations
                                                    .where(
                                                        (e) => (String name) {
                                                              return name
                                                                      .toLowerCase()
                                                                      .trim() ==
                                                                  'hba1c';
                                                            }(e.name))
                                                    .toList()
                                                    .sortedList(
                                                        keyOf: (e) =>
                                                            e.recordedAt!,
                                                        desc: true)
                                                    .firstOrNull
                                                    ?.value,
                                                'a1c',
                                              )} %',
                                              'a1c',
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
                                              padding: EdgeInsets.all(4.0),
                                              child: Text(
                                                'Message...',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                            preferredDirection:
                                                AxisDirection.up,
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
                                              Icons.assignment_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 25.0,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Builder(
                                            builder: (context) {
                                              if (true) {
                                                return Icon(
                                                  Icons.do_disturb_alt_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  size: 30.0,
                                                );
                                              } else {
                                                return SelectionArea(
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
                                                    'DIAB TYPE',
                                                  ),
                                                ));
                                              }
                                            },
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 25.0,
                                          ),
                                          Flexible(
                                            child: SelectionArea(
                                                child: AnimatedDefaultTextStyle(
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font: GoogleFonts.readexPro(
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
                                              duration:
                                                  Duration(milliseconds: 800),
                                              curve: Curves.easeInOut,
                                              child: Text(
                                                'DURATION Y',
                                              ),
                                            )),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.man_3_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                                      font:
                                                          GoogleFonts.readexPro(
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
                                                duration:
                                                    Duration(milliseconds: 800),
                                                curve: Curves.easeInOut,
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    '${(double.parse(_model.insChartObservations.where((e) => (String name) {
                                                          return name
                                                                  .toLowerCase()
                                                                  .trim() ==
                                                              'body height';
                                                        }(e.name)).toList().firstOrNull!.value).round()).toString()} cm',
                                                    'Ht. cm',
                                                  ),
                                                ),
                                              )),
                                            ].divide(SizedBox(width: 2.0)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.weight,
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                                      font:
                                                          GoogleFonts.readexPro(
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
                                                duration:
                                                    Duration(milliseconds: 800),
                                                curve: Curves.easeInOut,
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    '${(double.parse(_model.insChartObservations.where((e) => (String name) {
                                                          return name
                                                                  .toLowerCase()
                                                                  .trim() ==
                                                              'body weight';
                                                        }(e.name)).toList().firstOrNull!.value).round()).toString()} kg',
                                                    'Wt. kg',
                                                  ),
                                                ),
                                              )),
                                            ].divide(SizedBox(width: 4.0)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.ruler,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 22.0,
                                              ),
                                              SelectionArea(
                                                  child:
                                                      AnimatedDefaultTextStyle(
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
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
                                                duration:
                                                    Duration(milliseconds: 800),
                                                curve: Curves.easeInOut,
                                                child: Text(
                                                  'BMI',
                                                ),
                                              )),
                                            ].divide(SizedBox(width: 4.0)),
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
                                color: FlutterFlowTheme.of(context).cardBlue,
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        width: double.infinity,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.syringe,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                size: 20.0,
                                              ),
                                              Text(
                                                'INSULIN',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .headlineMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ].divide(SizedBox(width: 10.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SelectionArea(
                                            child: AnimatedDefaultTextStyle(
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          duration: Duration(milliseconds: 800),
                                          curve: Curves.easeInOut,
                                          child: Text(
                                            'Insulin 1 Name',
                                          ),
                                        )),
                                        SelectionArea(
                                            child: AnimatedDefaultTextStyle(
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          duration: Duration(milliseconds: 800),
                                          curve: Curves.easeInOut,
                                          child: Text(
                                            'M - A - N',
                                          ),
                                        )),
                                      ].divide(SizedBox(height: 6.0)),
                                    ),
                                    SizedBox(
                                      width: 200.0,
                                      child: Divider(
                                        thickness: 2.0,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SelectionArea(
                                            child: AnimatedDefaultTextStyle(
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          duration: Duration(milliseconds: 800),
                                          curve: Curves.easeInOut,
                                          child: Text(
                                            'Insulin 2 Name',
                                          ),
                                        )),
                                        SelectionArea(
                                            child: AnimatedDefaultTextStyle(
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          duration: Duration(milliseconds: 800),
                                          curve: Curves.easeInOut,
                                          child: Text(
                                            'M - A - N',
                                          ),
                                        )),
                                      ].divide(SizedBox(height: 6.0)),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.pills,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 22.0,
                                          ),
                                          Text(
                                            'OHA DETAILS',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  font: GoogleFonts.readexPro(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                    AlignedTooltip(
                                      content: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          'Message...',
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
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      offset: 4.0,
                                      preferredDirection: AxisDirection.up,
                                      borderRadius: BorderRadius.circular(8.0),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      elevation: 4.0,
                                      tailBaseWidth: 24.0,
                                      tailLength: 12.0,
                                      waitDuration: Duration(milliseconds: 100),
                                      showDuration:
                                          Duration(milliseconds: 1500),
                                      triggerMode: TooltipTriggerMode.tap,
                                      child: SelectionArea(
                                          child: AnimatedDefaultTextStyle(
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        duration: Duration(milliseconds: 800),
                                        curve: Curves.easeInOut,
                                        child: Text(
                                          'OHA Details Drug Names',
                                        ),
                                      )),
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
                                color: FlutterFlowTheme.of(context).cardBlue,
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.clipboardList,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 22.0,
                                          ),
                                          Text(
                                            'DIAGNOSIS',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  font: GoogleFonts.readexPro(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Builder(
                                        builder: (context) {
                                          if (widget.conditions != null &&
                                              (widget.conditions)!
                                                  .isNotEmpty) {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final conditions = widget
                                                      .conditions!
                                                      .sortedList(
                                                          keyOf: (e) =>
                                                              e.onsetDate!,
                                                          desc: false)
                                                      .toList();

                                                  return ListView.separated(
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        conditions.length,
                                                    separatorBuilder: (_, __) =>
                                                        SizedBox(height: 4.0),
                                                    itemBuilder: (context,
                                                        conditionsIndex) {
                                                      final conditionsItem =
                                                          conditions[
                                                              conditionsIndex];
                                                      return RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                (conditionsIndex +
                                                                        1)
                                                                    .toString(),
                                                                '1',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text: ') ',
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                conditionsItem
                                                                    .conditionName,
                                                                'Diagnosis',
                                                              ),
                                                              style:
                                                                  TextStyle(),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
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
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              'NO DIAGNOSIS ENTERED YET',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleLarge
                                                  .override(
                                                    font: GoogleFonts.readexPro(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
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
                          if (_model.isLoading)
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.refresh_rounded,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  size: 24.0,
                                ).animateOnPageLoad(
                                    animationsMap['iconOnPageLoadAnimation']!),
                                Text(
                                  'Loading Please Wait..!!',
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(SizedBox(height: 0.0)),
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          width: double.infinity,
                          height: 580.0,
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 40.0),
                                child: PageView(
                                  controller: _model.pageViewController ??=
                                      PageController(initialPage: 0),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '01-01-2000',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleLarge
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.black,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final timeSpot =
                                                        FFAppConstants.timespots
                                                            .toList()
                                                            .take(3)
                                                            .toList();

                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: List.generate(
                                                          timeSpot.length,
                                                          (timeSpotIndex) {
                                                        final timeSpotItem =
                                                            timeSpot[
                                                                timeSpotIndex];
                                                        return Expanded(
                                                          flex: 1,
                                                          child: Stack(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 1.0),
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .cardBlue,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(10.0),
                                                                        topRight:
                                                                            Radius.circular(10.0),
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              16.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          timeSpotItem
                                                                              .toUpperCase(),
                                                                          'MORNING',
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Builder(
                                                                    builder:
                                                                        (context) {
                                                                      if (_model
                                                                          .insChartObservations
                                                                          .isNotEmpty) {
                                                                        return Stack(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0),
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
                                                                                    onPressed: () {
                                                                                      print('AddCBGIB pressed ...');
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
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
                                                                          ],
                                                                        );
                                                                      } else {
                                                                        return Stack(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0),
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
                                                                                  color: FlutterFlowTheme.of(context).primary,
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
                                                                                        color: FlutterFlowTheme.of(context).accent2,
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
                                                                                              'FEED STATUS',
                                                                                              textAlign: TextAlign.start,
                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primary,
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
                                                                                        color: FlutterFlowTheme.of(context).accent2,
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
                                                                                              'STEROIDS',
                                                                                              textAlign: TextAlign.start,
                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primary,
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
                                                                                        color: FlutterFlowTheme.of(context).accent2,
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
                                                                                              'INOTROPES',
                                                                                              textAlign: TextAlign.start,
                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primary,
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
                                                                                        color: FlutterFlowTheme.of(context).accent2,
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
                                                                                              'NO INFUSION',
                                                                                              textAlign: TextAlign.start,
                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primary,
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
                                                                                        color: FlutterFlowTheme.of(context).accent2,
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
                                                                                              'Creatinine',
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
                                                                                        color: FlutterFlowTheme.of(context).accent2,
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
                                                                                              'CBG',
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
                                                                                        color: FlutterFlowTheme.of(context).accent2,
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
                                                                                              'SAI NAME',
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
                                                                                              'SAI DOSE',
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
                                                                                              if (true) {
                                                                                                return FaIcon(
                                                                                                  FontAwesomeIcons.syringe,
                                                                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                                                                  size: 24.0,
                                                                                                );
                                                                                              } else if (true) {
                                                                                                return Icon(
                                                                                                  Icons.check_circle_rounded,
                                                                                                  color: FlutterFlowTheme.of(context).success,
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
                                                                                        color: FlutterFlowTheme.of(context).accent2,
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
                                                                                              'LAI NAME',
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
                                                                                              'LAI DOSE',
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
                                                                                              if (true) {
                                                                                                return FaIcon(
                                                                                                  FontAwesomeIcons.syringe,
                                                                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                                                                  size: 24.0,
                                                                                                );
                                                                                              } else if (true) {
                                                                                                return Icon(
                                                                                                  Icons.check_circle_rounded,
                                                                                                  color: FlutterFlowTheme.of(context).success,
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
                                                                                                      child: Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: [
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
                                                                                                                    content: Text('...'),
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
                                                                                                          Text(
                                                                                                            '...',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                          Builder(
                                                                                                            builder: (context) {
                                                                                                              if (true) {
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
                                                                                                                return FlutterFlowIconButton(
                                                                                                                  borderRadius: 20.0,
                                                                                                                  borderWidth: 1.0,
                                                                                                                  buttonSize: 40.0,
                                                                                                                  fillColor: FlutterFlowTheme.of(context).error,
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
                                                                                                          Text(
                                                                                                            '...',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
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
                                                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        border: Border.all(
                                                                                          color: FlutterFlowTheme.of(context).tertiary,
                                                                                        ),
                                                                                      ),
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(4.0),
                                                                                        child: SingleChildScrollView(
                                                                                          scrollDirection: Axis.horizontal,
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
                                                                                              Icon(
                                                                                                Icons.phone_in_talk,
                                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                                size: 24.0,
                                                                                              ),
                                                                                              Icon(
                                                                                                Icons.mode_edit_rounded,
                                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                                size: 24.0,
                                                                                              ),
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
                                                                                                      onPressed: () {
                                                                                                        print('FollowedIB pressed ...');
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
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
                                                                                                      onPressed: () {
                                                                                                        print('enterInsulinIB pressed ...');
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
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
                                                          width: 10.0)),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child:
                                      smooth_page_indicator.SmoothPageIndicator(
                                    controller: _model.pageViewController ??=
                                        PageController(initialPage: 0),
                                    count: 1,
                                    axisDirection: Axis.horizontal,
                                    onDotClicked: (i) async {
                                      await _model.pageViewController!
                                          .animateToPage(
                                        i,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                      safeSetState(() {});
                                    },
                                    effect: smooth_page_indicator.SlideEffect(
                                      spacing: 8.0,
                                      radius: 8.0,
                                      dotWidth: 8.0,
                                      dotHeight: 8.0,
                                      dotColor:
                                          FlutterFlowTheme.of(context).accent1,
                                      activeDotColor:
                                          FlutterFlowTheme.of(context).primary,
                                      paintStyle: PaintingStyle.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
