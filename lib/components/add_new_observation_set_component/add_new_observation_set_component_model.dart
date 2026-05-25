import '/backend/api_requests/api_calls.dart';
import '/components/close_component/close_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_new_observation_set_component_widget.dart'
    show AddNewObservationSetComponentWidget;
import 'package:flutter/material.dart';

class AddNewObservationSetComponentModel
    extends FlutterFlowModel<AddNewObservationSetComponentWidget> {
  ///  Local state fields for this component.

  int? respiratoryScore;

  int? spo2Score;

  int? temperatureScore;

  int? bloodPressureScore;

  int? pulseScore;

  int? consciousnessScore;

  DateTime? recordedAt;

  int? totalScore;

  double? tempFahrenheit;

  int? airOrOxygenScore;

  bool isVisible = true;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Pulse widget.
  FocusNode? pulseFocusNode;
  TextEditingController? pulseTextController;
  String? Function(BuildContext, String?)? pulseTextControllerValidator;
  String? _pulseTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Pulse Rate is required';
    }

    if (val.length < 2) {
      return 'Invalid Pulse Rate value.';
    }
    if (val.length > 3) {
      return 'Invalid Pulse Rate value.';
    }

    return null;
  }

  // State field(s) for SystolicBP widget.
  FocusNode? systolicBPFocusNode;
  TextEditingController? systolicBPTextController;
  String? Function(BuildContext, String?)? systolicBPTextControllerValidator;
  String? _systolicBPTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Systolic BP is required';
    }

    if (val.length < 2) {
      return 'Invalid Systolic BP value.';
    }
    if (val.length > 3) {
      return 'Invalid Systolic BP value.';
    }

    return null;
  }

  // State field(s) for DiastolicBP widget.
  FocusNode? diastolicBPFocusNode;
  TextEditingController? diastolicBPTextController;
  String? Function(BuildContext, String?)? diastolicBPTextControllerValidator;
  String? _diastolicBPTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Diastolic BP is required';
    }

    if (val.length < 2) {
      return 'Invalid Diastolic BP value.';
    }
    if (val.length > 3) {
      return 'Invalid Diastolic BP value.';
    }

    return null;
  }

  // State field(s) for RespiratoryRate widget.
  FocusNode? respiratoryRateFocusNode;
  TextEditingController? respiratoryRateTextController;
  String? Function(BuildContext, String?)?
      respiratoryRateTextControllerValidator;
  String? _respiratoryRateTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Respiratory Rate is required';
    }

    if (val.length < 1) {
      return 'Invalid Respiratory Rate value.';
    }
    if (val.length > 2) {
      return 'Invalid Respiratory Rate value.';
    }

    return null;
  }

  // State field(s) for Temperature widget.
  FocusNode? temperatureFocusNode;
  TextEditingController? temperatureTextController;
  String? Function(BuildContext, String?)? temperatureTextControllerValidator;
  String? _temperatureTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Temperature is required';
    }

    if (val.length < 2) {
      return 'Invalid Temperature value';
    }
    if (val.length > 5) {
      return 'Invalid Temperature value';
    }

    return null;
  }

  // State field(s) for TempUnits widget.
  FormFieldController<String>? tempUnitsValueController;
  // State field(s) for RespiratoryFailure widget.
  FormFieldController<List<String>>? respiratoryFailureValueController;
  String? get respiratoryFailureValue =>
      respiratoryFailureValueController?.value?.firstOrNull;
  set respiratoryFailureValue(String? val) =>
      respiratoryFailureValueController?.value = val != null ? [val] : [];
  // State field(s) for AirOrOxygen widget.
  FormFieldController<List<String>>? airOrOxygenValueController;
  String? get airOrOxygenValue =>
      airOrOxygenValueController?.value?.firstOrNull;
  set airOrOxygenValue(String? val) =>
      airOrOxygenValueController?.value = val != null ? [val] : [];
  // State field(s) for SpO2 widget.
  FocusNode? spO2FocusNode;
  TextEditingController? spO2TextController;
  String? Function(BuildContext, String?)? spO2TextControllerValidator;
  String? _spO2TextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Oxygen Saturation is required';
    }

    if (val.length < 2) {
      return 'Invalid SpO2 value';
    }
    if (val.length > 3) {
      return 'Invalid SpO2 value';
    }

    return null;
  }

  // State field(s) for Consciousness widget.
  String? consciousnessValue;
  FormFieldController<String>? consciousnessValueController;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - API (Bundle POST NEWS Observations)] action in Button widget.
  ApiCallResponse? postNEWSObservations;
  // Model for closeComponent component.
  late CloseComponentModel closeComponentModel;

  @override
  void initState(BuildContext context) {
    pulseTextControllerValidator = _pulseTextControllerValidator;
    systolicBPTextControllerValidator = _systolicBPTextControllerValidator;
    diastolicBPTextControllerValidator = _diastolicBPTextControllerValidator;
    respiratoryRateTextControllerValidator =
        _respiratoryRateTextControllerValidator;
    temperatureTextControllerValidator = _temperatureTextControllerValidator;
    spO2TextControllerValidator = _spO2TextControllerValidator;
    closeComponentModel = createModel(context, () => CloseComponentModel());
  }

  @override
  void dispose() {
    pulseFocusNode?.dispose();
    pulseTextController?.dispose();

    systolicBPFocusNode?.dispose();
    systolicBPTextController?.dispose();

    diastolicBPFocusNode?.dispose();
    diastolicBPTextController?.dispose();

    respiratoryRateFocusNode?.dispose();
    respiratoryRateTextController?.dispose();

    temperatureFocusNode?.dispose();
    temperatureTextController?.dispose();

    spO2FocusNode?.dispose();
    spO2TextController?.dispose();

    closeComponentModel.dispose();
  }

  /// Additional helper methods.
  String? get tempUnitsValue => tempUnitsValueController?.value;
}
