import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/empty_widget_widget.dart';
import '/components/fire_component_widget.dart';
import '/components/menu_items_component_widget.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:math' as math;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            .parseFhirPatients(GetAllPatientsCall.entries(
              (_model.allPatientsQuery1?.jsonBody ?? ''),
            )?.toList())!
            .toList()
            .cast<PatientStruct>();
        _model.sortedAllPatients = functions
            .parseFhirPatients(GetAllPatientsCall.entries(
              (_model.allPatientsQuery1?.jsonBody ?? ''),
            )?.toList())!
            .sortedList(
                keyOf: (e) => '${e.firstName} ${e.familyName}', desc: false)
            .toList()
            .cast<PatientStruct>();
        safeSetState(() {});
        _model.allPatientsDataTableController.updateSort(
          columnIndex: 0,
          ascending: true,
        );
      }
    });

    _model.searchNameTextController ??= TextEditingController();
    _model.searchNameFocusNode ??= FocusNode();

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
                                            isSelected: _model.showPatients,
                                            text: 'Patients',
                                            icon: Icon(
                                              Icons.people,
                                              color: _model.showPatients
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                            onClick: () async {
                                              _model.showPatients = true;
                                              _model.showSearch = false;
                                              _model.showCreatePatient = false;
                                              _model.showActivity = false;
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
                                              size: 24.0,
                                            ),
                                            onClick: () async {
                                              _model.showPatients = false;
                                              _model.showSearch = true;
                                              _model.showCreatePatient = false;
                                              _model.showActivity = false;
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
                                          model: _model.createPatientModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemsComponentWidget(
                                            isSelected:
                                                _model.showCreatePatient,
                                            text: 'Create Patient',
                                            icon: Icon(
                                              Icons.person_add_alt_rounded,
                                              color: _model.showCreatePatient
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                            onClick: () async {
                                              _model.showPatients = false;
                                              _model.showSearch = false;
                                              _model.showCreatePatient = true;
                                              _model.showActivity = false;
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
                                              size: 24.0,
                                            ),
                                            onClick: () async {
                                              _model.showPatients = false;
                                              _model.showSearch = false;
                                              _model.showCreatePatient = false;
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
                                              size: 24.0,
                                            ),
                                            onClick: () async {
                                              _model.showPatients = false;
                                              _model.showSearch = false;
                                              _model.showCreatePatient = false;
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
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (_model.showPatients ||
                                          _model.showSearch)
                                        Container(
                                          height: 750.0,
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
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
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              _model.showSearch
                                                                  ? 'Find Patients on FHIR Server by typing all or part of a name.'
                                                                  : 'List of patients on the FHIR Server.',
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
                                                            Expanded(
                                                              child: RichText(
                                                                textScaler: MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: _model.showSearch &&
                                                                              (_model.searchNameTextController.text != '')
                                                                          ? 'Found '
                                                                          : 'Total ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: _model.showSearch && (_model.searchNameTextController.text != '')
                                                                          ? _model
                                                                              .simpleSearchResults
                                                                              .length
                                                                              .toString()
                                                                          : _model
                                                                              .allPatients
                                                                              .length
                                                                              .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          ' Patients ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
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
                                                        _model.allPatients =
                                                            functions
                                                                .parseFhirPatients(
                                                                    GetAllPatientsCall
                                                                        .entries(
                                                                  (_model.allPatientsQuery2
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                )?.toList())!
                                                                .toList()
                                                                .cast<
                                                                    PatientStruct>();
                                                        _model.sortedAllPatients =
                                                            functions
                                                                .parseFhirPatients(
                                                                    GetAllPatientsCall
                                                                        .entries(
                                                                  (_model.allPatientsQuery2
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                )?.toList())!
                                                                .sortedList(
                                                                    keyOf: (e) =>
                                                                        '${e.firstName} ${e.firstName}',
                                                                    desc: false)
                                                                .toList()
                                                                .cast<
                                                                    PatientStruct>();
                                                        safeSetState(() {});
                                                        _model
                                                            .allPatientsDataTableController
                                                            .updateSort(
                                                          columnIndex: 0,
                                                          ascending: true,
                                                        );
                                                      }

                                                      safeSetState(() {});
                                                    },
                                                    text: 'Refresh',
                                                    icon: Icon(
                                                      Icons.refresh_rounded,
                                                      size: 22.0,
                                                    ),
                                                    options: FFButtonOptions(
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
                                                      color: Colors.transparent,
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
                                                        color:
                                                            Colors.transparent,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      hoverColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .cardBlue,
                                                      hoverBorderSide:
                                                          BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 2.0,
                                                      ),
                                                      hoverTextColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      hoverElevation: 2.0,
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      _model.showPatients =
                                                          false;
                                                      _model.showSearch = false;
                                                      _model.showCreatePatient =
                                                          true;
                                                      _model.showActivity =
                                                          false;
                                                      _model.showSettings =
                                                          false;
                                                      safeSetState(() {});
                                                    },
                                                    text: 'Create Patient',
                                                    icon: Icon(
                                                      Icons.add_rounded,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
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
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(width: 20.0))
                                                    .around(
                                                        SizedBox(width: 20.0)),
                                              ),
                                              if (_model.showSearch)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: 60.0,
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
                                                                          .text !=
                                                                      '') {
                                                                safeSetState(
                                                                    () {
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
                                                                _model.displaySearch =
                                                                    true;
                                                                safeSetState(
                                                                    () {});
                                                              } else {
                                                                _model.displaySearch =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
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
                                                                'Search Name',
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
                                                                      if (_model.searchNameTextController.text !=
                                                                              '') {
                                                                        safeSetState(
                                                                            () {
                                                                          _model.simpleSearchResults = TextSearch((_model.sortedAllPatients.map((e) => e.combinedNames).toList() as List).cast<String>().map((str) => TextSearchItem.fromTerms(str, [str])).toList())
                                                                              .search(_model.searchNameTextController.text)
                                                                              .map((r) => r.object)
                                                                              .toList();
                                                                          ;
                                                                        });
                                                                        _model.displaySearch =
                                                                            true;
                                                                        safeSetState(
                                                                            () {});
                                                                      } else {
                                                                        _model.displaySearch =
                                                                            false;
                                                                        safeSetState(
                                                                            () {});
                                                                      }

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .clear,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
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
                                                    Container(
                                                      width: 250.0,
                                                      height: 50.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .cardBlue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
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
                                                      .divide(
                                                          SizedBox(width: 20.0))
                                                      .around(SizedBox(
                                                          width: 20.0)),
                                                ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          20.0, 0.0, 20.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final allPatientsList = (_model
                                                                  .displaySearch
                                                              ? _model
                                                                  .allPatients
                                                                  .where((e) => _model
                                                                      .simpleSearchResults
                                                                      .contains(e
                                                                          .combinedNames))
                                                                  .toList()
                                                              : _model
                                                                  .sortedAllPatients)
                                                          .toList();
                                                      if (allPatientsList
                                                          .isEmpty) {
                                                        return Center(
                                                          child: Container(
                                                            width: 350.0,
                                                            height: 50.0,
                                                            child:
                                                                EmptyWidgetWidget(),
                                                          ),
                                                        );
                                                      }

                                                      return FlutterFlowDataTable<
                                                          PatientStruct>(
                                                        controller: _model
                                                            .allPatientsDataTableController,
                                                        data: allPatientsList,
                                                        numRows: _model
                                                            .allPatients.length,
                                                        columnsBuilder:
                                                            (onSortChanged) => [
                                                          DataColumn2(
                                                            label:
                                                                DefaultTextStyle
                                                                    .merge(
                                                              softWrap: true,
                                                              child: Text(
                                                                'Name',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelLarge
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
                                                                          .labelLarge
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            onSort:
                                                                onSortChanged,
                                                          ),
                                                          DataColumn2(
                                                            label:
                                                                DefaultTextStyle
                                                                    .merge(
                                                              softWrap: true,
                                                              child: Text(
                                                                'Gender',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelLarge
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
                                                                          .labelLarge
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            onSort:
                                                                onSortChanged,
                                                          ),
                                                          DataColumn2(
                                                            label:
                                                                DefaultTextStyle
                                                                    .merge(
                                                              softWrap: true,
                                                              child: Text(
                                                                'Date of Birth',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelLarge
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
                                                                          .labelLarge
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            onSort:
                                                                onSortChanged,
                                                          ),
                                                          DataColumn2(
                                                            label:
                                                                DefaultTextStyle
                                                                    .merge(
                                                              softWrap: true,
                                                              child: Text(
                                                                ' ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelLarge
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelLarge
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            fixedWidth:
                                                                MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.02,
                                                          ),
                                                        ],
                                                        dataRowBuilder:
                                                            (allPatientsListItem,
                                                                    allPatientsListIndex,
                                                                    selected,
                                                                    onSelectChanged) =>
                                                                DataRow(
                                                          color:
                                                              WidgetStateProperty
                                                                  .all(
                                                            allPatientsListIndex %
                                                                        2 ==
                                                                    0
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                          ),
                                                          cells: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color:
                                                                          () {
                                                                        if (allPatientsListItem.gender ==
                                                                            'male') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .cardBlue;
                                                                        } else if (allPatientsListItem.gender ==
                                                                            'female') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .cardSuccess;
                                                                        } else {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .cardTertiary;
                                                                        }
                                                                      }(),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(10.0),
                                                                        child:
                                                                            Text(
                                                                          functions.getInitials(
                                                                              allPatientsListItem.firstName,
                                                                              allPatientsListItem.familyName),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                                color: () {
                                                                                  if (allPatientsListItem.gender == 'male') {
                                                                                    return FlutterFlowTheme.of(context).primary;
                                                                                  } else if (allPatientsListItem.gender == 'female') {
                                                                                    return FlutterFlowTheme.of(context).success;
                                                                                  } else {
                                                                                    return FlutterFlowTheme.of(context).tertiary;
                                                                                  }
                                                                                }(),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  allPatientsListItem
                                                                      .combinedNames,
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
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    if (allPatientsListItem
                                                                            .gender ==
                                                                        'male') {
                                                                      return Icon(
                                                                        Icons
                                                                            .male_rounded,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        size:
                                                                            24.0,
                                                                      );
                                                                    } else if (allPatientsListItem
                                                                            .gender ==
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
                                                                      allPatientsListItem
                                                                          .gender),
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
                                                            Text(
                                                              allPatientsListItem
                                                                  .birthDate,
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
                                                            Icon(
                                                              Icons
                                                                  .more_vert_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                          ]
                                                              .map((c) =>
                                                                  DataCell(c))
                                                              .toList(),
                                                        ),
                                                        emptyBuilder: () =>
                                                            Center(
                                                          child: Container(
                                                            width: 350.0,
                                                            height: 50.0,
                                                            child:
                                                                EmptyWidgetWidget(),
                                                          ),
                                                        ),
                                                        onSortChanged:
                                                            (columnIndex,
                                                                ascending) async {
                                                          if (columnIndex ==
                                                              0) {
                                                            if (ascending) {
                                                              _model.sortedAllPatients = _model
                                                                  .allPatients
                                                                  .sortedList(
                                                                      keyOf: (e) =>
                                                                          '${e.firstName} ${e.familyName}',
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
                                                                      keyOf: (e) =>
                                                                          '${e.firstName} ${e.familyName}',
                                                                      desc:
                                                                          true)
                                                                  .toList()
                                                                  .cast<
                                                                      PatientStruct>();
                                                              safeSetState(
                                                                  () {});
                                                            }
                                                          } else if (columnIndex ==
                                                              1) {
                                                            if (ascending) {
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
                                                          } else if (columnIndex ==
                                                              2) {
                                                            if (ascending) {
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
                                                          }
                                                        },
                                                        paginated: true,
                                                        selectable: false,
                                                        hidePaginator: false,
                                                        showFirstLastButtons:
                                                            true,
                                                        height: 800.0,
                                                        headingRowHeight: 56.0,
                                                        dataRowHeight: 56.0,
                                                        columnSpacing: 20.0,
                                                        headingRowColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .cardAlternate,
                                                        sortIconColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        addHorizontalDivider:
                                                            true,
                                                        addTopAndBottomDivider:
                                                            false,
                                                        hideDefaultHorizontalDivider:
                                                            true,
                                                        horizontalDividerColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        horizontalDividerThickness:
                                                            1.0,
                                                        addVerticalDivider:
                                                            false,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ]
                                                .divide(SizedBox(height: 10.0))
                                                .around(SizedBox(height: 10.0)),
                                          ),
                                        ),
                                      if (false)
                                        Container(
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Search',
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
                                      if (_model.showCreatePatient)
                                        Container(
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Create Patient',
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
                                      if (_model.showActivity)
                                        Container(
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Activity',
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
                                      if (_model.showSettings)
                                        Container(
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            'Settings',
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
                                    ],
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
