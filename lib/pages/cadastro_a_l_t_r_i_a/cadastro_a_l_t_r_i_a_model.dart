import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'cadastro_a_l_t_r_i_a_widget.dart' show CadastroALTRIAWidget;
import 'package:flutter/material.dart';

class CadastroALTRIAModel extends FlutterFlowModel<CadastroALTRIAWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for classealtria widget.
  FocusNode? classealtriaFocusNode;
  TextEditingController? classealtriaTextController;
  String? Function(BuildContext, String?)? classealtriaTextControllerValidator;
  // State field(s) for operacaoatria widget.
  FocusNode? operacaoatriaFocusNode;
  TextEditingController? operacaoatriaTextController;
  String? Function(BuildContext, String?)? operacaoatriaTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    classealtriaFocusNode?.dispose();
    classealtriaTextController?.dispose();

    operacaoatriaFocusNode?.dispose();
    operacaoatriaTextController?.dispose();
  }
}
