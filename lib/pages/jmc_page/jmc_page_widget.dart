import '/backend/api_requests/api_calls.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'jmc_page_model.dart';
export 'jmc_page_model.dart';

class JmcPageWidget extends StatefulWidget {
  const JmcPageWidget({
    super.key,
    required this.jmc,
    required this.ladoA,
    required this.ladoB,
  });

  final String? jmc;
  final String? ladoA;
  final String? ladoB;

  static String routeName = 'jmc_page';
  static String routePath = '/jmc_page';

  @override
  State<JmcPageWidget> createState() => _JmcPageWidgetState();
}

class _JmcPageWidgetState extends State<JmcPageWidget> {
  late JmcPageModel _model;

  bool _isSending = false;

  int? ultimaCaixa;

  Future<void> carregarUltimaCaixa() async {
    final lista = await SQLiteManager.instance.buscarConferenciasJMC();

    final ultima = lista.map((e) => e.caixa).whereType<int>().fold<int?>(null,
        (max, atual) {
      if (max == null || atual > max) return atual;
      return max;
    });

    setState(() {
      ultimaCaixa = ultima;
    });
  }

  int? totalCaixas;

  Future<void> carregarTotalCaixas() async {
    final total = await SQLiteManager.instance.contarCaixasLidasJMC();

    setState(() {
      totalCaixas = total;
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JmcPageModel());

    _model.nrcaixaTextController ??= TextEditingController();
    _model.nrcaixaFocusNode ??= FocusNode();

    _model.codigo1ATextController ??= TextEditingController();
    _model.codigo1AFocusNode ??= FocusNode();

    _model.codigo2ATextController ??= TextEditingController();
    _model.codigo2AFocusNode ??= FocusNode();

    _model.codigo3ATextController ??= TextEditingController();
    _model.codigo3AFocusNode ??= FocusNode();

    _model.codigo1BTextController ??= TextEditingController();
    _model.codigo1BFocusNode ??= FocusNode();

    _model.codigo2BTextController ??= TextEditingController();
    _model.codigo2BFocusNode ??= FocusNode();

    _model.codigo3BTextController ??= TextEditingController();
    _model.codigo3BFocusNode ??= FocusNode();

    carregarUltimaCaixa();
    carregarTotalCaixas();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).info,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            backgroundColor: Color(0xFF76232F),
            automaticallyImplyLeading: true,
            title: Text(
              'JMC',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    fontSize: 30.0,
                    letterSpacing: 0.0,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 1.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            22.0, 10.0, 0.0, 10.0),
                        child: Text(
                          'Nr da Caixa',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF173F35),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            25.0, 10.0, 0.0, 10.0),
                        child: Text(
                          'Ultimo Vol',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF173F35),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            25.0, 10.0, 0.0, 10.0),
                        child: Text(
                          'Contador',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF173F35),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: Container(
                            width: 100.0,
                            child: Form(
                              key: _model.formKey9,
                              autovalidateMode: AutovalidateMode.always,
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Container(
                                  width: 100.0,
                                  child: TextFormField(
                                    controller: _model.nrcaixaTextController,
                                    focusNode: _model.nrcaixaFocusNode,
                                    onChanged: (value) {
                                      if (value.length > 4) {
                                        final ultimos4 =
                                            value.substring(value.length - 4);

                                        // Atualiza o campo somente com os últimos 6
                                        _model.nrcaixaTextController?.value =
                                            TextEditingValue(
                                          text: ultimos4,
                                          selection: TextSelection.collapsed(
                                              offset: ultimos4.length),
                                        );
                                      }
                                    },
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Open Sans',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'Caixa',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Open Sans',
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF173F35),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF173F35),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      suffixIcon: _model.nrcaixaTextController!
                                              .text.isNotEmpty
                                          ? InkWell(
                                              onTap: () async {
                                                _model.nrcaixaTextController
                                                    ?.clear();
                                                safeSetState(() {});
                                              },
                                              child: Icon(
                                                Icons.clear,
                                                color: Color(0xFF173F35),
                                                size: 22,
                                              ),
                                            )
                                          : null,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          letterSpacing: 0.0,
                                        ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .nrcaixaTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  ultimaCaixa != null ? '$ultimaCaixa' : '-',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF173F35),
                                        letterSpacing: 0.0,
                                      ),
                                )),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  60.0, 0.0, 0.0, 0.0),
                              child: Text(
                                totalCaixas != null ? '$totalCaixas' : '-',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF173F35),
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 0.0, 10.0),
                      child: Text(
                        'Classe:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF173F35),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 0.0, 10.0),
                      child: Text(
                        'Operação:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF173F35),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Form(
                            key: _model.formKey4,
                            autovalidateMode: AutovalidateMode.always,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child:
                                        FutureBuilder<List<BuscaClasseJMCRow>>(
                                      future: SQLiteManager.instance
                                          .buscaClasseJMC(),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color(0xFF76232F),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final classebdBuscaClasseJMCRowList =
                                            snapshot.data!;

                                        return FormField<String>(
                                          validator: (val) {
                                            if (_model.classebdValue == null ||
                                                _model.classebdValue!.isEmpty) {
                                              return 'Campo Obrigatório';
                                            }
                                            return null;
                                          },
                                          builder: (formFieldState) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .classebdValueController ??=
                                                      FormFieldController<
                                                          String>(null),
                                                  options:
                                                      classebdBuscaClasseJMCRowList
                                                          .map((e) => e.classe)
                                                          .whereType<
                                                              String>() // remove nulls
                                                          .toList(),
                                                  onChanged: (val) {
                                                    safeSetState(() => _model
                                                        .classebdValue = val);
                                                    formFieldState
                                                        .didChange(val);
                                                  },
                                                  width: 170.0,
                                                  height: 40.0,
                                                  searchHintTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Open Sans',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  searchTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Open Sans',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'Defina a classe',
                                                  searchHintText: 'Buscar',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      Color(0xFF173F35),
                                                  borderWidth: 0.0,
                                                  borderRadius: 8.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  hidesUnderline: true,
                                                  isOverButton: false,
                                                  isSearchable: true,
                                                  isMultiSelect: false,
                                                ),
                                                if (formFieldState.hasError)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            top: 4.0),
                                                    child: Text(
                                                      formFieldState.errorText!,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: FutureBuilder<
                                        List<BuscaOperacaoJMCRow>>(
                                      future: SQLiteManager.instance
                                          .buscaOperacaoJMC(),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color(0xFF76232F),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final operacaobdBuscaOperacaoJMCRowList =
                                            snapshot.data!;

                                        return FormField<String>(
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return 'Campo Obrigatório';
                                            }
                                            return null;
                                          },
                                          builder: (field) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .operacaobdValueController ??=
                                                      FormFieldController<
                                                          String>(null),
                                                  options:
                                                      operacaobdBuscaOperacaoJMCRowList
                                                          .map(
                                                              (e) => e.operacao)
                                                          .whereType<
                                                              String>() // remove nulls
                                                          .toList(),
                                                  // options:
                                                  //     operacaobdBuscaOperacaoALTRIARowList
                                                  //         .map((e) =>
                                                  //             valueOrDefault<
                                                  //                     String>(
                                                  //                 e.operacao, '-'))
                                                  //         .toList(),
                                                  onChanged: (val) {
                                                    _model.operacaobdValue =
                                                        val;
                                                    field.didChange(val);
                                                  },
                                                  width: 170.0,
                                                  height: 40.0,
                                                  searchHintText: 'Buscar',
                                                  hintText: 'Defina a operação',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      Color(0xFF173F35),
                                                  borderWidth: 0.0,
                                                  borderRadius: 8.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          7.0, 0.0, 12.0, 0.0),
                                                  hidesUnderline: true,
                                                  isOverButton: false,
                                                  isSearchable: true,
                                                  isMultiSelect: false,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium,
                                                  searchTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium,
                                                  searchHintTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium,
                                                ),
                                                if (field.hasError)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5.0, left: 12.0),
                                                    child: Text(
                                                      field.errorText!,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 0.0, 10.0),
                      child: Text(
                        'Local Conferencia:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF173F35),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _model.formKey3,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FlutterFlowDropDown<String>(
                                controller: _model.localValueController ??=
                                    FormFieldController<String>(null),
                                options: ['Produção', 'Embarque'],
                                onChanged: (val) {
                                  safeSetState(() {
                                    _model.localValue = val;
                                  });
                                },
                                width: 180.0,
                                height: 40.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Selecione o Local',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor:
                                    const Color(0xFF173F35), // ✅ borda fixa
                                borderWidth: 1.0,
                                borderRadius: 8.0,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),
                              if ((_model.localValue == null ||
                                  _model.localValue!.isEmpty))
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 12.0, top: 4.0),
                                  child: Text(
                                    'Campo obrigatório',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12.0),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 20.0, 0.0, 10.0),
                          child: Text(
                            'Lado A ',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Open Sans',
                                  color: Color(0xFF173F35),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            5.0, 20.0, 0.0, 10.0),
                        child: FaIcon(
                          FontAwesomeIcons.box,
                          color: Color(0xFF173F35),
                          size: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 0.0, 10.0),
                      child: Text(
                        'Codigo 1:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF173F35),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Form(
                        key: _model.formKey7,
                        autovalidateMode: AutovalidateMode.always,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 0.0),
                          child: Container(
                            width: 100.0,
                            child: TextFormField(
                              controller: _model.codigo1ATextController,
                              focusNode: _model.codigo1AFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_model.codigo2AFocusNode);
                              },
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.codigo1ATextController',
                                Duration(milliseconds: 2000),
                                () => safeSetState(() {}),
                              ),
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Leia o codigo de barras superior',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF173F35),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF173F35),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                suffixIcon: _model
                                        .codigo1ATextController!.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          _model.codigo1ATextController
                                              ?.clear();
                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF173F35),
                                          size: 20.0,
                                        ),
                                      )
                                    : null,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.codigo1ATextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            5.0, 10.0, 0.0, 10.0),
                        child: Text(
                          'Codigo 2:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF173F35),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Form(
                          key: _model.formKey8,
                          autovalidateMode: AutovalidateMode.always,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 5.0, 0.0),
                            child: Container(
                              width: 100.0,
                              child: TextFormField(
                                controller: _model.codigo2ATextController,
                                focusNode: _model.codigo2AFocusNode,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_model.codigo3AFocusNode);
                                },
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.codigo2ATextController',
                                  Duration(milliseconds: 2000),
                                  () => safeSetState(() {}),
                                ),
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Leia o qrcode da esquerda',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF173F35),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF173F35),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  suffixIcon: _model.codigo2ATextController!
                                          .text.isNotEmpty
                                      ? InkWell(
                                          onTap: () async {
                                            _model.codigo2ATextController
                                                ?.clear();
                                            safeSetState(() {});
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            color: Color(0xFF173F35),
                                            size: 20.0,
                                          ),
                                        )
                                      : null,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model
                                    .codigo2ATextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            5.0, 10.0, 0.0, 10.0),
                        child: Text(
                          'Codigo 3:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF173F35),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Form(
                        key: _model.formKey5,
                        autovalidateMode: AutovalidateMode.always,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 10.0),
                          child: Container(
                            width: 100.0,
                            child: TextFormField(
                              controller: _model.codigo3ATextController,
                              focusNode: _model.codigo3AFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_model.codigo1BFocusNode);
                              },
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.codigo3ATextController',
                                Duration(milliseconds: 2000),
                                () => safeSetState(() {}),
                              ),
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Leia o qrcode da direita',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF173F35),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF173F35),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                suffixIcon: _model
                                        .codigo3ATextController!.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          _model.codigo3ATextController
                                              ?.clear();
                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF173F35),
                                          size: 20.0,
                                        ),
                                      )
                                    : null,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.codigo3ATextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 20.0, 0.0, 10.0),
                          child: Text(
                            'Lado B',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Open Sans',
                                  color: Color(0xFF173F35),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            5.0, 20.0, 0.0, 10.0),
                        child: FaIcon(
                          FontAwesomeIcons.box,
                          color: Color(0xFF173F35),
                          size: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 0.0, 10.0),
                      child: Text(
                        'Codigo 1:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF173F35),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Form(
                        key: _model.formKey6,
                        autovalidateMode: AutovalidateMode.always,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 0.0),
                          child: Container(
                            width: 100.0,
                            child: TextFormField(
                              controller: _model.codigo1BTextController,
                              focusNode: _model.codigo1BFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_model.codigo2BFocusNode);
                              },
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.codigo1BTextController',
                                Duration(milliseconds: 2000),
                                () => safeSetState(() {}),
                              ),
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Leia o codigo de barras',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF173F35),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF173F35),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                suffixIcon: _model
                                        .codigo1BTextController!.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          _model.codigo1BTextController
                                              ?.clear();
                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF173F35),
                                          size: 20.0,
                                        ),
                                      )
                                    : null,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.codigo1BTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            5.0, 10.0, 0.0, 10.0),
                        child: Text(
                          'Codigo 2:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF173F35),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Form(
                          key: _model.formKey1,
                          autovalidateMode: AutovalidateMode.always,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 5.0, 0.0),
                            child: Container(
                              width: 100.0,
                              child: TextFormField(
                                controller: _model.codigo2BTextController,
                                focusNode: _model.codigo2BFocusNode,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_model.codigo3BFocusNode);
                                },
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.codigo2BTextController',
                                  Duration(milliseconds: 2000),
                                  () => safeSetState(() {}),
                                ),
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Leia o qrcode da esquerda',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF173F35),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF173F35),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  suffixIcon: _model.codigo2BTextController!
                                          .text.isNotEmpty
                                      ? InkWell(
                                          onTap: () async {
                                            _model.codigo2BTextController
                                                ?.clear();
                                            safeSetState(() {});
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            color: Color(0xFF173F35),
                                            size: 20.0,
                                          ),
                                        )
                                      : null,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model
                                    .codigo2BTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            5.0, 10.0, 0.0, 10.0),
                        child: Text(
                          'Codigo 3:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF173F35),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Form(
                        key: _model.formKey2,
                        autovalidateMode: AutovalidateMode.always,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 10.0),
                          child: Container(
                            width: 100.0,
                            child: TextFormField(
                              controller: _model.codigo3BTextController,
                              focusNode: _model.codigo3BFocusNode,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.codigo3BTextController',
                                Duration(milliseconds: 2000),
                                () => safeSetState(() {}),
                              ),
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Leia o qrcode da direita',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF173F35),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF173F35),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                suffixIcon: _model
                                        .codigo3BTextController!.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          _model.codigo3BTextController
                                              ?.clear();
                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF173F35),
                                          size: 20.0,
                                        ),
                                      )
                                    : null,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.codigo3BTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 24.0),
                      child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (_isSending) return;
                              setState(() => _isSending = true);
                              try {
                                // Validações básicas
                                final numeroCaixa = int.tryParse(
                                    _model.nrcaixaTextController?.text ?? '');
                                final operacao = _model.operacaobdValue ?? '';
                                final classe = _model.classebdValue ?? '';
                                final local = _model.localValue ?? '';
                                final cod1a = int.tryParse(
                                    _model.codigo1ATextController?.text ?? '');
                                final cod2a = int.tryParse(
                                    _model.codigo2ATextController?.text ?? '');
                                final cod1b = int.tryParse(
                                    _model.codigo1BTextController?.text ?? '');
                                final cod2b = int.tryParse(
                                    _model.codigo2BTextController?.text ?? '');
                                final cod3a = int.tryParse(
                                    _model.codigo3ATextController?.text ?? '');
                                final cod3b = int.tryParse(
                                    _model.codigo3BTextController?.text ?? '');

                                if (numeroCaixa == null ||
                                    operacao.trim().isEmpty ||
                                    classe.trim().isEmpty ||
                                    local.trim().isEmpty ||
                                    cod1a == null ||
                                    cod2a == null ||
                                    cod1b == null ||
                                    cod2b == null ||
                                    cod3a == null ||
                                    cod3b == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '⚠️ Preencha todos os campos obrigatórios!'),
                                      backgroundColor: Colors.yellow[700],
                                    ),
                                  );
                                  return;
                                }
                                // Verifica duplicidade local (JMC)
                                final existe = await SQLiteManager.instance
                                    .existeCaixaRegistradaJMC(
                                  caixa: numeroCaixa,
                                  operacao: operacao,
                                  classe: classe,
                                );
                                if (existe) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '⚠️ Esta caixa já foi lida para esta operação e classe.'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                  return;
                                }
                                await SQLiteManager.instance
                                    .insertConferenciaJMC(
                                  caixa: numeroCaixa,
                                  classe: classe,
                                  localconferencia: local,
                                  ladoA: widget.ladoA,
                                  cliente: widget.jmc,
                                  data: getCurrentTimestamp,
                                  codigo1a: _model.codigo1ATextController?.text,
                                  codigo2a: _model.codigo2ATextController?.text,
                                  codigo3a: _model.codigo3ATextController?.text,
                                  codigo1b: _model.codigo1BTextController?.text,
                                  codigo2b: _model.codigo2BTextController?.text,
                                  codigo3b: _model.codigo3BTextController?.text,
                                  ladoB: widget.ladoB,
                                  operacao: operacao,
                                );

                                carregarUltimaCaixa();
                                carregarTotalCaixas();

                                // Recarrega e envia
                                final registrosLocais = await SQLiteManager
                                    .instance
                                    .buscarConferenciasJMC();

                                final apiResult =
                                    await AdicionarDadosConferenciaCall.call(
                                  dadosJMCJson: registrosLocais
                                      .map((e) => e.toMap())
                                      .toList(),
                                );

                                if ((apiResult.succeeded)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '✅ Dados gravados e enviados com sucesso!'),
                                        backgroundColor: Color(0xFF173F35)),
                                  );
                                  // await SQLiteManager.instance.limparConferenciasJMC(); // opcional
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '❌ Falha ao enviar dados. Código: ${apiResult.statusCode}'),
                                        backgroundColor: Color(0xFF76232F)),
                                  );
                                }

                                // Limpa campos e posiciona cursor na caixa
                                setState(() {
                                  _model.codigo1ATextController?.clear();
                                  _model.codigo2ATextController?.clear();
                                  _model.codigo3ATextController?.clear();
                                  _model.codigo1BTextController?.clear();
                                  _model.codigo2BTextController?.clear();
                                  _model.codigo3BTextController?.clear();
                                  _model.nrcaixaTextController?.clear();
                                });
                                _model.nrcaixaFocusNode?.requestFocus();
                                carregarUltimaCaixa();
                                carregarTotalCaixas();
                              } catch (e, st) {
                                debugPrint(
                                    'Erro ao salvar/enviar JMC: $e\n$st');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Erro inesperado: $e'),
                                      backgroundColor: Colors.red),
                                );
                              } finally {
                                setState(() => _isSending = false);
                              }
                            },
                            text: 'Salvar',
                            iconData: Icons.save,
                            options: FFButtonOptions(
                              height: 40,
                              width: 110,
                              color: const Color(0xFF76232F),
                              iconSize: 16,
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              elevation: 4,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )

                          // FFButtonWidget(
                          //   onPressed: () async {
                          //     var _shouldSetState = false;
                          //     if (_model.formKey9.currentState == null ||
                          //         !_model.formKey9.currentState!.validate()) {
                          //       return;
                          //     }
                          //     if (_model.formKey4.currentState == null ||
                          //         !_model.formKey4.currentState!.validate()) {
                          //       return;
                          //     }
                          //     if (_model.operacaobdValue == null) {
                          //       return;
                          //     }
                          //     if (_model.classebdValue == null) {
                          //       return;
                          //     }
                          //     if (_model.formKey3.currentState == null ||
                          //         !_model.formKey3.currentState!.validate()) {
                          //       return;
                          //     }
                          //     if (_model.localValue == null) {
                          //       return;
                          //     }
                          //     if (_model.formKey7.currentState == null ||
                          //         !_model.formKey7.currentState!.validate()) {
                          //       return;
                          //     }
                          //     if (_model.formKey8.currentState == null ||
                          //         !_model.formKey8.currentState!.validate()) {
                          //       return;
                          //     }
                          //     if (_model.formKey5.currentState == null ||
                          //         !_model.formKey5.currentState!.validate()) {
                          //       return;
                          //     }
                          //     if (_model.formKey6.currentState == null ||
                          //         !_model.formKey6.currentState!.validate()) {
                          //       return;
                          //     }
                          //     if (_model.formKey1.currentState == null ||
                          //         !_model.formKey1.currentState!.validate()) {
                          //       return;
                          //     }
                          //     if (_model.formKey2.currentState == null ||
                          //         !_model.formKey2.currentState!.validate()) {
                          //       return;
                          //     }
                          //     var confirmDialogResponse = await showDialog<bool>(
                          //           context: context,
                          //           builder: (alertDialogContext) {
                          //             return AlertDialog(
                          //               title: Text('Salvando'),
                          //               content:
                          //                   Text('Deseja salvar o registro?'),
                          //               actions: [
                          //                 TextButton(
                          //                   style: ButtonStyle(
                          //                     backgroundColor:
                          //                         WidgetStatePropertyAll(
                          //                             Color(0xFF76232F)),
                          //                     foregroundColor:
                          //                         WidgetStatePropertyAll(
                          //                             Colors.white),
                          //                     padding: WidgetStatePropertyAll(
                          //                         EdgeInsets.symmetric(
                          //                             horizontal: 16,
                          //                             vertical: 10)),
                          //                   ),
                          //                   onPressed: () => Navigator.pop(
                          //                       alertDialogContext, false),
                          //                   child: Text('Cancelar'),
                          //                 ),
                          //                 TextButton(
                          //                   style: ButtonStyle(
                          //                     backgroundColor:
                          //                         WidgetStatePropertyAll(
                          //                             Color(0xFF173F35)),
                          //                     foregroundColor:
                          //                         WidgetStatePropertyAll(
                          //                             Colors.white),
                          //                     padding: WidgetStatePropertyAll(
                          //                         EdgeInsets.symmetric(
                          //                             horizontal: 16,
                          //                             vertical: 10)),
                          //                   ),
                          //                   onPressed: () => Navigator.pop(
                          //                       alertDialogContext, true),
                          //                   child: Text('Confirmar'),
                          //                 ),
                          //               ],
                          //             );
                          //           },
                          //         ) ??
                          //         false;

                          //     if (confirmDialogResponse) {
                          //       final numeroCaixa = int.tryParse(
                          //           _model.nrcaixaTextController?.text ?? '');
                          //       final operacao = _model.operacaobdValue ?? '';
                          //       final classe = _model.classebdValue ?? '';

                          //       if (numeroCaixa == null ||
                          //           operacao.isEmpty ||
                          //           classe.isEmpty) {
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //             content: Text(
                          //                 '⚠️ Preencha todos os campos obrigatórios.'),
                          //             backgroundColor: Colors.orange,
                          //           ),
                          //         );
                          //         return;
                          //       }

                          //       final existe = await SQLiteManager.instance
                          //           .existeCaixaRegistradaJMC(
                          //         caixa: numeroCaixa,
                          //         operacao: operacao,
                          //         classe: classe,
                          //       );

                          //       if (existe) {
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //             content: Text(
                          //                 '⚠️ Esta caixa já foi lida para esta operação e classe.'),
                          //             backgroundColor: Colors.orange,
                          //           ),
                          //         );
                          //         return;
                          //       } else
                          //         // ✅ Prossegue com a gravação se não existir
                          //         await SQLiteManager.instance
                          //             .insertConferenciaJMC(
                          //           caixa: numeroCaixa,
                          //           classe: _model.classebdValue,
                          //           localconferencia: _model.localValue,
                          //           ladoA: widget.ladoA,
                          //           cliente: widget.jmc,
                          //           data: getCurrentTimestamp,
                          //           codigo1a: _model.codigo1ATextController.text,
                          //           codigo2a: _model.codigo2ATextController.text,
                          //           codigo3a: _model.codigo3ATextController.text,
                          //           codigo1b: _model.codigo1BTextController.text,
                          //           codigo2b: _model.codigo2BTextController.text,
                          //           codigo3b: _model.codigo3BTextController.text,
                          //           ladoB: widget.ladoB,
                          //           operacao: operacao,
                          //         );
                          //       carregarUltimaCaixa();
                          //       carregarTotalCaixas();
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //           content:
                          //               Text('✅ Registro salvo com sucesso!'),
                          //           backgroundColor: Color(0xFF173F35),
                          //         ),
                          //       );

                          //       // 1. Abre o diálogo de confirmação
                          //       final confirmDialogResponse =
                          //           await showDialog<bool>(
                          //                 context: context,
                          //                 builder: (alertDialogContext) {
                          //                   return AlertDialog(
                          //                     title: Text(
                          //                         'Realizar a sincronização?'),
                          //                     content: Text(
                          //                         'Deseja enviar os registros atuais?'),
                          //                     actions: [
                          //                       TextButton(
                          //                         style: ButtonStyle(
                          //                           backgroundColor:
                          //                               WidgetStatePropertyAll(
                          //                                   Color(0xFF76232F)),
                          //                           foregroundColor:
                          //                               WidgetStatePropertyAll(
                          //                                   Colors.white),
                          //                           padding:
                          //                               WidgetStatePropertyAll(
                          //                                   EdgeInsets.symmetric(
                          //                                       horizontal: 16,
                          //                                       vertical: 10)),
                          //                         ),
                          //                         onPressed: () => Navigator.pop(
                          //                             alertDialogContext, false),
                          //                         child: Text('Cancelar'),
                          //                       ),
                          //                       TextButton(
                          //                         style: ButtonStyle(
                          //                           backgroundColor:
                          //                               WidgetStatePropertyAll(
                          //                                   Color(0xFF173F35)),
                          //                           foregroundColor:
                          //                               WidgetStatePropertyAll(
                          //                                   Colors.white),
                          //                           padding:
                          //                               WidgetStatePropertyAll(
                          //                                   EdgeInsets.symmetric(
                          //                                       horizontal: 16,
                          //                                       vertical: 10)),
                          //                         ),
                          //                         onPressed: () => Navigator.pop(
                          //                             alertDialogContext, true),
                          //                         child: Text('Enviar'),
                          //                       ),
                          //                     ],
                          //                   );
                          //                 },
                          //               ) ??
                          //               false;
                          //       _model.jmcinsert = await SQLiteManager.instance
                          //           .buscarConferenciasJMC();

                          //       print(
                          //           '📦 Total de registros encontrados: ${_model.jmcinsert.length}');
                          //       print(
                          //           '📤 JSON a ser enviado: ${_model.jmcinsert.map((e) => e.toMap()).toList()}');

                          //       if (confirmDialogResponse) {
                          //         _model.apiResultqak =
                          //             await AdicionarDadosConferenciaCall.call(
                          //           dadosJMCJson: _model.jmcinsert
                          //               .map((e) => e.toMap())
                          //               .toList(),
                          //         );

                          //         if ((_model.apiResultqak?.succeeded ?? false)) {
                          //           ScaffoldMessenger.of(context).showSnackBar(
                          //             SnackBar(
                          //               content:
                          //                   Text('✅ Dados enviados com sucesso!'),
                          //               backgroundColor: Color(0xFF173F35),
                          //             ),
                          //           );
                          //         }
                          //       } else {
                          //         // Se cancelado, pode logar ou ignorar
                          //         print('🔁 Envio cancelado pelo usuário.');
                          //         _shouldSetState = true;
                          //       }

                          //       safeSetState(() {
                          //         _model.nrcaixaTextController?.clear();
                          //         _model.codigo1ATextController?.clear();
                          //         _model.codigo2ATextController?.clear();
                          //         _model.codigo3ATextController?.clear();
                          //         _model.codigo1BTextController?.clear();
                          //         _model.codigo2BTextController?.clear();
                          //         _model.codigo3BTextController?.clear();
                          //         _model.nrcaixaFocusNode?.requestFocus();
                          //       });
                          //       safeSetState(() {
                          //         _model.nrcaixaTextController?.clear();
                          //         _model.codigo1ATextController?.clear();
                          //         _model.codigo2ATextController?.clear();
                          //         _model.codigo3ATextController?.clear();
                          //         _model.codigo1BTextController?.clear();
                          //         _model.codigo2BTextController?.clear();
                          //         _model.codigo3BTextController?.clear();
                          //         _model.nrcaixaFocusNode?.requestFocus();
                          //       });
                          //       safeSetState(() {
                          //         _model.nrcaixaTextController?.text = '';
                          //       });
                          //       if (_shouldSetState) safeSetState(() {});
                          //       return;
                          //     } else {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //           content: Text(
                          //             'Cancelado!',
                          //             style: GoogleFonts.getFont(
                          //               'Open Sans',
                          //               color: FlutterFlowTheme.of(context)
                          //                   .secondaryBackground,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //           duration: Duration(milliseconds: 4000),
                          //           backgroundColor: Color(0xFF173F35),
                          //         ),
                          //       );
                          //       // if (_shouldSetState) safeSetState(() {});
                          //       return;
                          //     }

                          //     //  if (_shouldSetState) safeSetState(() {});
                          //   },
                          //   text: 'Gravar',
                          //   icon: Icon(
                          //     Icons.send,
                          //     size: 15.0,
                          //   ),
                          //   options: FFButtonOptions(
                          //     width: 110.0,
                          //     height: 40.0,
                          //     padding: EdgeInsetsDirectional.fromSTEB(
                          //         16.0, 0.0, 16.0, 0.0),
                          //     iconPadding: EdgeInsetsDirectional.fromSTEB(
                          //         0.0, 0.0, 0.0, 0.0),
                          //     color: Color(0xFF76232F),
                          //     textStyle: FlutterFlowTheme.of(context)
                          //         .labelLarge
                          //         .override(
                          //           fontFamily: 'Open Sans',
                          //           color: FlutterFlowTheme.of(context).info,
                          //           letterSpacing: 0.0,
                          //         ),
                          //     elevation: 10.0,
                          //     borderRadius: BorderRadius.circular(8.0),
                          //   ),
                          // ),
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 24.0),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xFFF5F5F5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      title: Text(
                                        'Você quer voltar?',
                                        style: TextStyle(
                                          color: Color(0xFF173F35),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text(
                                        'O que foi lido será perdido, quer continuar?',
                                        style: TextStyle(
                                          color: Color(0xFF173F35),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Color(0xFF76232F)),
                                            foregroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.white),
                                            padding: WidgetStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10)),
                                          ),
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: Text('Cancelar'),
                                        ),
                                        TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Color(0xFF173F35)),
                                            foregroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.white),
                                            padding: WidgetStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10)),
                                          ),
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: Text('Confirmar'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;

                            if (confirmDialogResponse) {
                              context.goNamed(HomePageWidget.routeName);
                            } else {
                              return;
                            }
                          },
                          text: 'Inicio',
                          icon: Icon(
                            Icons.home_filled,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: 110.0,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFF173F35),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Open Sans',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
