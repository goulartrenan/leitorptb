import 'package:leitorptb/backend/sqlite/models/conferencia_altria.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'altria_page_widget.dart' show AltriaPageWidget;
import 'package:flutter/material.dart';
import 'package:leitorptb/backend/api_requests/api_calls.dart';

class AltriaPageModel extends FlutterFlowModel<AltriaPageWidget> {
  final formKey6 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey9 = GlobalKey<FormState>();
  final formKey10 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey11 = GlobalKey<FormState>();
  final formKey13 = GlobalKey<FormState>();
  final formKey8 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey7 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey12 = GlobalKey<FormState>();

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

  String? Function(String?) get classebdValidator => (val) {
        if (val == null || val.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      };

  String? operacaobdValue;
  FormFieldController<String>? operacaobdValueController;
  String? classebdValue;
  FormFieldController<String>? classebdValueController;
  String? localValue;
  FormFieldController<String>? localValueController;

  FocusNode? codigo1AFocusNode;
  TextEditingController? codigo1ATextController;
  String? Function(BuildContext, String?)? codigo1ATextControllerValidator;
  String? _codigo1ATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 18 || val.length > 20) {
      return 'O código deve ter entre 18 e 20 caracteres!';
    }
    return null;
  }

  FocusNode? codigo2AFocusNode;
  TextEditingController? codigo2ATextController;
  String? Function(BuildContext, String?)? codigo2ATextControllerValidator;
  String? _codigo2ATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 18 || val.length > 20) {
      return 'O código deve ter entre 18 e 20 caracteres!';
    }
    return null;
  }

  FocusNode? codigo3AFocusNode;
  TextEditingController? codigo3ATextController;
  String? Function(BuildContext, String?)? codigo3ATextControllerValidator;
  String? _codigo3ATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 77 || val.length > 79) {
      return 'O código deve ter entre 77 e 79 caracteres!';
    }
    return null;
  }

  FocusNode? codigo4AFocusNode;
  TextEditingController? codigo4ATextController;
  String? Function(BuildContext, String?)? codigo4ATextControllerValidator;
  String? _codigo4ATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 77 || val.length > 79) {
      return 'O código deve ter entre 77 e 79 caracteres!';
    }
    return null;
  }

  FocusNode? codigo5AFocusNode;
  TextEditingController? codigo5ATextController;
  String? Function(BuildContext, String?)? codigo5ATextControllerValidator;
  String? _codigo5ATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 11 || val.length > 13) {
      return 'O código deve ter entre 11 e 13 caracteres!';
    }
    return null;
  }

  FocusNode? codigo1BFocusNode;
  TextEditingController? codigo1BTextController;
  String? Function(BuildContext, String?)? codigo1BTextControllerValidator;
  String? _codigo1BTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 18 || val.length > 20) {
      return 'O código deve ter entre 18 e 20 caracteres!';
    }
    return null;
  }

  FocusNode? codigo2BFocusNode;
  TextEditingController? codigo2BTextController;
  String? Function(BuildContext, String?)? codigo2BTextControllerValidator;
  String? _codigo2BTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 18 || val.length > 20) {
      return 'O código deve ter entre 18 e 20 caracteres!';
    }
    return null;
  }

  FocusNode? codigo3BFocusNode;
  TextEditingController? codigo3BTextController;
  String? Function(BuildContext, String?)? codigo3BTextControllerValidator;
  String? _codigo3BTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 77 || val.length > 79) {
      return 'O código deve ter entre 77 e 79 caracteres!';
    }
    return null;
  }

  FocusNode? codigo4BFocusNode;
  TextEditingController? codigo4BTextController;
  String? Function(BuildContext, String?)? codigo4BTextControllerValidator;
  String? _codigo4BTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 77 || val.length > 79) {
      return 'O código deve ter entre 77 e 79 caracteres!';
    }
    return null;
  }

  FocusNode? codigo5BFocusNode;
  TextEditingController? codigo5BTextController;
  String? Function(BuildContext, String?)? codigo5BTextControllerValidator;
  String? _codigo5BTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return 'Campo Obrigatório!';
    if (val.length < 11 || val.length > 13) {
      return 'O código deve ter entre 11 e 13 caracteres!';
    }
    return null;
  }

  // Variável privada e getter/setter corrigidos
  List<ConferenciaALTRIA> _altriainsert = [];

  List<ConferenciaALTRIA> get altriainsert => _altriainsert;
  set altriainsert(List<ConferenciaALTRIA> value) => _altriainsert = value;

  ApiCallResponse? apiResultqak;

  @override
  void initState(BuildContext context) {
    nrcaixaTextControllerValidator = _nrcaixaTextControllerValidator;
    codigo1ATextControllerValidator = _codigo1ATextControllerValidator;
    codigo2ATextControllerValidator = _codigo2ATextControllerValidator;
    codigo3ATextControllerValidator = _codigo3ATextControllerValidator;
    codigo4ATextControllerValidator = _codigo4ATextControllerValidator;
    codigo5ATextControllerValidator = _codigo5ATextControllerValidator;
    codigo1BTextControllerValidator = _codigo1BTextControllerValidator;
    codigo2BTextControllerValidator = _codigo2BTextControllerValidator;
    codigo3BTextControllerValidator = _codigo3BTextControllerValidator;
    codigo4BTextControllerValidator = _codigo4BTextControllerValidator;
    codigo5BTextControllerValidator = _codigo5BTextControllerValidator;
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
    codigo4AFocusNode?.dispose();
    codigo4ATextController?.dispose();
    codigo5AFocusNode?.dispose();
    codigo5ATextController?.dispose();
    codigo1BFocusNode?.dispose();
    codigo1BTextController?.dispose();
    codigo2BFocusNode?.dispose();
    codigo2BTextController?.dispose();
    codigo3BFocusNode?.dispose();
    codigo3BTextController?.dispose();
    codigo4BFocusNode?.dispose();
    codigo4BTextController?.dispose();
    codigo5BFocusNode?.dispose();
    codigo5BTextController?.dispose();
  }
}
