// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class _ChartPoint {
  const _ChartPoint(this.x, this.y);

  final String x;
  final double y;
}

class LineChart extends StatefulWidget {
  const LineChart(
      {super.key,
      this.width,
      this.height,
      required this.xData,
      required this.yData1,
      this.chartTitle,
      this.xAxisTitle,
      this.yAxisTitle,
      this.isLogarithmicYAxis,
      required this.minCount,
      required this.maxCount,
      this.name1,
      this.yData2,
      this.yData3,
      this.name2,
      this.name3,
      required this.isExpanded,
      required this.factor});

  final double? width;
  final double? height;
  final List<String> xData;
  final List<double> yData1;
  final String? chartTitle;
  final String? xAxisTitle;
  final String? yAxisTitle;
  final bool? isLogarithmicYAxis;
  final double minCount;
  final double maxCount;
  final String? name1;
  final List<double>? yData2;
  final List<double>? yData3;
  final String? name2;
  final String? name3;
  final bool isExpanded;
  final double factor;

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
      enableMouseWheelZooming: true,
      enableSelectionZooming: true,
      enableDoubleTapZooming: true,
    );
    _trackballBehavior = TrackballBehavior(
        enable: true,
        tooltipSettings: InteractiveTooltip(
            enable: true,
            color: Colors.black,
            format: 'point.y',
            decimalPlaces: 5,
            textStyle: TextStyle(color: Colors.white)),
        markerSettings: TrackballMarkerSettings(
            markerVisibility: TrackballVisibilityMode.visible),
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int count1 = widget.yData1.length.clamp(0, widget.xData.length);
    final List<_ChartPoint> series1Data = List.generate(
      count1,
      (i) => _ChartPoint(widget.xData[i], widget.yData1[i]),
    );

    final int count2 = widget.yData2 != null
        ? widget.yData2!.length.clamp(0, widget.xData.length)
        : 0;
    final List<_ChartPoint> series2Data = List.generate(
      count2,
      (i) => _ChartPoint(widget.xData[i], widget.yData2![i]),
    );

    final int count3 = widget.yData3 != null
        ? widget.yData3!.length.clamp(0, widget.xData.length)
        : 0;
    final List<_ChartPoint> series3Data = List.generate(
      count3,
      (i) => _ChartPoint(widget.xData[i], widget.yData3![i]),
    );

    return Scaffold(
        body: SafeArea(
            child: Container(
                child: SfCartesianChart(
                    title: ChartTitle(text: widget.chartTitle ?? ''),
                    borderWidth: 10,
                    primaryXAxis: CategoryAxis(
                        title: AxisTitle(text: widget.xAxisTitle ?? '')),
                    primaryYAxis: (widget.isLogarithmicYAxis ?? false)
                        ? LogarithmicAxis(
                            title: AxisTitle(text: widget.yAxisTitle ?? ''),
                            minimum: widget.minCount * (1 - widget.factor),
                            maximum: widget.maxCount * (1 + widget.factor),
                          )
                        : NumericAxis(
                            title: AxisTitle(text: widget.yAxisTitle ?? ''),
                            minimum: widget.minCount * (1 - widget.factor),
                            maximum: widget.maxCount * (1 + widget.factor),
                            decimalPlaces: 5,
                          ),
                    zoomPanBehavior:
                        widget.isExpanded ? _zoomPanBehavior : null,
                    tooltipBehavior:
                        TooltipBehavior(enable: true, decimalPlaces: 5),
                    trackballBehavior:
                        widget.isExpanded ? _trackballBehavior : null,
                    legend: Legend(
                        isVisible: widget.isExpanded,
                        position: LegendPosition.bottom),
                    // Palette colors
                    palette: <Color>[
          Color.fromRGBO(16, 93, 251, 1),
          Color.fromRGBO(230, 139, 96, 1),
          Color.fromRGBO(2, 202, 121, 1),
        ],
                    series: <CartesianSeries<_ChartPoint, String>>[
          SplineSeries<_ChartPoint, String>(
            dataSource: series1Data,
            name: widget.name1 ?? '',
            xValueMapper: (_ChartPoint point, _) => point.x,
            yValueMapper: (_ChartPoint point, _) => point.y,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
          if (count2 > 0) ...[
            SplineSeries<_ChartPoint, String>(
              dataSource: series2Data,
              name: widget.name2 ?? '',
              xValueMapper: (_ChartPoint point, _) => point.x,
              yValueMapper: (_ChartPoint point, _) => point.y,
              markerSettings: const MarkerSettings(isVisible: true),
            )
          ],
          if (count3 > 0) ...[
            SplineSeries<_ChartPoint, String>(
              dataSource: series3Data,
              name: widget.name3 ?? '',
              xValueMapper: (_ChartPoint point, _) => point.x,
              yValueMapper: (_ChartPoint point, _) => point.y,
              markerSettings: const MarkerSettings(isVisible: true),
            )
          ],
        ]))));
  }
}
