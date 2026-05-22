import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'close_component_model.dart';
export 'close_component_model.dart';

class CloseComponentWidget extends StatefulWidget {
  const CloseComponentWidget({super.key});

  @override
  State<CloseComponentWidget> createState() => _CloseComponentWidgetState();
}

class _CloseComponentWidgetState extends State<CloseComponentWidget> {
  late CloseComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CloseComponentModel());

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
        Navigator.pop(context);
      },
      child: Icon(
        Icons.close_rounded,
        color: FlutterFlowTheme.of(context).primaryText,
        size: 24.0,
      ),
    );
  }
}
