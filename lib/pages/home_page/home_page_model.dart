import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/conditioon_table_row_component_widget.dart';
import '/components/custom_dot_component_page_view_widget.dart';
import '/components/custom_table_header_component_widget.dart';
import '/components/fire_component_widget.dart';
import '/components/medications_table_row_component_widget.dart';
import '/components/menu_items_component_widget.dart';
import '/components/n_e_w_s_row_component_widget.dart';
import '/components/patient_table_row_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  bool showPatients = true;

  bool showSearch = false;

  bool showCreateEditPatient = false;

  bool showActivity = false;

  bool showSettings = false;

  List<PatientStruct> allPatients = [];
  void addToAllPatients(PatientStruct item) => allPatients.add(item);
  void removeFromAllPatients(PatientStruct item) => allPatients.remove(item);
  void removeAtIndexFromAllPatients(int index) => allPatients.removeAt(index);
  void insertAtIndexInAllPatients(int index, PatientStruct item) =>
      allPatients.insert(index, item);
  void updateAllPatientsAtIndex(int index, Function(PatientStruct) updateFn) =>
      allPatients[index] = updateFn(allPatients[index]);

  List<PatientStruct> sortedAllPatients = [];
  void addToSortedAllPatients(PatientStruct item) =>
      sortedAllPatients.add(item);
  void removeFromSortedAllPatients(PatientStruct item) =>
      sortedAllPatients.remove(item);
  void removeAtIndexFromSortedAllPatients(int index) =>
      sortedAllPatients.removeAt(index);
  void insertAtIndexInSortedAllPatients(int index, PatientStruct item) =>
      sortedAllPatients.insert(index, item);
  void updateSortedAllPatientsAtIndex(
          int index, Function(PatientStruct) updateFn) =>
      sortedAllPatients[index] = updateFn(sortedAllPatients[index]);

  bool displaySimpleSearchPatients = false;

  DateTime? selectedDob;

  PatientMode? patientMode = PatientMode.create;

  ObservationMode? observationMode = ObservationMode.create;

  PatientStruct? patientSelectedForEdit;
  void updatePatientSelectedForEditStruct(Function(PatientStruct) updateFn) {
    updateFn(patientSelectedForEdit ??= PatientStruct());
  }

  bool displayFHIRSearchPatients = false;

  List<PatientStruct> allFHIRSearchPatients = [];
  void addToAllFHIRSearchPatients(PatientStruct item) =>
      allFHIRSearchPatients.add(item);
  void removeFromAllFHIRSearchPatients(PatientStruct item) =>
      allFHIRSearchPatients.remove(item);
  void removeAtIndexFromAllFHIRSearchPatients(int index) =>
      allFHIRSearchPatients.removeAt(index);
  void insertAtIndexInAllFHIRSearchPatients(int index, PatientStruct item) =>
      allFHIRSearchPatients.insert(index, item);
  void updateAllFHIRSearchPatientsAtIndex(
          int index, Function(PatientStruct) updateFn) =>
      allFHIRSearchPatients[index] = updateFn(allFHIRSearchPatients[index]);

  String? selectedTableColumn = 'Latest NEWS2 Score';

  bool isAscendingSelectedTableColumn = false;

  int currentPatientPage = 0;

  PatientStruct? patientSelectedForDetails;
  void updatePatientSelectedForDetailsStruct(Function(PatientStruct) updateFn) {
    updateFn(patientSelectedForDetails ??= PatientStruct());
  }

  bool showPatientDetails = false;

  List<ObservationStruct> patientObservations = [];
  void addToPatientObservations(ObservationStruct item) =>
      patientObservations.add(item);
  void removeFromPatientObservations(ObservationStruct item) =>
      patientObservations.remove(item);
  void removeAtIndexFromPatientObservations(int index) =>
      patientObservations.removeAt(index);
  void insertAtIndexInPatientObservations(int index, ObservationStruct item) =>
      patientObservations.insert(index, item);
  void updatePatientObservationsAtIndex(
          int index, Function(ObservationStruct) updateFn) =>
      patientObservations[index] = updateFn(patientObservations[index]);

  List<ConditionStruct> patientConditions = [];
  void addToPatientConditions(ConditionStruct item) =>
      patientConditions.add(item);
  void removeFromPatientConditions(ConditionStruct item) =>
      patientConditions.remove(item);
  void removeAtIndexFromPatientConditions(int index) =>
      patientConditions.removeAt(index);
  void insertAtIndexInPatientConditions(int index, ConditionStruct item) =>
      patientConditions.insert(index, item);
  void updatePatientConditionsAtIndex(
          int index, Function(ConditionStruct) updateFn) =>
      patientConditions[index] = updateFn(patientConditions[index]);

  List<MedicationStruct> patientMedications = [];
  void addToPatientMedications(MedicationStruct item) =>
      patientMedications.add(item);
  void removeFromPatientMedications(MedicationStruct item) =>
      patientMedications.remove(item);
  void removeAtIndexFromPatientMedications(int index) =>
      patientMedications.removeAt(index);
  void insertAtIndexInPatientMedications(int index, MedicationStruct item) =>
      patientMedications.insert(index, item);
  void updatePatientMedicationsAtIndex(
          int index, Function(MedicationStruct) updateFn) =>
      patientMedications[index] = updateFn(patientMedications[index]);

  String selectedConditionsTableColumn = 'Onset Date';

  bool isAscendingConditionsTableColumn = true;

  String selectedMedicationsTableColumn = 'Medication';

  bool isAscendingMedicationTable = true;

  int currPractIdx = 0;

  int practItems = 0;

  String temp = '- Assessment by Nurse \\n - Monitor vitals every 4 hours.';

  int currPtIdx = 0;

  int ptItems = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Custom Action - fetchFhirPatientsWithLatestNews2] action in HomePage widget.
  List<PatientStruct>? fetchPatientsWithNews1;
  // Stores action output result for [Backend Call - API (Get All Practitioners)] action in HomePage widget.
  ApiCallResponse? practitionersQuery;
  // Model for fireComponent component.
  late FireComponentModel fireComponentModel;
  // Model for Patients.
  late MenuItemsComponentModel patientsModel;
  // Model for Search.
  late MenuItemsComponentModel searchModel;
  // Model for CreatePatient.
  late MenuItemsComponentModel createPatientModel;
  // Model for Activity.
  late MenuItemsComponentModel activityModel;
  // Model for Settings.
  late MenuItemsComponentModel settingsModel;
  // Stores action output result for [Custom Action - fetchFhirPatientsWithLatestNews2] action in Button widget.
  List<PatientStruct>? fetchPatientsWithNews2;
  // State field(s) for SearchType widget.
  FormFieldController<String>? searchTypeValueController;
  // State field(s) for SearchName widget.
  FocusNode? searchNameFocusNode;
  TextEditingController? searchNameTextController;
  String? Function(BuildContext, String?)? searchNameTextControllerValidator;
  List<String> simpleSearchResults = [];
  // Stores action output result for [Backend Call - API (Search Patients)] action in IconButton widget.
  ApiCallResponse? fHIRSearchPatients;
  // Model for TableHeaderComponentName.
  late CustomTableHeaderComponentModel tableHeaderComponentNameModel1;
  // Model for TableHeaderComponentGender.
  late CustomTableHeaderComponentModel tableHeaderComponentGenderModel1;
  // Model for TableHeaderComponentDOB.
  late CustomTableHeaderComponentModel tableHeaderComponentDOBModel1;
  // Model for TableHeaderComponentPhoneNumber.
  late CustomTableHeaderComponentModel tableHeaderComponentPhoneNumberModel1;
  // Model for TableHeaderComponentPhoneNumber.
  late CustomTableHeaderComponentModel tableHeaderComponentPhoneNumberModel2;
  // Model for TableHeaderComponentActions.
  late CustomTableHeaderComponentModel tableHeaderComponentActionsModel;
  // State field(s) for PageView widget.
  PageController? pageViewController1;

  int get pageViewCurrentIndex1 => pageViewController1 != null &&
          pageViewController1!.hasClients &&
          pageViewController1!.page != null
      ? pageViewController1!.page!.round()
      : 0;
  // Models for PatientTableRowComponent dynamic component.
  late FlutterFlowDynamicModels<PatientTableRowComponentModel>
      patientTableRowComponentModels;
  // Stores action output result for [Backend Call - API (Delete Patient)] action in PatientTableRowComponent widget.
  ApiCallResponse? deletePatient;
  // Stores action output result for [Backend Call - API (Get All Patients)] action in PatientTableRowComponent widget.
  ApiCallResponse? allPatientsQuery4;
  // Stores action output result for [Backend Call - API (Patient Bundle Requests)] action in PatientTableRowComponent widget.
  ApiCallResponse? bundleResponse;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Models for CustomDotComponentPageView dynamic component.
  late FlutterFlowDynamicModels<CustomDotComponentPageViewModel>
      customDotComponentPageViewModels1;
  // State field(s) for FirstName widget.
  FocusNode? firstNameFocusNode;
  TextEditingController? firstNameTextController;
  String? Function(BuildContext, String?)? firstNameTextControllerValidator;
  String? _firstNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'ⓘ First Name is required';
    }

    if (val.length < 3) {
      return 'ⓘ First Name must contain at least 3 letters';
    }

    return null;
  }

  // State field(s) for LastName widget.
  FocusNode? lastNameFocusNode;
  TextEditingController? lastNameTextController;
  String? Function(BuildContext, String?)? lastNameTextControllerValidator;
  String? _lastNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'ⓘ Last Name is required';
    }

    if (val.length < 3) {
      return 'ⓘ Last Name must contain at least 3 letters';
    }

    return null;
  }

  // State field(s) for GenderCC widget.
  FormFieldController<List<String>>? genderCCValueController;
  String? get genderCCValue => genderCCValueController?.value?.firstOrNull;
  set genderCCValue(String? val) =>
      genderCCValueController?.value = val != null ? [val] : [];
  DateTime? datePicked;
  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  String? _phoneNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'ⓘ Phone Number is required';
    }

    if (!RegExp('^\\d{3}-\\d{3}-\\d{4}\$').hasMatch(val)) {
      return 'Invalid US Phone Format.';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (Create New Patient)] action in Button widget.
  ApiCallResponse? createNewPatient;
  // Stores action output result for [Backend Call - API (Edit Patient)] action in Button widget.
  ApiCallResponse? editPatient;
  // Stores action output result for [Custom Action - fetchFhirPatientsWithLatestNews2] action in Button widget.
  List<PatientStruct>? fetchPatientsWithNews3;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for TableHeaderComponentName.
  late CustomTableHeaderComponentModel tableHeaderComponentNameModel2;
  // Model for TableHeaderComponentGender.
  late CustomTableHeaderComponentModel tableHeaderComponentGenderModel2;
  // Model for TableHeaderComponentDOB.
  late CustomTableHeaderComponentModel tableHeaderComponentDOBModel2;
  // Model for TableHeaderComponentPhoneNumber.
  late CustomTableHeaderComponentModel tableHeaderComponentPhoneNumberModel3;
  // State field(s) for PageView widget.
  PageController? pageViewController2;

  int get pageViewCurrentIndex2 => pageViewController2 != null &&
          pageViewController2!.hasClients &&
          pageViewController2!.page != null
      ? pageViewController2!.page!.round()
      : 0;
  // Models for ConditioonTableRowComponent dynamic component.
  late FlutterFlowDynamicModels<ConditioonTableRowComponentModel>
      conditioonTableRowComponentModels;
  // Models for CustomDotComponentPageView dynamic component.
  late FlutterFlowDynamicModels<CustomDotComponentPageViewModel>
      customDotComponentPageViewModels2;
  // Model for TableHeaderComponentName.
  late CustomTableHeaderComponentModel tableHeaderComponentNameModel3;
  // Model for TableHeaderComponentGender.
  late CustomTableHeaderComponentModel tableHeaderComponentGenderModel3;
  // Model for TableHeaderComponentDOB.
  late CustomTableHeaderComponentModel tableHeaderComponentDOBModel3;
  // Model for TableHeaderComponentPhoneNumber.
  late CustomTableHeaderComponentModel tableHeaderComponentPhoneNumberModel4;
  // Model for TableHeaderComponentPhoneNumber.
  late CustomTableHeaderComponentModel tableHeaderComponentPhoneNumberModel5;
  // State field(s) for PageView widget.
  PageController? pageViewController3;

  int get pageViewCurrentIndex3 => pageViewController3 != null &&
          pageViewController3!.hasClients &&
          pageViewController3!.page != null
      ? pageViewController3!.page!.round()
      : 0;
  // Models for MedicationsTableRowComponent dynamic component.
  late FlutterFlowDynamicModels<MedicationsTableRowComponentModel>
      medicationsTableRowComponentModels;
  // Models for CustomDotComponentPageView dynamic component.
  late FlutterFlowDynamicModels<CustomDotComponentPageViewModel>
      customDotComponentPageViewModels3;
  // Stores action output result for [Custom Action - fetchFhirPatientsWithLatestNews2] action in IconButton widget.
  List<PatientStruct>? fetchPatientsWithNews4;
  // Stores action output result for [Backend Call - API (Patient Bundle Requests)] action in IconButton widget.
  ApiCallResponse? bundleResponse2;
  // Model for RecordedAt.
  late CustomTableHeaderComponentModel recordedAtModel;
  // Model for PulseRate.
  late CustomTableHeaderComponentModel pulseRateModel;
  // Model for BloodPressure.
  late CustomTableHeaderComponentModel bloodPressureModel;
  // Model for RespiratoryRate.
  late CustomTableHeaderComponentModel respiratoryRateModel;
  // Model for Temperature.
  late CustomTableHeaderComponentModel temperatureModel;
  // Model for AirOxygen.
  late CustomTableHeaderComponentModel airOxygenModel;
  // Model for SpO2.
  late CustomTableHeaderComponentModel spO2Model;
  // Model for AVPU.
  late CustomTableHeaderComponentModel avpuModel;
  // Model for NEWS2Score.
  late CustomTableHeaderComponentModel nEWS2ScoreModel;
  // Models for NEWSRowComponent dynamic component.
  late FlutterFlowDynamicModels<NEWSRowComponentModel> nEWSRowComponentModels;

  @override
  void initState(BuildContext context) {
    fireComponentModel = createModel(context, () => FireComponentModel());
    patientsModel = createModel(context, () => MenuItemsComponentModel());
    searchModel = createModel(context, () => MenuItemsComponentModel());
    createPatientModel = createModel(context, () => MenuItemsComponentModel());
    activityModel = createModel(context, () => MenuItemsComponentModel());
    settingsModel = createModel(context, () => MenuItemsComponentModel());
    tableHeaderComponentNameModel1 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentGenderModel1 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentDOBModel1 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentPhoneNumberModel1 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentPhoneNumberModel2 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentActionsModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    patientTableRowComponentModels =
        FlutterFlowDynamicModels(() => PatientTableRowComponentModel());
    customDotComponentPageViewModels1 =
        FlutterFlowDynamicModels(() => CustomDotComponentPageViewModel());
    firstNameTextControllerValidator = _firstNameTextControllerValidator;
    lastNameTextControllerValidator = _lastNameTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    tableHeaderComponentNameModel2 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentGenderModel2 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentDOBModel2 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentPhoneNumberModel3 =
        createModel(context, () => CustomTableHeaderComponentModel());
    conditioonTableRowComponentModels =
        FlutterFlowDynamicModels(() => ConditioonTableRowComponentModel());
    customDotComponentPageViewModels2 =
        FlutterFlowDynamicModels(() => CustomDotComponentPageViewModel());
    tableHeaderComponentNameModel3 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentGenderModel3 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentDOBModel3 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentPhoneNumberModel4 =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentPhoneNumberModel5 =
        createModel(context, () => CustomTableHeaderComponentModel());
    medicationsTableRowComponentModels =
        FlutterFlowDynamicModels(() => MedicationsTableRowComponentModel());
    customDotComponentPageViewModels3 =
        FlutterFlowDynamicModels(() => CustomDotComponentPageViewModel());
    recordedAtModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    pulseRateModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    bloodPressureModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    respiratoryRateModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    temperatureModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    airOxygenModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    spO2Model = createModel(context, () => CustomTableHeaderComponentModel());
    avpuModel = createModel(context, () => CustomTableHeaderComponentModel());
    nEWS2ScoreModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    nEWSRowComponentModels =
        FlutterFlowDynamicModels(() => NEWSRowComponentModel());
  }

  @override
  void dispose() {
    fireComponentModel.dispose();
    patientsModel.dispose();
    searchModel.dispose();
    createPatientModel.dispose();
    activityModel.dispose();
    settingsModel.dispose();
    searchNameFocusNode?.dispose();
    searchNameTextController?.dispose();

    tableHeaderComponentNameModel1.dispose();
    tableHeaderComponentGenderModel1.dispose();
    tableHeaderComponentDOBModel1.dispose();
    tableHeaderComponentPhoneNumberModel1.dispose();
    tableHeaderComponentPhoneNumberModel2.dispose();
    tableHeaderComponentActionsModel.dispose();
    patientTableRowComponentModels.dispose();
    customDotComponentPageViewModels1.dispose();
    firstNameFocusNode?.dispose();
    firstNameTextController?.dispose();

    lastNameFocusNode?.dispose();
    lastNameTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    tabBarController?.dispose();
    tableHeaderComponentNameModel2.dispose();
    tableHeaderComponentGenderModel2.dispose();
    tableHeaderComponentDOBModel2.dispose();
    tableHeaderComponentPhoneNumberModel3.dispose();
    conditioonTableRowComponentModels.dispose();
    customDotComponentPageViewModels2.dispose();
    tableHeaderComponentNameModel3.dispose();
    tableHeaderComponentGenderModel3.dispose();
    tableHeaderComponentDOBModel3.dispose();
    tableHeaderComponentPhoneNumberModel4.dispose();
    tableHeaderComponentPhoneNumberModel5.dispose();
    medicationsTableRowComponentModels.dispose();
    customDotComponentPageViewModels3.dispose();
    recordedAtModel.dispose();
    pulseRateModel.dispose();
    bloodPressureModel.dispose();
    respiratoryRateModel.dispose();
    temperatureModel.dispose();
    airOxygenModel.dispose();
    spO2Model.dispose();
    avpuModel.dispose();
    nEWS2ScoreModel.dispose();
    nEWSRowComponentModels.dispose();
  }

  /// Additional helper methods.
  String? get searchTypeValue => searchTypeValueController?.value;
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
