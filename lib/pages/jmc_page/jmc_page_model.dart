import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'jmc_page_widget.dart' show JmcPageWidget;
import 'package:flutter/material.dart';
import '/backend/sqlite/models/conferencia_jmc.dart';

class JmcPageModel extends FlutterFlowModel<JmcPageWidget> {
  ///  Local state fields for this page.

  List<ConferenciaJMC> jmcinsert = [];

  void addToJmcinsert(ConferenciaJMC item) => jmcinsert.add(item);
  void removeFromJmcinsert(ConferenciaJMC item) => jmcinsert.remove(item);
  void removeAtIndexFromJmcinsert(int index) => jmcinsert.removeAt(index);
  void insertAtIndexInJmcinsert(int index, ConferenciaJMC item) =>
      jmcinsert.insert(index, item);
  void updateJmcinsertAtIndex(int index, Function(ConferenciaJMC) updateFn) =>
      jmcinsert[index] = updateFn(jmcinsert[index]);

  ///  State fields for stateful widgets in this page.

  final formKey9 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey7 = GlobalKey<FormState>();
  final formKey8 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey6 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  // State field(s) for nrcaixa widget.
  FocusNode? nrcaixaFocusNode;
  TextEditingController? nrcaixaTextController;
  String? Function(BuildContext, String?)? nrcaixaTextControllerValidator;
  String? _nrcaixaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Obrigatório!';
    }

    if (val.length < 1) {
      return 'Quantidade invalida!';
    }

    return null;
  }

  // State field(s) for classebd widget.
  String? classebdValue;
  FormFieldController<String>? classebdValueController;

// Aqui você define o validador como função
  String? Function(String?) get classebdValidator => (val) {
        if (val == null || val.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      };

  // State field(s) for operacaobd widget.
  String? operacaobdValue;
  FormFieldController<String>? operacaobdValueController;
  // State field(s) for local widget.
  String? localValue;
  FormFieldController<String>? localValueController;
  // State field(s) for codigo1_a widget.
  FocusNode? codigo1AFocusNode;
  TextEditingController? codigo1ATextController;
  String? Function(BuildContext, String?)? codigo1ATextControllerValidator;
  String? _codigo1ATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo Obrigatório!';
    }

    if (val.length < 10) {
      return 'Necessário 10 caracteres!';
    }

    return null;
  }

  // State field(s) for codigo2_a widget.
  FocusNode? codigo2AFocusNode;
  TextEditingController? codigo2ATextController;
  String? Function(BuildContext, String?)? codigo2ATextControllerValidator;
  String? _codigo2ATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo Obrigatório!';
    }

    if (val.length < 10) {
      return 'Necessário 10 caracteres!';
    }

    return null;
  }

  // State field(s) for codigo3_a widget.
  FocusNode? codigo3AFocusNode;
  TextEditingController? codigo3ATextController;
  String? Function(BuildContext, String?)? codigo3ATextControllerValidator;
  String? _codigo3ATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo Obrigatório!';
    }

    if (val.length < 10) {
      return 'Necessário 10 caracteres!';
    }

    return null;
  }

  // State field(s) for codigo1_b widget.
  FocusNode? codigo1BFocusNode;
  TextEditingController? codigo1BTextController;
  String? Function(BuildContext, String?)? codigo1BTextControllerValidator;
  String? _codigo1BTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo Obrigatório!';
    }

    if (val.length < 10) {
      return 'Necessário 10 caracteres!';
    }

    return null;
  }

  // State field(s) for codigo2_b widget.
  FocusNode? codigo2BFocusNode;
  TextEditingController? codigo2BTextController;
  String? Function(BuildContext, String?)? codigo2BTextControllerValidator;
  String? _codigo2BTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo Obrigatório!';
    }

    if (val.length < 10) {
      return 'Necessário 10 caracteres!';
    }

    return null;
  }

  // State field(s) for codigo3_b widget.
  FocusNode? codigo3BFocusNode;
  TextEditingController? codigo3BTextController;
  String? Function(BuildContext, String?)? codigo3BTextControllerValidator;
  String? _codigo3BTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo Obrigatório!';
    }

    if (val.length < 10) {
      return 'Necessário 10 caracteres!';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (Adicionar Dados Conferencia )] action in Button widget.
  ApiCallResponse? apiResultqak;

  @override
  void initState(BuildContext context) {
    nrcaixaTextControllerValidator = _nrcaixaTextControllerValidator;
    codigo1ATextControllerValidator = _codigo1ATextControllerValidator;
    codigo2ATextControllerValidator = _codigo2ATextControllerValidator;
    codigo3ATextControllerValidator = _codigo3ATextControllerValidator;
    codigo1BTextControllerValidator = _codigo1BTextControllerValidator;
    codigo2BTextControllerValidator = _codigo2BTextControllerValidator;
    codigo3BTextControllerValidator = _codigo3BTextControllerValidator;
  }

  @override
  void dispose() {
    nrcaixaFocusNode?.dispose();
    nrcaixaTextController?.dispose();

    codigo1AFocusNode?.dispose();
    codigo1ATextController?.dispose();

    codigo2AFocusNode?.dispose();
    codigo2ATextController?.dispose();

    codigo3AFocusNode?.dispose();
    codigo3ATextController?.dispose();

    codigo1BFocusNode?.dispose();
    codigo1BTextController?.dispose();

    codigo2BFocusNode?.dispose();
    codigo2BTextController?.dispose();

    codigo3BFocusNode?.dispose();
    codigo3BTextController?.dispose();
  }
}
