import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/close_component/close_component_widget.dart';
import '/components/custom_dot_component_page_view/custom_dot_component_page_view_widget.dart';
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

  List<ObservationStruct> allObservations = [];
  void addToAllObservations(ObservationStruct item) =>
      allObservations.add(item);
  void removeFromAllObservations(ObservationStruct item) =>
      allObservations.remove(item);
  void removeAtIndexFromAllObservations(int index) =>
      allObservations.removeAt(index);
  void insertAtIndexInAllObservations(int index, ObservationStruct item) =>
      allObservations.insert(index, item);
  void updateAllObservationsAtIndex(
          int index, Function(ObservationStruct) updateFn) =>
      allObservations[index] = updateFn(allObservations[index]);

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

  int selectedPageIdx = 0;

  bool showCBGEntryForm = false;

  bool showInsulinEntryForm = false;

  DateTime? selectedDate;

  String? selectedTimespot;

  List<MedicationStruct> allMedications = [];
  void addToAllMedications(MedicationStruct item) => allMedications.add(item);
  void removeFromAllMedications(MedicationStruct item) =>
      allMedications.remove(item);
  void removeAtIndexFromAllMedications(int index) =>
      allMedications.removeAt(index);
  void insertAtIndexInAllMedications(int index, MedicationStruct item) =>
      allMedications.insert(index, item);
  void updateAllMedicationsAtIndex(
          int index, Function(MedicationStruct) updateFn) =>
      allMedications[index] = updateFn(allMedications[index]);

  List<TidChartEntryStruct> tidChartEntries = [];
  void addToTidChartEntries(TidChartEntryStruct item) =>
      tidChartEntries.add(item);
  void removeFromTidChartEntries(TidChartEntryStruct item) =>
      tidChartEntries.remove(item);
  void removeAtIndexFromTidChartEntries(int index) =>
      tidChartEntries.removeAt(index);
  void insertAtIndexInTidChartEntries(int index, TidChartEntryStruct item) =>
      tidChartEntries.insert(index, item);
  void updateTidChartEntriesAtIndex(
          int index, Function(TidChartEntryStruct) updateFn) =>
      tidChartEntries[index] = updateFn(tidChartEntries[index]);

  List<InsulinAdviceStruct> insulinAdviceList = [];
  void addToInsulinAdviceList(InsulinAdviceStruct item) =>
      insulinAdviceList.add(item);
  void removeFromInsulinAdviceList(InsulinAdviceStruct item) =>
      insulinAdviceList.remove(item);
  void removeAtIndexFromInsulinAdviceList(int index) =>
      insulinAdviceList.removeAt(index);
  void insertAtIndexInInsulinAdviceList(int index, InsulinAdviceStruct item) =>
      insulinAdviceList.insert(index, item);
  void updateInsulinAdviceListAtIndex(
          int index, Function(InsulinAdviceStruct) updateFn) =>
      insulinAdviceList[index] = updateFn(insulinAdviceList[index]);

  List<InsulinAdministrationStruct> insulinAdministrationList = [];
  void addToInsulinAdministrationList(InsulinAdministrationStruct item) =>
      insulinAdministrationList.add(item);
  void removeFromInsulinAdministrationList(InsulinAdministrationStruct item) =>
      insulinAdministrationList.remove(item);
  void removeAtIndexFromInsulinAdministrationList(int index) =>
      insulinAdministrationList.removeAt(index);
  void insertAtIndexInInsulinAdministrationList(
          int index, InsulinAdministrationStruct item) =>
      insulinAdministrationList.insert(index, item);
  void updateInsulinAdministrationListAtIndex(
          int index, Function(InsulinAdministrationStruct) updateFn) =>
      insulinAdministrationList[index] =
          updateFn(insulinAdministrationList[index]);

  ///  State fields for stateful widgets in this component.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (Get All Observations by ID for Patient)] action in ExpandedInsulinChartComponent widget.
  ApiCallResponse? allObservations1;
  // Stores action output result for [Backend Call - API (Get All MedicationStatements by ID for Patient)] action in ExpandedInsulinChartComponent widget.
  ApiCallResponse? medicationStatementQuery1;
  // Stores action output result for [Backend Call - API (Get Patient Medications by ID)] action in ExpandedInsulinChartComponent widget.
  ApiCallResponse? allMedicationRequestsQuery;
  // Stores action output result for [Backend Call - API (Get CBG Observations by ID for Patient)] action in ExpandedInsulinChartComponent widget.
  ApiCallResponse? tidChartObservations1;
  // Stores action output result for [Backend Call - API (Get All Insulin Advice by ID for Patient)] action in ExpandedInsulinChartComponent widget.
  ApiCallResponse? insulinAdvice1;
  // Stores action output result for [Backend Call - API (Get All Insulin Administration by ID)] action in ExpandedInsulinChartComponent widget.
  ApiCallResponse? insulinAdministration1;
  // State field(s) for ChartColumnMain widget.
  ScrollController? chartColumnMainScrollController;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
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
  // State field(s) for CBGPageView widget.
  PageController? cBGPageViewController;

  int get cBGPageViewCurrentIndex => cBGPageViewController != null &&
          cBGPageViewController!.hasClients &&
          cBGPageViewController!.page != null
      ? cBGPageViewController!.page!.round()
      : 0;
  // State field(s) for Row widget.
  ScrollController? rowController1;
  // State field(s) for Row widget.
  ScrollController? rowController2;
  // State field(s) for Row widget.
  ScrollController? rowController3;
  // Stores action output result for [Backend Call - API (Bundle POST Insulin Administration Record)] action in FollowedIB widget.
  ApiCallResponse? postInsulinAdministration;
  // Stores action output result for [Backend Call - API (Get All Insulin Administration by ID)] action in FollowedIB widget.
  ApiCallResponse? insulinAdministration2;
  // Models for CustomDotComponentPageView dynamic component.
  late FlutterFlowDynamicModels<CustomDotComponentPageViewModel>
      customDotComponentPageViewModels;
  // State field(s) for FeedStatusCC widget.
  FormFieldController<List<String>>? feedStatusCCValueController;
  String? get feedStatusCCValue =>
      feedStatusCCValueController?.value?.firstOrNull;
  set feedStatusCCValue(String? val) =>
      feedStatusCCValueController?.value = val != null ? [val] : [];
  // State field(s) for Steroids widget.
  FocusNode? steroidsFocusNode;
  TextEditingController? steroidsTextController;
  String? Function(BuildContext, String?)? steroidsTextControllerValidator;
  // State field(s) for Inotropes widget.
  FocusNode? inotropesFocusNode;
  TextEditingController? inotropesTextController;
  String? Function(BuildContext, String?)? inotropesTextControllerValidator;
  // State field(s) for HbA1c widget.
  FocusNode? hbA1cFocusNode;
  TextEditingController? hbA1cTextController;
  String? Function(BuildContext, String?)? hbA1cTextControllerValidator;
  // State field(s) for Creatinine widget.
  FocusNode? creatinineFocusNode;
  TextEditingController? creatinineTextController;
  String? Function(BuildContext, String?)? creatinineTextControllerValidator;
  // State field(s) for InsulinInfusion widget.
  FocusNode? insulinInfusionFocusNode;
  TextEditingController? insulinInfusionTextController;
  String? Function(BuildContext, String?)?
      insulinInfusionTextControllerValidator;
  // State field(s) for NurseNotes widget.
  FocusNode? nurseNotesFocusNode;
  TextEditingController? nurseNotesTextController;
  String? Function(BuildContext, String?)? nurseNotesTextControllerValidator;
  // State field(s) for CBG widget.
  FocusNode? cbgFocusNode;
  TextEditingController? cbgTextController;
  String? Function(BuildContext, String?)? cbgTextControllerValidator;
  // Stores action output result for [Backend Call - API (Bundle POST CBG Entry)] action in IconButton widget.
  ApiCallResponse? postCBGEntry;
  // Stores action output result for [Backend Call - API (Get CBG Observations by ID for Patient)] action in IconButton widget.
  ApiCallResponse? cbgObservations2;
  // State field(s) for SAIName widget.
  String? sAINameValue;
  FormFieldController<String>? sAINameValueController;
  // State field(s) for SAIDose widget.
  FocusNode? sAIDoseFocusNode;
  TextEditingController? sAIDoseTextController;
  String? Function(BuildContext, String?)? sAIDoseTextControllerValidator;
  String? _sAIDoseTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Short Acting Dose is required';
    }

    return null;
  }

  // State field(s) for LAIName widget.
  String? lAINameValue;
  FormFieldController<String>? lAINameValueController;
  // State field(s) for LAIDose widget.
  FocusNode? lAIDoseFocusNode;
  TextEditingController? lAIDoseTextController;
  String? Function(BuildContext, String?)? lAIDoseTextControllerValidator;
  String? _lAIDoseTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Long Acting/Premixed Insulin Dose is required';
    }

    return null;
  }

  // State field(s) for DoctorNotes widget.
  FocusNode? doctorNotesFocusNode;
  TextEditingController? doctorNotesTextController;
  String? Function(BuildContext, String?)? doctorNotesTextControllerValidator;
  // Stores action output result for [Backend Call - API (Bundle POST TID Insulin Advice)] action in IconButton widget.
  ApiCallResponse? postInsulinEntry;
  // Stores action output result for [Backend Call - API (Get All Insulin Advice by ID for Patient)] action in IconButton widget.
  ApiCallResponse? insulinAdvice2;
  // Model for EmptyWidget component.
  late EmptyWidgetModel emptyWidgetModel;
  // Model for closeComponent component.
  late CloseComponentModel closeComponentModel;

  @override
  void initState(BuildContext context) {
    chartColumnMainScrollController = ScrollController();
    columnController = ScrollController();
    listViewController = ScrollController();
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
    rowController1 = ScrollController();
    rowController2 = ScrollController();
    rowController3 = ScrollController();
    customDotComponentPageViewModels =
        FlutterFlowDynamicModels(() => CustomDotComponentPageViewModel());
    sAIDoseTextControllerValidator = _sAIDoseTextControllerValidator;
    lAIDoseTextControllerValidator = _lAIDoseTextControllerValidator;
    emptyWidgetModel = createModel(context, () => EmptyWidgetModel());
    closeComponentModel = createModel(context, () => CloseComponentModel());
  }

  @override
  void dispose() {
    chartColumnMainScrollController?.dispose();
    columnController?.dispose();
    listViewController?.dispose();
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

    rowController1?.dispose();
    rowController2?.dispose();
    rowController3?.dispose();
    customDotComponentPageViewModels.dispose();
    steroidsFocusNode?.dispose();
    steroidsTextController?.dispose();

    inotropesFocusNode?.dispose();
    inotropesTextController?.dispose();

    hbA1cFocusNode?.dispose();
    hbA1cTextController?.dispose();

    creatinineFocusNode?.dispose();
    creatinineTextController?.dispose();

    insulinInfusionFocusNode?.dispose();
    insulinInfusionTextController?.dispose();

    nurseNotesFocusNode?.dispose();
    nurseNotesTextController?.dispose();

    cbgFocusNode?.dispose();
    cbgTextController?.dispose();

    sAIDoseFocusNode?.dispose();
    sAIDoseTextController?.dispose();

    lAIDoseFocusNode?.dispose();
    lAIDoseTextController?.dispose();

    doctorNotesFocusNode?.dispose();
    doctorNotesTextController?.dispose();

    emptyWidgetModel.dispose();
    closeComponentModel.dispose();
  }
}
