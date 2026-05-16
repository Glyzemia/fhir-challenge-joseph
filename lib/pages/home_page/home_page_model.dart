import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_dot_component_page_view_widget.dart';
import '/components/custom_table_header_component_widget.dart';
import '/components/fire_component_widget.dart';
import '/components/menu_items_component_widget.dart';
import '/components/patient_table_row_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
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

  String? selectedTableColumn = 'Name';

  bool isAscendingSelectedTableColumn = true;

  int currentPatientPage = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (Get All Patients)] action in HomePage widget.
  ApiCallResponse? allPatientsQuery1;
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
  // Stores action output result for [Backend Call - API (Get All Patients)] action in Button widget.
  ApiCallResponse? allPatientsQuery2;
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
  late CustomTableHeaderComponentModel tableHeaderComponentNameModel;
  // Model for TableHeaderComponentGender.
  late CustomTableHeaderComponentModel tableHeaderComponentGenderModel;
  // Model for TableHeaderComponentDOB.
  late CustomTableHeaderComponentModel tableHeaderComponentDOBModel;
  // Model for TableHeaderComponentPhoneNumber.
  late CustomTableHeaderComponentModel tableHeaderComponentPhoneNumberModel;
  // Model for TableHeaderComponentActions.
  late CustomTableHeaderComponentModel tableHeaderComponentActionsModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Models for PatientTableRowComponent dynamic component.
  late FlutterFlowDynamicModels<PatientTableRowComponentModel>
      patientTableRowComponentModels;
  // Stores action output result for [Backend Call - API (Delete Patient)] action in PatientTableRowComponent widget.
  ApiCallResponse? deletePatient;
  // Stores action output result for [Backend Call - API (Get All Patients)] action in PatientTableRowComponent widget.
  ApiCallResponse? allPatientsQuery4;
  // Models for CustomDotComponentPageView dynamic component.
  late FlutterFlowDynamicModels<CustomDotComponentPageViewModel>
      customDotComponentPageViewModels;
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
  // Stores action output result for [Backend Call - API (Get All Patients)] action in Button widget.
  ApiCallResponse? allPatientsQuery3;

  @override
  void initState(BuildContext context) {
    fireComponentModel = createModel(context, () => FireComponentModel());
    patientsModel = createModel(context, () => MenuItemsComponentModel());
    searchModel = createModel(context, () => MenuItemsComponentModel());
    createPatientModel = createModel(context, () => MenuItemsComponentModel());
    activityModel = createModel(context, () => MenuItemsComponentModel());
    settingsModel = createModel(context, () => MenuItemsComponentModel());
    tableHeaderComponentNameModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentGenderModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentDOBModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentPhoneNumberModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    tableHeaderComponentActionsModel =
        createModel(context, () => CustomTableHeaderComponentModel());
    patientTableRowComponentModels =
        FlutterFlowDynamicModels(() => PatientTableRowComponentModel());
    customDotComponentPageViewModels =
        FlutterFlowDynamicModels(() => CustomDotComponentPageViewModel());
    firstNameTextControllerValidator = _firstNameTextControllerValidator;
    lastNameTextControllerValidator = _lastNameTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
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

    tableHeaderComponentNameModel.dispose();
    tableHeaderComponentGenderModel.dispose();
    tableHeaderComponentDOBModel.dispose();
    tableHeaderComponentPhoneNumberModel.dispose();
    tableHeaderComponentActionsModel.dispose();
    patientTableRowComponentModels.dispose();
    customDotComponentPageViewModels.dispose();
    firstNameFocusNode?.dispose();
    firstNameTextController?.dispose();

    lastNameFocusNode?.dispose();
    lastNameTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();
  }

  /// Additional helper methods.
  String? get searchTypeValue => searchTypeValueController?.value;
}
