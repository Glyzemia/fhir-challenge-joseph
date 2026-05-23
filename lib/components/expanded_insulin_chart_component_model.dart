import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/close_component/close_component_widget.dart';
import '/components/empty_widget/empty_widget_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'expanded_insulin_chart_component_widget.dart'
    show ExpandedInsulinChartComponentWidget;
import 'package:flutter/material.dart';

class ExpandedInsulinChartComponentModel
    extends FlutterFlowModel<ExpandedInsulinChartComponentWidget> {
  ///  Local state fields for this component.

  List<ConditionStruct> ptConditions = [];
  void addToPtConditions(ConditionStruct item) => ptConditions.add(item);
  void removeFromPtConditions(ConditionStruct item) =>
      ptConditions.remove(item);
  void removeAtIndexFromPtConditions(int index) => ptConditions.removeAt(index);
  void insertAtIndexInPtConditions(int index, ConditionStruct item) =>
      ptConditions.insert(index, item);
  void updatePtConditionsAtIndex(
          int index, Function(ConditionStruct) updateFn) =>
      ptConditions[index] = updateFn(ptConditions[index]);

  bool isLoading = false;

  List<ObservationStruct> insChartObservations = [];
  void addToInsChartObservations(ObservationStruct item) =>
      insChartObservations.add(item);
  void removeFromInsChartObservations(ObservationStruct item) =>
      insChartObservations.remove(item);
  void removeAtIndexFromInsChartObservations(int index) =>
      insChartObservations.removeAt(index);
  void insertAtIndexInInsChartObservations(int index, ObservationStruct item) =>
      insChartObservations.insert(index, item);
  void updateInsChartObservationsAtIndex(
          int index, Function(ObservationStruct) updateFn) =>
      insChartObservations[index] = updateFn(insChartObservations[index]);

  bool hideEverything = true;

  bool showDiabetesEntryForm = false;

  List<MedicationStatementStruct> medicationStatements = [];
  void addToMedicationStatements(MedicationStatementStruct item) =>
      medicationStatements.add(item);
  void removeFromMedicationStatements(MedicationStatementStruct item) =>
      medicationStatements.remove(item);
  void removeAtIndexFromMedicationStatements(int index) =>
      medicationStatements.removeAt(index);
  void insertAtIndexInMedicationStatements(
          int index, MedicationStatementStruct item) =>
      medicationStatements.insert(index, item);
  void updateMedicationStatementsAtIndex(
          int index, Function(MedicationStatementStruct) updateFn) =>
      medicationStatements[index] = updateFn(medicationStatements[index]);

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (Get All Observations by ID for Patient)] action in ExpandedInsulinChartComponent widget.
  ApiCallResponse? allObservations;
  // Stores action output result for [Backend Call - API (Get All MedicationStatements by ID for Patient)] action in ExpandedInsulinChartComponent widget.
  ApiCallResponse? medicationStatementQuery1;
  // State field(s) for DiabetesType widget.
  String? diabetesTypeValue;
  FormFieldController<String>? diabetesTypeValueController;
  // State field(s) for DiabetesDuration widget.
  FocusNode? diabetesDurationFocusNode;
  TextEditingController? diabetesDurationTextController;
  String? Function(BuildContext, String?)?
      diabetesDurationTextControllerValidator;
  String? _diabetesDurationTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Diabetes Duration is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }
    if (val.length > 2) {
      return 'Maximum 2 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // State field(s) for InsulinName widget.
  FocusNode? insulinNameFocusNode;
  TextEditingController? insulinNameTextController;
  String? Function(BuildContext, String?)? insulinNameTextControllerValidator;
  String? _insulinNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Insulin Name is required';
    }

    if (val.length < 3) {
      return 'Requires at least 3 characters.';
    }

    return null;
  }

  // State field(s) for MornInsulinDose widget.
  FocusNode? mornInsulinDoseFocusNode;
  TextEditingController? mornInsulinDoseTextController;
  String? Function(BuildContext, String?)?
      mornInsulinDoseTextControllerValidator;
  String? _mornInsulinDoseTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Morning Insulin Dose is required';
    }

    return null;
  }

  // State field(s) for AftInsulinDose widget.
  FocusNode? aftInsulinDoseFocusNode;
  TextEditingController? aftInsulinDoseTextController;
  String? Function(BuildContext, String?)?
      aftInsulinDoseTextControllerValidator;
  String? _aftInsulinDoseTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Afternoon Insulin Dose is required';
    }

    return null;
  }

  // State field(s) for NightInsulinDose widget.
  FocusNode? nightInsulinDoseFocusNode;
  TextEditingController? nightInsulinDoseTextController;
  String? Function(BuildContext, String?)?
      nightInsulinDoseTextControllerValidator;
  String? _nightInsulinDoseTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Night Insulin Dose';
    }

    return null;
  }

  // State field(s) for OHAName widget.
  FocusNode? oHANameFocusNode;
  TextEditingController? oHANameTextController;
  String? Function(BuildContext, String?)? oHANameTextControllerValidator;
  String? _oHANameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'OHA Name and Dose is required';
    }

    return null;
  }

  // State field(s) for MornOHADose widget.
  FocusNode? mornOHADoseFocusNode;
  TextEditingController? mornOHADoseTextController;
  String? Function(BuildContext, String?)? mornOHADoseTextControllerValidator;
  String? _mornOHADoseTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Morning OHA Dose is required';
    }

    return null;
  }

  // State field(s) for AftOHADose widget.
  FocusNode? aftOHADoseFocusNode;
  TextEditingController? aftOHADoseTextController;
  String? Function(BuildContext, String?)? aftOHADoseTextControllerValidator;
  String? _aftOHADoseTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Afternoon OHA Dose is required';
    }

    return null;
  }

  // State field(s) for NightOHADose widget.
  FocusNode? nightOHADoseFocusNode;
  TextEditingController? nightOHADoseTextController;
  String? Function(BuildContext, String?)? nightOHADoseTextControllerValidator;
  String? _nightOHADoseTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Morning OHA Dose is required';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (Bundle POST Diabetes Details)] action in AdmissionSubmit widget.
  ApiCallResponse? diabetesDetailsBundlePost;
  // Stores action output result for [Backend Call - API (Get Patient Condition by ID Copy)] action in AdmissionSubmit widget.
  ApiCallResponse? allConditions1;
  // Stores action output result for [Backend Call - API (Get All MedicationStatements by ID for Patient)] action in AdmissionSubmit widget.
  ApiCallResponse? medicationStatements2;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for EmptyWidget component.
  late EmptyWidgetModel emptyWidgetModel;
  // Model for closeComponent component.
  late CloseComponentModel closeComponentModel;

  @override
  void initState(BuildContext context) {
    diabetesDurationTextControllerValidator =
        _diabetesDurationTextControllerValidator;
    insulinNameTextControllerValidator = _insulinNameTextControllerValidator;
    mornInsulinDoseTextControllerValidator =
        _mornInsulinDoseTextControllerValidator;
    aftInsulinDoseTextControllerValidator =
        _aftInsulinDoseTextControllerValidator;
    nightInsulinDoseTextControllerValidator =
        _nightInsulinDoseTextControllerValidator;
    oHANameTextControllerValidator = _oHANameTextControllerValidator;
    mornOHADoseTextControllerValidator = _mornOHADoseTextControllerValidator;
    aftOHADoseTextControllerValidator = _aftOHADoseTextControllerValidator;
    nightOHADoseTextControllerValidator = _nightOHADoseTextControllerValidator;
    emptyWidgetModel = createModel(context, () => EmptyWidgetModel());
    closeComponentModel = createModel(context, () => CloseComponentModel());
  }

  @override
  void dispose() {
    diabetesDurationFocusNode?.dispose();
    diabetesDurationTextController?.dispose();

    insulinNameFocusNode?.dispose();
    insulinNameTextController?.dispose();

    mornInsulinDoseFocusNode?.dispose();
    mornInsulinDoseTextController?.dispose();

    aftInsulinDoseFocusNode?.dispose();
    aftInsulinDoseTextController?.dispose();

    nightInsulinDoseFocusNode?.dispose();
    nightInsulinDoseTextController?.dispose();

    oHANameFocusNode?.dispose();
    oHANameTextController?.dispose();

    mornOHADoseFocusNode?.dispose();
    mornOHADoseTextController?.dispose();

    aftOHADoseFocusNode?.dispose();
    aftOHADoseTextController?.dispose();

    nightOHADoseFocusNode?.dispose();
    nightOHADoseTextController?.dispose();

    emptyWidgetModel.dispose();
    closeComponentModel.dispose();
  }
}
