import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_dot_component_page_view_model.dart';
export 'custom_dot_component_page_view_model.dart';

class CustomDotComponentPageViewWidget extends StatefulWidget {
  const CustomDotComponentPageViewWidget({
    super.key,
    bool? isSelected,
    required this.assignedIdx,
  }) : this.isSelected = isSelected ?? false;

  final bool isSelected;
  final int? assignedIdx;

  @override
  State<CustomDotComponentPageViewWidget> createState() =>
      _CustomDotComponentPageViewWidgetState();
}

class _CustomDotComponentPageViewWidgetState
    extends State<CustomDotComponentPageViewWidget> {
  late CustomDotComponentPageViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomDotComponentPageViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        color: widget.isSelected
            ? FlutterFlowTheme.of(context).primary
            : FlutterFlowTheme.of(context).cardBlue,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        ((widget.assignedIdx!) + 1).toString(),
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              ),
              color: widget.isSelected
                  ? FlutterFlowTheme.of(context).info
                  : FlutterFlowTheme.of(context).primary,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
            ),
      ),
    );
  }
}
