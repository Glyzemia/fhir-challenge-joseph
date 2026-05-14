import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/fire_component_widget.dart';
import '/components/menu_items_component_widget.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  bool showPatients = true;

  bool showSearch = false;

  bool showCreatePatient = false;

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

  ///  State fields for stateful widgets in this page.

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

  @override
  void initState(BuildContext context) {
    fireComponentModel = createModel(context, () => FireComponentModel());
    patientsModel = createModel(context, () => MenuItemsComponentModel());
    searchModel = createModel(context, () => MenuItemsComponentModel());
    createPatientModel = createModel(context, () => MenuItemsComponentModel());
    activityModel = createModel(context, () => MenuItemsComponentModel());
    settingsModel = createModel(context, () => MenuItemsComponentModel());
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
  }
}
