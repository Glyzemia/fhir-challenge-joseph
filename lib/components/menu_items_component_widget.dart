import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menu_items_component_model.dart';
export 'menu_items_component_model.dart';

class MenuItemsComponentWidget extends StatefulWidget {
  const MenuItemsComponentWidget({
    super.key,
    bool? isSelected,
    required this.text,
    required this.icon,
    required this.onClick,
  }) : this.isSelected = isSelected ?? false;

  final bool isSelected;
  final String? text;
  final Widget? icon;
  final Future Function()? onClick;

  @override
  State<MenuItemsComponentWidget> createState() =>
      _MenuItemsComponentWidgetState();
}

class _MenuItemsComponentWidgetState extends State<MenuItemsComponentWidget> {
  late MenuItemsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuItemsComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            await widget.onClick?.call();
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            curve: Curves.linear,
            height: 60.0,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? FlutterFlowTheme.of(context).cardBlue
                  : FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: widget.isSelected ? 4.0 : 0.0,
                  color: Color(0x33000000),
                  offset: Offset(
                    widget.isSelected ? 2.0 : 0.0,
                    widget.isSelected ? 2.0 : 0.0,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  widget.icon!,
                  Text(
                    valueOrDefault<String>(
                      widget.text,
                      'TEXT',
                    ),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.readexPro(
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          color: widget.isSelected
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).secondaryText,
                          fontSize: widget.isSelected ? 24.0 : 22.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                  ),
                ]
                    .divide(SizedBox(width: 30.0))
                    .addToStart(SizedBox(width: 10.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
