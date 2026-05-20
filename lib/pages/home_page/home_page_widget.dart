import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/add_new_observation_set_component_widget.dart';
import '/components/common_wait_component_widget.dart';
import '/components/conditioon_table_row_component_widget.dart';
import '/components/custom_dot_component_page_view_widget.dart';
import '/components/custom_table_header_component_widget.dart';
import '/components/empty_widget_widget.dart';
import '/components/fire_component_widget.dart';
import '/components/medications_table_row_component_widget.dart';
import '/components/menu_items_component_widget.dart';
import '/components/n_e_w_s_row_component_widget.dart';
import '/components/patient_table_row_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
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
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please Wait..!! Loading Data.....',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).info,
            ),
            textAlign: TextAlign.center,
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).tertiary,
        ),
      );
      await Future.wait([
        Future(() async {
          _model.fetchPatientsWithNews1 =
              await actions.fetchFhirPatientsWithLatestNews2(
            FFAppState().fhirBaseUrl,
            FFAppState().fhirBearerToken,
            '2026-05-18',
          );
          _model.allPatients =
              _model.fetchPatientsWithNews1!.toList().cast<PatientStruct>();
          _model.sortedAllPatients = _model.fetchPatientsWithNews1!
              .sortedList(keyOf: (e) => e.latestNEWS2Score, desc: true)
              .toList()
              .cast<PatientStruct>();
          safeSetState(() {});
        }),
        Future(() async {
          _model.practitionersQuery = await GetAllPractitionersCall.call(
            token: FFAppState().fhirBearerToken,
          );

          if ((_model.practitionersQuery?.succeeded ?? true)) {
            _model.currPractIdx = 0;
            _model.practItems = GetAllPractitionersCall.total(
              (_model.practitionersQuery?.jsonBody ?? ''),
            )!;
            safeSetState(() {});
            while (_model.currPractIdx < _model.practItems) {
              FFAppState().addToPractitioners(PractitionerStruct(
                id: GetAllPractitionersCall.id(
                  (_model.practitionersQuery?.jsonBody ?? ''),
                )?.elementAtOrNull(_model.currPractIdx),
                combinedNames: '${GetAllPractitionersCall.givenName(
                  (_model.practitionersQuery?.jsonBody ?? ''),
                )?.elementAtOrNull(_model.currPractIdx)} ${GetAllPractitionersCall.familyName(
                  (_model.practitionersQuery?.jsonBody ?? ''),
                )?.elementAtOrNull(_model.currPractIdx)}',
                prefix: (GetAllPractitionersCall.prefix(
                  (_model.practitionersQuery?.jsonBody ?? ''),
                )?.elementAtOrNull(_model.currPractIdx))
                    ?.toString(),
              ));
              safeSetState(() {});
              _model.currPractIdx = _model.currPractIdx + 1;
              safeSetState(() {});
            }
          } else {
            await showDialog(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text((_model.practitionersQuery?.bodyText ?? '')),
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
        }),
      ]);
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
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });

    _model.searchNameTextController ??= TextEditingController();
    _model.searchNameFocusNode ??= FocusNode();

    _model.firstNameTextController ??= TextEditingController();
    _model.firstNameFocusNode ??= FocusNode();

    _model.lastNameTextController ??= TextEditingController();
    _model.lastNameFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    animationsMap.addAll({
      'containerOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 700.0.ms,
            color: FlutterFlowTheme.of(context).success,
            angle: 0.524,
          ),
        ],
      ),
      'containerOnActionTriggerAnimation2': AnimationInfo(
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
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: Drawer(
        elevation: 16.0,
      ),
      body: Container(
        height: 1080.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 945.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
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
                    Container(
                      height: 160.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
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
                                wrapWithModel(
                                  model: _model.fireComponentModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FireComponentWidget(),
                                ),
                              ].divide(SizedBox(width: 20.0)),
                            ),
                          ),
                          RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'GLY',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                ),
                                TextSpan(
                                  text: 'Z',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).error,
                                  ),
                                ),
                                TextSpan(
                                  text: 'EMIA - ',
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: 'FHIR',
                                  style: TextStyle(
                                    color:
                                        FlutterFlowTheme.of(context).fireOrange,
                                  ),
                                ),
                                TextSpan(
                                  text: ' CHALLENGE',
                                  style: TextStyle(),
                                )
                              ],
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
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: wrapWithModel(
                        model: _model.patientsModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MenuItemsComponentWidget(
                          isSelected: _model.showPatients ||
                              (_model.patientMode == PatientMode.edit) ||
                              _model.showPatientDetails,
                          text: 'Patients',
                          icon: Icon(
                            Icons.people,
                            color: _model.showPatients
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).secondaryText,
                            size: _model.showPatients ||
                                    (_model.patientMode == PatientMode.edit)
                                ? 26.0
                                : 24.0,
                          ),
                          onClick: () async {
                            _model.showPatients = true;
                            _model.showSearch = false;
                            _model.showCreateEditPatient = false;
                            _model.showActivity = false;
                            _model.showSettings = false;
                            _model.displaySimpleSearchPatients = false;
                            _model.displayFHIRSearchPatients = false;
                            _model.patientMode = PatientMode.create;
                            _model.showPatientDetails = false;
                            safeSetState(() {});
                            safeSetState(() {
                              _model.searchNameTextController?.clear();
                            });
                            await _model.pageViewController1?.animateToPage(
                              _model.currentPatientPage,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: wrapWithModel(
                        model: _model.searchModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MenuItemsComponentWidget(
                          isSelected: _model.showSearch,
                          text: 'Search',
                          icon: FaIcon(
                            FontAwesomeIcons.search,
                            color: _model.showSearch
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).secondaryText,
                            size: _model.showSearch ? 26.0 : 24.0,
                          ),
                          onClick: () async {
                            _model.showPatients = false;
                            _model.showSearch = true;
                            _model.showCreateEditPatient = false;
                            _model.showActivity = false;
                            _model.showSettings = false;
                            _model.patientMode = PatientMode.create;
                            _model.showPatientDetails = false;
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: wrapWithModel(
                        model: _model.createPatientModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MenuItemsComponentWidget(
                          isSelected: _model.showCreateEditPatient,
                          text: 'Create Patient',
                          icon: Icon(
                            Icons.person_add_alt_rounded,
                            color: _model.showCreateEditPatient
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).secondaryText,
                            size: _model.showCreateEditPatient ? 26.0 : 24.0,
                          ),
                          onClick: () async {
                            safeSetState(() {
                              _model.firstNameTextController?.clear();
                              _model.lastNameTextController?.clear();
                              _model.phoneNumberTextController?.clear();
                            });
                            safeSetState(() {
                              _model.genderCCValueController?.reset();
                            });
                            _model.selectedDob = null;
                            safeSetState(() {});
                            _model.showPatients = false;
                            _model.showSearch = false;
                            _model.showCreateEditPatient = true;
                            _model.showActivity = false;
                            _model.showSettings = false;
                            _model.patientMode = PatientMode.create;
                            _model.showPatientDetails = false;
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: wrapWithModel(
                        model: _model.activityModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MenuItemsComponentWidget(
                          isSelected: _model.showActivity,
                          text: 'Activity',
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: _model.showActivity
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).secondaryText,
                            size: _model.showActivity ? 26.0 : 24.0,
                          ),
                          onClick: () async {
                            _model.showPatients = false;
                            _model.showSearch = false;
                            _model.showCreateEditPatient = false;
                            _model.showActivity = true;
                            _model.showSettings = false;
                            _model.showPatientDetails = false;
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: wrapWithModel(
                        model: _model.settingsModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MenuItemsComponentWidget(
                          isSelected: _model.showSettings,
                          text: 'Settings',
                          icon: Icon(
                            Icons.settings_rounded,
                            color: _model.showSettings
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).secondaryText,
                            size: _model.showSettings ? 26.0 : 24.0,
                          ),
                          onClick: () async {
                            _model.showPatients = false;
                            _model.showSearch = false;
                            _model.showCreateEditPatient = false;
                            _model.showActivity = false;
                            _model.showSettings = true;
                            _model.showPatientDetails = false;
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 20.0)),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 100.0, 0.0),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_model.showPatients || _model.showSearch)
                          Container(
                            height: 925.0,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _model.showSearch
                                                ? 'Search Patients'
                                                : 'Patients',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .headlineLarge
                                                .override(
                                                  font: GoogleFonts.readexPro(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _model.showSearch
                                                    ? 'Find Patients on FHIR Server by typing all or part of a name.'
                                                    : 'List of patients on the FHIR Server.',
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                              ),
                                              Expanded(
                                                child: RichText(
                                                  textScaler:
                                                      MediaQuery.of(context)
                                                          .textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: _model.showSearch &&
                                                                (_model.searchNameTextController
                                                                            .text !=
                                                                        '')
                                                            ? 'Found '
                                                            : 'Total ',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: _model.showSearch &&
                                                                (_model.searchNameTextController
                                                                            .text !=
                                                                        '')
                                                            ? _model
                                                                .simpleSearchResults
                                                                .length
                                                                .toString()
                                                            : _model.allPatients
                                                                .length
                                                                .toString(),
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' Patients ',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
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
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 220.0)),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.fetchPatientsWithNews2 =
                                            await actions
                                                .fetchFhirPatientsWithLatestNews2(
                                          FFAppState().fhirBaseUrl,
                                          FFAppState().fhirBearerToken,
                                          '2026-05-18',
                                        );
                                        _model.allPatients = _model
                                            .fetchPatientsWithNews2!
                                            .toList()
                                            .cast<PatientStruct>();
                                        _model.sortedAllPatients = _model
                                            .fetchPatientsWithNews2!
                                            .sortedList(
                                                keyOf: (e) =>
                                                    e.latestNEWS2Score,
                                                desc: true)
                                            .toList()
                                            .cast<PatientStruct>();
                                        safeSetState(() {});
                                        safeSetState(() {
                                          _model.searchNameTextController
                                              ?.clear();
                                        });

                                        safeSetState(() {});
                                      },
                                      text: 'Refresh',
                                      icon: Icon(
                                        Icons.refresh_rounded,
                                        size: 22.0,
                                      ),
                                      options: FFButtonOptions(
                                        height: 50.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Colors.transparent,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
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
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        hoverColor: FlutterFlowTheme.of(context)
                                            .cardBlue,
                                        hoverBorderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                        hoverTextColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.showPatients = false;
                                        _model.showSearch = false;
                                        _model.showCreateEditPatient = true;
                                        _model.showActivity = false;
                                        _model.showSettings = false;
                                        _model.patientMode = PatientMode.create;
                                        safeSetState(() {});
                                        safeSetState(() {
                                          _model.firstNameTextController
                                              ?.clear();
                                          _model.lastNameTextController
                                              ?.clear();
                                          _model.phoneNumberTextController
                                              ?.clear();
                                        });
                                        _model.selectedDob = null;
                                        safeSetState(() {});
                                        safeSetState(() {
                                          _model.genderCCValueController
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color: Colors.white,
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
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ]
                                      .divide(SizedBox(width: 20.0))
                                      .around(SizedBox(width: 20.0)),
                                ),
                                if (_model.showSearch)
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FlutterFlowRadioButton(
                                        options: ['FHIR Query', 'Simple Search']
                                            .toList(),
                                        onChanged: (val) async {
                                          safeSetState(() {});
                                          safeSetState(() {
                                            _model.searchNameTextController
                                                ?.clear();
                                          });
                                          _model.displaySimpleSearchPatients =
                                              false;
                                          safeSetState(() {});
                                        },
                                        controller:
                                            _model.searchTypeValueController ??=
                                                FormFieldController<String>(
                                                    'FHIR Query'),
                                        optionHeight: 28.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        selectedTextStyle: FlutterFlowTheme.of(
                                                context)
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
                                        buttonPosition:
                                            RadioButtonPosition.left,
                                        direction: Axis.vertical,
                                        radioButtonColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        inactiveRadioButtonColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                        toggleable: false,
                                        horizontalAlignment:
                                            WrapAlignment.start,
                                        verticalAlignment:
                                            WrapCrossAlignment.start,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          ),
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: TextFormField(
                                            controller:
                                                _model.searchNameTextController,
                                            focusNode:
                                                _model.searchNameFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.searchNameTextController',
                                              Duration(milliseconds: 200),
                                              () async {
                                                if (_model.searchNameTextController
                                                            .text ==
                                                        '') {
                                                  _model.displaySimpleSearchPatients =
                                                      false;
                                                  _model.displayFHIRSearchPatients =
                                                      false;
                                                  _model.currentPatientPage = 0;
                                                  safeSetState(() {});
                                                  await _model
                                                      .pageViewController1
                                                      ?.animateToPage(
                                                    0,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.ease,
                                                  );
                                                } else {
                                                  if (_model.searchTypeValue ==
                                                      'Simple Search') {
                                                    if (_model.searchNameTextController
                                                                .text !=
                                                            '') {
                                                      safeSetState(() {
                                                        _model
                                                            .simpleSearchResults = TextSearch((_model
                                                                        .sortedAllPatients
                                                                        .map((e) => e
                                                                            .combinedNames)
                                                                        .toList()
                                                                    as List)
                                                                .cast<String>()
                                                                .map((str) =>
                                                                    TextSearchItem.fromTerms(
                                                                        str,
                                                                        [str]))
                                                                .toList())
                                                            .search(_model
                                                                .searchNameTextController
                                                                .text)
                                                            .map(
                                                                (r) => r.object)
                                                            .toList();
                                                        ;
                                                      });
                                                      _model.displaySimpleSearchPatients =
                                                          true;
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.displaySimpleSearchPatients =
                                                          false;
                                                      safeSetState(() {});
                                                    }
                                                  }
                                                }
                                              },
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
                                              hintText: _model
                                                          .searchTypeValue ==
                                                      'FHIR Query'
                                                  ? 'Enter the Patient\'s Name and Click the Search Button.'
                                                  : 'Enter the Patient\'s Name',
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
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
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
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              prefixIcon: Icon(
                                                FontAwesomeIcons.search,
                                              ),
                                              suffixIcon: _model
                                                      .searchNameTextController!
                                                      .text
                                                      .isNotEmpty
                                                  ? InkWell(
                                                      onTap: () async {
                                                        _model
                                                            .searchNameTextController
                                                            ?.clear();
                                                        if (_model.searchNameTextController
                                                                    .text ==
                                                                '') {
                                                          _model.displaySimpleSearchPatients =
                                                              false;
                                                          _model.displayFHIRSearchPatients =
                                                              false;
                                                          _model.currentPatientPage =
                                                              0;
                                                          safeSetState(() {});
                                                          await _model
                                                              .pageViewController1
                                                              ?.animateToPage(
                                                            0,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    500),
                                                            curve: Curves.ease,
                                                          );
                                                        } else {
                                                          if (_model
                                                                  .searchTypeValue ==
                                                              'Simple Search') {
                                                            if (_model.searchNameTextController
                                                                        .text !=
                                                                    '') {
                                                              safeSetState(() {
                                                                _model
                                                                    .simpleSearchResults = TextSearch((_model.sortedAllPatients.map((e) => e.combinedNames).toList()
                                                                            as List)
                                                                        .cast<
                                                                            String>()
                                                                        .map((str) =>
                                                                            TextSearchItem.fromTerms(str, [
                                                                              str
                                                                            ]))
                                                                        .toList())
                                                                    .search(_model
                                                                        .searchNameTextController
                                                                        .text)
                                                                    .map((r) =>
                                                                        r.object)
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
                                                .searchNameTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                      if (_model.searchTypeValue ==
                                          'FHIR Query')
                                        FlutterFlowIconButton(
                                          borderRadius: 20.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          hoverColor:
                                              FlutterFlowTheme.of(context)
                                                  .cardBlue,
                                          hoverIconColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          hoverBorderColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          icon: FaIcon(
                                            FontAwesomeIcons.search,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 24.0,
                                          ),
                                          showLoadingIndicator: true,
                                          onPressed: () async {
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Please Wait..!! Loading Data.....',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                              ),
                                            );
                                            _model.fHIRSearchPatients =
                                                await SearchPatientsCall.call(
                                              token:
                                                  FFAppState().fhirBearerToken,
                                              searchTerm: _model
                                                  .searchNameTextController
                                                  .text,
                                            );

                                            if ((_model.fHIRSearchPatients
                                                    ?.succeeded ??
                                                true)) {
                                              _model.allFHIRSearchPatients =
                                                  functions
                                                      .parseFhirPatients(
                                                          SearchPatientsCall
                                                              .entries(
                                                            (_model.fHIRSearchPatients
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )?.toList(),
                                                          functions
                                                              .convertDateStringListtoDateTimeList(
                                                                  SearchPatientsCall
                                                                      .lastUpdated(
                                                                (_model.fHIRSearchPatients
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )?.toList())
                                                              .toList())!
                                                      .toList()
                                                      .cast<PatientStruct>();
                                              _model.displaySimpleSearchPatients =
                                                  false;
                                              _model.displayFHIRSearchPatients =
                                                  true;
                                              safeSetState(() {});
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text('Error'),
                                                    content: Text((_model
                                                            .fHIRSearchPatients
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

                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();

                                            safeSetState(() {});
                                          },
                                        ),
                                      Container(
                                        width: 250.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .cardBlue,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons
                                                  .check_circle_outline_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 24.0,
                                            ),
                                            Text(
                                              'Supports Partial Match',
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
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
                                          ]
                                              .divide(SizedBox(width: 10.0))
                                              .around(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 20.0))
                                        .around(SizedBox(width: 20.0)),
                                  ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: wrapWithModel(
                                            model: _model
                                                .tableHeaderComponentNameModel1,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child:
                                                CustomTableHeaderComponentWidget(
                                              columnName: 'Name',
                                              isSelected:
                                                  _model.selectedTableColumn ==
                                                      'Name',
                                              isAscending: _model
                                                  .isAscendingSelectedTableColumn,
                                              topLeftBorderRadius: 10.0,
                                              bgColor:
                                                  FlutterFlowTheme.of(context)
                                                      .cardAlternate,
                                              onClick: (columnName) async {
                                                if (_model
                                                        .selectedTableColumn ==
                                                    columnName) {
                                                  _model.isAscendingSelectedTableColumn =
                                                      !_model
                                                          .isAscendingSelectedTableColumn;
                                                  safeSetState(() {});
                                                } else {
                                                  _model.isAscendingSelectedTableColumn =
                                                      false;
                                                  _model.selectedTableColumn =
                                                      columnName;
                                                  safeSetState(() {});
                                                }

                                                if (_model
                                                        .selectedTableColumn ==
                                                    'Name') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .combinedNames,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .combinedNames,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Gender') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.gender,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.gender,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Date of Birth') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.birthDate,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.birthDate,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Phone Number') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model
                                                            .allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .telecomValue,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model
                                                            .allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .telecomValue,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Latest News Score') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients = _model
                                                        .allPatients
                                                        .sortedList(
                                                            keyOf: (e) => e
                                                                .latestNEWS2Score,
                                                            desc: false)
                                                        .toList()
                                                        .cast<PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients = _model
                                                        .allPatients
                                                        .sortedList(
                                                            keyOf: (e) => e
                                                                .latestNEWS2Score,
                                                            desc: true)
                                                        .toList()
                                                        .cast<PatientStruct>();
                                                    safeSetState(() {});
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
                                                .tableHeaderComponentGenderModel1,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child:
                                                CustomTableHeaderComponentWidget(
                                              columnName: 'Gender',
                                              isSelected:
                                                  _model.selectedTableColumn ==
                                                      'Gender',
                                              isAscending: _model
                                                  .isAscendingSelectedTableColumn,
                                              bgColor:
                                                  FlutterFlowTheme.of(context)
                                                      .cardAlternate,
                                              onClick: (columnName) async {
                                                if (_model
                                                        .selectedTableColumn ==
                                                    columnName) {
                                                  _model.isAscendingSelectedTableColumn =
                                                      !_model
                                                          .isAscendingSelectedTableColumn;
                                                  safeSetState(() {});
                                                } else {
                                                  _model.isAscendingSelectedTableColumn =
                                                      false;
                                                  _model.selectedTableColumn =
                                                      columnName;
                                                  safeSetState(() {});
                                                }

                                                if (_model
                                                        .selectedTableColumn ==
                                                    'Name') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .combinedNames,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .combinedNames,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Gender') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.gender,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.gender,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Date of Birth') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.birthDate,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.birthDate,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Phone Number') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model
                                                            .allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .telecomValue,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model
                                                            .allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .telecomValue,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Latest News Score') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients = _model
                                                        .allPatients
                                                        .sortedList(
                                                            keyOf: (e) => e
                                                                .latestNEWS2Score,
                                                            desc: false)
                                                        .toList()
                                                        .cast<PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients = _model
                                                        .allPatients
                                                        .sortedList(
                                                            keyOf: (e) => e
                                                                .latestNEWS2Score,
                                                            desc: true)
                                                        .toList()
                                                        .cast<PatientStruct>();
                                                    safeSetState(() {});
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
                                                .tableHeaderComponentDOBModel1,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child:
                                                CustomTableHeaderComponentWidget(
                                              columnName: 'Date of Birth',
                                              isSelected:
                                                  _model.selectedTableColumn ==
                                                      'Date of Birth',
                                              isAscending: _model
                                                  .isAscendingSelectedTableColumn,
                                              bgColor:
                                                  FlutterFlowTheme.of(context)
                                                      .cardAlternate,
                                              onClick: (columnName) async {
                                                if (_model
                                                        .selectedTableColumn ==
                                                    columnName) {
                                                  _model.isAscendingSelectedTableColumn =
                                                      !_model
                                                          .isAscendingSelectedTableColumn;
                                                  safeSetState(() {});
                                                } else {
                                                  _model.isAscendingSelectedTableColumn =
                                                      false;
                                                  _model.selectedTableColumn =
                                                      columnName;
                                                  safeSetState(() {});
                                                }

                                                if (_model
                                                        .selectedTableColumn ==
                                                    'Name') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .combinedNames,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .combinedNames,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Gender') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.gender,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.gender,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Date of Birth') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.birthDate,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.birthDate,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Phone Number') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model
                                                            .allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .telecomValue,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model
                                                            .allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .telecomValue,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Latest News Score') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients = _model
                                                        .allPatients
                                                        .sortedList(
                                                            keyOf: (e) => e
                                                                .latestNEWS2Score,
                                                            desc: false)
                                                        .toList()
                                                        .cast<PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients = _model
                                                        .allPatients
                                                        .sortedList(
                                                            keyOf: (e) => e
                                                                .latestNEWS2Score,
                                                            desc: true)
                                                        .toList()
                                                        .cast<PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        if (_model.showSearch)
                                          Expanded(
                                            flex: 1,
                                            child: wrapWithModel(
                                              model: _model
                                                  .tableHeaderComponentPhoneNumberModel1,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child:
                                                  CustomTableHeaderComponentWidget(
                                                columnName: 'Phone Number',
                                                isSelected: _model
                                                        .selectedTableColumn ==
                                                    'Phone Number',
                                                isAscending: _model
                                                    .isAscendingSelectedTableColumn,
                                                bgColor:
                                                    FlutterFlowTheme.of(context)
                                                        .cardAlternate,
                                                onClick: (columnName) async {
                                                  if (_model
                                                          .selectedTableColumn ==
                                                      columnName) {
                                                    _model.isAscendingSelectedTableColumn =
                                                        !_model
                                                            .isAscendingSelectedTableColumn;
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.isAscendingSelectedTableColumn =
                                                        false;
                                                    _model.selectedTableColumn =
                                                        columnName;
                                                    safeSetState(() {});
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
                                                              desc: false)
                                                          .toList()
                                                          .cast<
                                                              PatientStruct>();
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.sortedAllPatients = _model
                                                          .allPatients
                                                          .sortedList(
                                                              keyOf: (e) => e
                                                                  .combinedNames,
                                                              desc: true)
                                                          .toList()
                                                          .cast<
                                                              PatientStruct>();
                                                      safeSetState(() {});
                                                    }
                                                  } else if (_model
                                                          .selectedTableColumn ==
                                                      'Gender') {
                                                    if (_model
                                                        .isAscendingSelectedTableColumn) {
                                                      _model.sortedAllPatients =
                                                          _model.allPatients
                                                              .sortedList(
                                                                  keyOf: (e) =>
                                                                      e.gender,
                                                                  desc: false)
                                                              .toList()
                                                              .cast<
                                                                  PatientStruct>();
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.sortedAllPatients =
                                                          _model.allPatients
                                                              .sortedList(
                                                                  keyOf: (e) =>
                                                                      e.gender,
                                                                  desc: true)
                                                              .toList()
                                                              .cast<
                                                                  PatientStruct>();
                                                      safeSetState(() {});
                                                    }
                                                  } else if (_model
                                                          .selectedTableColumn ==
                                                      'Date of Birth') {
                                                    if (_model
                                                        .isAscendingSelectedTableColumn) {
                                                      _model.sortedAllPatients =
                                                          _model.allPatients
                                                              .sortedList(
                                                                  keyOf: (e) => e
                                                                      .birthDate,
                                                                  desc: false)
                                                              .toList()
                                                              .cast<
                                                                  PatientStruct>();
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.sortedAllPatients =
                                                          _model.allPatients
                                                              .sortedList(
                                                                  keyOf: (e) => e
                                                                      .birthDate,
                                                                  desc: true)
                                                              .toList()
                                                              .cast<
                                                                  PatientStruct>();
                                                      safeSetState(() {});
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
                                                              desc: false)
                                                          .toList()
                                                          .cast<
                                                              PatientStruct>();
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.sortedAllPatients = _model
                                                          .allPatients
                                                          .sortedList(
                                                              keyOf: (e) => e
                                                                  .telecomValue,
                                                              desc: true)
                                                          .toList()
                                                          .cast<
                                                              PatientStruct>();
                                                      safeSetState(() {});
                                                    }
                                                  } else if (_model
                                                          .selectedTableColumn ==
                                                      'Latest News Score') {
                                                    if (_model
                                                        .isAscendingSelectedTableColumn) {
                                                      _model.sortedAllPatients = _model
                                                          .allPatients
                                                          .sortedList(
                                                              keyOf: (e) => e
                                                                  .latestNEWS2Score,
                                                              desc: false)
                                                          .toList()
                                                          .cast<
                                                              PatientStruct>();
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.sortedAllPatients = _model
                                                          .allPatients
                                                          .sortedList(
                                                              keyOf: (e) => e
                                                                  .latestNEWS2Score,
                                                              desc: true)
                                                          .toList()
                                                          .cast<
                                                              PatientStruct>();
                                                      safeSetState(() {});
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
                                                .tableHeaderComponentPhoneNumberModel2,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child:
                                                CustomTableHeaderComponentWidget(
                                              columnName: 'Latest NEWS2 Score',
                                              isSelected:
                                                  _model.selectedTableColumn ==
                                                      'Latest NEWS2 Score',
                                              isAscending: _model
                                                  .isAscendingSelectedTableColumn,
                                              bgColor:
                                                  FlutterFlowTheme.of(context)
                                                      .cardAlternate,
                                              subHeader: 'Score/Risk',
                                              onClick: (columnName) async {
                                                if (_model
                                                        .selectedTableColumn ==
                                                    columnName) {
                                                  _model.isAscendingSelectedTableColumn =
                                                      !_model
                                                          .isAscendingSelectedTableColumn;
                                                  safeSetState(() {});
                                                } else {
                                                  _model.isAscendingSelectedTableColumn =
                                                      false;
                                                  _model.selectedTableColumn =
                                                      columnName;
                                                  safeSetState(() {});
                                                }

                                                if (_model
                                                        .selectedTableColumn ==
                                                    'Name') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .combinedNames,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .combinedNames,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Gender') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.gender,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.gender,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Date of Birth') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.birthDate,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model.allPatients
                                                            .sortedList(
                                                                keyOf: (e) =>
                                                                    e.birthDate,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Phone Number') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients =
                                                        _model
                                                            .allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .telecomValue,
                                                                desc: false)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients =
                                                        _model
                                                            .allPatients
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .telecomValue,
                                                                desc: true)
                                                            .toList()
                                                            .cast<
                                                                PatientStruct>();
                                                    safeSetState(() {});
                                                  }
                                                } else if (_model
                                                        .selectedTableColumn ==
                                                    'Latest News Score') {
                                                  if (_model
                                                      .isAscendingSelectedTableColumn) {
                                                    _model.sortedAllPatients = _model
                                                        .allPatients
                                                        .sortedList(
                                                            keyOf: (e) => e
                                                                .latestNEWS2Score,
                                                            desc: false)
                                                        .toList()
                                                        .cast<PatientStruct>();
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.sortedAllPatients = _model
                                                        .allPatients
                                                        .sortedList(
                                                            keyOf: (e) => e
                                                                .latestNEWS2Score,
                                                            desc: true)
                                                        .toList()
                                                        .cast<PatientStruct>();
                                                    safeSetState(() {});
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
                                                safeSetState(() {}),
                                            child:
                                                CustomTableHeaderComponentWidget(
                                              columnName: 'Actions',
                                              isSelected: false,
                                              isAscending: false,
                                              topRIghtBorderRadius: 10.0,
                                              bgColor:
                                                  FlutterFlowTheme.of(context)
                                                      .cardAlternate,
                                              onClick: (columnName) async {},
                                            ),
                                          ),
                                        ),
                                      ]
                                          .addToStart(SizedBox(width: 20.0))
                                          .addToEnd(SizedBox(width: 20.0)),
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final pages =
                                            functions.createPageIndices(() {
                                          if (_model
                                              .displaySimpleSearchPatients) {
                                            return _model.allPatients
                                                .where((e) => _model
                                                    .simpleSearchResults
                                                    .contains(e.combinedNames))
                                                .toList()
                                                .length;
                                          } else if (_model
                                              .displayFHIRSearchPatients) {
                                            return _model
                                                .allFHIRSearchPatients.length;
                                          } else {
                                            return _model
                                                .sortedAllPatients.length;
                                          }
                                        }(), 10).toList();
                                        if (pages.isEmpty) {
                                          return Center(
                                            child: EmptyWidgetWidget(),
                                          );
                                        }

                                        return Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 540.0,
                                          child: PageView.builder(
                                            controller: _model
                                                    .pageViewController1 ??=
                                                PageController(
                                                    initialPage: max(
                                                        0,
                                                        min(0,
                                                            pages.length - 1))),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: pages.length,
                                            itemBuilder: (context, pagesIndex) {
                                              final pagesItem =
                                                  pages[pagesIndex];
                                              return Builder(
                                                builder: (context) {
                                                  final allPatientsListTable =
                                                      () {
                                                            if (_model
                                                                .displaySimpleSearchPatients) {
                                                              return functions.slicePatientsListForTablePages(
                                                                  _model
                                                                      .allPatients
                                                                      .where((e) => _model
                                                                          .simpleSearchResults
                                                                          .contains(e
                                                                              .combinedNames))
                                                                      .toList(),
                                                                  pagesIndex *
                                                                      10,
                                                                  (pagesIndex +
                                                                          1) *
                                                                      10);
                                                            } else if (_model
                                                                .displayFHIRSearchPatients) {
                                                              return functions.slicePatientsListForTablePages(
                                                                  _model
                                                                      .allFHIRSearchPatients
                                                                      .toList(),
                                                                  pagesIndex *
                                                                      10,
                                                                  (pagesIndex +
                                                                          1) *
                                                                      10);
                                                            } else {
                                                              return functions.slicePatientsListForTablePages(
                                                                  _model
                                                                      .sortedAllPatients
                                                                      .toList(),
                                                                  pagesIndex *
                                                                      10,
                                                                  (pagesIndex +
                                                                          1) *
                                                                      10);
                                                            }
                                                          }()
                                                              ?.toList() ??
                                                          [];

                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: List.generate(
                                                        allPatientsListTable
                                                            .length,
                                                        (allPatientsListTableIndex) {
                                                      final allPatientsListTableItem =
                                                          allPatientsListTable[
                                                              allPatientsListTableIndex];
                                                      return Builder(
                                                        builder: (context) =>
                                                            wrapWithModel(
                                                          model: _model
                                                              .patientTableRowComponentModels
                                                              .getModel(
                                                            allPatientsListTableIndex
                                                                .toString(),
                                                            allPatientsListTableIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              PatientTableRowComponentWidget(
                                                            key: Key(
                                                              'Key4mq_${allPatientsListTableIndex.toString()}',
                                                            ),
                                                            patientRow:
                                                                allPatientsListTableItem,
                                                            showPhoneNumber:
                                                                _model
                                                                    .showSearch,
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
                                                                  PatientMode
                                                                      .edit;
                                                              _model.patientSelectedForEdit =
                                                                  patientRow;
                                                              _model.selectedDob =
                                                                  functions.convertSingleDateStringtoDateTime(
                                                                      patientRow
                                                                          .birthDate);
                                                              safeSetState(
                                                                  () {});
                                                              await Future
                                                                  .delayed(
                                                                Duration(
                                                                  milliseconds:
                                                                      100,
                                                                ),
                                                              );
                                                              safeSetState(() {
                                                                _model.firstNameTextController
                                                                        ?.text =
                                                                    patientRow
                                                                        .givenNames;
                                                              });
                                                              safeSetState(() {
                                                                _model.lastNameTextController
                                                                        ?.text =
                                                                    patientRow
                                                                        .familyName;
                                                              });
                                                              safeSetState(() {
                                                                _model
                                                                    .genderCCValueController
                                                                    ?.value = [
                                                                  functions.capitalizeFirst(
                                                                      patientRow
                                                                          .gender)
                                                                ];
                                                              });
                                                              safeSetState(() {
                                                                _model.phoneNumberTextController
                                                                        ?.text =
                                                                    patientRow
                                                                        .telecomValue;
                                                              });
                                                              if (animationsMap[
                                                                      'containerOnActionTriggerAnimation1'] !=
                                                                  null) {
                                                                await animationsMap[
                                                                        'containerOnActionTriggerAnimation1']!
                                                                    .controller
                                                                    .forward(
                                                                        from:
                                                                            0.0);
                                                              }
                                                              if (animationsMap[
                                                                      'containerOnActionTriggerAnimation1'] !=
                                                                  null) {
                                                                await animationsMap[
                                                                        'containerOnActionTriggerAnimation1']!
                                                                    .controller
                                                                    .reverse();
                                                              }
                                                            },
                                                            onDeleteAction:
                                                                (patientRow) async {
                                                              var _shouldSetState =
                                                                  false;
                                                              var confirmDialogResponse =
                                                                  await showDialog<
                                                                          bool>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Warning'),
                                                                            content:
                                                                                Text('Are you sure you want to delete this patient..?? This process is irreversible..!!'),
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
                                                                  safeSetState(
                                                                      () {});
                                                                return;
                                                              }
                                                              _model.deletePatient =
                                                                  await DeletePatientCall
                                                                      .call(
                                                                id: patientRow
                                                                    .identifier,
                                                                token: FFAppState()
                                                                    .fhirBearerToken,
                                                              );

                                                              _shouldSetState =
                                                                  true;
                                                              if ((_model
                                                                      .deletePatient
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Patient Deleted successfully..!!',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .info,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .success,
                                                                  ),
                                                                );
                                                              } else {
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (alertDialogContext) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Delete Failed'),
                                                                      content: Text((_model
                                                                              .deletePatient
                                                                              ?.bodyText ??
                                                                          '')),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                          child:
                                                                              Text('Ok'),
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

                                                              _model.allPatientsQuery4 =
                                                                  await GetAllPatientsCall
                                                                      .call(
                                                                token: FFAppState()
                                                                    .fhirBearerToken,
                                                              );

                                                              _shouldSetState =
                                                                  true;
                                                              if ((_model
                                                                      .allPatientsQuery4
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                _model.allPatients = functions
                                                                    .parseFhirPatients(
                                                                        GetAllPatientsCall.entries(
                                                                          (_model.allPatientsQuery4?.jsonBody ??
                                                                              ''),
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
                                                                          (_model.allPatientsQuery4?.jsonBody ??
                                                                              ''),
                                                                        )?.toList(),
                                                                        functions
                                                                            .convertDateStringListtoDateTimeList(GetAllPatientsCall.lastUpdated(
                                                                              (_model.allPatientsQuery4?.jsonBody ?? ''),
                                                                            )?.toList())
                                                                            .toList())!
                                                                    .sortedList(keyOf: (e) => e.combinedNames, desc: false)
                                                                    .toList()
                                                                    .cast<PatientStruct>();
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                            },
                                                            showDetailsCallBack:
                                                                (patientRow) async {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (dialogContext) {
                                                                  return Dialog(
                                                                    elevation:
                                                                        0,
                                                                    insetPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    child:
                                                                        CommonWaitComponentWidget(
                                                                      infoText:
                                                                          'Fetching Data.....',
                                                                    ),
                                                                  );
                                                                },
                                                              );

                                                              _model.patientSelectedForDetails =
                                                                  patientRow;
                                                              _model.patientObservations =
                                                                  [];
                                                              _model.patientConditions =
                                                                  [];
                                                              _model.patientMedications =
                                                                  [];
                                                              await Future
                                                                  .wait([
                                                                Future(
                                                                    () async {
                                                                  _model.bundleResponse =
                                                                      await PatientBundleRequestsCall
                                                                          .call(
                                                                    token: FFAppState()
                                                                        .fhirBearerToken,
                                                                    id: _model
                                                                        .patientSelectedForDetails
                                                                        ?.identifier,
                                                                  );

                                                                  if ((_model
                                                                          .bundleResponse
                                                                          ?.succeeded ??
                                                                      true)) {
                                                                    if (PatientBundleRequestsCall
                                                                            .observationTotal(
                                                                          (_model.bundleResponse?.jsonBody ??
                                                                              ''),
                                                                        )! >
                                                                        0) {
                                                                      _model.patientObservations = functions
                                                                          .parseFhirObservations(PatientBundleRequestsCall.observationEntries(
                                                                            (_model.bundleResponse?.jsonBody ??
                                                                                ''),
                                                                          )!
                                                                              .toList())
                                                                          .toList()
                                                                          .cast<ObservationStruct>();
                                                                    } else {
                                                                      _model.patientObservations =
                                                                          [];
                                                                    }

                                                                    if (PatientBundleRequestsCall
                                                                            .conditionTotal(
                                                                          (_model.bundleResponse?.jsonBody ??
                                                                              ''),
                                                                        )! >
                                                                        0) {
                                                                      _model.patientConditions = functions
                                                                          .parseFhirConditions(PatientBundleRequestsCall.conditionEntries(
                                                                            (_model.bundleResponse?.jsonBody ??
                                                                                ''),
                                                                          )!
                                                                              .toList())
                                                                          .sortedList(keyOf: (e) => e.onsetDate!, desc: false)
                                                                          .toList()
                                                                          .cast<ConditionStruct>();
                                                                    } else {
                                                                      _model.patientConditions =
                                                                          [];
                                                                    }

                                                                    if (PatientBundleRequestsCall
                                                                            .medicationTotal(
                                                                          (_model.bundleResponse?.jsonBody ??
                                                                              ''),
                                                                        )! >
                                                                        0) {
                                                                      _model.patientMedications = functions
                                                                          .parseFhirMedications(PatientBundleRequestsCall.medicationEntries(
                                                                            (_model.bundleResponse?.jsonBody ??
                                                                                ''),
                                                                          )!
                                                                              .toList())
                                                                          .sortedList(keyOf: (e) => e.medicationName, desc: false)
                                                                          .toList()
                                                                          .cast<MedicationStruct>();
                                                                    } else {
                                                                      _model.patientMedications =
                                                                          [];
                                                                    }

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
                                                                    _model.showPatientDetails =
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
                                                                          title:
                                                                              Text('Error'),
                                                                          content:
                                                                              Text((_model.bundleResponse?.bodyText ?? '')),
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

                                                                  Navigator.pop(
                                                                      context);
                                                                  await Future
                                                                      .delayed(
                                                                    Duration(
                                                                      milliseconds:
                                                                          200,
                                                                    ),
                                                                  );
                                                                  if (animationsMap[
                                                                          'containerOnActionTriggerAnimation2'] !=
                                                                      null) {
                                                                    await animationsMap[
                                                                            'containerOnActionTriggerAnimation2']!
                                                                        .controller
                                                                        .forward(
                                                                            from:
                                                                                0.0)
                                                                        .whenComplete(animationsMap['containerOnActionTriggerAnimation2']!
                                                                            .controller
                                                                            .reverse);
                                                                  }
                                                                  if (animationsMap[
                                                                          'containerOnActionTriggerAnimation2'] !=
                                                                      null) {
                                                                    animationsMap[
                                                                            'containerOnActionTriggerAnimation2']!
                                                                        .controller
                                                                        .stop();
                                                                  }
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  safeSetState(() =>
                                                                      _model.apiRequestCompleter =
                                                                          null);
                                                                  await _model
                                                                      .waitForApiRequestCompleted();
                                                                }),
                                                              ]);

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                          ),
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
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Pages',
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
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final pages2 =
                                                functions.createPageIndices(() {
                                              if (_model
                                                  .displaySimpleSearchPatients) {
                                                return _model.allPatients
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
                                                    .sortedAllPatients.length;
                                              }
                                            }(), 10).toList();

                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  pages2.length, (pages2Index) {
                                                final pages2Item =
                                                    pages2[pages2Index];
                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.currentPatientPage =
                                                        pages2Item;
                                                    safeSetState(() {});
                                                    await _model
                                                        .pageViewController1
                                                        ?.animateToPage(
                                                      _model.currentPatientPage,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease,
                                                    );
                                                  },
                                                  child: wrapWithModel(
                                                    model: _model
                                                        .customDotComponentPageViewModels1
                                                        .getModel(
                                                      pages2Item.toString(),
                                                      pages2Index,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        CustomDotComponentPageViewWidget(
                                                      key: Key(
                                                        'Keycvo_${pages2Item.toString()}',
                                                      ),
                                                      isSelected: _model
                                                              .currentPatientPage ==
                                                          pages2Item,
                                                      assignedIdx: pages2Item,
                                                    ),
                                                  ),
                                                );
                                              }).divide(SizedBox(width: 10.0)),
                                            );
                                          },
                                        ),
                                      ].divide(SizedBox(width: 10.0)),
                                    ),
                                  ],
                                ),
                              ]
                                  .divide(SizedBox(height: 10.0))
                                  .around(SizedBox(height: 10.0)),
                            ),
                          ),
                        if (_model.showCreateEditPatient ||
                            (_model.patientMode == PatientMode.edit))
                          Container(
                            height: 925.0,
                            decoration: BoxDecoration(),
                            child: SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_model.patientMode == PatientMode.edit)
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
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
                                            _model.showPatients = true;
                                            _model.showSearch = false;
                                            _model.showCreateEditPatient =
                                                false;
                                            _model.showActivity = false;
                                            _model.showSettings = false;
                                            _model.selectedDob = null;
                                            _model.patientMode =
                                                PatientMode.create;
                                            _model.patientSelectedForEdit =
                                                null;
                                            safeSetState(() {});
                                          },
                                          child: Text(
                                            'Patient',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          '/',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
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
                                            _model.patientSelectedForEdit
                                                ?.combinedNames,
                                            'Name',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          '/',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          'Edit',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
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
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _model.patientMode ==
                                                      PatientMode.edit
                                                  ? 'Edit Patient'
                                                  : 'Create Patient',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineLarge
                                                  .override(
                                                    font: GoogleFonts.readexPro(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Text(
                                              _model.patientMode ==
                                                      PatientMode.edit
                                                  ? 'Edit Details of a Patient already existing in FHIR server.'
                                                  : 'Add a New Patient to the FHIR Server.',
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
                                          ]
                                              .divide(SizedBox(height: 10.0))
                                              .addToStart(SizedBox(height: 5.0))
                                              .addToEnd(SizedBox(height: 5.0)),
                                        ),
                                      ),
                                      if (_model.patientMode ==
                                          PatientMode.edit)
                                        FFButtonWidget(
                                          onPressed: () async {
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
                                            _model.showPatients = true;
                                            _model.showSearch = false;
                                            _model.showCreateEditPatient =
                                                false;
                                            _model.showActivity = false;
                                            _model.showSettings = false;
                                            _model.selectedDob = null;
                                            _model.patientMode =
                                                PatientMode.create;
                                            _model.patientSelectedForEdit =
                                                null;
                                            safeSetState(() {});
                                          },
                                          text: 'Back to Patients',
                                          icon: Icon(
                                            Icons.arrow_back_rounded,
                                            size: 24.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: 200.0,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            color: Colors.transparent,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.inter(
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 18.0,
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
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            hoverColor:
                                                FlutterFlowTheme.of(context)
                                                    .cardBlue,
                                            hoverBorderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            hoverTextColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                          ),
                                        ),
                                    ]
                                        .divide(SizedBox(width: 20.0))
                                        .around(SizedBox(width: 20.0)),
                                  ),
                                  if (_model.patientMode == PatientMode.edit)
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 1399.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: Color(0x8AD0FFEE),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .success,
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
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
                                                  ),
                                                ].divide(SizedBox(width: 20.0)),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                                child: VerticalDivider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
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
                                                  ),
                                                  SelectionArea(
                                                      child: Text(
                                                    valueOrDefault<String>(
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
                                                  )),
                                                ].divide(SizedBox(width: 20.0)),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                                child: VerticalDivider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
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
                                                  ),
                                                ].divide(SizedBox(width: 20.0)),
                                              ),
                                            ]
                                                .divide(SizedBox(width: 10.0))
                                                .around(SizedBox(width: 10.0)),
                                          ),
                                        ).animateOnActionTrigger(
                                          animationsMap[
                                              'containerOnActionTriggerAnimation1']!,
                                        ),
                                      ]
                                          .divide(SizedBox(width: 20.0))
                                          .around(SizedBox(width: 20.0)),
                                    ),
                                  Form(
                                    key: _model.formKey,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
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
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'First Name   ',
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                  TextSpan(
                                                                    text: '*',
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                    ),
                                                                  )
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
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
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 10.0))
                                                              .around(SizedBox(
                                                                  width: 10.0)),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.4,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.4,
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .firstNameTextController,
                                                              focusNode: _model
                                                                  .firstNameFocusNode,
                                                              onChanged: (_) =>
                                                                  EasyDebounce
                                                                      .debounce(
                                                                '_model.firstNameTextController',
                                                                Duration(
                                                                    milliseconds:
                                                                        200),
                                                                () =>
                                                                    safeSetState(
                                                                        () {}),
                                                              ),
                                                              autofocus: false,
                                                              enabled: true,
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
                                                                      fontSize:
                                                                          14.0,
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
                                                                    'First Name and Middle Name(s) (if any)',
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
                                                                        .alternate,
                                                                    width: 2.0,
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
                                                                    width: 2.0,
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
                                                                    width: 2.0,
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
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                filled: true,
                                                                fillColor: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                suffixIcon: _model
                                                                        .firstNameTextController!
                                                                        .text
                                                                        .isNotEmpty
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          _model
                                                                              .firstNameTextController
                                                                              ?.clear();
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .clear,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
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
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        20.0,
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
                                                                  .firstNameTextControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 10.0)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Last Name   ',
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                  TextSpan(
                                                                    text: '*',
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                    ),
                                                                  )
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
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
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 10.0))
                                                              .around(SizedBox(
                                                                  width: 10.0)),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.4,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.4,
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .lastNameTextController,
                                                              focusNode: _model
                                                                  .lastNameFocusNode,
                                                              onChanged: (_) =>
                                                                  EasyDebounce
                                                                      .debounce(
                                                                '_model.lastNameTextController',
                                                                Duration(
                                                                    milliseconds:
                                                                        200),
                                                                () =>
                                                                    safeSetState(
                                                                        () {}),
                                                              ),
                                                              autofocus: false,
                                                              enabled: true,
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
                                                                    'Last Name (Family Name Only)',
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
                                                                        .alternate,
                                                                    width: 2.0,
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
                                                                    width: 2.0,
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
                                                                    width: 2.0,
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
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                filled: true,
                                                                fillColor: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                suffixIcon: _model
                                                                        .lastNameTextController!
                                                                        .text
                                                                        .isNotEmpty
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          _model
                                                                              .lastNameTextController
                                                                              ?.clear();
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .clear,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
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
                                                                    fontSize:
                                                                        20.0,
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
                                                                  .lastNameTextControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 10.0))
                                                          .around(SizedBox(
                                                              height: 10.0)),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(width: 20.0))
                                                    .around(
                                                        SizedBox(width: 20.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Gender  ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text: '*',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                  ),
                                                                )
                                                              ],
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
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                width: 10.0))
                                                            .around(SizedBox(
                                                                width: 10.0)),
                                                      ),
                                                      FlutterFlowChoiceChips(
                                                        options: [
                                                          ChipData(
                                                              'Male',
                                                              Icons
                                                                  .male_rounded),
                                                          ChipData(
                                                              'Female',
                                                              Icons
                                                                  .female_rounded),
                                                          ChipData(
                                                              'Other',
                                                              Icons
                                                                  .transgender_rounded)
                                                        ],
                                                        onChanged: (val) =>
                                                            safeSetState(() => _model
                                                                    .genderCCValue =
                                                                val?.firstOrNull),
                                                        selectedChipStyle:
                                                            ChipStyle(
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                          iconColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .info,
                                                          iconSize: 24.0,
                                                          labelPadding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                        ),
                                                        unselectedChipStyle:
                                                            ChipStyle(
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                          iconColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          iconSize: 24.0,
                                                          labelPadding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          elevation: 8.0,
                                                          borderColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .alternate,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                        ),
                                                        chipSpacing: 100.0,
                                                        rowSpacing: 8.0,
                                                        multiselect: false,
                                                        alignment: WrapAlignment
                                                            .spaceBetween,
                                                        controller: _model
                                                                .genderCCValueController ??=
                                                            FormFieldController<
                                                                List<String>>(
                                                          [],
                                                        ),
                                                        wrapped: true,
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 10.0))
                                                        .around(SizedBox(
                                                            height: 10.0)),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(width: 20.0))
                                                    .around(
                                                        SizedBox(width: 20.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Date of Birth  ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text: '*',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                  ),
                                                                )
                                                              ],
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
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                width: 10.0))
                                                            .around(SizedBox(
                                                                width: 10.0)),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          final _datePickedDate =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                getCurrentTimestamp,
                                                            firstDate:
                                                                DateTime(1900),
                                                            lastDate:
                                                                (getCurrentTimestamp ??
                                                                    DateTime(
                                                                        2050)),
                                                            builder: (context,
                                                                child) {
                                                              return wrapInMaterialDatePickerTheme(
                                                                context,
                                                                child!,
                                                                headerBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                headerForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                headerTextStyle:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLarge
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              32.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineLarge
                                                                              .fontStyle,
                                                                        ),
                                                                pickerBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                pickerForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                selectedDateTimeBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                selectedDateTimeForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                actionButtonForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                iconSize: 24.0,
                                                              );
                                                            },
                                                          );

                                                          if (_datePickedDate !=
                                                              null) {
                                                            safeSetState(() {
                                                              _model.datePicked =
                                                                  DateTime(
                                                                _datePickedDate
                                                                    .year,
                                                                _datePickedDate
                                                                    .month,
                                                                _datePickedDate
                                                                    .day,
                                                              );
                                                            });
                                                          } else if (_model
                                                                  .datePicked !=
                                                              null) {
                                                            safeSetState(() {
                                                              _model.datePicked =
                                                                  getCurrentTimestamp;
                                                            });
                                                          }
                                                          if (_model
                                                                  .patientMode ==
                                                              PatientMode
                                                                  .create) {
                                                            _model.selectedDob =
                                                                _model
                                                                    .datePicked;
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        text: _model.selectedDob !=
                                                                null
                                                            ? dateTimeFormat(
                                                                "y-MM-dd",
                                                                _model
                                                                    .selectedDob)
                                                            : 'Select Date',
                                                        icon: Icon(
                                                          Icons
                                                              .calendar_month_outlined,
                                                          size: 30.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 200.0,
                                                          height: 50.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconAlignment:
                                                              IconAlignment.end,
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
                                                                  .titleLarge
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleLarge
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    fontSize:
                                                                        20.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0.0,
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
                                                                      25.0),
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
                                                          hoverElevation: 8.0,
                                                        ),
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 10.0))
                                                        .around(SizedBox(
                                                            height: 10.0)),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(width: 20.0))
                                                    .around(
                                                        SizedBox(width: 20.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Phone Number  ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text: '*',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                  ),
                                                                )
                                                              ],
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
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                width: 10.0))
                                                            .around(SizedBox(
                                                                width: 10.0)),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 100.0,
                                                            height: 50.0,
                                                            child: custom_widgets
                                                                .CountryDialCodePicker(
                                                              width: 100.0,
                                                              height: 50.0,
                                                              initialDialCode:
                                                                  FFAppState()
                                                                      .selectedPhoneDialCode,
                                                              initialIsoCode:
                                                                  FFAppState()
                                                                      .selectedPhoneIsoCode,
                                                              borderRadius: 8.0,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.3,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.3,
                                                              child:
                                                                  TextFormField(
                                                                controller: _model
                                                                    .phoneNumberTextController,
                                                                focusNode: _model
                                                                    .phoneNumberFocusNode,
                                                                onChanged: (_) =>
                                                                    EasyDebounce
                                                                        .debounce(
                                                                  '_model.phoneNumberTextController',
                                                                  Duration(
                                                                      milliseconds:
                                                                          2000),
                                                                  () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                ),
                                                                autofocus:
                                                                    false,
                                                                enabled: true,
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .none,
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
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  hintText:
                                                                      'Phone Number',
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  errorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  focusedErrorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  filled: true,
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  suffixIcon: _model
                                                                          .phoneNumberTextController!
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            _model.phoneNumberTextController?.clear();
                                                                            safeSetState(() {});
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.clear,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                            size:
                                                                                22,
                                                                          ),
                                                                        )
                                                                      : null,
                                                                ),
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
                                                                      fontSize:
                                                                          20.0,
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
                                                                maxLength: 14,
                                                                maxLengthEnforcement:
                                                                    MaxLengthEnforcement
                                                                        .enforced,
                                                                buildCounter: (context,
                                                                        {required currentLength,
                                                                        required isFocused,
                                                                        maxLength}) =>
                                                                    null,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                cursorColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                enableInteractiveSelection:
                                                                    true,
                                                                validator: _model
                                                                    .phoneNumberTextControllerValidator
                                                                    .asValidator(
                                                                        context),
                                                                inputFormatters: [
                                                                  if (!isAndroid &&
                                                                      !isiOS)
                                                                    TextInputFormatter.withFunction(
                                                                        (oldValue,
                                                                            newValue) {
                                                                      return TextEditingValue(
                                                                        selection:
                                                                            newValue.selection,
                                                                        text: newValue
                                                                            .text
                                                                            .toCapitalization(TextCapitalization.none),
                                                                      );
                                                                    }),
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp(
                                                                          '^[0-9-]+\$'))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                width: 10.0))
                                                            .around(SizedBox(
                                                                width: 10.0)),
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 10.0))
                                                        .around(SizedBox(
                                                            height: 10.0)),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(width: 20.0))
                                                    .around(
                                                        SizedBox(width: 20.0)),
                                              ),
                                            ),
                                            Divider(
                                              thickness: 2.0,
                                              indent: 10.0,
                                              endIndent: 10.0,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Spacer(),
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
                                                    _model.showPatients = true;
                                                    _model.showSearch = false;
                                                    _model.showCreateEditPatient =
                                                        false;
                                                    _model.showActivity = false;
                                                    _model.showSettings = false;
                                                    _model.selectedDob = null;
                                                    _model.patientMode =
                                                        PatientMode.create;
                                                    _model.patientSelectedForEdit =
                                                        null;
                                                    safeSetState(() {});
                                                  },
                                                  text: 'Cancel',
                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                    size: 24.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 130.0,
                                                    height: 50.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    iconAlignment:
                                                        IconAlignment.end,
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    iconColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    color: Colors.transparent,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 20.0,
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
                                                    elevation: 0.0,
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    hoverColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .cardTertiary,
                                                    hoverBorderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      width: 1.0,
                                                    ),
                                                    hoverTextColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tertiary,
                                                  ),
                                                ),
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
                                                    _model.selectedDob = null;
                                                    _model.patientMode =
                                                        PatientMode.create;
                                                    _model.patientSelectedForEdit =
                                                        null;
                                                    _model.showCreateEditPatient =
                                                        true;
                                                    safeSetState(() {});
                                                  },
                                                  text: 'Reset',
                                                  icon: Icon(
                                                    Icons.refresh_outlined,
                                                    size: 24.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 130.0,
                                                    height: 50.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    iconAlignment:
                                                        IconAlignment.end,
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: Colors.transparent,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 20.0,
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
                                                    elevation: 0.0,
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    hoverColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .cardBlue,
                                                    hoverBorderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                    var _shouldSetState = false;
                                                    if (_model.formKey
                                                                .currentState ==
                                                            null ||
                                                        !_model.formKey
                                                            .currentState!
                                                            .validate()) {
                                                      return;
                                                    }
                                                    if (!(_model.genderCCValue !=
                                                            null &&
                                                        _model.genderCCValue !=
                                                            '')) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('ⓘ Error'),
                                                            content: Text(
                                                                'Gender Must be selected..!!'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }
                                                    if (!(_model.selectedDob !=
                                                        null)) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('ⓘ Error'),
                                                            content: Text(
                                                                'Date of Birth must -${dateTimeFormat("d/M/y", _model.selectedDob)}  -be chosen..!! '),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }
                                                    if (!functions.isValidPhoneNumberForCountry(
                                                        _model
                                                            .phoneNumberTextController
                                                            .text,
                                                        FFAppState()
                                                            .selectedPhoneIsoCode)) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('ⓘ Error'),
                                                            content: Text(
                                                                'Invalid Phone Number for the country selected..!! Please check the Phone Numer once again.'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }
                                                    if (_model.patientMode ==
                                                        PatientMode.create) {
                                                      _model.createNewPatient =
                                                          await CreateNewPatientCall
                                                              .call(
                                                        givenNameList: functions
                                                            .splitWords(_model
                                                                .firstNameTextController
                                                                .text),
                                                        familyName: _model
                                                            .lastNameTextController
                                                            .text,
                                                        birthDate: dateTimeFormat(
                                                            "y-MM-dd",
                                                            _model.selectedDob),
                                                        gender: (_model
                                                                .genderCCValue!)
                                                            .toLowerCase(),
                                                        phoneNumber: _model
                                                            .phoneNumberTextController
                                                            .text,
                                                        token: FFAppState()
                                                            .fhirBearerToken,
                                                      );

                                                      _shouldSetState = true;
                                                      if ((_model
                                                              .createNewPatient
                                                              ?.succeeded ??
                                                          true)) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Patient added successfully..!!',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                          ),
                                                        );
                                                      } else {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Error'),
                                                              content: Text((_model
                                                                      .createNewPatient
                                                                      ?.bodyText ??
                                                                  '')),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }
                                                    } else if (_model
                                                            .patientMode ==
                                                        PatientMode.edit) {
                                                      _model.editPatient =
                                                          await EditPatientCall
                                                              .call(
                                                        givenNameList: functions
                                                            .splitWords(_model
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
                                                        gender: (_model
                                                                .genderCCValue!)
                                                            .toLowerCase(),
                                                        token: FFAppState()
                                                            .fhirBearerToken,
                                                        id: _model
                                                            .patientSelectedForEdit
                                                            ?.identifier,
                                                      );

                                                      _shouldSetState = true;
                                                      if ((_model.editPatient
                                                              ?.succeeded ??
                                                          true)) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Patient Edited successfully..!!',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
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
                                                        safeSetState(() {});
                                                      } else {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Error'),
                                                              content: Text((_model
                                                                      .editPatient
                                                                      ?.bodyText ??
                                                                  '')),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }
                                                    } else {
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }

                                                    _model.fetchPatientsWithNews3 =
                                                        await actions
                                                            .fetchFhirPatientsWithLatestNews2(
                                                      FFAppState().fhirBaseUrl,
                                                      FFAppState()
                                                          .fhirBearerToken,
                                                      '2026-05-18',
                                                    );
                                                    _shouldSetState = true;
                                                    _model.allPatients = _model
                                                        .fetchPatientsWithNews3!
                                                        .toList()
                                                        .cast<PatientStruct>();
                                                    _model.sortedAllPatients = _model
                                                        .fetchPatientsWithNews3!
                                                        .sortedList(
                                                            keyOf: (e) => e
                                                                .latestNEWS2Score,
                                                            desc: true)
                                                        .toList()
                                                        .cast<PatientStruct>();
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
                                                    safeSetState(() {
                                                      _model
                                                          .genderCCValueController
                                                          ?.reset();
                                                    });
                                                    _model.selectedDob = null;
                                                    safeSetState(() {});
                                                    await _model
                                                        .pageViewController1
                                                        ?.animateToPage(
                                                      _model.currentPatientPage,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease,
                                                    );
                                                    if (_shouldSetState)
                                                      safeSetState(() {});
                                                  },
                                                  text: _model.patientMode ==
                                                          PatientMode.edit
                                                      ? 'Edit Patient'
                                                      : 'Create Patient',
                                                  icon: Icon(
                                                    Icons.add_rounded,
                                                    size: 24.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 200.0,
                                                    height: 50.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                          color: Colors.white,
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
                                                    elevation: 0.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                ),
                                              ]
                                                  .divide(SizedBox(width: 20.0))
                                                  .around(
                                                      SizedBox(width: 20.0)),
                                            ),
                                          ]
                                              .divide(SizedBox(height: 10.0))
                                              .around(SizedBox(height: 10.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(height: 8.0))
                                    .around(SizedBox(height: 8.0)),
                              ),
                            ),
                          ),
                        if (_model.showActivity)
                          Container(
                            height: 925.0,
                            decoration: BoxDecoration(),
                            child: Text(
                              'Activity',
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
                          ),
                        if (_model.showSettings)
                          Container(
                            height: 925.0,
                            decoration: BoxDecoration(),
                            child: Text(
                              'Settings',
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
                          ),
                        if (_model.showPatientDetails)
                          FutureBuilder<ApiCallResponse>(
                            future: (_model.apiRequestCompleter ??= Completer<
                                    ApiCallResponse>()
                                  ..complete(
                                      GetAdmissionEncounterByPatientIDCall.call(
                                    token: FFAppState().fhirBearerToken,
                                    id: _model
                                        .patientSelectedForDetails?.identifier,
                                  )))
                                .future,
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: LinearProgressIndicator(
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                              }
                              final patientDetailsContainerGetAdmissionEncounterByPatientIDResponse =
                                  snapshot.data!;

                              return Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.showPatients = true;
                                            _model.showSearch = false;
                                            _model.showCreateEditPatient =
                                                false;
                                            _model.showActivity = false;
                                            _model.showSettings = false;
                                            _model.selectedDob = null;
                                            _model.patientMode =
                                                PatientMode.create;
                                            _model.patientSelectedForDetails =
                                                null;
                                            _model.showPatientDetails = false;
                                            safeSetState(() {});
                                            await _model.pageViewController1
                                                ?.animateToPage(
                                              _model.currentPatientPage,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          child: Text(
                                            'Patient',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          '/',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
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
                                            _model.patientSelectedForDetails
                                                ?.combinedNames,
                                            'NAME',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
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
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Patient Details',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .headlineLarge
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Text(
                                                'View the patient\'s basic demographic information from the FHIR Server.',
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
                                            ]
                                                .divide(SizedBox(height: 10.0))
                                                .addToStart(
                                                    SizedBox(height: 5.0))
                                                .addToEnd(
                                                    SizedBox(height: 5.0)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            alignment:
                                                AlignmentDirectional(1.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                _model.showPatients = true;
                                                _model.showSearch = false;
                                                _model.showCreateEditPatient =
                                                    false;
                                                _model.showActivity = false;
                                                _model.showSettings = false;
                                                _model.selectedDob = null;
                                                _model.patientMode =
                                                    PatientMode.create;
                                                _model.patientSelectedForDetails =
                                                    null;
                                                _model.showPatientDetails =
                                                    false;
                                                safeSetState(() {});
                                                await _model.pageViewController1
                                                    ?.animateToPage(
                                                  _model.currentPatientPage,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              text: 'Back to Patients',
                                              icon: Icon(
                                                Icons.arrow_back_rounded,
                                                size: 24.0,
                                              ),
                                              options: FFButtonOptions(
                                                width: 200.0,
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                iconColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                color: Colors.transparent,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.inter(
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 18.0,
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
                                                elevation: 0.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                hoverColor:
                                                    FlutterFlowTheme.of(context)
                                                        .cardBlue,
                                                hoverBorderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                hoverTextColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          decoration: BoxDecoration(),
                                        ),
                                      ]
                                          .divide(SizedBox(width: 20.0))
                                          .around(SizedBox(width: 20.0)),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 1250.0,
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 60.0,
                                                            height: 60.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: () {
                                                                if (_model
                                                                        .patientSelectedForDetails
                                                                        ?.gender ==
                                                                    'male') {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .cardBlue;
                                                                } else if (_model
                                                                        .patientSelectedForDetails
                                                                        ?.gender ==
                                                                    'female') {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .cardSuccess;
                                                                } else {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .cardTertiary;
                                                                }
                                                              }(),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                child: Text(
                                                                  functions.getInitials(
                                                                      _model
                                                                          .patientSelectedForDetails!
                                                                          .givenNames,
                                                                      _model
                                                                          .patientSelectedForDetails!
                                                                          .familyName),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color:
                                                                            () {
                                                                          if (_model.patientSelectedForDetails?.gender ==
                                                                              'male') {
                                                                            return FlutterFlowTheme.of(context).primary;
                                                                          } else if (_model.patientSelectedForDetails?.gender ==
                                                                              'female') {
                                                                            return FlutterFlowTheme.of(context).success;
                                                                          } else {
                                                                            return FlutterFlowTheme.of(context).tertiary;
                                                                          }
                                                                        }(),
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${valueOrDefault<String>(
                                                                  _model
                                                                      .patientSelectedForDetails
                                                                      ?.familyName,
                                                                  'name',
                                                                )}, ${valueOrDefault<String>(
                                                                  _model
                                                                      .patientSelectedForDetails
                                                                      ?.givenNames,
                                                                  'name',
                                                                )}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .headlineMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                              ),
                                                              Container(
                                                                height: 30.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .cardSuccess,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .success,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                child: Row(
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
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Text(
                                                                      'FHIR Synced.',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).success,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
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
                                                                    'containerOnActionTriggerAnimation2']!,
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 10.0)),
                                                          ),
                                                          if (kDebugMode &&
                                                              responsiveVisibility(
                                                                context:
                                                                    context,
                                                                phone: false,
                                                                tablet: false,
                                                                tabletLandscape:
                                                                    false,
                                                                desktop: false,
                                                              ))
                                                            InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await Clipboard.setData(ClipboardData(
                                                                    text: _model
                                                                        .patientSelectedForDetails!
                                                                        .identifier));
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .content_copy_rounded,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                size: 24.0,
                                                              ),
                                                            ),
                                                          if (kDebugMode &&
                                                              responsiveVisibility(
                                                                context:
                                                                    context,
                                                                phone: false,
                                                                tablet: false,
                                                                tabletLandscape:
                                                                    false,
                                                                desktop: false,
                                                              ))
                                                            InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await Clipboard.setData(
                                                                    ClipboardData(
                                                                        text: GetAdmissionEncounterByPatientIDCall
                                                                            .encounterID(
                                                                  patientDetailsContainerGetAdmissionEncounterByPatientIDResponse
                                                                      .jsonBody,
                                                                )!));
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .content_copy_rounded,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                size: 24.0,
                                                              ),
                                                            ),
                                                        ]
                                                            .divide(SizedBox(
                                                                width: 150.0))
                                                            .addToStart(
                                                                SizedBox(
                                                                    width:
                                                                        30.0))
                                                            .addToEnd(SizedBox(
                                                                width: 50.0)),
                                                      ),
                                                    ),
                                                  ),
                                                  if ((GetAdmissionEncounterByPatientIDCall
                                                              .total(
                                                            patientDetailsContainerGetAdmissionEncounterByPatientIDResponse
                                                                .jsonBody,
                                                          )! >
                                                          0) &&
                                                      (GetAdmissionEncounterByPatientIDCall
                                                              .encounterStatus(
                                                            patientDetailsContainerGetAdmissionEncounterByPatientIDResponse
                                                                .jsonBody,
                                                          ) ==
                                                          'in-progress') &&
                                                      (GetAdmissionEncounterByPatientIDCall
                                                              .encounterType(
                                                            patientDetailsContainerGetAdmissionEncounterByPatientIDResponse
                                                                .jsonBody,
                                                          ) ==
                                                          'IMP'))
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            AlignedTooltip(
                                                              content: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            4.0),
                                                                child: Text(
                                                                  'Encounter ID: ${GetAdmissionEncounterByPatientIDCall.encounterID(
                                                                    patientDetailsContainerGetAdmissionEncounterByPatientIDResponse
                                                                        .jsonBody,
                                                                  )}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
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
                                                              preferredDirection:
                                                                  AxisDirection
                                                                      .up,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              elevation: 4.0,
                                                              tailBaseWidth:
                                                                  24.0,
                                                              tailLength: 12.0,
                                                              waitDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          100),
                                                              showDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          1500),
                                                              triggerMode:
                                                                  TooltipTriggerMode
                                                                      .tap,
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .bed,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                                size: 24.0,
                                                              ),
                                                            ),
                                                            Text(
                                                              'In-Patient',
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
                                                          ].divide(SizedBox(
                                                              width: 10.0)),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            AlignedTooltip(
                                                              content: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            4.0),
                                                                child: Text(
                                                                  'Date of Admission',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
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
                                                              preferredDirection:
                                                                  AxisDirection
                                                                      .up,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              elevation: 4.0,
                                                              tailBaseWidth:
                                                                  24.0,
                                                              tailLength: 12.0,
                                                              waitDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          100),
                                                              showDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          1500),
                                                              triggerMode:
                                                                  TooltipTriggerMode
                                                                      .tap,
                                                              child: Icon(
                                                                Icons
                                                                    .calendar_month_outlined,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 24.0,
                                                              ),
                                                            ),
                                                            Text(
                                                              dateTimeFormat(
                                                                  "y-MM-dd",
                                                                  functions.convertSingleDateStringtoDateTime(
                                                                      GetAdmissionEncounterByPatientIDCall
                                                                          .admissionDate(
                                                                    patientDetailsContainerGetAdmissionEncounterByPatientIDResponse
                                                                        .jsonBody,
                                                                  ))),
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
                                                          ].divide(SizedBox(
                                                              width: 10.0)),
                                                        ),
                                                      ],
                                                    ),
                                                  if (_model
                                                          .patientSelectedForDetails
                                                          ?.hasLatestNEWS2Score ??
                                                      true)
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 400.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  if (_model
                                                                          .patientSelectedForDetails!
                                                                          .hasLatestNEWS2Score &&
                                                                      (_model.patientSelectedForDetails!
                                                                              .latestNEWS2Score <=
                                                                          4) &&
                                                                      !_model
                                                                          .patientSelectedForDetails!
                                                                          .latestSingleRedScore) {
                                                                    return Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            FaIcon(
                                                                          FontAwesomeIcons
                                                                              .smile,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).success,
                                                                          size:
                                                                              30.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              Builder(
                                                                                builder: (context) {
                                                                                  if (_model.patientSelectedForDetails!.latestNEWS2Score >= 7) {
                                                                                    return Icon(
                                                                                      Icons.wb_incandescent_rounded,
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      size: 24.0,
                                                                                    );
                                                                                  } else {
                                                                                    return Icon(
                                                                                      Icons.wb_incandescent_outlined,
                                                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                                                      size: 30.0,
                                                                                    );
                                                                                  }
                                                                                },
                                                                              ),
                                                                              Expanded(
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Text(
                                                                                    functions.decodeNewsScore(_model.patientSelectedForDetails!.latestNEWS2Score, _model.patientSelectedForDetails!.latestSingleRedScore).interpretation,
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
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 10.0)),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              Icon(
                                                                                Icons.person_search_sharp,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 24.0,
                                                                              ),
                                                                              Expanded(
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Text(
                                                                                    functions.decodeNewsScore(_model.patientSelectedForDetails!.latestNEWS2Score, _model.patientSelectedForDetails!.latestSingleRedScore).assessmentBy,
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
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 10.0)),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              Icon(
                                                                                Icons.looks_one_outlined,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 24.0,
                                                                              ),
                                                                              Expanded(
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Text(
                                                                                    functions.decodeNewsScore(_model.patientSelectedForDetails!.latestNEWS2Score, _model.patientSelectedForDetails!.latestSingleRedScore).action1,
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
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 10.0)),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              Icon(
                                                                                Icons.looks_two_outlined,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 24.0,
                                                                              ),
                                                                              Expanded(
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Text(
                                                                                    functions.decodeNewsScore(_model.patientSelectedForDetails!.latestNEWS2Score, _model.patientSelectedForDetails!.latestSingleRedScore).action2,
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
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 10.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await Navigator
                                                                    .push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .fade,
                                                                    child:
                                                                        FlutterFlowExpandedImageView(
                                                                      image: Image
                                                                          .asset(
                                                                        'assets/images/The-NEWS2-scoring-system-Reproduced-from-Royal-College-of-Physicians-National-Early.webp',
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      allowRotation:
                                                                          false,
                                                                      tag:
                                                                          'imageTag',
                                                                      useHeroAnimation:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Hero(
                                                                tag: 'imageTag',
                                                                transitionOnUserGestures:
                                                                    true,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/The-NEWS2-scoring-system-Reproduced-from-Royal-College-of-Physicians-National-Early.webp',
                                                                    width: 75.0,
                                                                    height:
                                                                        75.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ].addToEnd(
                                                    SizedBox(width: 10.0)),
                                              ),
                                              Divider(
                                                thickness: 2.0,
                                                indent: 30.0,
                                                endIndent: 30.0,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
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
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Full name',
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
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .person_rounded,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 24.0,
                                                                ),
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    _model
                                                                        .patientSelectedForDetails
                                                                        ?.combinedNames,
                                                                    'Name',
                                                                  ),
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
                                                                  width: 10.0)),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 10.0)),
                                                        ),
                                                      ]
                                                          .addToStart(SizedBox(
                                                              width: 20.0))
                                                          .addToEnd(SizedBox(
                                                              width: 20.0)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 100.0,
                                                    child: VerticalDivider(
                                                      thickness: 2.0,
                                                      indent: 20.0,
                                                      endIndent: 20.0,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Gender',
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
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    if (_model
                                                                            .patientSelectedForDetails
                                                                            ?.gender ==
                                                                        'male') {
                                                                      return Icon(
                                                                        Icons
                                                                            .male_rounded,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        size:
                                                                            24.0,
                                                                      );
                                                                    } else if (_model
                                                                            .patientSelectedForDetails
                                                                            ?.gender ==
                                                                        'female') {
                                                                      return Icon(
                                                                        Icons
                                                                            .female_rounded,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .success,
                                                                        size:
                                                                            24.0,
                                                                      );
                                                                    } else {
                                                                      return Icon(
                                                                        Icons
                                                                            .transgender_rounded,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                        size:
                                                                            24.0,
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                                Text(
                                                                  functions.capitalizeFirst(
                                                                      valueOrDefault<
                                                                          String>(
                                                                    _model
                                                                        .patientSelectedForDetails
                                                                        ?.gender,
                                                                    'Gender',
                                                                  )),
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
                                                                  width: 10.0)),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 10.0)),
                                                        ),
                                                      ]
                                                          .addToStart(SizedBox(
                                                              width: 20.0))
                                                          .addToEnd(SizedBox(
                                                              width: 20.0)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 100.0,
                                                    child: VerticalDivider(
                                                      thickness: 2.0,
                                                      indent: 20.0,
                                                      endIndent: 20.0,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Date of Birth',
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
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .calendar_month,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 24.0,
                                                                ),
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    _model
                                                                        .patientSelectedForDetails
                                                                        ?.birthDate,
                                                                    'Birth Date',
                                                                  ),
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
                                                                  width: 10.0)),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 10.0)),
                                                        ),
                                                      ]
                                                          .addToStart(SizedBox(
                                                              width: 20.0))
                                                          .addToEnd(SizedBox(
                                                              width: 20.0)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 100.0,
                                                    child: VerticalDivider(
                                                      thickness: 2.0,
                                                      indent: 20.0,
                                                      endIndent: 20.0,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Phone Number',
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
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .phone,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 20.0,
                                                                ),
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    _model
                                                                        .patientSelectedForDetails
                                                                        ?.telecomValue,
                                                                    'Phone Number',
                                                                  ),
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
                                                                  width: 10.0)),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 10.0)),
                                                        ),
                                                      ]
                                                          .addToStart(SizedBox(
                                                              width: 20.0))
                                                          .addToEnd(SizedBox(
                                                              width: 20.0)),
                                                    ),
                                                  ),
                                                ]
                                                    .addToStart(
                                                        SizedBox(width: 20.0))
                                                    .addToEnd(
                                                        SizedBox(width: 20.0)),
                                              ),
                                            ]
                                                .divide(SizedBox(height: 6.0))
                                                .around(SizedBox(height: 6.0)),
                                          ),
                                        ),
                                      ]
                                          .divide(SizedBox(width: 20.0))
                                          .around(SizedBox(width: 20.0)),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 10.0, 0.0, 0.0),
                                        child: Container(
                                          width: 1250.0,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              1.0,
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment(1.0, 0),
                                                child: FlutterFlowButtonTabBar(
                                                  useToggleButtonStyle: true,
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .readexPro(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontStyle,
                                                          ),
                                                  unselectedLabelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .readexPro(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontStyle,
                                                          ),
                                                  labelColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                  unselectedLabelColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  unselectedBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .cardAlternate,
                                                  unselectedBorderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  borderWidth: 1.0,
                                                  borderRadius: 10.0,
                                                  elevation: 0.0,
                                                  buttonMargin:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(5.0, 0.0,
                                                              5.0, 0.0),
                                                  padding: EdgeInsets.all(10.0),
                                                  tabs: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .chartLine,
                                                          ),
                                                        ),
                                                        Tab(
                                                          text: 'Vital Signs',
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons.notes_rounded,
                                                          ),
                                                        ),
                                                        Tab(
                                                          text:
                                                              'Active Conditions',
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .pills,
                                                          ),
                                                        ),
                                                        Tab(
                                                          text:
                                                              'Current Medications',
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons.warning_amber,
                                                          ),
                                                        ),
                                                        Tab(
                                                          text: 'NEWS2 Score',
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                  controller:
                                                      _model.tabBarController,
                                                  onTap: (i) async {
                                                    [
                                                      () async {},
                                                      () async {},
                                                      () async {},
                                                      () async {}
                                                    ][i]();
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: TabBarView(
                                                  controller:
                                                      _model.tabBarController,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Wrap(
                                                            spacing: 20.0,
                                                            runSpacing: 0.0,
                                                            alignment:
                                                                WrapAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .start,
                                                            direction:
                                                                Axis.horizontal,
                                                            runAlignment:
                                                                WrapAlignment
                                                                    .start,
                                                            verticalDirection:
                                                                VerticalDirection
                                                                    .down,
                                                            clipBehavior:
                                                                Clip.none,
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Blood Pressure',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  Builder(
                                                                    builder:
                                                                        (context) {
                                                                      if (_model
                                                                          .patientObservations
                                                                          .where((e) =>
                                                                              e.name ==
                                                                              'Systolic blood pressure')
                                                                          .toList()
                                                                          .isNotEmpty) {
                                                                        return Container(
                                                                          decoration:
                                                                              BoxDecoration(
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
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                1100.0,
                                                                            height:
                                                                                250.0,
                                                                            child:
                                                                                custom_widgets.LineChart(
                                                                              width: 1100.0,
                                                                              height: 250.0,
                                                                              isLogarithmicYAxis: false,
                                                                              minCount: double.parse(_model.patientObservations.where((e) => e.name == 'Diastolic blood pressure').toList().sortedList(keyOf: (e) => e.value, desc: false).firstOrNull!.value),
                                                                              maxCount: double.parse(_model.patientObservations.where((e) => e.name == 'Systolic blood pressure').toList().sortedList(keyOf: (e) => e.value, desc: false).lastOrNull!.value),
                                                                              name1: 'Systolic BP',
                                                                              name2: 'Diastolic BP',
                                                                              isExpanded: true,
                                                                              factor: 1.0,
                                                                              yAxisTitle: 'Blood Pressure',
                                                                              xData: functions.convertUTCtoISTDatetime(_model.patientObservations.where((e) => e.name == 'Systolic blood pressure').toList().map((e) => e.recordedAt).withoutNulls.toList()).sortedList(keyOf: (e) => e, desc: false).map((e) => dateTimeFormat("d/M H:mm", e)).toList(),
                                                                              yData1: (List<String> strList) {
                                                                                return strList.map((e) => double.parse(e)).toList();
                                                                              }(_model.patientObservations.where((e) => e.name == 'Systolic blood pressure').toList().sortedList(keyOf: (e) => e.recordedAt!, desc: false).map((e) => e.value).toList()),
                                                                              yData2: (List<String> strList) {
                                                                                return strList.map((e) => double.parse(e)).toList();
                                                                              }(_model.patientObservations.where((e) => e.name == 'Diastolic blood pressure').toList().sortedList(keyOf: (e) => e.recordedAt!, desc: false).map((e) => e.value).toList()),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                          width:
                                                                              1240.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
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
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(10.0),
                                                                            child:
                                                                                Text(
                                                                              'No Data Found',
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).info,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        height:
                                                                            10.0))
                                                                    .around(SizedBox(
                                                                        height:
                                                                            10.0)),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Heart Rate',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  Builder(
                                                                    builder:
                                                                        (context) {
                                                                      if (_model
                                                                          .patientObservations
                                                                          .where((e) =>
                                                                              e.name ==
                                                                              'Heart rate')
                                                                          .toList()
                                                                          .isNotEmpty) {
                                                                        return Container(
                                                                          decoration:
                                                                              BoxDecoration(
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
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                390.0,
                                                                            height:
                                                                                250.0,
                                                                            child:
                                                                                custom_widgets.LineChart(
                                                                              width: 390.0,
                                                                              height: 250.0,
                                                                              isLogarithmicYAxis: false,
                                                                              minCount: double.parse(_model.patientObservations.where((e) => e.name == 'Heart rate').toList().sortedList(keyOf: (e) => e.value, desc: false).firstOrNull!.value),
                                                                              maxCount: double.parse(_model.patientObservations.where((e) => e.name == 'Heart rate').toList().sortedList(keyOf: (e) => e.value, desc: false).lastOrNull!.value),
                                                                              name1: 'Heart Rate',
                                                                              isExpanded: true,
                                                                              factor: 1.0,
                                                                              yAxisTitle: 'Heart Rate',
                                                                              xData: functions.convertUTCtoISTDatetime(_model.patientObservations.where((e) => e.name == 'Heart rate').toList().map((e) => e.recordedAt).withoutNulls.toList()).sortedList(keyOf: (e) => e, desc: false).map((e) => dateTimeFormat("d/M H:mm", e)).toList(),
                                                                              yData1: (List<String> strList) {
                                                                                return strList.map((e) => double.parse(e)).toList();
                                                                              }(_model.patientObservations.where((e) => e.name == 'Heart rate').toList().sortedList(keyOf: (e) => e.recordedAt!, desc: false).map((e) => e.value).toList()),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                          width:
                                                                              390.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
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
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(10.0),
                                                                            child:
                                                                                Text(
                                                                              'No Data Found',
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).info,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        height:
                                                                            10.0))
                                                                    .around(SizedBox(
                                                                        height:
                                                                            10.0)),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Body Temperature',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  Builder(
                                                                    builder:
                                                                        (context) {
                                                                      if (_model
                                                                          .patientObservations
                                                                          .where((e) =>
                                                                              e.name ==
                                                                              'Body temperature')
                                                                          .toList()
                                                                          .isNotEmpty) {
                                                                        return Container(
                                                                          decoration:
                                                                              BoxDecoration(
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
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                390.0,
                                                                            height:
                                                                                250.0,
                                                                            child:
                                                                                custom_widgets.LineChart(
                                                                              width: 390.0,
                                                                              height: 250.0,
                                                                              isLogarithmicYAxis: false,
                                                                              minCount: double.parse(_model.patientObservations.where((e) => e.name == 'Body temperature').toList().sortedList(keyOf: (e) => e.value, desc: false).firstOrNull!.value),
                                                                              maxCount: double.parse(_model.patientObservations.where((e) => e.name == 'Body temperature').toList().sortedList(keyOf: (e) => e.value, desc: false).lastOrNull!.value),
                                                                              name1: 'Temperature',
                                                                              isExpanded: true,
                                                                              factor: 1.0,
                                                                              yAxisTitle: 'Temperature',
                                                                              xData: functions.convertUTCtoISTDatetime(_model.patientObservations.where((e) => e.name == 'Body temperature').toList().map((e) => e.recordedAt).withoutNulls.toList()).sortedList(keyOf: (e) => e, desc: false).map((e) => dateTimeFormat("d/M H:mm", e)).toList(),
                                                                              yData1: (List<String> strList) {
                                                                                return strList.map((e) => double.parse(e)).toList();
                                                                              }(_model.patientObservations.where((e) => e.name == 'Body temperature').toList().sortedList(keyOf: (e) => e.recordedAt!, desc: false).map((e) => e.value).toList()),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                          width:
                                                                              390.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
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
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(10.0),
                                                                            child:
                                                                                Text(
                                                                              'No Data Found',
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).info,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        height:
                                                                            10.0))
                                                                    .around(SizedBox(
                                                                        height:
                                                                            10.0)),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Respiratory Rate',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  Builder(
                                                                    builder:
                                                                        (context) {
                                                                      if (_model
                                                                          .patientObservations
                                                                          .where((e) =>
                                                                              e.name ==
                                                                              'Body temperature')
                                                                          .toList()
                                                                          .isNotEmpty) {
                                                                        return Container(
                                                                          decoration:
                                                                              BoxDecoration(
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
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                390.0,
                                                                            height:
                                                                                250.0,
                                                                            child:
                                                                                custom_widgets.LineChart(
                                                                              width: 390.0,
                                                                              height: 250.0,
                                                                              isLogarithmicYAxis: false,
                                                                              minCount: double.parse(_model.patientObservations.where((e) => e.name == 'Respiratory rate').toList().sortedList(keyOf: (e) => e.value, desc: false).firstOrNull!.value),
                                                                              maxCount: double.parse(_model.patientObservations.where((e) => e.name == 'Respiratory rate').toList().sortedList(keyOf: (e) => e.value, desc: false).lastOrNull!.value),
                                                                              name1: 'Respiratory Rate',
                                                                              isExpanded: true,
                                                                              factor: 1.0,
                                                                              yAxisTitle: 'RespiratoryRate',
                                                                              xData: functions.convertUTCtoISTDatetime(_model.patientObservations.where((e) => e.name == 'Respiratory rate').toList().map((e) => e.recordedAt).withoutNulls.toList()).sortedList(keyOf: (e) => e, desc: false).map((e) => dateTimeFormat("d/M H:mm", e)).toList(),
                                                                              yData1: (List<String> strList) {
                                                                                return strList.map((e) => double.parse(e)).toList();
                                                                              }(_model.patientObservations.where((e) => e.name == 'Respiratory rate').toList().sortedList(keyOf: (e) => e.recordedAt!, desc: false).map((e) => e.value).toList()),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                          width:
                                                                              390.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
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
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(10.0),
                                                                            child:
                                                                                Text(
                                                                              'No Data Found',
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).info,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        height:
                                                                            10.0))
                                                                    .around(SizedBox(
                                                                        height:
                                                                            10.0)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .tableHeaderComponentNameModel2,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomTableHeaderComponentWidget(
                                                                      columnName:
                                                                          'Condition',
                                                                      isSelected:
                                                                          _model.selectedConditionsTableColumn ==
                                                                              'Condition',
                                                                      isAscending:
                                                                          _model
                                                                              .isAscendingConditionsTableColumn,
                                                                      topLeftBorderRadius:
                                                                          10.0,
                                                                      bgColor:
                                                                          Color(
                                                                              0xFFFDFDFF),
                                                                      onClick:
                                                                          (columnName) async {
                                                                        if (_model.selectedConditionsTableColumn ==
                                                                            columnName) {
                                                                          _model.isAscendingConditionsTableColumn =
                                                                              !_model.isAscendingConditionsTableColumn;
                                                                          safeSetState(
                                                                              () {});
                                                                        } else {
                                                                          _model.isAscendingConditionsTableColumn =
                                                                              true;
                                                                          _model.selectedConditionsTableColumn =
                                                                              columnName!;
                                                                          safeSetState(
                                                                              () {});
                                                                        }

                                                                        if (_model.selectedConditionsTableColumn ==
                                                                            'Onset Date') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.onsetDate!, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.onsetDate!, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedConditionsTableColumn ==
                                                                            'Condition') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionName, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionName, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedConditionsTableColumn ==
                                                                            'Code') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionCode, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionCode, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedConditionsTableColumn ==
                                                                            'Status') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.status, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.status, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .tableHeaderComponentGenderModel2,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomTableHeaderComponentWidget(
                                                                      columnName:
                                                                          'Code',
                                                                      isSelected:
                                                                          _model.selectedConditionsTableColumn ==
                                                                              'Code',
                                                                      isAscending:
                                                                          _model
                                                                              .isAscendingConditionsTableColumn,
                                                                      bgColor:
                                                                          Color(
                                                                              0xFFFDFDFF),
                                                                      onClick:
                                                                          (columnName) async {
                                                                        if (_model.selectedConditionsTableColumn ==
                                                                            columnName) {
                                                                          _model.isAscendingConditionsTableColumn =
                                                                              !_model.isAscendingConditionsTableColumn;
                                                                          safeSetState(
                                                                              () {});
                                                                        } else {
                                                                          _model.isAscendingConditionsTableColumn =
                                                                              true;
                                                                          _model.selectedConditionsTableColumn =
                                                                              columnName!;
                                                                          safeSetState(
                                                                              () {});
                                                                        }

                                                                        if (_model.selectedConditionsTableColumn ==
                                                                            'Onset Date') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.onsetDate!, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.onsetDate!, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedConditionsTableColumn ==
                                                                            'Condition') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionName, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionName, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedConditionsTableColumn ==
                                                                            'Code') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionCode, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionCode, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedConditionsTableColumn ==
                                                                            'Status') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.status, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.status, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .tableHeaderComponentDOBModel2,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomTableHeaderComponentWidget(
                                                                      columnName:
                                                                          'Onset Date',
                                                                      isSelected:
                                                                          _model.selectedConditionsTableColumn ==
                                                                              'Onset Date',
                                                                      isAscending:
                                                                          _model
                                                                              .isAscendingConditionsTableColumn,
                                                                      bgColor:
                                                                          Color(
                                                                              0xFFFDFDFF),
                                                                      onClick:
                                                                          (columnName) async {
                                                                        if (_model.selectedConditionsTableColumn ==
                                                                            columnName) {
                                                                          _model.isAscendingConditionsTableColumn =
                                                                              !_model.isAscendingConditionsTableColumn;
                                                                          safeSetState(
                                                                              () {});
                                                                        } else {
                                                                          _model.isAscendingConditionsTableColumn =
                                                                              true;
                                                                          _model.selectedConditionsTableColumn =
                                                                              columnName!;
                                                                          safeSetState(
                                                                              () {});
                                                                        }

                                                                        if (_model.selectedConditionsTableColumn ==
                                                                            'Onset Date') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.onsetDate!, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.onsetDate!, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedConditionsTableColumn ==
                                                                            'Condition') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionName, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionName, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedConditionsTableColumn ==
                                                                            'Code') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionCode, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.conditionCode, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedConditionsTableColumn ==
                                                                            'Status') {
                                                                          if (_model
                                                                              .isAscendingConditionsTableColumn) {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.status, desc: false).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientConditions =
                                                                                _model.patientConditions.sortedList(keyOf: (e) => e.status, desc: true).toList().cast<ConditionStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .tableHeaderComponentPhoneNumberModel3,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomTableHeaderComponentWidget(
                                                                      columnName:
                                                                          'Status',
                                                                      isSelected:
                                                                          false,
                                                                      isAscending:
                                                                          false,
                                                                      topRIghtBorderRadius:
                                                                          10.0,
                                                                      bgColor:
                                                                          Color(
                                                                              0xFFFDFDFF),
                                                                      onClick:
                                                                          (columnName) async {},
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                                  .addToStart(
                                                                      SizedBox(
                                                                          width:
                                                                              20.0))
                                                                  .addToEnd(
                                                                      SizedBox(
                                                                          width:
                                                                              20.0)),
                                                            ),
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                final conditionPages = functions
                                                                    .createPageIndices(
                                                                        _model
                                                                            .patientConditions
                                                                            .length,
                                                                        5)
                                                                    .toList();
                                                                if (conditionPages
                                                                    .isEmpty) {
                                                                  return Center(
                                                                    child:
                                                                        EmptyWidgetWidget(),
                                                                  );
                                                                }

                                                                return Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: 270.0,
                                                                  child: PageView
                                                                      .builder(
                                                                    controller: _model
                                                                            .pageViewController2 ??=
                                                                        PageController(
                                                                            initialPage:
                                                                                max(0, min(0, conditionPages.length - 1))),
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    itemCount:
                                                                        conditionPages
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            conditionPagesIndex) {
                                                                      final conditionPagesItem =
                                                                          conditionPages[
                                                                              conditionPagesIndex];
                                                                      return Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final conditionsList =
                                                                              functions.sliceConditionsListForTablePages(_model.patientConditions.toList(), conditionPagesItem * 5, (conditionPagesItem + 1) * 5)?.toList() ?? [];

                                                                          return SingleChildScrollView(
                                                                            primary:
                                                                                false,
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: List.generate(conditionsList.length, (conditionsListIndex) {
                                                                                final conditionsListItem = conditionsList[conditionsListIndex];
                                                                                return wrapWithModel(
                                                                                  model: _model.conditioonTableRowComponentModels.getModel(
                                                                                    conditionsListIndex.toString(),
                                                                                    conditionsListIndex,
                                                                                  ),
                                                                                  updateCallback: () => safeSetState(() {}),
                                                                                  child: ConditioonTableRowComponentWidget(
                                                                                    key: Key(
                                                                                      'Keyjli_${conditionsListIndex.toString()}',
                                                                                    ),
                                                                                    conditionsRow: conditionsListItem,
                                                                                  ),
                                                                                );
                                                                              }),
                                                                            ),
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
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Pages',
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
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final pages2 = functions
                                                                        .createPageIndices(
                                                                            _model.patientConditions.length,
                                                                            5)
                                                                        .toList();

                                                                    return Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          pages2
                                                                              .length,
                                                                          (pages2Index) {
                                                                        final pages2Item =
                                                                            pages2[pages2Index];
                                                                        return InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            _model.currentPatientPage =
                                                                                pages2Item;
                                                                            safeSetState(() {});
                                                                            await _model.pageViewController2?.animateToPage(
                                                                              _model.currentPatientPage,
                                                                              duration: Duration(milliseconds: 500),
                                                                              curve: Curves.ease,
                                                                            );
                                                                          },
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.customDotComponentPageViewModels2.getModel(
                                                                              pages2Item.toString(),
                                                                              pages2Index,
                                                                            ),
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomDotComponentPageViewWidget(
                                                                              key: Key(
                                                                                'Key9no_${pages2Item.toString()}',
                                                                              ),
                                                                              isSelected: _model.currentPatientPage == pages2Item,
                                                                              assignedIdx: pages2Item,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          width:
                                                                              10.0)),
                                                                    );
                                                                  },
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 10.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ].addToStart(SizedBox(
                                                          height: 20.0)),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .tableHeaderComponentNameModel3,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomTableHeaderComponentWidget(
                                                                      columnName:
                                                                          'Medication',
                                                                      isSelected:
                                                                          _model.selectedMedicationsTableColumn ==
                                                                              'Medication',
                                                                      isAscending:
                                                                          _model
                                                                              .isAscendingMedicationTable,
                                                                      topLeftBorderRadius:
                                                                          10.0,
                                                                      bgColor:
                                                                          Color(
                                                                              0xFFFDFDFF),
                                                                      onClick:
                                                                          (columnName) async {
                                                                        if (_model.selectedMedicationsTableColumn ==
                                                                            columnName) {
                                                                          _model.isAscendingMedicationTable =
                                                                              !_model.isAscendingMedicationTable;
                                                                          safeSetState(
                                                                              () {});
                                                                        } else {
                                                                          _model.isAscendingMedicationTable =
                                                                              true;
                                                                          _model.selectedMedicationsTableColumn =
                                                                              columnName!;
                                                                          safeSetState(
                                                                              () {});
                                                                        }

                                                                        if (_model.selectedMedicationsTableColumn ==
                                                                            'Medication') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationName, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationName, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Dose') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationDose, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationDose, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Frequency') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.frequency, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.frequency, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Route') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.route, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.route, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .tableHeaderComponentGenderModel3,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomTableHeaderComponentWidget(
                                                                      columnName:
                                                                          'Dose',
                                                                      isSelected:
                                                                          _model.selectedMedicationsTableColumn ==
                                                                              'Dose',
                                                                      isAscending:
                                                                          _model
                                                                              .isAscendingConditionsTableColumn,
                                                                      bgColor:
                                                                          Color(
                                                                              0xFFFDFDFF),
                                                                      onClick:
                                                                          (columnName) async {
                                                                        if (_model.selectedMedicationsTableColumn ==
                                                                            columnName) {
                                                                          _model.isAscendingMedicationTable =
                                                                              !_model.isAscendingMedicationTable;
                                                                          safeSetState(
                                                                              () {});
                                                                        } else {
                                                                          _model.isAscendingMedicationTable =
                                                                              true;
                                                                          _model.selectedMedicationsTableColumn =
                                                                              columnName!;
                                                                          safeSetState(
                                                                              () {});
                                                                        }

                                                                        if (_model.selectedMedicationsTableColumn ==
                                                                            'Medication') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationName, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationName, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Dose') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationDose, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationDose, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Frequency') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.frequency, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.frequency, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Route') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.route, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.route, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .tableHeaderComponentDOBModel3,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomTableHeaderComponentWidget(
                                                                      columnName:
                                                                          'Frequency',
                                                                      isSelected:
                                                                          _model.selectedMedicationsTableColumn ==
                                                                              'Frequency',
                                                                      isAscending:
                                                                          _model
                                                                              .isAscendingConditionsTableColumn,
                                                                      bgColor:
                                                                          Color(
                                                                              0xFFFDFDFF),
                                                                      onClick:
                                                                          (columnName) async {
                                                                        if (_model.selectedMedicationsTableColumn ==
                                                                            columnName) {
                                                                          _model.isAscendingMedicationTable =
                                                                              !_model.isAscendingMedicationTable;
                                                                          safeSetState(
                                                                              () {});
                                                                        } else {
                                                                          _model.isAscendingMedicationTable =
                                                                              true;
                                                                          _model.selectedMedicationsTableColumn =
                                                                              columnName!;
                                                                          safeSetState(
                                                                              () {});
                                                                        }

                                                                        if (_model.selectedMedicationsTableColumn ==
                                                                            'Medication') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationName, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationName, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Dose') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationDose, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationDose, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Frequency') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.frequency, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.frequency, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Route') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.route, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.route, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .tableHeaderComponentPhoneNumberModel4,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomTableHeaderComponentWidget(
                                                                      columnName:
                                                                          'Route',
                                                                      isSelected:
                                                                          _model.selectedMedicationsTableColumn ==
                                                                              'Route',
                                                                      isAscending:
                                                                          _model
                                                                              .isAscendingMedicationTable,
                                                                      topRIghtBorderRadius:
                                                                          10.0,
                                                                      bgColor:
                                                                          Color(
                                                                              0xFFFDFDFF),
                                                                      onClick:
                                                                          (columnName) async {
                                                                        if (_model.selectedMedicationsTableColumn ==
                                                                            columnName) {
                                                                          _model.isAscendingMedicationTable =
                                                                              !_model.isAscendingMedicationTable;
                                                                          safeSetState(
                                                                              () {});
                                                                        } else {
                                                                          _model.isAscendingMedicationTable =
                                                                              true;
                                                                          _model.selectedMedicationsTableColumn =
                                                                              columnName!;
                                                                          safeSetState(
                                                                              () {});
                                                                        }

                                                                        if (_model.selectedMedicationsTableColumn ==
                                                                            'Medication') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationName, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationName, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Dose') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationDose, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.medicationDose, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Frequency') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.frequency, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.frequency, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        } else if (_model.selectedMedicationsTableColumn ==
                                                                            'Route') {
                                                                          if (_model
                                                                              .isAscendingMedicationTable) {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.route, desc: false).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            _model.patientMedications =
                                                                                _model.patientMedications.sortedList(keyOf: (e) => e.route, desc: true).toList().cast<MedicationStruct>();
                                                                            safeSetState(() {});
                                                                          }
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .tableHeaderComponentPhoneNumberModel5,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CustomTableHeaderComponentWidget(
                                                                      columnName:
                                                                          'Status',
                                                                      isSelected:
                                                                          false,
                                                                      isAscending:
                                                                          false,
                                                                      topRIghtBorderRadius:
                                                                          10.0,
                                                                      bgColor:
                                                                          Color(
                                                                              0xFFFDFDFF),
                                                                      onClick:
                                                                          (columnName) async {},
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                                  .addToStart(
                                                                      SizedBox(
                                                                          width:
                                                                              20.0))
                                                                  .addToEnd(
                                                                      SizedBox(
                                                                          width:
                                                                              20.0)),
                                                            ),
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                final medicationPages = functions
                                                                    .createPageIndices(
                                                                        _model
                                                                            .patientMedications
                                                                            .length,
                                                                        5)
                                                                    .toList();
                                                                if (medicationPages
                                                                    .isEmpty) {
                                                                  return Center(
                                                                    child:
                                                                        EmptyWidgetWidget(),
                                                                  );
                                                                }

                                                                return Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: 270.0,
                                                                  child: PageView
                                                                      .builder(
                                                                    controller: _model
                                                                            .pageViewController3 ??=
                                                                        PageController(
                                                                            initialPage:
                                                                                max(0, min(0, medicationPages.length - 1))),
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    itemCount:
                                                                        medicationPages
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            medicationPagesIndex) {
                                                                      final medicationPagesItem =
                                                                          medicationPages[
                                                                              medicationPagesIndex];
                                                                      return Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final medicationsList =
                                                                              functions.sliceMedicationsListForTablePages(_model.patientMedications.toList(), medicationPagesItem * 5, (medicationPagesItem + 1) * 5)?.toList() ?? [];

                                                                          return SingleChildScrollView(
                                                                            primary:
                                                                                false,
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: List.generate(medicationsList.length, (medicationsListIndex) {
                                                                                final medicationsListItem = medicationsList[medicationsListIndex];
                                                                                return wrapWithModel(
                                                                                  model: _model.medicationsTableRowComponentModels.getModel(
                                                                                    medicationsListIndex.toString(),
                                                                                    medicationsListIndex,
                                                                                  ),
                                                                                  updateCallback: () => safeSetState(() {}),
                                                                                  child: MedicationsTableRowComponentWidget(
                                                                                    key: Key(
                                                                                      'Keyffw_${medicationsListIndex.toString()}',
                                                                                    ),
                                                                                    medicationsRow: medicationsListItem,
                                                                                  ),
                                                                                );
                                                                              }),
                                                                            ),
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
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Pages',
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
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final pages2 = functions
                                                                        .createPageIndices(
                                                                            _model.patientMedications.length,
                                                                            5)
                                                                        .toList();

                                                                    return Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          pages2
                                                                              .length,
                                                                          (pages2Index) {
                                                                        final pages2Item =
                                                                            pages2[pages2Index];
                                                                        return InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            _model.currentPatientPage =
                                                                                pages2Item;
                                                                            safeSetState(() {});
                                                                            await _model.pageViewController3?.animateToPage(
                                                                              _model.currentPatientPage,
                                                                              duration: Duration(milliseconds: 500),
                                                                              curve: Curves.ease,
                                                                            );
                                                                          },
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.customDotComponentPageViewModels3.getModel(
                                                                              pages2Item.toString(),
                                                                              pages2Index,
                                                                            ),
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomDotComponentPageViewWidget(
                                                                              key: Key(
                                                                                'Key0qq_${pages2Item.toString()}',
                                                                              ),
                                                                              isSelected: _model.currentPatientPage == pages2Item,
                                                                              assignedIdx: pages2Item,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          width:
                                                                              10.0)),
                                                                    );
                                                                  },
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 10.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ].addToStart(SizedBox(
                                                          height: 20.0)),
                                                    ),
                                                    Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              AlignedTooltip(
                                                                content:
                                                                    Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Text(
                                                                    'Add New Observation',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
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
                                                                preferredDirection:
                                                                    AxisDirection
                                                                        .down,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                elevation: 4.0,
                                                                tailBaseWidth:
                                                                    24.0,
                                                                tailLength:
                                                                    12.0,
                                                                waitDuration:
                                                                    Duration(
                                                                        milliseconds:
                                                                            100),
                                                                showDuration:
                                                                    Duration(
                                                                        milliseconds:
                                                                            1500),
                                                                triggerMode:
                                                                    TooltipTriggerMode
                                                                        .tap,
                                                                child: Builder(
                                                                  builder:
                                                                      (context) =>
                                                                          FlutterFlowIconButton(
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                    borderRadius:
                                                                        20.0,
                                                                    buttonSize:
                                                                        40.0,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .add_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                Container(
                                                                              width: 1000.0,
                                                                              child: AddNewObservationSetComponentWidget(
                                                                                practitionerID: functions.getRandomStringFromList(FFAppState().practitioners.map((e) => e.id).toList()),
                                                                                encounterID: GetAdmissionEncounterByPatientIDCall.encounterID(
                                                                                  patientDetailsContainerGetAdmissionEncounterByPatientIDResponse.jsonBody,
                                                                                )!,
                                                                                admissionDate: functions.convertSingleDateStringtoDateTime(GetAdmissionEncounterByPatientIDCall.admissionDate(
                                                                                  patientDetailsContainerGetAdmissionEncounterByPatientIDResponse.jsonBody,
                                                                                ))!,
                                                                                patientID: _model.patientSelectedForDetails?.identifier,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );

                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .clearSnackBars();
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            'Fectching Updated Records. Please wait..!!',
                                                                            style:
                                                                                TextStyle(
                                                                              color: FlutterFlowTheme.of(context).info,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                          duration:
                                                                              Duration(milliseconds: 4000),
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                        ),
                                                                      );
                                                                      _model.fetchPatientsWithNews4 =
                                                                          await actions
                                                                              .fetchFhirPatientsWithLatestNews2(
                                                                        FFAppState()
                                                                            .fhirBaseUrl,
                                                                        FFAppState()
                                                                            .fhirBearerToken,
                                                                        '2026-05-18',
                                                                      );
                                                                      _model.allPatients = _model
                                                                          .fetchPatientsWithNews4!
                                                                          .toList()
                                                                          .cast<
                                                                              PatientStruct>();
                                                                      _model.sortedAllPatients = _model
                                                                          .fetchPatientsWithNews4!
                                                                          .sortedList(
                                                                              keyOf: (e) => e.latestNEWS2Score,
                                                                              desc: true)
                                                                          .toList()
                                                                          .cast<PatientStruct>();
                                                                      _model.selectedTableColumn =
                                                                          'Latest NEWS2 Score';
                                                                      _model.isAscendingSelectedTableColumn =
                                                                          false;
                                                                      _model
                                                                          .updatePatientSelectedForDetailsStruct(
                                                                        (e) => e
                                                                          ..hasLatestNEWS2Score = _model
                                                                              .allPatients
                                                                              .where((e) => e.identifier == _model.patientSelectedForDetails?.identifier)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.hasLatestNEWS2Score
                                                                          ..latestNEWS2Score = _model
                                                                              .allPatients
                                                                              .where((e) => e.identifier == _model.patientSelectedForDetails?.identifier)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.latestNEWS2Score
                                                                          ..latestSingleRedScore = _model
                                                                              .allPatients
                                                                              .where((e) => e.identifier == _model.patientSelectedForDetails?.identifier)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.latestSingleRedScore,
                                                                      );
                                                                      safeSetState(
                                                                          () {});
                                                                      _model.bundleResponse2 =
                                                                          await PatientBundleRequestsCall
                                                                              .call(
                                                                        token: FFAppState()
                                                                            .fhirBearerToken,
                                                                        id: _model
                                                                            .patientSelectedForDetails
                                                                            ?.identifier,
                                                                      );

                                                                      if ((_model
                                                                              .bundleResponse2
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        if (PatientBundleRequestsCall.observationTotal(
                                                                              (_model.bundleResponse2?.jsonBody ?? ''),
                                                                            )! >
                                                                            0) {
                                                                          _model.patientObservations = functions
                                                                              .parseFhirObservations(PatientBundleRequestsCall.observationEntries(
                                                                                (_model.bundleResponse2?.jsonBody ?? ''),
                                                                              )!
                                                                                  .toList())
                                                                              .toList()
                                                                              .cast<ObservationStruct>();
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
                                                                                content: Text('No observations noted'),
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

                                                                        ScaffoldMessenger.of(context)
                                                                            .hideCurrentSnackBar();
                                                                      } else {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              title: Text('Error'),
                                                                              content: Text((_model.bundleResponse2?.bodyText ?? '')),
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

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                                .divide(SizedBox(
                                                                    width:
                                                                        10.0))
                                                                .around(SizedBox(
                                                                    width:
                                                                        10.0)),
                                                          ),
                                                          Builder(
                                                            builder: (context) {
                                                              if (_model
                                                                  .patientObservations
                                                                  .isNotEmpty) {
                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.recordedAtModel,
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomTableHeaderComponentWidget(
                                                                              columnName: 'Date',
                                                                              isSelected: false,
                                                                              isAscending: false,
                                                                              topLeftBorderRadius: 10.0,
                                                                              subHeader: 'Time',
                                                                              onClick: (columnName) async {},
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.pulseRateModel,
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomTableHeaderComponentWidget(
                                                                              columnName: 'PR',
                                                                              isSelected: false,
                                                                              isAscending: false,
                                                                              subHeader: '/min (score)',
                                                                              onClick: (columnName) async {},
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.bloodPressureModel,
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomTableHeaderComponentWidget(
                                                                              columnName: 'BP',
                                                                              isSelected: false,
                                                                              isAscending: false,
                                                                              subHeader: 'mm Hg (score)',
                                                                              onClick: (columnName) async {},
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.respiratoryRateModel,
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomTableHeaderComponentWidget(
                                                                              columnName: 'RR',
                                                                              isSelected: false,
                                                                              isAscending: false,
                                                                              subHeader: '/min (score)',
                                                                              onClick: (columnName) async {},
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.temperatureModel,
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomTableHeaderComponentWidget(
                                                                              columnName: 'Temp',
                                                                              isSelected: false,
                                                                              isAscending: false,
                                                                              subHeader: '°F (score)',
                                                                              onClick: (columnName) async {},
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.airOxygenModel,
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomTableHeaderComponentWidget(
                                                                              columnName: 'Air/Oxygen',
                                                                              isSelected: false,
                                                                              isAscending: false,
                                                                              subHeader: 'value (score)',
                                                                              onClick: (columnName) async {},
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.spO2Model,
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomTableHeaderComponentWidget(
                                                                              columnName: 'SpO2',
                                                                              isSelected: false,
                                                                              isAscending: false,
                                                                              subHeader: '% (score)',
                                                                              onClick: (columnName) async {},
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.avpuModel,
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomTableHeaderComponentWidget(
                                                                              columnName: 'AVPU',
                                                                              isSelected: false,
                                                                              isAscending: false,
                                                                              subHeader: 'Value (score)',
                                                                              onClick: (columnName) async {},
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.nEWS2ScoreModel,
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                CustomTableHeaderComponentWidget(
                                                                              columnName: 'NEWS2',
                                                                              isSelected: false,
                                                                              isAscending: false,
                                                                              topRIghtBorderRadius: 10.0,
                                                                              subHeader: 'score',
                                                                              onClick: (columnName) async {},
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ].addToStart(SizedBox(width: 20.0)).addToEnd(
                                                                              SizedBox(width: 20.0)),
                                                                    ),
                                                                    Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final newsRows = _model
                                                                            .patientObservations
                                                                            .unique((e) =>
                                                                                e.recordedAt!)
                                                                            .sortedList(keyOf: (e) => e.recordedAt!, desc: true)
                                                                            .map((e) => e.recordedAt)
                                                                            .withoutNulls
                                                                            .toList();

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: List.generate(
                                                                              newsRows.length,
                                                                              (newsRowsIndex) {
                                                                            final newsRowsItem =
                                                                                newsRows[newsRowsIndex];
                                                                            return wrapWithModel(
                                                                              model: _model.nEWSRowComponentModels.getModel(
                                                                                newsRowsIndex.toString(),
                                                                                newsRowsIndex,
                                                                              ),
                                                                              updateCallback: () => safeSetState(() {}),
                                                                              child: NEWSRowComponentWidget(
                                                                                key: Key(
                                                                                  'Key8wu_${newsRowsIndex.toString()}',
                                                                                ),
                                                                                observationsRow: _model.patientObservations.where((e) => e.recordedAt == newsRowsItem).toList(),
                                                                                isLatest: newsRowsIndex == 0,
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              } else {
                                                                return Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Enter New Vital signs to view the NEWS Score.',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .divide(SizedBox(height: 6.0))
                                      .addToStart(SizedBox(height: 10.0)),
                                ),
                              );
                            },
                          ),
                      ].addToStart(SizedBox(height: 20.0)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
