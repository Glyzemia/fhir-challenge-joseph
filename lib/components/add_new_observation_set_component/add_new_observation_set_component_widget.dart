import '/backend/api_requests/api_calls.dart';
import '/components/close_component/close_component_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_new_observation_set_component_model.dart';
export 'add_new_observation_set_component_model.dart';

class AddNewObservationSetComponentWidget extends StatefulWidget {
  const AddNewObservationSetComponentWidget({
    super.key,
    this.patientID,
    required this.practitionerID,
    required this.encounterID,
    required this.admissionDate,
  });

  final String? patientID;
  final String? practitionerID;
  final String? encounterID;
  final DateTime? admissionDate;

  @override
  State<AddNewObservationSetComponentWidget> createState() =>
      _AddNewObservationSetComponentWidgetState();
}

class _AddNewObservationSetComponentWidgetState
    extends State<AddNewObservationSetComponentWidget> {
  late AddNewObservationSetComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddNewObservationSetComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.recordedAt = getCurrentTimestamp;
      safeSetState(() {});
    });

    _model.pulseTextController ??= TextEditingController();
    _model.pulseFocusNode ??= FocusNode();

    _model.systolicBPTextController ??= TextEditingController();
    _model.systolicBPFocusNode ??= FocusNode();

    _model.diastolicBPTextController ??= TextEditingController();
    _model.diastolicBPFocusNode ??= FocusNode();

    _model.respiratoryRateTextController ??= TextEditingController();
    _model.respiratoryRateFocusNode ??= FocusNode();

    _model.temperatureTextController ??= TextEditingController();
    _model.temperatureFocusNode ??= FocusNode();

    _model.spO2TextController ??= TextEditingController();
    _model.spO2FocusNode ??= FocusNode();

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
        if (_model.isVisible)
          Container(
            width: 1000.0,
            height: 880.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Add New Observation',
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
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Pulse Rate/Heart Rate',
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
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 200.0,
                                child: TextFormField(
                                  controller: _model.pulseTextController,
                                  focusNode: _model.pulseFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.pulseTextController',
                                    Duration(milliseconds: 100),
                                    () async {
                                      if (_model.pulseTextController.text !=
                                              '') {
                                        _model.pulseScore = functions
                                            .calculateNews2IndividualScores(
                                                'pulse',
                                                _model.pulseTextController.text,
                                                false,
                                                false);
                                        safeSetState(() {});
                                        if ((_model.pulseTextController.text != '') &&
                                            (_model.systolicBPTextController.text !=
                                                    '') &&
                                            (_model.diastolicBPTextController.text !=
                                                    '') &&
                                            (_model.respiratoryRateTextController
                                                        .text !=
                                                    '') &&
                                            (_model.respiratoryFailureValue != null &&
                                                _model.respiratoryFailureValue !=
                                                    '') &&
                                            (_model.airOrOxygenValue != null &&
                                                _model.airOrOxygenValue !=
                                                    '') &&
                                            (_model.spO2TextController.text !=
                                                    '') &&
                                            (_model.consciousnessValue !=
                                                    null &&
                                                _model.consciousnessValue !=
                                                    '') &&
                                            (_model.temperatureTextController
                                                        .text !=
                                                    '') &&
                                            (_model.tempFahrenheit != null)) {
                                          _model.bloodPressureScore = functions
                                              .calculateNews2IndividualScores(
                                                  'systolicBp',
                                                  _model
                                                      .systolicBPTextController
                                                      .text,
                                                  false,
                                                  false);
                                          _model.temperatureScore = functions
                                              .calculateNews2IndividualScores(
                                                  'temperature',
                                                  _model.tempFahrenheit!
                                                      .toString(),
                                                  false,
                                                  false);
                                          _model.respiratoryScore = functions
                                              .calculateNews2IndividualScores(
                                                  'respiratoryRate',
                                                  _model
                                                      .respiratoryRateTextController
                                                      .text,
                                                  false,
                                                  false);
                                          _model.consciousnessScore = functions
                                              .calculateNews2IndividualScores(
                                                  'consciousness',
                                                  _model.consciousnessValue!,
                                                  false,
                                                  false);
                                          _model.spo2Score = functions
                                              .calculateNews2IndividualScores(
                                                  'SpO2',
                                                  _model
                                                      .spO2TextController.text,
                                                  _model.respiratoryFailureValue ==
                                                      'Yes',
                                                  _model.airOrOxygenValue ==
                                                      'Supplemental Oxygen');
                                          _model.airOrOxygenScore = functions
                                              .calculateNews2IndividualScores(
                                                  'airOrOxygen',
                                                  _model.airOrOxygenValue!,
                                                  false,
                                                  false);
                                          safeSetState(() {});
                                          _model.totalScore =
                                              (_model.pulseScore!) +
                                                  (_model.bloodPressureScore!) +
                                                  (_model.respiratoryScore!) +
                                                  (_model.spo2Score!) +
                                                  (_model.consciousnessScore!) +
                                                  (_model.airOrOxygenScore!);
                                          safeSetState(() {});
                                        } else {
                                          _model.totalScore = null;
                                          safeSetState(() {});
                                        }
                                      } else {
                                        _model.pulseScore = null;
                                        safeSetState(() {});
                                      }
                                    },
                                  ),
                                  autofocus: false,
                                  enabled: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: FlutterFlowTheme.of(context)
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
                                    hintText: 'Enter pulse Rate',
                                    hintStyle: FlutterFlowTheme.of(context)
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
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    prefixIcon: Icon(
                                      Icons.favorite_rounded,
                                      color: FlutterFlowTheme.of(context).error,
                                    ),
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
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
                                      FlutterFlowTheme.of(context).primaryText,
                                  enableInteractiveSelection: true,
                                  validator: _model.pulseTextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                ),
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
                              flex: 1,
                              child: Text(
                                'Blood Pressure',
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
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 80.0,
                                      child: TextFormField(
                                        controller:
                                            _model.systolicBPTextController,
                                        focusNode: _model.systolicBPFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.systolicBPTextController',
                                          Duration(milliseconds: 100),
                                          () async {
                                            if (_model.systolicBPTextController
                                                        .text !=
                                                    '') {
                                              _model.bloodPressureScore = functions
                                                  .calculateNews2IndividualScores(
                                                      'systolicBp',
                                                      _model
                                                          .systolicBPTextController
                                                          .text,
                                                      false,
                                                      false);
                                              safeSetState(() {});
                                              if ((_model.pulseTextController.text != '') &&
                                                  (_model.systolicBPTextController.text !=
                                                          '') &&
                                                  (_model.diastolicBPTextController.text !=
                                                          '') &&
                                                  (_model.respiratoryRateTextController
                                                              .text !=
                                                          '') &&
                                                  (_model.respiratoryFailureValue !=
                                                          null &&
                                                      _model.respiratoryFailureValue !=
                                                          '') &&
                                                  (_model.airOrOxygenValue != null &&
                                                      _model.airOrOxygenValue !=
                                                          '') &&
                                                  (_model.spO2TextController.text !=
                                                          '') &&
                                                  (_model.consciousnessValue !=
                                                          null &&
                                                      _model.consciousnessValue !=
                                                          '') &&
                                                  (_model.temperatureTextController
                                                              .text !=
                                                          '') &&
                                                  (_model.tempFahrenheit !=
                                                      null)) {
                                                _model.temperatureScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'temperature',
                                                        _model.tempFahrenheit!
                                                            .toString(),
                                                        false,
                                                        false);
                                                _model.respiratoryScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'respiratoryRate',
                                                        _model
                                                            .respiratoryRateTextController
                                                            .text,
                                                        false,
                                                        false);
                                                _model.consciousnessScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'consciousness',
                                                        _model
                                                            .consciousnessValue!,
                                                        false,
                                                        false);
                                                _model.spo2Score = functions
                                                    .calculateNews2IndividualScores(
                                                        'SpO2',
                                                        _model
                                                            .spO2TextController
                                                            .text,
                                                        _model.respiratoryFailureValue ==
                                                            'Yes',
                                                        _model.airOrOxygenValue ==
                                                            'Supplemental Oxygen');
                                                _model.airOrOxygenScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'airOrOxygen',
                                                        _model
                                                            .airOrOxygenValue!,
                                                        false,
                                                        false);
                                                _model.pulseScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'pulse',
                                                        _model
                                                            .pulseTextController
                                                            .text,
                                                        false,
                                                        false);
                                                safeSetState(() {});
                                                _model.totalScore = (_model
                                                        .pulseScore!) +
                                                    (_model
                                                        .bloodPressureScore!) +
                                                    (_model.respiratoryScore!) +
                                                    (_model.spo2Score!) +
                                                    (_model
                                                        .consciousnessScore!) +
                                                    (_model.airOrOxygenScore!);
                                                safeSetState(() {});
                                              } else {
                                                _model.totalScore = null;
                                                safeSetState(() {});
                                              }
                                            } else {
                                              _model.bloodPressureScore = null;
                                              safeSetState(() {});
                                            }
                                          },
                                        ),
                                        autofocus: false,
                                        enabled: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
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
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                          hintText: 'Systolic BP',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
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
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
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
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          prefixIcon: Icon(
                                            Icons.speed,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
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
                                            .systolicBPTextControllerValidator
                                            .asValidator(context),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]'))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '/',
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
                                  Expanded(
                                    child: Container(
                                      width: 80.0,
                                      child: TextFormField(
                                        controller:
                                            _model.diastolicBPTextController,
                                        focusNode: _model.diastolicBPFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.diastolicBPTextController',
                                          Duration(milliseconds: 100),
                                          () async {
                                            if (_model.diastolicBPTextController
                                                        .text !=
                                                    '') {
                                              if ((_model.pulseTextController.text != '') &&
                                                  (_model.systolicBPTextController.text !=
                                                          '') &&
                                                  (_model.diastolicBPTextController.text !=
                                                          '') &&
                                                  (_model.respiratoryRateTextController
                                                              .text !=
                                                          '') &&
                                                  (_model.respiratoryFailureValue !=
                                                          null &&
                                                      _model.respiratoryFailureValue !=
                                                          '') &&
                                                  (_model.airOrOxygenValue != null &&
                                                      _model.airOrOxygenValue !=
                                                          '') &&
                                                  (_model.spO2TextController.text !=
                                                          '') &&
                                                  (_model.consciousnessValue !=
                                                          null &&
                                                      _model.consciousnessValue !=
                                                          '') &&
                                                  (_model.temperatureTextController
                                                              .text !=
                                                          '') &&
                                                  (_model.tempFahrenheit !=
                                                      null)) {
                                                _model.bloodPressureScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'systolicBp',
                                                        _model
                                                            .systolicBPTextController
                                                            .text,
                                                        false,
                                                        false);
                                                _model.temperatureScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'temperature',
                                                        _model.tempFahrenheit!
                                                            .toString(),
                                                        false,
                                                        false);
                                                _model.respiratoryScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'respiratoryRate',
                                                        _model
                                                            .respiratoryRateTextController
                                                            .text,
                                                        false,
                                                        false);
                                                _model.consciousnessScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'consciousness',
                                                        _model
                                                            .consciousnessValue!,
                                                        false,
                                                        false);
                                                _model.spo2Score = functions
                                                    .calculateNews2IndividualScores(
                                                        'SpO2',
                                                        _model
                                                            .spO2TextController
                                                            .text,
                                                        _model.respiratoryFailureValue ==
                                                            'Yes',
                                                        _model.airOrOxygenValue ==
                                                            'Supplemental Oxygen');
                                                _model.airOrOxygenScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'airOrOxygen',
                                                        _model
                                                            .airOrOxygenValue!,
                                                        false,
                                                        false);
                                                _model.pulseScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'pulse',
                                                        _model
                                                            .pulseTextController
                                                            .text,
                                                        false,
                                                        false);
                                                safeSetState(() {});
                                                _model.totalScore = (_model
                                                        .pulseScore!) +
                                                    (_model
                                                        .bloodPressureScore!) +
                                                    (_model.respiratoryScore!) +
                                                    (_model.spo2Score!) +
                                                    (_model
                                                        .consciousnessScore!) +
                                                    (_model.airOrOxygenScore!);
                                                safeSetState(() {});
                                              } else {
                                                _model.totalScore = null;
                                                safeSetState(() {});
                                              }
                                            }
                                          },
                                        ),
                                        autofocus: false,
                                        enabled: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
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
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                          hintText: 'Diastolic BP',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
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
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
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
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          prefixIcon: Icon(
                                            Icons.speed,
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
                                          ),
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
                                            .diastolicBPTextControllerValidator
                                            .asValidator(context),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]'))
                                        ],
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 15.0)),
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
                              flex: 1,
                              child: Text(
                                'Respiratory Rate',
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
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 200.0,
                                child: TextFormField(
                                  controller:
                                      _model.respiratoryRateTextController,
                                  focusNode: _model.respiratoryRateFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.respiratoryRateTextController',
                                    Duration(milliseconds: 2000),
                                    () async {
                                      if (_model.respiratoryRateTextController
                                                  .text !=
                                              '') {
                                        _model.respiratoryScore = functions
                                            .calculateNews2IndividualScores(
                                                'respiratoryRate',
                                                _model
                                                    .respiratoryRateTextController
                                                    .text,
                                                false,
                                                false);
                                        safeSetState(() {});
                                        if ((_model.pulseTextController.text != '') &&
                                            (_model.systolicBPTextController.text !=
                                                    '') &&
                                            (_model.diastolicBPTextController.text !=
                                                    '') &&
                                            (_model.respiratoryRateTextController
                                                        .text !=
                                                    '') &&
                                            (_model.respiratoryFailureValue != null &&
                                                _model.respiratoryFailureValue !=
                                                    '') &&
                                            (_model.airOrOxygenValue != null &&
                                                _model.airOrOxygenValue !=
                                                    '') &&
                                            (_model.spO2TextController.text !=
                                                    '') &&
                                            (_model.consciousnessValue !=
                                                    null &&
                                                _model.consciousnessValue !=
                                                    '') &&
                                            (_model.temperatureTextController
                                                        .text !=
                                                    '') &&
                                            (_model.tempFahrenheit != null)) {
                                          _model.bloodPressureScore = functions
                                              .calculateNews2IndividualScores(
                                                  'systolicBp',
                                                  _model
                                                      .systolicBPTextController
                                                      .text,
                                                  false,
                                                  false);
                                          _model.temperatureScore = functions
                                              .calculateNews2IndividualScores(
                                                  'temperature',
                                                  _model.tempFahrenheit!
                                                      .toString(),
                                                  false,
                                                  false);
                                          _model.consciousnessScore = functions
                                              .calculateNews2IndividualScores(
                                                  'consciousness',
                                                  _model.consciousnessValue!,
                                                  false,
                                                  false);
                                          _model.spo2Score = functions
                                              .calculateNews2IndividualScores(
                                                  'SpO2',
                                                  _model
                                                      .spO2TextController.text,
                                                  _model.respiratoryFailureValue ==
                                                      'Yes',
                                                  _model.airOrOxygenValue ==
                                                      'Supplemental Oxygen');
                                          _model.airOrOxygenScore = functions
                                              .calculateNews2IndividualScores(
                                                  'airOrOxygen',
                                                  _model.airOrOxygenValue!,
                                                  false,
                                                  false);
                                          _model.pulseScore = functions
                                              .calculateNews2IndividualScores(
                                                  'pulse',
                                                  _model
                                                      .pulseTextController.text,
                                                  false,
                                                  false);
                                          safeSetState(() {});
                                          _model.totalScore =
                                              (_model.pulseScore!) +
                                                  (_model.bloodPressureScore!) +
                                                  (_model.respiratoryScore!) +
                                                  (_model.spo2Score!) +
                                                  (_model.consciousnessScore!) +
                                                  (_model.airOrOxygenScore!);
                                          safeSetState(() {});
                                        } else {
                                          _model.totalScore = null;
                                          safeSetState(() {});
                                        }
                                      } else {
                                        _model.respiratoryScore = null;
                                        safeSetState(() {});
                                      }
                                    },
                                  ),
                                  autofocus: false,
                                  enabled: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: FlutterFlowTheme.of(context)
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
                                    hintText: 'Enter Respiratory Rate',
                                    hintStyle: FlutterFlowTheme.of(context)
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
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.lungs,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  maxLength: 2,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  keyboardType: TextInputType.number,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  enableInteractiveSelection: true,
                                  validator: _model
                                      .respiratoryRateTextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                ),
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
                              flex: 1,
                              child: Text(
                                'Temperature',
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
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 200.0,
                                      child: Container(
                                        width: 200.0,
                                        child: TextFormField(
                                          controller:
                                              _model.temperatureTextController,
                                          focusNode:
                                              _model.temperatureFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.temperatureTextController',
                                            Duration(milliseconds: 100),
                                            () async {
                                              if (_model.temperatureTextController
                                                          .text !=
                                                      '') {
                                                _model.tempFahrenheit = _model
                                                            .tempUnitsValue ==
                                                        '°F'
                                                    ? double.tryParse(_model
                                                        .temperatureTextController
                                                        .text)
                                                    : functions.celsiusToFahrenheit(
                                                        double.parse(_model
                                                            .temperatureTextController
                                                            .text));
                                                safeSetState(() {});
                                                _model.temperatureScore = functions
                                                    .calculateNews2IndividualScores(
                                                        'temperature',
                                                        _model.tempFahrenheit!
                                                            .toString(),
                                                        false,
                                                        false);
                                                safeSetState(() {});
                                                if ((_model.pulseTextController.text != '') &&
                                                    (_model.systolicBPTextController.text !=
                                                            '') &&
                                                    (_model.diastolicBPTextController.text !=
                                                            '') &&
                                                    (_model.respiratoryRateTextController.text !=
                                                            '') &&
                                                    (_model.respiratoryFailureValue !=
                                                            null &&
                                                        _model.respiratoryFailureValue !=
                                                            '') &&
                                                    (_model.airOrOxygenValue !=
                                                            null &&
                                                        _model.airOrOxygenValue !=
                                                            '') &&
                                                    (_model.spO2TextController
                                                                .text !=
                                                            '') &&
                                                    (_model.consciousnessValue !=
                                                            null &&
                                                        _model.consciousnessValue !=
                                                            '') &&
                                                    (_model.temperatureTextController
                                                                .text !=
                                                            '') &&
                                                    (_model.tempFahrenheit !=
                                                        null)) {
                                                  _model.bloodPressureScore = functions
                                                      .calculateNews2IndividualScores(
                                                          'systolicBp',
                                                          _model
                                                              .systolicBPTextController
                                                              .text,
                                                          false,
                                                          false);
                                                  _model.respiratoryScore = functions
                                                      .calculateNews2IndividualScores(
                                                          'respiratoryRate',
                                                          _model
                                                              .respiratoryRateTextController
                                                              .text,
                                                          false,
                                                          false);
                                                  _model.consciousnessScore = functions
                                                      .calculateNews2IndividualScores(
                                                          'consciousness',
                                                          _model
                                                              .consciousnessValue!,
                                                          false,
                                                          false);
                                                  _model.spo2Score = functions
                                                      .calculateNews2IndividualScores(
                                                          'SpO2',
                                                          _model
                                                              .spO2TextController
                                                              .text,
                                                          _model.respiratoryFailureValue ==
                                                              'Yes',
                                                          _model.airOrOxygenValue ==
                                                              'Supplemental Oxygen');
                                                  _model.airOrOxygenScore = functions
                                                      .calculateNews2IndividualScores(
                                                          'airOrOxygen',
                                                          _model
                                                              .airOrOxygenValue!,
                                                          false,
                                                          false);
                                                  _model.pulseScore = functions
                                                      .calculateNews2IndividualScores(
                                                          'pulse',
                                                          _model
                                                              .pulseTextController
                                                              .text,
                                                          false,
                                                          false);
                                                  safeSetState(() {});
                                                  _model.totalScore = (_model
                                                          .pulseScore!) +
                                                      (_model
                                                          .bloodPressureScore!) +
                                                      (_model
                                                          .respiratoryScore!) +
                                                      (_model.spo2Score!) +
                                                      (_model
                                                          .consciousnessScore!) +
                                                      (_model
                                                          .airOrOxygenScore!);
                                                  safeSetState(() {});
                                                } else {
                                                  _model.totalScore = null;
                                                  safeSetState(() {});
                                                }
                                              } else {
                                                _model.tempFahrenheit = null;
                                                _model.temperatureScore = null;
                                                safeSetState(() {});
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
                                            hintText: 'Enter Temperature',
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
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
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
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.thermometerEmpty,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 24.0,
                                            ),
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
                                          maxLength: 5,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          buildCounter: (context,
                                                  {required currentLength,
                                                  required isFocused,
                                                  maxLength}) =>
                                              null,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          enableInteractiveSelection: true,
                                          validator: _model
                                              .temperatureTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FlutterFlowRadioButton(
                                    options: ['°C', '°F'].toList(),
                                    onChanged: (val) async {
                                      safeSetState(() {});
                                      if (_model.temperatureTextController
                                                  .text !=
                                              '') {
                                        _model.tempFahrenheit = _model
                                                    .tempUnitsValue ==
                                                '°F'
                                            ? double.tryParse(_model
                                                .temperatureTextController.text)
                                            : functions.celsiusToFahrenheit(
                                                double.parse(_model
                                                    .temperatureTextController
                                                    .text));
                                        safeSetState(() {});
                                        _model.temperatureScore = () {
                                          if ((double tempFah) {
                                            return tempFah <= 95;
                                          }(_model.tempFahrenheit!)) {
                                            return 3;
                                          } else if ((double tempFah) {
                                            return tempFah > 95.0 &&
                                                tempFah <= 96.88;
                                          }(_model.tempFahrenheit!)) {
                                            return 1;
                                          } else if ((double tempFah) {
                                            return tempFah > 96.8 &&
                                                tempFah <= 100.4;
                                          }(_model.tempFahrenheit!)) {
                                            return 0;
                                          } else if ((double tempFah) {
                                            return tempFah > 100.4 &&
                                                tempFah <= 102.2;
                                          }(_model.tempFahrenheit!)) {
                                            return 1;
                                          } else {
                                            return 2;
                                          }
                                        }();
                                        safeSetState(() {});
                                        if ((_model.pulseTextController.text != '') &&
                                            (_model.systolicBPTextController.text !=
                                                    '') &&
                                            (_model.diastolicBPTextController.text !=
                                                    '') &&
                                            (_model.respiratoryRateTextController
                                                        .text !=
                                                    '') &&
                                            (_model.respiratoryFailureValue != null &&
                                                _model.respiratoryFailureValue !=
                                                    '') &&
                                            (_model.airOrOxygenValue != null &&
                                                _model.airOrOxygenValue !=
                                                    '') &&
                                            (_model.spO2TextController.text !=
                                                    '') &&
                                            (_model.consciousnessValue !=
                                                    null &&
                                                _model.consciousnessValue !=
                                                    '') &&
                                            (_model.temperatureTextController
                                                        .text !=
                                                    '') &&
                                            (_model.tempFahrenheit != null)) {
                                          _model.respiratoryScore = () {
                                            if ((String rr) {
                                              return int.parse(rr) <= 8;
                                            }(_model
                                                .respiratoryRateTextController
                                                .text)) {
                                              return 3;
                                            } else if ((String rr) {
                                              return int.parse(rr) >= 9 &&
                                                  int.parse(rr) <= 11;
                                            }(_model
                                                .respiratoryRateTextController
                                                .text)) {
                                              return 1;
                                            } else if ((String rr) {
                                              return int.parse(rr) >= 12 &&
                                                  int.parse(rr) <= 20;
                                            }(_model
                                                .respiratoryRateTextController
                                                .text)) {
                                              return 0;
                                            } else if ((String rr) {
                                              return int.parse(rr) >= 21 &&
                                                  int.parse(rr) <= 24;
                                            }(_model
                                                .respiratoryRateTextController
                                                .text)) {
                                              return 2;
                                            } else {
                                              return 3;
                                            }
                                          }();
                                          _model.consciousnessScore =
                                              _model.consciousnessValue ==
                                                      'Alert'
                                                  ? 0
                                                  : 3;
                                          _model.spo2Score =
                                              _model.respiratoryFailureValue ==
                                                      'No'
                                                  ? () {
                                                      if ((String spo) {
                                                        return int.parse(spo) <=
                                                            91;
                                                      }(_model
                                                          .spO2TextController
                                                          .text)) {
                                                        return 3;
                                                      } else if ((String spo) {
                                                        return int.parse(spo) >=
                                                                92 &&
                                                            int.parse(spo) <=
                                                                93;
                                                      }(_model
                                                          .spO2TextController
                                                          .text)) {
                                                        return 2;
                                                      } else if ((String spo) {
                                                        return int.parse(spo) >=
                                                                94 &&
                                                            int.parse(spo) <=
                                                                95;
                                                      }(_model
                                                          .spO2TextController
                                                          .text)) {
                                                        return 1;
                                                      } else {
                                                        return 0;
                                                      }
                                                    }()
                                                  : () {
                                                      if ((String spo) {
                                                        return int.parse(spo) <=
                                                            83;
                                                      }(_model
                                                          .spO2TextController
                                                          .text)) {
                                                        return 3;
                                                      } else if ((String spo) {
                                                        return int.parse(spo) >=
                                                                84 &&
                                                            int.parse(spo) <=
                                                                85;
                                                      }(_model
                                                          .spO2TextController
                                                          .text)) {
                                                        return 2;
                                                      } else if ((String spo) {
                                                        return int.parse(spo) >=
                                                                86 &&
                                                            int.parse(spo) <=
                                                                87;
                                                      }(_model
                                                          .spO2TextController
                                                          .text)) {
                                                        return 1;
                                                      } else if ((String spo) {
                                                        return int.parse(spo) >=
                                                                88 &&
                                                            int.parse(spo) <=
                                                                92;
                                                      }(_model
                                                          .spO2TextController
                                                          .text)) {
                                                        return 0;
                                                      } else if ((String spo,
                                                              String osupp) {
                                                        return int.parse(spo) >=
                                                                93 &&
                                                            osupp == 'Room Air';
                                                      }(
                                                          _model
                                                              .spO2TextController
                                                              .text,
                                                          _model
                                                              .airOrOxygenValue!)) {
                                                        return 0;
                                                      } else if ((String spo,
                                                              String osupp) {
                                                        return int.parse(spo) >=
                                                                93 &&
                                                            int.parse(spo) <=
                                                                94 &&
                                                            osupp ==
                                                                'Supplemental Oxygen';
                                                      }(
                                                          _model
                                                              .spO2TextController
                                                              .text,
                                                          _model
                                                              .airOrOxygenValue!)) {
                                                        return 1;
                                                      } else if ((String spo,
                                                              String osupp) {
                                                        return int.parse(spo) >=
                                                                95 &&
                                                            int.parse(spo) <=
                                                                96 &&
                                                            osupp ==
                                                                'Supplemental Oxygen';
                                                      }(
                                                          _model
                                                              .spO2TextController
                                                              .text,
                                                          _model
                                                              .airOrOxygenValue!)) {
                                                        return 2;
                                                      } else {
                                                        return 3;
                                                      }
                                                    }();
                                          _model.airOrOxygenScore =
                                              _model.airOrOxygenValue ==
                                                      'Supplemental Oxygen'
                                                  ? 2
                                                  : 0;
                                          _model.pulseScore = () {
                                            if ((String pr) {
                                              return int.parse(pr) <= 40;
                                            }(_model
                                                .pulseTextController.text)) {
                                              return 3;
                                            } else if ((String pr) {
                                              return int.parse(pr) >= 41 &&
                                                  int.parse(pr) <= 50;
                                            }(_model
                                                .pulseTextController.text)) {
                                              return 1;
                                            } else if ((String pr) {
                                              return int.parse(pr) >= 51 &&
                                                  int.parse(pr) <= 90;
                                            }(_model
                                                .pulseTextController.text)) {
                                              return 0;
                                            } else if ((String pr) {
                                              return int.parse(pr) >= 91 &&
                                                  int.parse(pr) <= 110;
                                            }(_model
                                                .pulseTextController.text)) {
                                              return 1;
                                            } else if ((String pr) {
                                              return int.parse(pr) >= 111 &&
                                                  int.parse(pr) <= 130;
                                            }(_model
                                                .pulseTextController.text)) {
                                              return 2;
                                            } else {
                                              return 3;
                                            }
                                          }();
                                          _model.bloodPressureScore = () {
                                            if ((String sbp) {
                                              return int.parse(sbp) <= 90;
                                            }(_model.systolicBPTextController
                                                .text)) {
                                              return 3;
                                            } else if ((String sbp) {
                                              return int.parse(sbp) >= 91 &&
                                                  int.parse(sbp) <= 100;
                                            }(_model.systolicBPTextController
                                                .text)) {
                                              return 2;
                                            } else if ((String sbp) {
                                              return int.parse(sbp) >= 101 &&
                                                  int.parse(sbp) <= 110;
                                            }(_model.systolicBPTextController
                                                .text)) {
                                              return 1;
                                            } else if ((String sbp) {
                                              return int.parse(sbp) >= 111 &&
                                                  int.parse(sbp) <= 219;
                                            }(_model.systolicBPTextController
                                                .text)) {
                                              return 0;
                                            } else {
                                              return 3;
                                            }
                                          }();
                                          _model.totalScore =
                                              (_model.pulseScore!) +
                                                  (_model.bloodPressureScore!) +
                                                  (_model.respiratoryScore!) +
                                                  (_model.spo2Score!) +
                                                  (_model.consciousnessScore!) +
                                                  (_model.airOrOxygenScore!);
                                          safeSetState(() {});
                                        } else {
                                          _model.totalScore = null;
                                          safeSetState(() {});
                                        }
                                      } else {
                                        _model.tempFahrenheit = null;
                                        _model.temperatureScore = null;
                                        safeSetState(() {});
                                      }
                                    },
                                    controller:
                                        _model.tempUnitsValueController ??=
                                            FormFieldController<String>('°F'),
                                    optionHeight: 32.0,
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
                                    selectedTextStyle:
                                        FlutterFlowTheme.of(context)
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
                                    buttonPosition: RadioButtonPosition.left,
                                    direction: Axis.horizontal,
                                    radioButtonColor:
                                        FlutterFlowTheme.of(context).primary,
                                    inactiveRadioButtonColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    toggleable: false,
                                    horizontalAlignment: WrapAlignment.start,
                                    verticalAlignment: WrapCrossAlignment.start,
                                  ),
                                ],
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
                              flex: 1,
                              child: Text(
                                'Hypercapnic Respiratory Failure',
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
                            Expanded(
                              child: FlutterFlowChoiceChips(
                                options: [
                                  ChipData('No', Icons.check_circle),
                                  ChipData('Yes', FontAwesomeIcons.lungsVirus)
                                ],
                                onChanged: (val) async {
                                  safeSetState(() =>
                                      _model.respiratoryFailureValue =
                                          val?.firstOrNull);
                                  if (_model.spO2TextController.text != '') {
                                    _model.spo2Score = functions
                                        .calculateNews2IndividualScores(
                                            'SpO2',
                                            _model.spO2TextController.text,
                                            _model.respiratoryFailureValue ==
                                                'Yes',
                                            _model.airOrOxygenValue ==
                                                'Supplemental Oxygen');
                                    safeSetState(() {});
                                    if ((_model.pulseTextController.text !=
                                                '') &&
                                        (_model.systolicBPTextController.text !=
                                                '') &&
                                        (_model.diastolicBPTextController.text !=
                                                '') &&
                                        (_model.respiratoryRateTextController
                                                    .text !=
                                                '') &&
                                        (_model.respiratoryFailureValue !=
                                                null &&
                                            _model.respiratoryFailureValue !=
                                                '') &&
                                        (_model.airOrOxygenValue != null &&
                                            _model.airOrOxygenValue != '') &&
                                        (_model.spO2TextController.text !=
                                                '') &&
                                        (_model.consciousnessValue != null &&
                                            _model.consciousnessValue != '') &&
                                        (_model.temperatureTextController
                                                    .text !=
                                                '') &&
                                        (_model.tempFahrenheit != null)) {
                                      _model.bloodPressureScore = functions
                                          .calculateNews2IndividualScores(
                                              'systolicBp',
                                              _model.systolicBPTextController
                                                  .text,
                                              false,
                                              false);
                                      _model.temperatureScore = functions
                                          .calculateNews2IndividualScores(
                                              'temperature',
                                              _model.tempFahrenheit!.toString(),
                                              false,
                                              false);
                                      _model.respiratoryScore = functions
                                          .calculateNews2IndividualScores(
                                              'respiratoryRate',
                                              _model
                                                  .respiratoryRateTextController
                                                  .text,
                                              false,
                                              false);
                                      _model.consciousnessScore = functions
                                          .calculateNews2IndividualScores(
                                              'consciousness',
                                              _model.consciousnessValue!,
                                              false,
                                              false);
                                      _model.airOrOxygenScore = functions
                                          .calculateNews2IndividualScores(
                                              'airOrOxygen',
                                              _model.airOrOxygenValue!,
                                              false,
                                              false);
                                      _model.pulseScore = functions
                                          .calculateNews2IndividualScores(
                                              'pulse',
                                              _model.pulseTextController.text,
                                              false,
                                              false);
                                      safeSetState(() {});
                                      _model.totalScore = (_model.pulseScore!) +
                                          (_model.bloodPressureScore!) +
                                          (_model.respiratoryScore!) +
                                          (_model.spo2Score!) +
                                          (_model.consciousnessScore!) +
                                          (_model.airOrOxygenScore!);
                                      safeSetState(() {});
                                    } else {
                                      _model.totalScore = null;
                                      safeSetState(() {});
                                    }
                                  } else {
                                    _model.spo2Score = null;
                                    safeSetState(() {});
                                  }
                                },
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
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
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context).info,
                                  iconSize: 16.0,
                                  elevation: 0.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  iconSize: 16.0,
                                  elevation: 0.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                                chipSpacing: 10.0,
                                rowSpacing: 8.0,
                                multiselect: false,
                                initialized:
                                    _model.respiratoryFailureValue != null,
                                alignment: WrapAlignment.start,
                                controller:
                                    _model.respiratoryFailureValueController ??=
                                        FormFieldController<List<String>>(
                                  ['No'],
                                ),
                                wrapped: false,
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
                              flex: 1,
                              child: Text(
                                'Room Air / Supplemental Oxygen',
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
                            Expanded(
                              child: FlutterFlowChoiceChips(
                                options: [
                                  ChipData('Room Air', Icons.check_circle),
                                  ChipData('Supplemental Oxygen',
                                      Icons.masks_rounded)
                                ],
                                onChanged: (val) async {
                                  safeSetState(() => _model.airOrOxygenValue =
                                      val?.firstOrNull);
                                  if (_model.airOrOxygenValue != null &&
                                      _model.airOrOxygenValue != '') {
                                    _model.airOrOxygenScore = functions
                                        .calculateNews2IndividualScores(
                                            'airOrOxygen',
                                            _model.airOrOxygenValue!,
                                            false,
                                            false);
                                    safeSetState(() {});
                                    if ((_model.pulseTextController.text !=
                                                '') &&
                                        (_model.systolicBPTextController.text !=
                                                '') &&
                                        (_model.diastolicBPTextController.text !=
                                                '') &&
                                        (_model.respiratoryRateTextController
                                                    .text !=
                                                '') &&
                                        (_model.respiratoryFailureValue !=
                                                null &&
                                            _model.respiratoryFailureValue !=
                                                '') &&
                                        (_model.airOrOxygenValue != null &&
                                            _model.airOrOxygenValue != '') &&
                                        (_model.spO2TextController.text !=
                                                '') &&
                                        (_model.consciousnessValue != null &&
                                            _model.consciousnessValue != '') &&
                                        (_model.temperatureTextController
                                                    .text !=
                                                '') &&
                                        (_model.tempFahrenheit != null)) {
                                      _model.bloodPressureScore = functions
                                          .calculateNews2IndividualScores(
                                              'systolicBp',
                                              _model.systolicBPTextController
                                                  .text,
                                              false,
                                              false);
                                      _model.temperatureScore = functions
                                          .calculateNews2IndividualScores(
                                              'temperature',
                                              _model.tempFahrenheit!.toString(),
                                              false,
                                              false);
                                      _model.respiratoryScore = functions
                                          .calculateNews2IndividualScores(
                                              'respiratoryRate',
                                              _model
                                                  .respiratoryRateTextController
                                                  .text,
                                              false,
                                              false);
                                      _model.consciousnessScore = functions
                                          .calculateNews2IndividualScores(
                                              'consciousness',
                                              _model.consciousnessValue!,
                                              false,
                                              false);
                                      _model.spo2Score = functions
                                          .calculateNews2IndividualScores(
                                              'SpO2',
                                              _model.spO2TextController.text,
                                              _model.respiratoryFailureValue ==
                                                  'Yes',
                                              _model.airOrOxygenValue ==
                                                  'Supplemental Oxygen');
                                      _model.pulseScore = functions
                                          .calculateNews2IndividualScores(
                                              'pulse',
                                              _model.pulseTextController.text,
                                              false,
                                              false);
                                      safeSetState(() {});
                                      _model.totalScore = (_model.pulseScore!) +
                                          (_model.bloodPressureScore!) +
                                          (_model.respiratoryScore!) +
                                          (_model.spo2Score!) +
                                          (_model.consciousnessScore!) +
                                          (_model.airOrOxygenScore!);
                                      safeSetState(() {});
                                    } else {
                                      _model.totalScore = null;
                                      safeSetState(() {});
                                    }
                                  } else {
                                    _model.airOrOxygenScore = null;
                                    safeSetState(() {});
                                  }
                                },
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
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
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context).info,
                                  iconSize: 16.0,
                                  elevation: 0.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  iconSize: 16.0,
                                  elevation: 0.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                                chipSpacing: 10.0,
                                rowSpacing: 8.0,
                                multiselect: false,
                                initialized: _model.airOrOxygenValue != null,
                                alignment: WrapAlignment.start,
                                controller:
                                    _model.airOrOxygenValueController ??=
                                        FormFieldController<List<String>>(
                                  ['Room Air'],
                                ),
                                wrapped: false,
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
                              flex: 1,
                              child: Text(
                                'Oxygen Saturation (SpO2)',
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
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 200.0,
                                child: TextFormField(
                                  controller: _model.spO2TextController,
                                  focusNode: _model.spO2FocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.spO2TextController',
                                    Duration(milliseconds: 100),
                                    () async {
                                      if (_model.spO2TextController.text !=
                                              '') {
                                        _model.spo2Score = functions
                                            .calculateNews2IndividualScores(
                                                'SpO2',
                                                _model.spO2TextController.text,
                                                _model.respiratoryFailureValue ==
                                                    'Yes',
                                                _model.airOrOxygenValue ==
                                                    'Supplemental Oxygen');
                                        safeSetState(() {});
                                        if ((_model.pulseTextController.text != '') &&
                                            (_model.systolicBPTextController.text !=
                                                    '') &&
                                            (_model.diastolicBPTextController.text !=
                                                    '') &&
                                            (_model.respiratoryRateTextController
                                                        .text !=
                                                    '') &&
                                            (_model.respiratoryFailureValue != null &&
                                                _model.respiratoryFailureValue !=
                                                    '') &&
                                            (_model.airOrOxygenValue != null &&
                                                _model.airOrOxygenValue !=
                                                    '') &&
                                            (_model.spO2TextController.text !=
                                                    '') &&
                                            (_model.consciousnessValue !=
                                                    null &&
                                                _model.consciousnessValue !=
                                                    '') &&
                                            (_model.temperatureTextController
                                                        .text !=
                                                    '') &&
                                            (_model.tempFahrenheit != null)) {
                                          _model.bloodPressureScore = functions
                                              .calculateNews2IndividualScores(
                                                  'systolicBp',
                                                  _model
                                                      .systolicBPTextController
                                                      .text,
                                                  false,
                                                  false);
                                          _model.temperatureScore = functions
                                              .calculateNews2IndividualScores(
                                                  'temperature',
                                                  _model.tempFahrenheit!
                                                      .toString(),
                                                  false,
                                                  false);
                                          _model.respiratoryScore = functions
                                              .calculateNews2IndividualScores(
                                                  'respiratoryRate',
                                                  _model
                                                      .respiratoryRateTextController
                                                      .text,
                                                  false,
                                                  false);
                                          _model.consciousnessScore = functions
                                              .calculateNews2IndividualScores(
                                                  'consciousness',
                                                  _model.consciousnessValue!,
                                                  false,
                                                  false);
                                          _model.airOrOxygenScore = functions
                                              .calculateNews2IndividualScores(
                                                  'airOrOxygen',
                                                  _model.airOrOxygenValue!,
                                                  false,
                                                  false);
                                          _model.pulseScore = functions
                                              .calculateNews2IndividualScores(
                                                  'pulse',
                                                  _model
                                                      .pulseTextController.text,
                                                  false,
                                                  false);
                                          safeSetState(() {});
                                          _model.totalScore =
                                              (_model.pulseScore!) +
                                                  (_model.bloodPressureScore!) +
                                                  (_model.respiratoryScore!) +
                                                  (_model.spo2Score!) +
                                                  (_model.consciousnessScore!) +
                                                  (_model.airOrOxygenScore!);
                                          safeSetState(() {});
                                        } else {
                                          _model.totalScore = null;
                                          safeSetState(() {});
                                        }
                                      } else {
                                        _model.spo2Score = null;
                                        safeSetState(() {});
                                      }
                                    },
                                  ),
                                  autofocus: false,
                                  enabled: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: FlutterFlowTheme.of(context)
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
                                    hintText: 'Enter Oxygen Saturation',
                                    hintStyle: FlutterFlowTheme.of(context)
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
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.lungs,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
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
                                      FlutterFlowTheme.of(context).primaryText,
                                  enableInteractiveSelection: true,
                                  validator: _model.spO2TextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                ),
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
                              flex: 1,
                              child: Text(
                                'Consciousness (AVPU)',
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
                            Expanded(
                              child: FlutterFlowDropDown<String>(
                                controller:
                                    _model.consciousnessValueController ??=
                                        FormFieldController<String>(
                                  _model.consciousnessValue ??= 'Alert',
                                ),
                                options: [
                                  'Alert',
                                  'Verbal',
                                  'Pain',
                                  'Unresponsive',
                                  'New Confusion'
                                ],
                                onChanged: (val) async {
                                  safeSetState(
                                      () => _model.consciousnessValue = val);
                                  if (_model.consciousnessValue != null &&
                                      _model.consciousnessValue != '') {
                                    _model.consciousnessScore = functions
                                        .calculateNews2IndividualScores(
                                            'consciousness',
                                            _model.consciousnessValue!,
                                            false,
                                            false);
                                    safeSetState(() {});
                                    if ((_model.pulseTextController.text !=
                                                '') &&
                                        (_model.systolicBPTextController.text !=
                                                '') &&
                                        (_model.diastolicBPTextController.text !=
                                                '') &&
                                        (_model.respiratoryRateTextController
                                                    .text !=
                                                '') &&
                                        (_model.respiratoryFailureValue !=
                                                null &&
                                            _model.respiratoryFailureValue !=
                                                '') &&
                                        (_model.airOrOxygenValue != null &&
                                            _model.airOrOxygenValue != '') &&
                                        (_model.spO2TextController.text !=
                                                '') &&
                                        (_model.consciousnessValue != null &&
                                            _model.consciousnessValue != '') &&
                                        (_model.temperatureTextController
                                                    .text !=
                                                '') &&
                                        (_model.tempFahrenheit != null)) {
                                      _model.bloodPressureScore = functions
                                          .calculateNews2IndividualScores(
                                              'systolicBp',
                                              _model.systolicBPTextController
                                                  .text,
                                              false,
                                              false);
                                      _model.temperatureScore = functions
                                          .calculateNews2IndividualScores(
                                              'temperature',
                                              _model.tempFahrenheit!.toString(),
                                              false,
                                              false);
                                      _model.respiratoryScore = functions
                                          .calculateNews2IndividualScores(
                                              'respiratoryRate',
                                              _model
                                                  .respiratoryRateTextController
                                                  .text,
                                              false,
                                              false);
                                      _model.spo2Score = functions
                                          .calculateNews2IndividualScores(
                                              'SpO2',
                                              _model.spO2TextController.text,
                                              _model.respiratoryFailureValue ==
                                                  'Yes',
                                              _model.airOrOxygenValue ==
                                                  'Supplemental Oxygen');
                                      _model.airOrOxygenScore = functions
                                          .calculateNews2IndividualScores(
                                              'airOrOxygen',
                                              _model.airOrOxygenValue!,
                                              false,
                                              false);
                                      _model.pulseScore = functions
                                          .calculateNews2IndividualScores(
                                              'pulse',
                                              _model.pulseTextController.text,
                                              false,
                                              false);
                                      safeSetState(() {});
                                      _model.totalScore = (_model.pulseScore!) +
                                          (_model.bloodPressureScore!) +
                                          (_model.respiratoryScore!) +
                                          (_model.spo2Score!) +
                                          (_model.consciousnessScore!) +
                                          (_model.airOrOxygenScore!);
                                      safeSetState(() {});
                                    } else {
                                      _model.totalScore = null;
                                      safeSetState(() {});
                                    }
                                  } else {
                                    _model.consciousnessScore = null;
                                    safeSetState(() {});
                                  }
                                },
                                width: 200.0,
                                height: 40.0,
                                textStyle: FlutterFlowTheme.of(context)
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
                                hintText: 'Select consciousness level...',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                focusBorderColor:
                                    FlutterFlowTheme.of(context).primary,
                                borderWidth: 0.0,
                                borderRadius: 10.0,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
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
                              flex: 1,
                              child: Text(
                                'Recorded At (Optional)',
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
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        final _datePickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: getCurrentTimestamp,
                                          firstDate: (widget.admissionDate ??
                                              DateTime(1900)),
                                          lastDate: (getCurrentTimestamp ??
                                              DateTime(2050)),
                                          builder: (context, child) {
                                            return wrapInMaterialDatePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle: FlutterFlowTheme
                                                      .of(context)
                                                  .headlineLarge
                                                  .override(
                                                    font: GoogleFonts.readexPro(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 32.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontStyle,
                                                  ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );

                                        TimeOfDay? _datePickedTime;
                                        if (_datePickedDate != null) {
                                          _datePickedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                                getCurrentTimestamp),
                                            builder: (context, child) {
                                              return wrapInMaterialTimePickerTheme(
                                                context,
                                                child!,
                                                headerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                headerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                headerTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .fontStyle,
                                                        ),
                                                pickerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                pickerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                selectedDateTimeBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                selectedDateTimeForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                actionButtonForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                iconSize: 24.0,
                                              );
                                            },
                                          );
                                        }

                                        if (_datePickedDate != null &&
                                            _datePickedTime != null) {
                                          safeSetState(() {
                                            _model.datePicked = DateTime(
                                              _datePickedDate.year,
                                              _datePickedDate.month,
                                              _datePickedDate.day,
                                              _datePickedTime!.hour,
                                              _datePickedTime.minute,
                                            );
                                          });
                                        } else if (_model.datePicked != null) {
                                          safeSetState(() {
                                            _model.datePicked =
                                                getCurrentTimestamp;
                                          });
                                        }
                                        _model.recordedAt = _model.datePicked;
                                        safeSetState(() {});
                                      },
                                      text: dateTimeFormat(
                                          "d-M-y h:mm a", _model.recordedAt),
                                      icon: Icon(
                                        Icons.access_time_rounded,
                                        size: 24.0,
                                      ),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .cardBlue,
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
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  FlutterFlowIconButton(
                                    borderRadius: 20.0,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.refresh_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ].divide(SizedBox(width: 20.0)),
                              ),
                            ),
                          ]
                              .divide(SizedBox(width: 20.0))
                              .around(SizedBox(width: 20.0)),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            var _shouldSetState = false;
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            if (_model.consciousnessValue == null) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content:
                                        Text('Consciousness must be selected.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }
                            if (!((String pulse) {
                              return int.parse(pulse) > 30 &&
                                  int.parse(pulse) <= 220;
                            }(_model.pulseTextController.text))) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Pulse value is invalid..!!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                            if (!((String sbp) {
                              return int.parse(sbp) > 60 &&
                                  int.parse(sbp) <= 300;
                            }(_model.systolicBPTextController.text))) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(
                                        'Systolic BP value is invalid..!!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                            if (!((String dbp) {
                              return int.parse(dbp) > 30 &&
                                  int.parse(dbp) <= 180;
                            }(_model.diastolicBPTextController.text))) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(
                                        'Diastolic BP value is invalid..!!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                            if (!(int.parse(
                                    _model.systolicBPTextController.text) >
                                int.parse(
                                    _model.diastolicBPTextController.text))) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(
                                        'Systolic BP can\'t be less than Diastolic BP..!!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                            if (!((String rr) {
                              return int.parse(rr) > 0 && int.parse(rr) <= 70;
                            }(_model.respiratoryRateTextController.text))) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content:
                                        Text('Respiratory Late is invalid..!!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                            if (!((double tempFah) {
                              return tempFah > 53.0 && tempFah <= 110;
                            }(_model.tempFahrenheit!))) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(
                                        'Temperature value is invalid..!!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                            if (!((String spo2) {
                              return int.parse(spo2) > 20 &&
                                  int.parse(spo2) <= 100;
                            }(_model.spO2TextController.text))) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('SpO2 value is invalid..!!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                            _model.postNEWSObservations =
                                await BundlePOSTNEWSObservationsCall.call(
                              token: FFAppState().fhirBearerToken,
                              bundleJsonJson:
                                  functions.generateNEWS2ObservationPostJSON(
                                      widget.patientID!,
                                      widget.encounterID!,
                                      'NEWS2-${dateTimeFormat("yMMddhhmm", getCurrentTimestamp)}',
                                      widget.practitionerID!,
                                      functions.datetimeToISO8601String(
                                          getCurrentTimestamp)!,
                                      int.parse(
                                          _model.pulseTextController.text),
                                      int.parse(
                                          _model.systolicBPTextController.text),
                                      int.parse(_model
                                          .diastolicBPTextController.text),
                                      int.parse(_model.spO2TextController.text),
                                      double.parse(_model
                                          .temperatureTextController.text),
                                      int.parse(_model
                                          .respiratoryRateTextController.text),
                                      _model.airOrOxygenValue!,
                                      _model.totalScore!,
                                      _model.consciousnessValue!,
                                      _model.tempUnitsValue == '°C' ? 'C' : 'F',
                                      (_model.pulseScore == 3) ||
                                          (_model.bloodPressureScore == 3) ||
                                          (_model.respiratoryScore == 3) ||
                                          (_model.spo2Score == 3) ||
                                          (_model.consciousnessScore == 3) ||
                                          (_model.airOrOxygenScore == 3),
                                      _model.respiratoryFailureValue == 'Yes'),
                            );

                            _shouldSetState = true;
                            if ((_model.postNEWSObservations?.succeeded ??
                                true)) {
                              Navigator.pop(context);
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text((_model
                                            .postNEWSObservations?.bodyText ??
                                        '')),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }

                            if (_shouldSetState) safeSetState(() {});
                          },
                          text: 'Submit',
                          icon: Icon(
                            Icons.send_rounded,
                            size: 24.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconAlignment: IconAlignment.end,
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        if (_model.totalScore != null)
                          Container(
                            width: 300.0,
                            height: 250.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).cardBlue,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Recommendation',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 300.0,
                                    decoration: BoxDecoration(),
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        () {
                                          if (((_model.pulseScore == 3) ||
                                                  (_model.bloodPressureScore ==
                                                      3) ||
                                                  (_model.respiratoryScore ==
                                                      3) ||
                                                  (_model.spo2Score == 3) ||
                                                  (_model.consciousnessScore ==
                                                      3) ||
                                                  (_model.airOrOxygenScore ==
                                                      3)) &&
                                              (_model.totalScore! < 7)) {
                                            return '- Inform RMO Immediately.';
                                          } else if ((_model.totalScore! >=
                                                  0) &&
                                              (_model.totalScore! <= 4)) {
                                            return '- Assessment by Nurse.';
                                          } else if ((_model.totalScore! >=
                                                  5) &&
                                              (_model.totalScore! <= 6)) {
                                            return '- Inform RMO Immediately.';
                                          } else if (_model.totalScore! >= 7) {
                                            return '- Inform RMO and Consultant Immediately.';
                                          } else {
                                            return 'None';
                                          }
                                        }(),
                                        'None',
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
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 300.0,
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      valueOrDefault<String>(
                                        () {
                                          if (((_model.pulseScore == 3) ||
                                                  (_model.bloodPressureScore ==
                                                      3) ||
                                                  (_model.respiratoryScore ==
                                                      3) ||
                                                  (_model.spo2Score == 3) ||
                                                  (_model.consciousnessScore ==
                                                      3) ||
                                                  (_model.airOrOxygenScore ==
                                                      3)) &&
                                              (_model.totalScore! < 7)) {
                                            return '- Monitor vitals every 30 mins.';
                                          } else if ((_model.totalScore! >=
                                                  0) &&
                                              (_model.totalScore! <= 4)) {
                                            return '- Monitor vitals every 4 hours.';
                                          } else if ((_model.totalScore! >=
                                                  5) &&
                                              (_model.totalScore! <= 6)) {
                                            return '- Monitor vitals every 1 hour (at least).';
                                          } else if (_model.totalScore! >= 7) {
                                            return '- Monitor Vitals every 15 mins (Continuous Monitoring)';
                                          } else {
                                            return 'None';
                                          }
                                        }(),
                                        'None',
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
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 300.0,
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      valueOrDefault<String>(
                                        () {
                                          if (((_model.pulseScore == 3) ||
                                                  (_model.bloodPressureScore ==
                                                      3) ||
                                                  (_model.respiratoryScore ==
                                                      3) ||
                                                  (_model.spo2Score == 3) ||
                                                  (_model.consciousnessScore ==
                                                      3) ||
                                                  (_model.airOrOxygenScore ==
                                                      3)) &&
                                              (_model.totalScore! < 7)) {
                                            return '- RMO to decide on ICU transfer ';
                                          } else if ((_model.totalScore! >=
                                                  0) &&
                                              (_model.totalScore! <= 4)) {
                                            return ' ';
                                          } else if ((_model.totalScore! >=
                                                  5) &&
                                              (_model.totalScore! <= 6)) {
                                            return '- RMO to decide on ICU transfer.';
                                          } else if (_model.totalScore! >= 7) {
                                            return '- Transfer to ICU. Decide on immediate medical interventions.';
                                          } else {
                                            return 'None';
                                          }
                                        }(),
                                        'None',
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
                                  ),
                                ),
                              ]
                                  .divide(SizedBox(height: 20.0))
                                  .around(SizedBox(height: 20.0)),
                            ),
                          ),
                      ]
                          .divide(SizedBox(height: 10.0))
                          .around(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 750.0,
                  child: VerticalDivider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Pulse Score',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              valueOrDefault<String>(
                                _model.pulseScore != null
                                    ? _model.pulseScore?.toString()
                                    : 'Empty',
                                'Empty',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].addToStart(SizedBox(width: 10.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'BP Score',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              valueOrDefault<String>(
                                _model.bloodPressureScore != null
                                    ? _model.bloodPressureScore?.toString()
                                    : 'Empty',
                                'Empty',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].addToStart(SizedBox(width: 10.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Respiratory Score',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              valueOrDefault<String>(
                                _model.respiratoryScore != null
                                    ? _model.respiratoryScore?.toString()
                                    : 'Empty',
                                'Empty',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].addToStart(SizedBox(width: 10.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Temperature Score',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              valueOrDefault<String>(
                                _model.temperatureScore != null
                                    ? _model.temperatureScore?.toString()
                                    : 'Empty',
                                'Empty',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].addToStart(SizedBox(width: 10.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Air/Oxygen Score',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              valueOrDefault<String>(
                                _model.airOrOxygenScore != null
                                    ? _model.airOrOxygenScore?.toString()
                                    : 'Empty',
                                'Empty',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].addToStart(SizedBox(width: 10.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'SpO2 Score',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              valueOrDefault<String>(
                                _model.spo2Score != null
                                    ? _model.spo2Score?.toString()
                                    : 'Empty',
                                'Empty',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].addToStart(SizedBox(width: 10.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Alertness Score',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              valueOrDefault<String>(
                                _model.consciousnessScore != null
                                    ? _model.consciousnessScore?.toString()
                                    : 'Empty',
                                'Empty',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].addToStart(SizedBox(width: 10.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Total',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              valueOrDefault<String>(
                                _model.totalScore != null
                                    ? _model.totalScore?.toString()
                                    : 'Empty',
                                'Empty',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].addToStart(SizedBox(width: 10.0)),
                      ),
                      if ((_model.pulseScore != null) &&
                          (_model.bloodPressureScore != null) &&
                          (_model.respiratoryScore != null) &&
                          (_model.spo2Score != null) &&
                          (_model.consciousnessScore != null) &&
                          (_model.airOrOxygenScore != null))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Interpretation',
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
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                () {
                                  if (((_model.pulseScore == 3) ||
                                          (_model.bloodPressureScore == 3) ||
                                          (_model.respiratoryScore == 3) ||
                                          (_model.spo2Score == 3) ||
                                          (_model.consciousnessScore == 3) ||
                                          (_model.airOrOxygenScore == 3)) &&
                                      (_model.totalScore! < 7)) {
                                    return 'Low-Medium Clinical Risk';
                                  } else if ((_model.totalScore! >= 0) &&
                                      (_model.totalScore! <= 4)) {
                                    return 'Low Clinical Risk';
                                  } else if ((_model.totalScore! >= 5) &&
                                      (_model.totalScore! <= 6)) {
                                    return 'Medium Clinical Risk';
                                  } else if (_model.totalScore! >= 7) {
                                    return 'High Clinical Risk';
                                  } else {
                                    return 'None';
                                  }
                                }(),
                                'None',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                            Text(
                              'Reference',
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
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
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
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: FlutterFlowExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/The-NEWS2-scoring-system-Reproduced-from-Royal-College-of-Physicians-National-Early.webp',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag',
                                transitionOnUserGestures: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/The-NEWS2-scoring-system-Reproduced-from-Royal-College-of-Physicians-National-Early.webp',
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 10.0)),
                        ),
                    ]
                        .divide(SizedBox(height: 20.0))
                        .around(SizedBox(height: 20.0)),
                  ),
                ),
              ].divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
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
