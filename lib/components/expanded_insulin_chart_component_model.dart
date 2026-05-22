import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/close_component/close_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
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

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Get All Observations by ID for Patient)] action in ExpandedInsulinChartComponent widget.
  ApiCallResponse? allObservations;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for closeComponent component.
  late CloseComponentModel closeComponentModel;

  @override
  void initState(BuildContext context) {
    closeComponentModel = createModel(context, () => CloseComponentModel());
  }

  @override
  void dispose() {
    closeComponentModel.dispose();
  }
}
