import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_dot_component_page_view_widget.dart';
import '/components/custom_table_header_component_widget.dart';
import '/components/empty_widget_widget.dart';
import '/components/fire_component_widget.dart';
import '/components/menu_items_component_widget.dart';
import '/components/patient_table_row_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:math' as math;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/home';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setDarkModeSetting(context, ThemeMode.light);
      _model.allPatientsQuery1 = await GetAllPatientsCall.call(
        token: FFAppState().fhirBearerToken,
      );

      if ((_model.allPatientsQuery1?.succeeded ?? true)) {
        _model.allPatients = functions
            .parseFhirPatients(
                GetAllPatientsCall.entries(
                  (_model.allPatientsQuery1?.jsonBody ?? ''),
                )?.toList(),
                functions
                    .convertDateStringListtoDateTimeList(
                        GetAllPatientsCall.lastUpdated(
                      (_model.allPatientsQuery1?.jsonBody ?? ''),
                    )?.toList())
                    .toList())!
            .toList()
            .cast<PatientStruct>();
        _model.sortedAllPatients = functions
            .parseFhirPatients(
                GetAllPatientsCall.entries(
                  (_model.allPatientsQuery1?.jsonBody ?? ''),
                )?.toList(),
                functions
                    .convertDateStringListtoDateTimeList(
                        GetAllPatientsCall.lastUpdated(
                      (_model.allPatientsQuery1?.jsonBody ?? ''),
                    )?.toList())
                    .toList())!
            .sortedList(keyOf: (e) => e.combinedNames, desc: false)
            .toList()
            .cast<PatientStruct>();
        _model.selectedDob = null;
        _model.patientSelectedForEdit = null;
        _model.patientMode = PatientMode.create;
        _model.showPatients = true;
        _model.showSearch = false;
        _model.showCreateEditPatient = false;
        _model.showActivity = false;
        _model.showSettings = false;
        _model.displaySimpleSearchPatients = false;
        safeSetState(() {});
      }
    });

    _model.searchNameTextController ??= TextEditingController();
    _model.searchNameFocusNode ??= FocusNode();

    _model.firstNameTextController ??= TextEditingController();
    _model.firstNameFocusNode ??= FocusNode();

    _model.lastNameTextController ??= TextEditingController();
    _model.lastNameFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            color: FlutterFlowTheme.of(context).success,
            angle: 0.524,
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
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      drawer: Drawer(
        elevation: 16.0,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional(0.0, -1.0),
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 78.0),
                    child: Container(
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            desktop: false,
                          ))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: Transform.rotate(
                                angle: 180.0 * (math.pi / 180),
                                child: FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 40.0,
                                  icon: Icon(
                                    Icons.menu_open_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24.0,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ),
                            ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional(1.0, -1.0),
                                children: [
                                  Container(
                                    width: 90.0,
                                    height: 90.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/GLYZEMIA_LOGO_JPG.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'GLYZEMIA - FHIR CHALLENGE',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context).info,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                              ),
                              wrapWithModel(
                                model: _model.fireComponentModel,
                                updateCallback: () => safeSetState(() {}),
                                child: FireComponentWidget(),
                              ),
                            ].divide(SizedBox(width: 20.0)),
                          ),
                          if (responsiveVisibility(
                            context: context,
                            desktop: false,
                          ))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                icon: Icon(
                                  Icons.menu_open_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 110.0, 0.0, 0.0),
                    child: Container(
                      height: 850.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 835.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.patientsModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemsComponentWidget(
                                            isSelected: _model.showPatients ||
                                                (_model.patientMode ==
                                                    PatientMode.edit),
                                            text: 'Patients',
                                            icon: Icon(
                                              Icons.people,
                                              color: _model.showPatients
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: _model.showPatients ||
                                                      (_model.patientMode ==
                                                          PatientMode.edit)
                                                  ? 26.0
                                                  : 24.0,
                                            ),
                                            onClick: () async {
                                              _model.showPatients = true;
                                              _model.showSearch = false;
                                              _model.showCreateEditPatient =
                                                  false;
                                              _model.showActivity = false;
                                              _model.showSettings = false;
                                              _model.displaySimpleSearchPatients =
                                                  false;
                                              _model.displayFHIRSearchPatients =
                                                  false;
                                              _model.patientMode =
                                                  PatientMode.create;
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model.searchNameTextController
                                                    ?.clear();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.searchModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemsComponentWidget(
                                            isSelected: _model.showSearch,
                                            text: 'Search',
                                            icon: FaIcon(
                                              FontAwesomeIcons.search,
                                              color: _model.showSearch
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: _model.showSearch
                                                  ? 26.0
                                                  : 24.0,
                                            ),
                                            onClick: () async {
                                              _model.showPatients = false;
                                              _model.showSearch = true;
                                              _model.showCreateEditPatient =
                                                  false;
                                              _model.showActivity = false;
                                              _model.showSettings = false;
                                              _model.patientMode =
                                                  PatientMode.create;
                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.createPatientModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemsComponentWidget(
                                            isSelected:
                                                _model.showCreateEditPatient,
                                            text: 'Create Patient',
                                            icon: Icon(
                                              Icons.person_add_alt_rounded,
                                              color: _model
                                                      .showCreateEditPatient
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: _model.showCreateEditPatient
                                                  ? 26.0
                                                  : 24.0,
                                            ),
                                            onClick: () async {
                                              safeSetState(() {
                                                _model.firstNameTextController
                                                    ?.clear();
                                                _model.lastNameTextController
                                                    ?.clear();
                                                _model.phoneNumberTextController
                                                    ?.clear();
                                              });
                                              safeSetState(() {
                                                _model.genderCCValueController
                                                    ?.reset();
                                              });
                                              _model.selectedDob = null;
                                              safeSetState(() {});
                                              _model.showPatients = false;
                                              _model.showSearch = false;
                                              _model.showCreateEditPatient =
                                                  true;
                                              _model.showActivity = false;
                                              _model.showSettings = false;
                                              _model.patientMode =
                                                  PatientMode.create;
                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.activityModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemsComponentWidget(
                                            isSelected: _model.showActivity,
                                            text: 'Activity',
                                            icon: Icon(
                                              Icons.access_time_rounded,
                                              color: _model.showActivity
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: _model.showActivity
                                                  ? 26.0
                                                  : 24.0,
                                            ),
                                            onClick: () async {
                                              _model.showPatients = false;
                                              _model.showSearch = false;
                                              _model.showCreateEditPatient =
                                                  false;
                                              _model.showActivity = true;
                                              _model.showSettings = false;
                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.settingsModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemsComponentWidget(
                                            isSelected: _model.showSettings,
                                            text: 'Settings',
                                            icon: Icon(
                                              Icons.settings_rounded,
                                              color: _model.showSettings
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: _model.showSettings
                                                  ? 26.0
                                                  : 24.0,
                                            ),
                                            onClick: () async {
                                              _model.showPatients = false;
                                              _model.showSearch = false;
                                              _model.showCreateEditPatient =
                                                  false;
                                              _model.showActivity = false;
                                              _model.showSettings = true;
                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(height: 20.0))
                                        .around(SizedBox(height: 20.0)),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (_model.showPatients ||
                                            _model.showSearch)
                                          Container(
                                            height: 835.0,
                                            decoration: BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _model.showSearch
                                                                ? 'Search Patients'
                                                                : 'Patients',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLarge
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                _model.showSearch
                                                                    ? 'Find Patients on FHIR Server by typing all or part of a name.'
                                                                    : 'List of patients on the FHIR Server.',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
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
                                                              ),
                                                              Expanded(
                                                                child: RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: _model.showSearch &&
                                                                                (_model.searchNameTextController.text != '')
                                                                            ? 'Found '
                                                                            : 'Total ',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: _model.showSearch &&
                                                                                (_model.searchNameTextController.text != '')
                                                                            ? _model.simpleSearchResults.length.toString()
                                                                            : _model.allPatients.length.toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            ' Patients ',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      )
                                                                    ],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 220.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 10.0)),
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        _model.allPatientsQuery2 =
                                                            await GetAllPatientsCall
                                                                .call(
                                                          token: FFAppState()
                                                              .fhirBearerToken,
                                                        );

                                                        if ((_model
                                                                .allPatientsQuery2
                                                                ?.succeeded ??
                                                            true)) {
                                                          _model.allPatients = functions
                                                              .parseFhirPatients(
                                                                  GetAllPatientsCall.entries(
                                                                    (_model.allPatientsQuery2
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  )?.toList(),
                                                                  functions
                                                                      .convertDateStringListtoDateTimeList(GetAllPatientsCall.lastUpdated(
                                                                        (_model.allPatientsQuery2?.jsonBody ??
                                                                            ''),
                                                                      )?.toList())
                                                                      .toList())!
                                                              .toList()
                                                              .cast<PatientStruct>();
                                                          _model.sortedAllPatients =
                                                              functions
                                                                  .parseFhirPatients(
                                                                      GetAllPatientsCall
                                                                              .entries(
                                                                        (_model.allPatientsQuery2?.jsonBody ??
                                                                            ''),
                                                                      )
                                                                          ?.toList(),
                                                                      functions
                                                                          .convertDateStringListtoDateTimeList(GetAllPatientsCall
                                                                                  .lastUpdated(
                                                                            (_model.allPatientsQuery2?.jsonBody ??
                                                                                ''),
                                                                          )
                                                                              ?.toList())
                                                                          .toList())!
                                                                  .sortedList(
                                                                      keyOf: (e) => e
                                                                          .combinedNames,
                                                                      desc:
                                                                          false)
                                                                  .toList()
                                                                  .cast<
                                                                      PatientStruct>();
                                                          safeSetState(() {});
                                                        }
                                                        safeSetState(() {
                                                          _model
                                                              .searchNameTextController
                                                              ?.clear();
                                                        });
                                                        _model.displaySimpleSearchPatients =
                                                            false;
                                                        _model.displayFHIRSearchPatients =
                                                            false;
                                                        safeSetState(() {});

                                                        safeSetState(() {});
                                                      },
                                                      text: 'Refresh',
                                                      icon: Icon(
                                                        Icons.refresh_rounded,
                                                        size: 22.0,
                                                      ),
                                                      options: FFButtonOptions(
                                                        height: 50.0,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            Colors.transparent,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
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
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        hoverColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .cardBlue,
                                                        hoverBorderSide:
                                                            BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.0,
                                                        ),
                                                        hoverTextColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        _model.showPatients =
                                                            false;
                                                        _model.showSearch =
                                                            false;
                                                        _model.showCreateEditPatient =
                                                            true;
                                                        _model.showActivity =
                                                            false;
                                                        _model.showSettings =
                                                            false;
                                                        _model.patientMode =
                                                            PatientMode.create;
                                                        safeSetState(() {});
                                                        safeSetState(() {
                                                          _model
                                                              .firstNameTextController
                                                              ?.clear();
                                                          _model
                                                              .lastNameTextController
                                                              ?.clear();
                                                          _model
                                                              .phoneNumberTextController
                                                              ?.clear();
                                                        });
                                                        _model.selectedDob =
                                                            null;
                                                        safeSetState(() {});
                                                        safeSetState(() {
                                                          _model
                                                              .genderCCValueController
                                                              ?.reset();
                                                        });
                                                      },
                                                      text: 'Create Patient',
                                                      icon: Icon(
                                                        Icons.add_rounded,
                                                        size: 15.0,
                                                      ),
                                                      options: FFButtonOptions(
                                                        height: 50.0,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                      .white,
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
                                                        elevation: 0.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(width: 20.0))
                                                      .around(SizedBox(
                                                          width: 20.0)),
                                                ),
                                                if (_model.showSearch)
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      FlutterFlowRadioButton(
                                                        options: [
                                                          'FHIR Query',
                                                          'Simple Search'
                                                        ].toList(),
                                                        onChanged: (val) async {
                                                          safeSetState(() {});
                                                          safeSetState(() {
                                                            _model
                                                                .searchNameTextController
                                                                ?.clear();
                                                          });
                                                          _model.displaySimpleSearchPatients =
                                                              false;
                                                          safeSetState(() {});
                                                        },
                                                        controller: _model
                                                                .searchTypeValueController ??=
                                                            FormFieldController<
                                                                    String>(
                                                                'FHIR Query'),
                                                        optionHeight: 28.0,
                                                        textStyle:
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
                                                        selectedTextStyle:
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
                                                        buttonPosition:
                                                            RadioButtonPosition
                                                                .left,
                                                        direction:
                                                            Axis.vertical,
                                                        radioButtonColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        inactiveRadioButtonColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        toggleable: false,
                                                        horizontalAlignment:
                                                            WrapAlignment.start,
                                                        verticalAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: 50.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: TextFormField(
                                                            controller: _model
                                                                .searchNameTextController,
                                                            focusNode: _model
                                                                .searchNameFocusNode,
                                                            onChanged: (_) =>
                                                                EasyDebounce
                                                                    .debounce(
                                                              '_model.searchNameTextController',
                                                              Duration(
                                                                  milliseconds:
                                                                      200),
                                                              () async {
                                                                if (_model.searchNameTextController
                                                                            .text ==
                                                                        '') {
                                                                  _model.displaySimpleSearchPatients =
                                                                      false;
                                                                  _model.displayFHIRSearchPatients =
                                                                      false;
                                                                  _model.currentPatientPage =
                                                                      0;
                                                                  safeSetState(
                                                                      () {});
                                                                  await _model
                                                                      .pageViewController
                                                                      ?.animateToPage(
                                                                    0,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    curve: Curves
                                                                        .ease,
                                                                  );
                                                                } else {
                                                                  if (_model
                                                                          .searchTypeValue ==
                                                                      'Simple Search') {
                                                                    if (_model.searchNameTextController.text !=
                                                                            '') {
                                                                      safeSetState(
                                                                          () {
                                                                        _model
                                                                            .simpleSearchResults = TextSearch(
                                                                                (_model.sortedAllPatients.map((e) => e.combinedNames).toList() as List).cast<String>().map((str) => TextSearchItem.fromTerms(str, [str])).toList())
                                                                            .search(_model.searchNameTextController.text)
                                                                            .map((r) => r.object)
                                                                            .toList();
                                                                        ;
                                                                      });
                                                                      _model.displaySimpleSearchPatients =
                                                                          true;
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      _model.displaySimpleSearchPatients =
                                                                          false;
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  }
                                                                }
                                                              },
                                                            ),
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
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              hintText: _model
                                                                          .searchTypeValue ==
                                                                      'FHIR Query'
                                                                  ? 'Enter the Patient\'s Name and Click the Search Button.'
                                                                  : 'Enter the Patient\'s Name',
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
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
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
                                                                            8.0),
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
                                                                            8.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              prefixIcon: Icon(
                                                                FontAwesomeIcons
                                                                    .search,
                                                              ),
                                                              suffixIcon: _model
                                                                      .searchNameTextController!
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        _model
                                                                            .searchNameTextController
                                                                            ?.clear();
                                                                        if (_model.searchNameTextController.text ==
                                                                                '') {
                                                                          _model.displaySimpleSearchPatients =
                                                                              false;
                                                                          _model.displayFHIRSearchPatients =
                                                                              false;
                                                                          _model.currentPatientPage =
                                                                              0;
                                                                          safeSetState(
                                                                              () {});
                                                                          await _model
                                                                              .pageViewController
                                                                              ?.animateToPage(
                                                                            0,
                                                                            duration:
                                                                                Duration(milliseconds: 500),
                                                                            curve:
                                                                                Curves.ease,
                                                                          );
                                                                        } else {
                                                                          if (_model.searchTypeValue ==
                                                                              'Simple Search') {
                                                                            if (_model.searchNameTextController.text != '') {
                                                                              safeSetState(() {
                                                                                _model.simpleSearchResults = TextSearch((_model.sortedAllPatients.map((e) => e.combinedNames).toList() as List).cast<String>().map((str) => TextSearchItem.fromTerms(str, [str])).toList()).search(_model.searchNameTextController.text).map((r) => r.object).toList();
                                                                                ;
                                                                              });
                                                                              _model.displaySimpleSearchPatients = true;
                                                                              safeSetState(() {});
                                                                            } else {
                                                                              _model.displaySimpleSearchPatients = false;
                                                                              safeSetState(() {});
                                                                            }
                                                                          }
                                                                        }

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                    )
                                                                  : null,
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
                                                                .searchNameTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      if (_model
                                                              .searchTypeValue ==
                                                          'FHIR Query')
                                                        FlutterFlowIconButton(
                                                          borderRadius: 20.0,
                                                          borderWidth: 1.0,
                                                          buttonSize: 40.0,
                                                          hoverColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .cardBlue,
                                                          hoverIconColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          hoverBorderColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          icon: FaIcon(
                                                            FontAwesomeIcons
                                                                .search,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 24.0,
                                                          ),
                                                          showLoadingIndicator:
                                                              true,
                                                          onPressed: () async {
                                                            _model.fHIRSearchPatients =
                                                                await SearchPatientsCall
                                                                    .call(
                                                              token: FFAppState()
                                                                  .fhirBearerToken,
                                                              searchTerm: _model
                                                                  .searchNameTextController
                                                                  .text,
                                                            );

                                                            if ((_model
                                                                    .fHIRSearchPatients
                                                                    ?.succeeded ??
                                                                true)) {
                                                              _model.allFHIRSearchPatients = functions
                                                                  .parseFhirPatients(
                                                                      SearchPatientsCall.entries(
                                                                        (_model.fHIRSearchPatients?.jsonBody ??
                                                                            ''),
                                                                      )?.toList(),
                                                                      functions
                                                                          .convertDateStringListtoDateTimeList(SearchPatientsCall.lastUpdated(
                                                                            (_model.fHIRSearchPatients?.jsonBody ??
                                                                                ''),
                                                                          )?.toList())
                                                                          .toList())!
                                                                  .toList()
                                                                  .cast<PatientStruct>();
                                                              _model.displaySimpleSearchPatients =
                                                                  false;
                                                              _model.displayFHIRSearchPatients =
                                                                  true;
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Error'),
                                                                    content: Text((_model
                                                                            .fHIRSearchPatients
                                                                            ?.bodyText ??
                                                                        '')),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                        child: Text(
                                                                            'Ok'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                        ),
                                                      Container(
                                                        width: 250.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .cardBlue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .check_circle_outline_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 24.0,
                                                            ),
                                                            Text(
                                                              'Supports Partial Match',
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
                                                                        .primary,
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
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 10.0))
                                                              .around(SizedBox(
                                                                  width: 10.0)),
                                                        ),
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            width: 20.0))
                                                        .around(SizedBox(
                                                            width: 20.0)),
                                                  ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: wrapWithModel(
                                                            model: _model
                                                                .tableHeaderComponentNameModel,
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                CustomTableHeaderComponentWidget(
                                                              columnName:
                                                                  'Name',
                                                              isSelected: _model
                                                                      .selectedTableColumn ==
                                                                  'Name',
                                                              isAscending: _model
                                                                  .isAscendingSelectedTableColumn,
                                                              topLeftBorderRadius:
                                                                  10.0,
                                                              onClick:
                                                                  (columnName) async {
                                                                if (_model
                                                                        .selectedTableColumn ==
                                                                    columnName) {
                                                                  _model.isAscendingSelectedTableColumn =
                                                                      !_model
                                                                          .isAscendingSelectedTableColumn;
                                                                  safeSetState(
                                                                      () {});
                                                                } else {
                                                                  _model.isAscendingSelectedTableColumn =
                                                                      true;
                                                                  _model.selectedTableColumn =
                                                                      columnName;
                                                                  safeSetState(
                                                                      () {});
                                                                }

                                                                if (_model
                                                                        .selectedTableColumn ==
                                                                    'Name') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .combinedNames,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .combinedNames,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                } else if (_model
                                                                        .selectedTableColumn ==
                                                                    'Gender') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .gender,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .gender,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                } else if (_model
                                                                        .selectedTableColumn ==
                                                                    'Date of Birth') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .birthDate,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .birthDate,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                } else if (_model
                                                                        .selectedTableColumn ==
                                                                    'Phone Number') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .telecomValue,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .telecomValue,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: wrapWithModel(
                                                            model: _model
                                                                .tableHeaderComponentGenderModel,
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                CustomTableHeaderComponentWidget(
                                                              columnName:
                                                                  'Gender',
                                                              isSelected: _model
                                                                      .selectedTableColumn ==
                                                                  'Gender',
                                                              isAscending: _model
                                                                  .isAscendingSelectedTableColumn,
                                                              onClick:
                                                                  (columnName) async {
                                                                if (_model
                                                                        .selectedTableColumn ==
                                                                    columnName) {
                                                                  _model.isAscendingSelectedTableColumn =
                                                                      !_model
                                                                          .isAscendingSelectedTableColumn;
                                                                  safeSetState(
                                                                      () {});
                                                                } else {
                                                                  _model.isAscendingSelectedTableColumn =
                                                                      true;
                                                                  _model.selectedTableColumn =
                                                                      columnName;
                                                                  safeSetState(
                                                                      () {});
                                                                }

                                                                if (_model
                                                                        .selectedTableColumn ==
                                                                    'Name') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .combinedNames,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .combinedNames,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                } else if (_model
                                                                        .selectedTableColumn ==
                                                                    'Gender') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .gender,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .gender,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                } else if (_model
                                                                        .selectedTableColumn ==
                                                                    'Date of Birth') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .birthDate,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .birthDate,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                } else if (_model
                                                                        .selectedTableColumn ==
                                                                    'Phone Number') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .telecomValue,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .telecomValue,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: wrapWithModel(
                                                            model: _model
                                                                .tableHeaderComponentDOBModel,
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                CustomTableHeaderComponentWidget(
                                                              columnName:
                                                                  'Date of Birth',
                                                              isSelected: _model
                                                                      .selectedTableColumn ==
                                                                  'Date of Birth',
                                                              isAscending: _model
                                                                  .isAscendingSelectedTableColumn,
                                                              onClick:
                                                                  (columnName) async {
                                                                if (_model
                                                                        .selectedTableColumn ==
                                                                    columnName) {
                                                                  _model.isAscendingSelectedTableColumn =
                                                                      !_model
                                                                          .isAscendingSelectedTableColumn;
                                                                  safeSetState(
                                                                      () {});
                                                                } else {
                                                                  _model.isAscendingSelectedTableColumn =
                                                                      true;
                                                                  _model.selectedTableColumn =
                                                                      columnName;
                                                                  safeSetState(
                                                                      () {});
                                                                }

                                                                if (_model
                                                                        .selectedTableColumn ==
                                                                    'Name') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .combinedNames,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .combinedNames,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                } else if (_model
                                                                        .selectedTableColumn ==
                                                                    'Gender') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .gender,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .gender,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                } else if (_model
                                                                        .selectedTableColumn ==
                                                                    'Date of Birth') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .birthDate,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .birthDate,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                } else if (_model
                                                                        .selectedTableColumn ==
                                                                    'Phone Number') {
                                                                  if (_model
                                                                      .isAscendingSelectedTableColumn) {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .telecomValue,
                                                                            desc:
                                                                                false)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.sortedAllPatients = _model
                                                                        .allPatients
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .telecomValue,
                                                                            desc:
                                                                                true)
                                                                        .toList()
                                                                        .cast<
                                                                            PatientStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        if (_model.showSearch)
                                                          Expanded(
                                                            flex: 1,
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .tableHeaderComponentPhoneNumberModel,
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  CustomTableHeaderComponentWidget(
                                                                columnName:
                                                                    'Phone Number',
                                                                isSelected: _model
                                                                        .selectedTableColumn ==
                                                                    'Phone Number',
                                                                isAscending: _model
                                                                    .isAscendingSelectedTableColumn,
                                                                onClick:
                                                                    (columnName) async {
                                                                  if (_model
                                                                          .selectedTableColumn ==
                                                                      columnName) {
                                                                    _model.isAscendingSelectedTableColumn =
                                                                        !_model
                                                                            .isAscendingSelectedTableColumn;
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.isAscendingSelectedTableColumn =
                                                                        true;
                                                                    _model.selectedTableColumn =
                                                                        columnName;
                                                                    safeSetState(
                                                                        () {});
                                                                  }

                                                                  if (_model
                                                                          .selectedTableColumn ==
                                                                      'Name') {
                                                                    if (_model
                                                                        .isAscendingSelectedTableColumn) {
                                                                      _model.sortedAllPatients = _model
                                                                          .allPatients
                                                                          .sortedList(
                                                                              keyOf: (e) => e.combinedNames,
                                                                              desc: false)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      _model.sortedAllPatients = _model
                                                                          .allPatients
                                                                          .sortedList(
                                                                              keyOf: (e) => e.combinedNames,
                                                                              desc: true)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  } else if (_model
                                                                          .selectedTableColumn ==
                                                                      'Gender') {
                                                                    if (_model
                                                                        .isAscendingSelectedTableColumn) {
                                                                      _model.sortedAllPatients = _model
                                                                          .allPatients
                                                                          .sortedList(
                                                                              keyOf: (e) => e.gender,
                                                                              desc: false)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      _model.sortedAllPatients = _model
                                                                          .allPatients
                                                                          .sortedList(
                                                                              keyOf: (e) => e.gender,
                                                                              desc: true)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  } else if (_model
                                                                          .selectedTableColumn ==
                                                                      'Date of Birth') {
                                                                    if (_model
                                                                        .isAscendingSelectedTableColumn) {
                                                                      _model.sortedAllPatients = _model
                                                                          .allPatients
                                                                          .sortedList(
                                                                              keyOf: (e) => e.birthDate,
                                                                              desc: false)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      _model.sortedAllPatients = _model
                                                                          .allPatients
                                                                          .sortedList(
                                                                              keyOf: (e) => e.birthDate,
                                                                              desc: true)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  } else if (_model
                                                                          .selectedTableColumn ==
                                                                      'Phone Number') {
                                                                    if (_model
                                                                        .isAscendingSelectedTableColumn) {
                                                                      _model.sortedAllPatients = _model
                                                                          .allPatients
                                                                          .sortedList(
                                                                              keyOf: (e) => e.telecomValue,
                                                                              desc: false)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      _model.sortedAllPatients = _model
                                                                          .allPatients
                                                                          .sortedList(
                                                                              keyOf: (e) => e.telecomValue,
                                                                              desc: true)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: wrapWithModel(
                                                            model: _model
                                                                .tableHeaderComponentActionsModel,
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                CustomTableHeaderComponentWidget(
                                                              columnName:
                                                                  'Actions',
                                                              isSelected: false,
                                                              isAscending:
                                                                  false,
                                                              topRIghtBorderRadius:
                                                                  10.0,
                                                              onClick:
                                                                  (columnName) async {},
                                                            ),
                                                          ),
                                                        ),
                                                      ]
                                                          .addToStart(SizedBox(
                                                              width: 20.0))
                                                          .addToEnd(SizedBox(
                                                              width: 20.0)),
                                                    ),
                                                    Builder(
                                                      builder: (context) {
                                                        final pages = functions
                                                            .createPageIndices(
                                                                () {
                                                          if (_model
                                                              .displaySimpleSearchPatients) {
                                                            return _model
                                                                .allPatients
                                                                .where((e) => _model
                                                                    .simpleSearchResults
                                                                    .contains(e
                                                                        .combinedNames))
                                                                .toList()
                                                                .length;
                                                          } else if (_model
                                                              .displayFHIRSearchPatients) {
                                                            return _model
                                                                .allFHIRSearchPatients
                                                                .length;
                                                          } else {
                                                            return _model
                                                                .sortedAllPatients
                                                                .length;
                                                          }
                                                        }()).toList();
                                                        if (pages.isEmpty) {
                                                          return Center(
                                                            child:
                                                                EmptyWidgetWidget(),
                                                          );
                                                        }

                                                        return Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height: 540.0,
                                                          child:
                                                              PageView.builder(
                                                            controller: _model
                                                                    .pageViewController ??=
                                                                PageController(
                                                                    initialPage: max(
                                                                        0,
                                                                        min(
                                                                            0,
                                                                            pages.length -
                                                                                1))),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                pages.length,
                                                            itemBuilder:
                                                                (context,
                                                                    pagesIndex) {
                                                              final pagesItem =
                                                                  pages[
                                                                      pagesIndex];
                                                              return Builder(
                                                                builder:
                                                                    (context) {
                                                                  final allPatientsListTable =
                                                                      () {
                                                                            if (_model.displaySimpleSearchPatients) {
                                                                              return functions.slicePatientsListForTablePages(_model.allPatients.where((e) => _model.simpleSearchResults.contains(e.combinedNames)).toList(), pagesIndex * 10, (pagesIndex + 1) * 10);
                                                                            } else if (_model.displayFHIRSearchPatients) {
                                                                              return functions.slicePatientsListForTablePages(_model.allFHIRSearchPatients.toList(), pagesIndex * 10, (pagesIndex + 1) * 10);
                                                                            } else {
                                                                              return functions.slicePatientsListForTablePages(_model.sortedAllPatients.toList(), pagesIndex * 10, (pagesIndex + 1) * 10);
                                                                            }
                                                                          }()
                                                                              ?.toList() ??
                                                                          [];

                                                                  return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: List.generate(
                                                                        allPatientsListTable
                                                                            .length,
                                                                        (allPatientsListTableIndex) {
                                                                      final allPatientsListTableItem =
                                                                          allPatientsListTable[
                                                                              allPatientsListTableIndex];
                                                                      return wrapWithModel(
                                                                        model: _model
                                                                            .patientTableRowComponentModels
                                                                            .getModel(
                                                                          allPatientsListTableIndex
                                                                              .toString(),
                                                                          allPatientsListTableIndex,
                                                                        ),
                                                                        updateCallback:
                                                                            () =>
                                                                                safeSetState(() {}),
                                                                        child:
                                                                            PatientTableRowComponentWidget(
                                                                          key:
                                                                              Key(
                                                                            'Key4mq_${allPatientsListTableIndex.toString()}',
                                                                          ),
                                                                          patientRow:
                                                                              allPatientsListTableItem,
                                                                          showPhoneNumber:
                                                                              _model.showSearch,
                                                                          onEditAction:
                                                                              (patientRow) async {
                                                                            _model.showPatients =
                                                                                false;
                                                                            _model.showSearch =
                                                                                false;
                                                                            _model.showCreateEditPatient =
                                                                                false;
                                                                            _model.showActivity =
                                                                                false;
                                                                            _model.showSettings =
                                                                                false;
                                                                            _model.patientMode =
                                                                                PatientMode.edit;
                                                                            _model.patientSelectedForEdit =
                                                                                patientRow;
                                                                            _model.selectedDob =
                                                                                functions.convertSingleDateStringtoDateTime(patientRow.birthDate);
                                                                            safeSetState(() {});
                                                                            await Future.delayed(
                                                                              Duration(
                                                                                milliseconds: 100,
                                                                              ),
                                                                            );
                                                                            safeSetState(() {
                                                                              _model.firstNameTextController?.text = patientRow.givenNames;
                                                                            });
                                                                            safeSetState(() {
                                                                              _model.lastNameTextController?.text = patientRow.familyName;
                                                                            });
                                                                            safeSetState(() {
                                                                              _model.genderCCValueController?.value = [
                                                                                functions.capitalizeFirst(patientRow.gender)
                                                                              ];
                                                                            });
                                                                            safeSetState(() {
                                                                              _model.phoneNumberTextController?.text = patientRow.telecomValue;
                                                                            });
                                                                            if (animationsMap['containerOnActionTriggerAnimation'] !=
                                                                                null) {
                                                                              await animationsMap['containerOnActionTriggerAnimation']!.controller.forward(from: 0.0);
                                                                            }
                                                                            if (animationsMap['containerOnActionTriggerAnimation'] !=
                                                                                null) {
                                                                              await animationsMap['containerOnActionTriggerAnimation']!.controller.reverse();
                                                                            }
                                                                          },
                                                                          onDeleteAction:
                                                                              (patientRow) async {
                                                                            var _shouldSetState =
                                                                                false;
                                                                            var confirmDialogResponse = await showDialog<bool>(
                                                                                  context: context,
                                                                                  builder: (alertDialogContext) {
                                                                                    return AlertDialog(
                                                                                      title: Text('Warning'),
                                                                                      content: Text('Are you sure you want to delete this patient..?? This process is irreversible..!!'),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                          child: Text('Cancel'),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                          child: Text('Delete'),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  },
                                                                                ) ??
                                                                                false;
                                                                            if (!confirmDialogResponse) {
                                                                              if (_shouldSetState)
                                                                                safeSetState(() {});
                                                                              return;
                                                                            }
                                                                            _model.deletePatient =
                                                                                await DeletePatientCall.call(
                                                                              id: patientRow.identifier,
                                                                              token: FFAppState().fhirBearerToken,
                                                                            );

                                                                            _shouldSetState =
                                                                                true;
                                                                            if ((_model.deletePatient?.succeeded ??
                                                                                true)) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    'Patient Deleted successfully..!!',
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).info,
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).success,
                                                                                ),
                                                                              );
                                                                            } else {
                                                                              await showDialog(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return AlertDialog(
                                                                                    title: Text('Delete Failed'),
                                                                                    content: Text((_model.deletePatient?.bodyText ?? '')),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext),
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

                                                                            _model.allPatientsQuery4 =
                                                                                await GetAllPatientsCall.call(
                                                                              token: FFAppState().fhirBearerToken,
                                                                            );

                                                                            _shouldSetState =
                                                                                true;
                                                                            if ((_model.allPatientsQuery4?.succeeded ??
                                                                                true)) {
                                                                              _model.allPatients = functions
                                                                                  .parseFhirPatients(
                                                                                      GetAllPatientsCall.entries(
                                                                                        (_model.allPatientsQuery4?.jsonBody ?? ''),
                                                                                      )?.toList(),
                                                                                      functions
                                                                                          .convertDateStringListtoDateTimeList(GetAllPatientsCall.lastUpdated(
                                                                                            (_model.allPatientsQuery4?.jsonBody ?? ''),
                                                                                          )?.toList())
                                                                                          .toList())!
                                                                                  .toList()
                                                                                  .cast<PatientStruct>();
                                                                              _model.sortedAllPatients = functions
                                                                                  .parseFhirPatients(
                                                                                      GetAllPatientsCall.entries(
                                                                                        (_model.allPatientsQuery4?.jsonBody ?? ''),
                                                                                      )?.toList(),
                                                                                      functions
                                                                                          .convertDateStringListtoDateTimeList(GetAllPatientsCall.lastUpdated(
                                                                                            (_model.allPatientsQuery4?.jsonBody ?? ''),
                                                                                          )?.toList())
                                                                                          .toList())!
                                                                                  .sortedList(keyOf: (e) => e.combinedNames, desc: false)
                                                                                  .toList()
                                                                                  .cast<PatientStruct>();
                                                                              safeSetState(() {});
                                                                            }
                                                                            if (_shouldSetState)
                                                                              safeSetState(() {});
                                                                          },
                                                                        ),
                                                                      );
                                                                    }),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Pages',
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
                                                        ),
                                                        Builder(
                                                          builder: (context) {
                                                            final pages2 = functions
                                                                .createPageIndices(
                                                                    () {
                                                              if (_model
                                                                  .displaySimpleSearchPatients) {
                                                                return _model
                                                                    .allPatients
                                                                    .where((e) => _model
                                                                        .simpleSearchResults
                                                                        .contains(
                                                                            e.combinedNames))
                                                                    .toList()
                                                                    .length;
                                                              } else if (_model
                                                                  .displayFHIRSearchPatients) {
                                                                return _model
                                                                    .allFHIRSearchPatients
                                                                    .length;
                                                              } else {
                                                                return _model
                                                                    .sortedAllPatients
                                                                    .length;
                                                              }
                                                            }()).toList();

                                                            return Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: List.generate(
                                                                  pages2.length,
                                                                  (pages2Index) {
                                                                final pages2Item =
                                                                    pages2[
                                                                        pages2Index];
                                                                return InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    _model.currentPatientPage =
                                                                        pages2Item;
                                                                    safeSetState(
                                                                        () {});
                                                                    await _model
                                                                        .pageViewController
                                                                        ?.animateToPage(
                                                                      _model
                                                                          .currentPatientPage,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              500),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                                  },
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .customDotComponentPageViewModels
                                                                        .getModel(
                                                                      pages2Item
                                                                          .toString(),
                                                                      pages2Index,
                                                                    ),
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomDotComponentPageViewWidget(
                                                                      key: Key(
                                                                        'Keycvo_${pages2Item.toString()}',
                                                                      ),
                                                                      isSelected:
                                                                          _model.currentPatientPage ==
                                                                              pages2Item,
                                                                      assignedIdx:
                                                                          pages2Item,
                                                                    ),
                                                                  ),
                                                                );
                                                              }).divide(SizedBox(
                                                                  width: 10.0)),
                                                            );
                                                          },
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 10.0)),
                                                    ),
                                                  ],
                                                ),
                                              ]
                                                  .divide(
                                                      SizedBox(height: 10.0))
                                                  .around(
                                                      SizedBox(height: 10.0)),
                                            ),
                                          ),
                                        if (_model.showCreateEditPatient ||
                                            (_model.patientMode ==
                                                PatientMode.edit))
                                          Container(
                                            height: 835.0,
                                            decoration: BoxDecoration(),
                                            child: SingleChildScrollView(
                                              primary: false,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  if (_model.patientMode ==
                                                      PatientMode.edit)
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            safeSetState(() {
                                                              _model
                                                                  .firstNameTextController
                                                                  ?.clear();
                                                              _model
                                                                  .lastNameTextController
                                                                  ?.clear();
                                                              _model
                                                                  .phoneNumberTextController
                                                                  ?.clear();
                                                            });
                                                            safeSetState(() {
                                                              _model
                                                                  .genderCCValueController
                                                                  ?.reset();
                                                            });
                                                            _model.showPatients =
                                                                true;
                                                            _model.showSearch =
                                                                false;
                                                            _model.showCreateEditPatient =
                                                                false;
                                                            _model.showActivity =
                                                                false;
                                                            _model.showSettings =
                                                                false;
                                                            _model.selectedDob =
                                                                null;
                                                            _model.patientMode =
                                                                PatientMode
                                                                    .create;
                                                            _model.patientSelectedForEdit =
                                                                null;
                                                            safeSetState(() {});
                                                          },
                                                          child: Text(
                                                            'Patient',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
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
                                                          ),
                                                        ),
                                                        Text(
                                                          '/',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
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
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            _model
                                                                .patientSelectedForEdit
                                                                ?.combinedNames,
                                                            'Name',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
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
                                                        ),
                                                        Text(
                                                          '/',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
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
                                                        ),
                                                        Text(
                                                          'Edit',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
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
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              width: 20.0))
                                                          .around(SizedBox(
                                                              width: 20.0)),
                                                    ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              _model.patientMode ==
                                                                      PatientMode
                                                                          .edit
                                                                  ? 'Edit Patient'
                                                                  : 'Create Patient',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineLarge
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineLarge
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineLarge
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLarge
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              _model.patientMode ==
                                                                      PatientMode
                                                                          .edit
                                                                  ? 'Edit Details of a Patient already existing in FHIR server.'
                                                                  : 'Add a New Patient to the FHIR Server.',
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
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  height: 10.0))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      height:
                                                                          5.0))
                                                              .addToEnd(
                                                                  SizedBox(
                                                                      height:
                                                                          5.0)),
                                                        ),
                                                      ),
                                                      if (_model.patientMode ==
                                                          PatientMode.edit)
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            safeSetState(() {
                                                              _model
                                                                  .firstNameTextController
                                                                  ?.clear();
                                                              _model
                                                                  .lastNameTextController
                                                                  ?.clear();
                                                              _model
                                                                  .phoneNumberTextController
                                                                  ?.clear();
                                                            });
                                                            safeSetState(() {
                                                              _model
                                                                  .genderCCValueController
                                                                  ?.reset();
                                                            });
                                                            _model.showPatients =
                                                                true;
                                                            _model.showSearch =
                                                                false;
                                                            _model.showCreateEditPatient =
                                                                false;
                                                            _model.showActivity =
                                                                false;
                                                            _model.showSettings =
                                                                false;
                                                            _model.selectedDob =
                                                                null;
                                                            _model.patientMode =
                                                                PatientMode
                                                                    .create;
                                                            _model.patientSelectedForEdit =
                                                                null;
                                                            safeSetState(() {});
                                                          },
                                                          text:
                                                              'Back to Patients',
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_back_rounded,
                                                            size: 24.0,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: 200.0,
                                                            height: 40.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            iconColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            color: Colors
                                                                .transparent,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      fontSize:
                                                                          18.0,
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
                                                            elevation: 0.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            hoverColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .cardBlue,
                                                            hoverBorderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1.0,
                                                            ),
                                                            hoverTextColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                          ),
                                                        ),
                                                    ]
                                                        .divide(SizedBox(
                                                            width: 20.0))
                                                        .around(SizedBox(
                                                            width: 20.0)),
                                                  ),
                                                  if (_model.patientMode ==
                                                      PatientMode.edit)
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          width: 1399.0,
                                                          height: 50.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x8AD0FFEE),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .success,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .check_circle_outline_rounded,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .success,
                                                                    size: 24.0,
                                                                  ),
                                                                  Text(
                                                                    'Loaded From FHIR Server',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        20.0)),
                                                              ),
                                                              SizedBox(
                                                                height: 20.0,
                                                                child:
                                                                    VerticalDivider(
                                                                  thickness:
                                                                      2.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Patient ID:',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  SelectionArea(
                                                                      child:
                                                                          Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      _model
                                                                          .patientSelectedForEdit
                                                                          ?.identifier,
                                                                      'ID',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  )),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        20.0)),
                                                              ),
                                                              SizedBox(
                                                                height: 20.0,
                                                                child:
                                                                    VerticalDivider(
                                                                  thickness:
                                                                      2.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Last Updated:',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    '${dateTimeFormat("yMMMd", _model.patientSelectedForEdit?.lastUpdated)} at ${dateTimeFormat("jm", _model.patientSelectedForEdit?.lastUpdated)}',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        20.0)),
                                                              ),
                                                            ]
                                                                .divide(SizedBox(
                                                                    width:
                                                                        10.0))
                                                                .around(SizedBox(
                                                                    width:
                                                                        10.0)),
                                                          ),
                                                        ).animateOnActionTrigger(
                                                          animationsMap[
                                                              'containerOnActionTriggerAnimation']!,
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              width: 20.0))
                                                          .around(SizedBox(
                                                              width: 20.0)),
                                                    ),
                                                  Form(
                                                    key: _model.formKey,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .disabled,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(20.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: Color(
                                                                  0x33000000),
                                                              offset: Offset(
                                                                0.0,
                                                                2.0,
                                                              ),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            RichText(
                                                                              textScaler: MediaQuery.of(context).textScaler,
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: 'First Name   ',
                                                                                    style: TextStyle(),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: '*',
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.readexPro(
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.4,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.4,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: _model.firstNameTextController,
                                                                              focusNode: _model.firstNameFocusNode,
                                                                              onChanged: (_) => EasyDebounce.debounce(
                                                                                '_model.firstNameTextController',
                                                                                Duration(milliseconds: 200),
                                                                                () => safeSetState(() {}),
                                                                              ),
                                                                              autofocus: false,
                                                                              enabled: true,
                                                                              obscureText: false,
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: 14.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                hintText: 'First Name and Middle Name(s) (if any)',
                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                                errorBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                                focusedErrorBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                                filled: true,
                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                suffixIcon: _model.firstNameTextController!.text.isNotEmpty
                                                                                    ? InkWell(
                                                                                        onTap: () async {
                                                                                          _model.firstNameTextController?.clear();
                                                                                          safeSetState(() {});
                                                                                        },
                                                                                        child: Icon(
                                                                                          Icons.clear,
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                      )
                                                                                    : null,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                              cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                              enableInteractiveSelection: true,
                                                                              validator: _model.firstNameTextControllerValidator.asValidator(context),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 10.0)),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            RichText(
                                                                              textScaler: MediaQuery.of(context).textScaler,
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: 'Last Name   ',
                                                                                    style: TextStyle(),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: '*',
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.readexPro(
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.4,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.4,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: _model.lastNameTextController,
                                                                              focusNode: _model.lastNameFocusNode,
                                                                              onChanged: (_) => EasyDebounce.debounce(
                                                                                '_model.lastNameTextController',
                                                                                Duration(milliseconds: 200),
                                                                                () => safeSetState(() {}),
                                                                              ),
                                                                              autofocus: false,
                                                                              enabled: true,
                                                                              obscureText: false,
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                hintText: 'Last Name (Family Name Only)',
                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                                errorBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                                focusedErrorBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                                filled: true,
                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                suffixIcon: _model.lastNameTextController!.text.isNotEmpty
                                                                                    ? InkWell(
                                                                                        onTap: () async {
                                                                                          _model.lastNameTextController?.clear();
                                                                                          safeSetState(() {});
                                                                                        },
                                                                                        child: Icon(
                                                                                          Icons.clear,
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                      )
                                                                                    : null,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                              cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                              enableInteractiveSelection: true,
                                                                              validator: _model.lastNameTextControllerValidator.asValidator(context),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(height: 10.0)).around(
                                                                              SizedBox(height: 10.0)),
                                                                    ),
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        width:
                                                                            20.0))
                                                                    .around(SizedBox(
                                                                        width:
                                                                            20.0)),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          RichText(
                                                                            textScaler:
                                                                                MediaQuery.of(context).textScaler,
                                                                            text:
                                                                                TextSpan(
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: 'Gender  ',
                                                                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                        font: GoogleFonts.readexPro(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: '*',
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
                                                                      ),
                                                                      FlutterFlowChoiceChips(
                                                                        options: [
                                                                          ChipData(
                                                                              'Male',
                                                                              Icons.male_rounded),
                                                                          ChipData(
                                                                              'Female',
                                                                              Icons.female_rounded),
                                                                          ChipData(
                                                                              'Other',
                                                                              Icons.transgender_rounded)
                                                                        ],
                                                                        onChanged:
                                                                            (val) =>
                                                                                safeSetState(() => _model.genderCCValue = val?.firstOrNull),
                                                                        selectedChipStyle:
                                                                            ChipStyle(
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                              ),
                                                                          iconColor:
                                                                              FlutterFlowTheme.of(context).info,
                                                                          iconSize:
                                                                              24.0,
                                                                          labelPadding:
                                                                              EdgeInsets.all(10.0),
                                                                          elevation:
                                                                              0.0,
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                        ),
                                                                        unselectedChipStyle:
                                                                            ChipStyle(
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                              ),
                                                                          iconColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          iconSize:
                                                                              24.0,
                                                                          labelPadding:
                                                                              EdgeInsets.all(10.0),
                                                                          elevation:
                                                                              8.0,
                                                                          borderColor:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                        ),
                                                                        chipSpacing:
                                                                            100.0,
                                                                        rowSpacing:
                                                                            8.0,
                                                                        multiselect:
                                                                            false,
                                                                        alignment:
                                                                            WrapAlignment.spaceBetween,
                                                                        controller:
                                                                            _model.genderCCValueController ??=
                                                                                FormFieldController<List<String>>(
                                                                          [],
                                                                        ),
                                                                        wrapped:
                                                                            true,
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(
                                                                            height:
                                                                                10.0))
                                                                        .around(SizedBox(
                                                                            height:
                                                                                10.0)),
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        width:
                                                                            20.0))
                                                                    .around(SizedBox(
                                                                        width:
                                                                            20.0)),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          RichText(
                                                                            textScaler:
                                                                                MediaQuery.of(context).textScaler,
                                                                            text:
                                                                                TextSpan(
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: 'Date of Birth  ',
                                                                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                        font: GoogleFonts.readexPro(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: '*',
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
                                                                      ),
                                                                      FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          final _datePickedDate =
                                                                              await showDatePicker(
                                                                            context:
                                                                                context,
                                                                            initialDate:
                                                                                getCurrentTimestamp,
                                                                            firstDate:
                                                                                DateTime(1900),
                                                                            lastDate:
                                                                                (getCurrentTimestamp ?? DateTime(2050)),
                                                                            builder:
                                                                                (context, child) {
                                                                              return wrapInMaterialDatePickerTheme(
                                                                                context,
                                                                                child!,
                                                                                headerBackgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                headerForegroundColor: FlutterFlowTheme.of(context).info,
                                                                                headerTextStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                      font: GoogleFonts.readexPro(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                      ),
                                                                                      fontSize: 32.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                    ),
                                                                                pickerBackgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                selectedDateTimeBackgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                selectedDateTimeForegroundColor: FlutterFlowTheme.of(context).info,
                                                                                actionButtonForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                iconSize: 24.0,
                                                                              );
                                                                            },
                                                                          );

                                                                          if (_datePickedDate !=
                                                                              null) {
                                                                            safeSetState(() {
                                                                              _model.datePicked = DateTime(
                                                                                _datePickedDate.year,
                                                                                _datePickedDate.month,
                                                                                _datePickedDate.day,
                                                                              );
                                                                            });
                                                                          } else if (_model.datePicked !=
                                                                              null) {
                                                                            safeSetState(() {
                                                                              _model.datePicked = getCurrentTimestamp;
                                                                            });
                                                                          }
                                                                          if (_model.patientMode ==
                                                                              PatientMode.create) {
                                                                            _model.selectedDob =
                                                                                _model.datePicked;
                                                                            safeSetState(() {});
                                                                          }
                                                                        },
                                                                        text: _model.selectedDob !=
                                                                                null
                                                                            ? dateTimeFormat("y-MM-dd",
                                                                                _model.selectedDob)
                                                                            : 'Select Date',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .calendar_month_outlined,
                                                                          size:
                                                                              30.0,
                                                                        ),
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              200.0,
                                                                          height:
                                                                              50.0,
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16.0,
                                                                              0.0,
                                                                              16.0,
                                                                              0.0),
                                                                          iconAlignment:
                                                                              IconAlignment.end,
                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          iconColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          color:
                                                                              Colors.transparent,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                              ),
                                                                          elevation:
                                                                              0.0,
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          hoverColor:
                                                                              FlutterFlowTheme.of(context).cardBlue,
                                                                          hoverBorderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                          hoverTextColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          hoverElevation:
                                                                              8.0,
                                                                        ),
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(
                                                                            height:
                                                                                10.0))
                                                                        .around(SizedBox(
                                                                            height:
                                                                                10.0)),
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        width:
                                                                            20.0))
                                                                    .around(SizedBox(
                                                                        width:
                                                                            20.0)),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          RichText(
                                                                            textScaler:
                                                                                MediaQuery.of(context).textScaler,
                                                                            text:
                                                                                TextSpan(
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: 'Phone Number  ',
                                                                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                        font: GoogleFonts.readexPro(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: '*',
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Container(
                                                                            width:
                                                                                100.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                custom_widgets.CountryDialCodePicker(
                                                                              width: 100.0,
                                                                              height: 50.0,
                                                                              initialDialCode: FFAppState().selectedPhoneDialCode,
                                                                              initialIsoCode: FFAppState().selectedPhoneIsoCode,
                                                                              borderRadius: 8.0,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.3,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.3,
                                                                              child: TextFormField(
                                                                                controller: _model.phoneNumberTextController,
                                                                                focusNode: _model.phoneNumberFocusNode,
                                                                                onChanged: (_) => EasyDebounce.debounce(
                                                                                  '_model.phoneNumberTextController',
                                                                                  Duration(milliseconds: 2000),
                                                                                  () => safeSetState(() {}),
                                                                                ),
                                                                                autofocus: false,
                                                                                enabled: true,
                                                                                textCapitalization: TextCapitalization.none,
                                                                                obscureText: false,
                                                                                decoration: InputDecoration(
                                                                                  isDense: true,
                                                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                      ),
                                                                                  hintText: 'Phone Number',
                                                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                      ),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).alternate,
                                                                                      width: 2.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      width: 2.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                  ),
                                                                                  errorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 2.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                  ),
                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 2.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                  ),
                                                                                  filled: true,
                                                                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  suffixIcon: _model.phoneNumberTextController!.text.isNotEmpty
                                                                                      ? InkWell(
                                                                                          onTap: () async {
                                                                                            _model.phoneNumberTextController?.clear();
                                                                                            safeSetState(() {});
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.clear,
                                                                                            color: FlutterFlowTheme.of(context).alternate,
                                                                                            size: 22,
                                                                                          ),
                                                                                        )
                                                                                      : null,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                maxLength: 14,
                                                                                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                                                                buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                                                                                keyboardType: TextInputType.number,
                                                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                enableInteractiveSelection: true,
                                                                                validator: _model.phoneNumberTextControllerValidator.asValidator(context),
                                                                                inputFormatters: [
                                                                                  if (!isAndroid && !isiOS)
                                                                                    TextInputFormatter.withFunction((oldValue, newValue) {
                                                                                      return TextEditingValue(
                                                                                        selection: newValue.selection,
                                                                                        text: newValue.text.toCapitalization(TextCapitalization.none),
                                                                                      );
                                                                                    }),
                                                                                  FilteringTextInputFormatter.allow(RegExp('^[0-9-]+\$'))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(
                                                                            height:
                                                                                10.0))
                                                                        .around(SizedBox(
                                                                            height:
                                                                                10.0)),
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        width:
                                                                            20.0))
                                                                    .around(SizedBox(
                                                                        width:
                                                                            20.0)),
                                                              ),
                                                            ),
                                                            Divider(
                                                              thickness: 2.0,
                                                              indent: 10.0,
                                                              endIndent: 10.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Spacer(),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    safeSetState(
                                                                        () {
                                                                      _model
                                                                          .firstNameTextController
                                                                          ?.clear();
                                                                      _model
                                                                          .lastNameTextController
                                                                          ?.clear();
                                                                      _model
                                                                          .phoneNumberTextController
                                                                          ?.clear();
                                                                    });
                                                                    safeSetState(
                                                                        () {
                                                                      _model
                                                                          .genderCCValueController
                                                                          ?.reset();
                                                                    });
                                                                    _model.showPatients =
                                                                        true;
                                                                    _model.showSearch =
                                                                        false;
                                                                    _model.showCreateEditPatient =
                                                                        false;
                                                                    _model.showActivity =
                                                                        false;
                                                                    _model.showSettings =
                                                                        false;
                                                                    _model.selectedDob =
                                                                        null;
                                                                    _model.patientMode =
                                                                        PatientMode
                                                                            .create;
                                                                    _model.patientSelectedForEdit =
                                                                        null;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text:
                                                                      'Cancel',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .close_rounded,
                                                                    size: 24.0,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width:
                                                                        130.0,
                                                                    height:
                                                                        50.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconAlignment:
                                                                        IconAlignment
                                                                            .end,
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    iconColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    color: Colors
                                                                        .transparent,
                                                                    textStyle: FlutterFlowTheme.of(
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
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontSize:
                                                                              20.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25.0),
                                                                    hoverColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .cardTertiary,
                                                                    hoverBorderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .tertiary,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    hoverTextColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    safeSetState(
                                                                        () {
                                                                      _model
                                                                          .firstNameTextController
                                                                          ?.clear();
                                                                      _model
                                                                          .lastNameTextController
                                                                          ?.clear();
                                                                      _model
                                                                          .phoneNumberTextController
                                                                          ?.clear();
                                                                    });
                                                                    safeSetState(
                                                                        () {
                                                                      _model
                                                                          .genderCCValueController
                                                                          ?.reset();
                                                                    });
                                                                    _model.selectedDob =
                                                                        null;
                                                                    _model.patientMode =
                                                                        PatientMode
                                                                            .create;
                                                                    _model.patientSelectedForEdit =
                                                                        null;
                                                                    _model.showCreateEditPatient =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text: 'Reset',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .refresh_outlined,
                                                                    size: 24.0,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width:
                                                                        130.0,
                                                                    height:
                                                                        50.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconAlignment:
                                                                        IconAlignment
                                                                            .end,
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: Colors
                                                                        .transparent,
                                                                    textStyle: FlutterFlowTheme.of(
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
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          fontSize:
                                                                              20.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25.0),
                                                                    hoverColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .cardBlue,
                                                                    hoverBorderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    hoverTextColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    var _shouldSetState =
                                                                        false;
                                                                    if (_model.formKey.currentState ==
                                                                            null ||
                                                                        !_model
                                                                            .formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                      return;
                                                                    }
                                                                    if (!(_model.genderCCValue !=
                                                                            null &&
                                                                        _model.genderCCValue !=
                                                                            '')) {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('ⓘ Error'),
                                                                            content:
                                                                                Text('Gender Must be selected..!!'),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                child: Text('Ok'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                      if (_shouldSetState)
                                                                        safeSetState(
                                                                            () {});
                                                                      return;
                                                                    }
                                                                    if (!(_model
                                                                            .selectedDob !=
                                                                        null)) {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('ⓘ Error'),
                                                                            content:
                                                                                Text('Date of Birth must -${dateTimeFormat("d/M/y", _model.selectedDob)}  -be chosen..!! '),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                child: Text('Ok'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                      if (_shouldSetState)
                                                                        safeSetState(
                                                                            () {});
                                                                      return;
                                                                    }
                                                                    if (!functions.isValidPhoneNumberForCountry(
                                                                        _model
                                                                            .phoneNumberTextController
                                                                            .text,
                                                                        FFAppState()
                                                                            .selectedPhoneIsoCode)) {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('ⓘ Error'),
                                                                            content:
                                                                                Text('Invalid Phone Number for the country selected..!! Please check the Phone Numer once again.'),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                child: Text('Ok'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                      if (_shouldSetState)
                                                                        safeSetState(
                                                                            () {});
                                                                      return;
                                                                    }
                                                                    if (_model
                                                                            .patientMode ==
                                                                        PatientMode
                                                                            .create) {
                                                                      _model.createNewPatient =
                                                                          await CreateNewPatientCall
                                                                              .call(
                                                                        givenNameList: functions.splitWords(_model
                                                                            .firstNameTextController
                                                                            .text),
                                                                        familyName: _model
                                                                            .lastNameTextController
                                                                            .text,
                                                                        birthDate: dateTimeFormat(
                                                                            "y-MM-dd",
                                                                            _model.selectedDob),
                                                                        gender:
                                                                            (_model.genderCCValue!).toLowerCase(),
                                                                        phoneNumber: _model
                                                                            .phoneNumberTextController
                                                                            .text,
                                                                        token: FFAppState()
                                                                            .fhirBearerToken,
                                                                      );

                                                                      _shouldSetState =
                                                                          true;
                                                                      if ((_model
                                                                              .createNewPatient
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Patient added successfully..!!',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).info,
                                                                              ),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).success,
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              title: Text('Error'),
                                                                              content: Text((_model.createNewPatient?.bodyText ?? '')),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        if (_shouldSetState)
                                                                          safeSetState(
                                                                              () {});
                                                                        return;
                                                                      }
                                                                    } else if (_model
                                                                            .patientMode ==
                                                                        PatientMode
                                                                            .edit) {
                                                                      _model.editPatient =
                                                                          await EditPatientCall
                                                                              .call(
                                                                        givenNameList: functions.splitWords(_model
                                                                            .firstNameTextController
                                                                            .text),
                                                                        familyName: _model
                                                                            .lastNameTextController
                                                                            .text,
                                                                        birthDate: dateTimeFormat(
                                                                            "y-MM-dd",
                                                                            _model.selectedDob),
                                                                        phoneNumber: _model
                                                                            .phoneNumberTextController
                                                                            .text,
                                                                        gender:
                                                                            (_model.genderCCValue!).toLowerCase(),
                                                                        token: FFAppState()
                                                                            .fhirBearerToken,
                                                                        id: _model
                                                                            .patientSelectedForEdit
                                                                            ?.identifier,
                                                                      );

                                                                      _shouldSetState =
                                                                          true;
                                                                      if ((_model
                                                                              .editPatient
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Patient Edited successfully..!!',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).info,
                                                                              ),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).success,
                                                                          ),
                                                                        );
                                                                        _model.showPatients =
                                                                            true;
                                                                        _model.showSearch =
                                                                            false;
                                                                        _model.showCreateEditPatient =
                                                                            false;
                                                                        _model.showActivity =
                                                                            false;
                                                                        _model.showSettings =
                                                                            false;
                                                                        _model.patientMode =
                                                                            PatientMode.create;
                                                                        safeSetState(
                                                                            () {});
                                                                      } else {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              title: Text('Error'),
                                                                              content: Text((_model.editPatient?.bodyText ?? '')),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        if (_shouldSetState)
                                                                          safeSetState(
                                                                              () {});
                                                                        return;
                                                                      }
                                                                    } else {
                                                                      if (_shouldSetState)
                                                                        safeSetState(
                                                                            () {});
                                                                      return;
                                                                    }

                                                                    _model.allPatientsQuery3 =
                                                                        await GetAllPatientsCall
                                                                            .call(
                                                                      token: FFAppState()
                                                                          .fhirBearerToken,
                                                                    );

                                                                    _shouldSetState =
                                                                        true;
                                                                    if ((_model
                                                                            .allPatientsQuery3
                                                                            ?.succeeded ??
                                                                        true)) {
                                                                      _model.allPatients = functions
                                                                          .parseFhirPatients(
                                                                              GetAllPatientsCall.entries(
                                                                                (_model.allPatientsQuery3?.jsonBody ?? ''),
                                                                              )?.toList(),
                                                                              functions
                                                                                  .convertDateStringListtoDateTimeList(GetAllPatientsCall.lastUpdated(
                                                                                    (_model.allPatientsQuery3?.jsonBody ?? ''),
                                                                                  )?.toList())
                                                                                  .toList())!
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      _model.sortedAllPatients = functions
                                                                          .parseFhirPatients(
                                                                              GetAllPatientsCall.entries(
                                                                                (_model.allPatientsQuery3?.jsonBody ?? ''),
                                                                              )?.toList(),
                                                                              functions
                                                                                  .convertDateStringListtoDateTimeList(GetAllPatientsCall.lastUpdated(
                                                                                    (_model.allPatientsQuery3?.jsonBody ?? ''),
                                                                                  )?.toList())
                                                                                  .toList())!
                                                                          .sortedList(keyOf: (e) => e.combinedNames, desc: false)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                    safeSetState(
                                                                        () {
                                                                      _model
                                                                          .firstNameTextController
                                                                          ?.clear();
                                                                      _model
                                                                          .lastNameTextController
                                                                          ?.clear();
                                                                      _model
                                                                          .phoneNumberTextController
                                                                          ?.clear();
                                                                    });
                                                                    safeSetState(
                                                                        () {
                                                                      _model
                                                                          .genderCCValueController
                                                                          ?.reset();
                                                                    });
                                                                    _model.selectedDob =
                                                                        null;
                                                                    safeSetState(
                                                                        () {});
                                                                    if (_shouldSetState)
                                                                      safeSetState(
                                                                          () {});
                                                                  },
                                                                  text: _model.patientMode ==
                                                                          PatientMode
                                                                              .edit
                                                                      ? 'Edit Patient'
                                                                      : 'Create Patient',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .add_rounded,
                                                                    size: 24.0,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width:
                                                                        200.0,
                                                                    height:
                                                                        50.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    textStyle: FlutterFlowTheme.of(
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
                                                                              Colors.white,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25.0),
                                                                  ),
                                                                ),
                                                              ]
                                                                  .divide(SizedBox(
                                                                      width:
                                                                          20.0))
                                                                  .around(SizedBox(
                                                                      width:
                                                                          20.0)),
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  height: 10.0))
                                                              .around(SizedBox(
                                                                  height:
                                                                      10.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(height: 8.0))
                                                    .around(
                                                        SizedBox(height: 8.0)),
                                              ),
                                            ),
                                          ),
                                        if (_model.showActivity &&
                                            responsiveVisibility(
                                              context: context,
                                              phone: false,
                                              tablet: false,
                                              tabletLandscape: false,
                                              desktop: false,
                                            ))
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              'Activity',
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
                                        if (_model.showSettings &&
                                            responsiveVisibility(
                                              context: context,
                                              phone: false,
                                              tablet: false,
                                              tabletLandscape: false,
                                              desktop: false,
                                            ))
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              'Settings',
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
