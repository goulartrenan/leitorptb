import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'cadastro_j_m_c_widget.dart' show CadastroJMCWidget;
import 'package:flutter/material.dart';

class CadastroJMCModel extends FlutterFlowModel<CadastroJMCWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for classejmc widget.
  FocusNode? classejmcFocusNode;
  TextEditingController? classejmcTextController;
  String? Function(BuildContext, String?)? classejmcTextControllerValidator;
  // State field(s) for operacaojmc widget.
  FocusNode? operacaojmcFocusNode;
  TextEditingController? operacaojmcTextController;
  String? Function(BuildContext, String?)? operacaojmcTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    classejmcFocusNode?.dispose();
    classejmcTextController?.dispose();

    operacaojmcFocusNode?.dispose();
    operacaojmcTextController?.dispose();
  }
}
