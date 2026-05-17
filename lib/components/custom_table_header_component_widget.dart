import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_table_header_component_model.dart';
export 'custom_table_header_component_model.dart';

class CustomTableHeaderComponentWidget extends StatefulWidget {
  const CustomTableHeaderComponentWidget({
    super.key,
    required this.columnName,
    bool? isSelected,
    bool? isAscending,
    required this.onClick,
    double? topLeftBorderRadius,
    double? topRIghtBorderRadius,
    double? bottomLeftBorderRadius,
    double? bottomRightBorderRadius,
    double? rowHeight,
    this.bgColor,
  })  : this.isSelected = isSelected ?? false,
        this.isAscending = isAscending ?? true,
        this.topLeftBorderRadius = topLeftBorderRadius ?? 0.0,
        this.topRIghtBorderRadius = topRIghtBorderRadius ?? 0.0,
        this.bottomLeftBorderRadius = bottomLeftBorderRadius ?? 0.0,
        this.bottomRightBorderRadius = bottomRightBorderRadius ?? 0.0,
        this.rowHeight = rowHeight ?? 50.0;

  final String? columnName;
  final bool isSelected;
  final bool isAscending;
  final Future Function(String? columnName)? onClick;
  final double topLeftBorderRadius;
  final double topRIghtBorderRadius;
  final double bottomLeftBorderRadius;
  final double bottomRightBorderRadius;
  final double rowHeight;
  final Color? bgColor;

  @override
  State<CustomTableHeaderComponentWidget> createState() =>
      _CustomTableHeaderComponentWidgetState();
}

class _CustomTableHeaderComponentWidgetState
    extends State<CustomTableHeaderComponentWidget> {
  late CustomTableHeaderComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomTableHeaderComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await widget.onClick?.call(
          widget.columnName,
        );
      },
      child: Container(
        height: widget.rowHeight,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(valueOrDefault<double>(
              widget.topLeftBorderRadius,
              0.0,
            )),
            topRight: Radius.circular(valueOrDefault<double>(
              widget.topRIghtBorderRadius,
              0.0,
            )),
            bottomLeft: Radius.circular(valueOrDefault<double>(
              widget.bottomLeftBorderRadius,
              0.0,
            )),
            bottomRight: Radius.circular(valueOrDefault<double>(
              widget.bottomRightBorderRadius,
              0.0,
            )),
          ),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
          ),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              valueOrDefault<String>(
                widget.columnName,
                'Column Name',
              ),
              style: FlutterFlowTheme.of(context).labelLarge.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelLarge.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelLarge.fontStyle,
                  ),
            ),
            if (widget.isSelected)
              Builder(
                builder: (context) {
                  if (widget.isAscending) {
                    return Icon(
                      Icons.arrow_upward_rounded,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 20.0,
                    );
                  } else {
                    return Icon(
                      Icons.arrow_downward_rounded,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 20.0,
                    );
                  }
                },
              ),
          ].divide(SizedBox(width: 4.0)),
        ),
      ),
    );
  }
}
