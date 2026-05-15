import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/fire_component_widget.dart';
import '/components/menu_items_component_widget.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
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

  bool displaySearch = false;

  DateTime? selectedDob;

  PatientMode? patientMode = PatientMode.create;

  ObservationMode? observationMode = ObservationMode.create;

  PatientStruct? patientSelectedForEdit;
  void updatePatientSelectedForEditStruct(Function(PatientStruct) updateFn) {
    updateFn(patientSelectedForEdit ??= PatientStruct());
  }

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
  // State field(s) for SearchName widget.
  FocusNode? searchNameFocusNode;
  TextEditingController? searchNameTextController;
  String? Function(BuildContext, String?)? searchNameTextControllerValidator;
  List<String> simpleSearchResults = [];
  // State field(s) for AllPatientsDataTable widget.
  final allPatientsDataTableController =
      FlutterFlowDataTableController<PatientStruct>();
  // Stores action output result for [Backend Call - API (Delete Patient)] action in DeleteIconButton widget.
  ApiCallResponse? deletePatient;
  // Stores action output result for [Backend Call - API (Get All Patients)] action in DeleteIconButton widget.
  ApiCallResponse? allPatientsQuery4;
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

    allPatientsDataTableController.dispose();
    firstNameFocusNode?.dispose();
    firstNameTextController?.dispose();

    lastNameFocusNode?.dispose();
    lastNameTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();
  }
}
