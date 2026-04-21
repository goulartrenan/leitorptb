import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leitorptb/backend/sqlite/sqlite_manager.dart';
import 'package:leitorptb/flutter_flow/flutter_flow_util.dart';
import 'package:leitorptb/pages/romaneio_page/classe_producao_stp.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/form_field_controller.dart';
import '/backend/api_requests/api_calls.dart';

class ReprocessarAltriaPage extends StatefulWidget {
  const ReprocessarAltriaPage({super.key});

  static String routeName = 'reprocessar_altria';
  static String routePath = '/reprocessar_altria';

  @override
  State<ReprocessarAltriaPage> createState() => _ReprocessarAltriaPageState();
}

class _DateTimeInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (text.isEmpty) return newValue;

    // Remove non-digits
    text = text.replaceAll(RegExp(r'\D'), '');

    StringBuffer formatted = StringBuffer();

    // Format as dd/mm/yyyy hh:mm (12 digits max)
    for (int i = 0; i < text.length && i < 12; i++) {
      if (i == 2 || i == 4) {
        formatted.write('/');
      } else if (i == 8) {
        formatted.write(' ');
      } else if (i == 10) {
        formatted.write(':');
      }
      formatted.write(text[i]);
    }

    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ReprocessarAltriaPageState extends State<ReprocessarAltriaPage> {
  bool _loadingCaixas = false;
  bool _loadingInfo = false;
  bool _sending = false;

  final List<Map<String, int>> _regrasCodigos = [
    {'min': 18, 'max': 20}, // Código 1
    {'min': 18, 'max': 20}, // Código 2
    {'min': 77, 'max': 79}, // Código 3
    {'min': 77, 'max': 79},
    {'min': 11, 'max': 13},
  ];

  bool _validarCodigos(List<TextEditingController> codigos, String lado) {
    for (int i = 0; i < codigos.length; i++) {
      final texto = codigos[i].text.trim();

      if (texto.isEmpty) {
        _showSnack(
            'Código ${i + 1} lado $lado não pode estar vazio', Colors.orange);
        return false;
      }

      final regra = _regrasCodigos[i];
      final min = regra['min']!;
      final max = regra['max']!;

      if (texto.length < min || texto.length > max) {
        _showSnack(
          'Código ${i + 1} lado $lado deve ter entre $min e $max caracteres',
          Colors.red,
        );
        return false;
      }
    }
    return true;
  }

  final List<FocusNode> _focusA = List.generate(5, (_) => FocusNode());
  final List<FocusNode> _focusB = List.generate(5, (_) => FocusNode());

  // Campos principais
  final _dataCtrl = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final _localValues = const ['Produção', 'Embarque'];
  String? _localSelecionado;

  // Dropdowns
  List<String> _caixas = [];
  String? _caixaSel;

  String? _classeAtualDb;
  String? _operacaoAtualDb;

  String?
      _novaClasseSel; // armazena CodClasseProd (value único, evita duplicatas)
  String? _novaClasseNome; // armazena NomeClasseProd (enviado no payload)
  String? _novaOperacaoSel;

  // Lista de classes carregada em estado (evita FutureBuilder recriar o dropdown)
  List<Map<String, dynamic>> _classes = [];

  final _codA = List.generate(5, (_) => TextEditingController());
  final _codB = List.generate(5, (_) => TextEditingController());

  FormFieldController<String>? _caixaDdController;
  FormFieldController<String>? _localDdController;
  FormFieldController<String>? _novaClasseDdController;
  FormFieldController<String>? _novaOperacaoDdController;

  int get _qtdCodigos => 5;

  @override
  void initState() {
    super.initState();
    _sincronizarCaixasLidasComSQLite().whenComplete(() async {
      await _carregarCaixasFromSQLite();
    });

    _sincronizarClassesComSQLite().whenComplete(() async {
      await _carregarClasses();
    });
  }

  @override
  void dispose() {
    _dataCtrl.dispose();
    for (final c in _codA) c.dispose();
    for (final c in _codB) c.dispose();
    for (final f in _focusA) f.dispose();
    for (final f in _focusB) f.dispose();
    super.dispose();
  }

  Future<void> _sincronizarCaixasLidasComSQLite() async {
    setState(() => _loadingCaixas = true);
    try {
      final resp = await ListarCaixasConferenciaCall.call(cliente: 'ALTRIA')
          .timeout(const Duration(seconds: 12));

      if (!resp.succeeded) {
        debugPrint('❌ Falha API: ${resp.statusCode} ${resp.bodyText}');
        return;
      }

      final dynamic bodyAny = resp.jsonBody ??
          ((resp.bodyText.isNotEmpty) ? jsonDecode(resp.bodyText) : null);

      late final List<dynamic> items;
      if (bodyAny is List) {
        items = bodyAny;
      } else if (bodyAny is Map && bodyAny['dados'] is List) {
        items = bodyAny['dados'] as List;
      } else {
        throw Exception('Formato JSON inesperado em ListarCaixasConferencia');
      }

      final linhas = items
          .map<Map<String, dynamic>>((raw) {
            final e = (raw as Map).map((k, v) => MapEntry(k.toString(), v));
            return <String, dynamic>{
              'Caixa': (e['Caixa'] ?? e['caixa'] ?? '').toString(),
              'Classe': (e['Classe'] ?? e['classe'] ?? '').toString(),
              'Operacao': (e['Operacao'] ?? e['operacao'] ?? '').toString(),
              'Cliente': (e['Cliente'] ?? e['cliente'] ?? 'ALTRIA').toString(),
            };
          })
          .where((m) => (m['Caixa'] as String).isNotEmpty)
          .toList();

      if (linhas.isEmpty) {
        debugPrint('ℹ️ API retornou lista vazia.');
        return;
      }
      await SQLiteManager.instance.inserirCaixasLidasFromMaps(linhas);

      debugPrint('✅ Sincronização concluída: ${linhas.length} caixas.');
    } on TimeoutException {
      debugPrint('⏱️ Timeout (12s) em ListarCaixasConferencia.');
    } catch (e, st) {
      debugPrint('❌ Erro em _sincronizarCaixasLidasComSQLite: $e');
      debugPrint('$st');
    } finally {
      if (mounted) setState(() => _loadingCaixas = false);
    }
  }

  Future<void> _carregarCaixasFromSQLite() async {
    try {
      final caixas = await SQLiteManager.instance.getDistinctCaixas('ALTRIA');
      if (!mounted) return;
      setState(() {
        _caixas = caixas;
        if (_caixaSel != null && !_caixas.contains(_caixaSel)) {
          _caixaSel = null;
        }
      });
      if (_caixaSel != null) {
        await _carregarInfoAtualFromSQLite(_caixaSel!);
      }
    } catch (e) {
      debugPrint('Erro ao carregar caixas do SQLite: $e');
    }
  }

  Future<void> _carregarInfoAtualFromSQLite(String caixa) async {
    setState(() => _loadingInfo = true);
    try {
      final info = await SQLiteManager.instance.getInfoAtualByCaixa(caixa);
      if (!mounted) return;
      setState(() {
        _classeAtualDb = info?['Classe']?.toString();
        _operacaoAtualDb = info?['Operacao']?.toString();
        //_clienteAtualDb = info?['Cliente']?.toString();
      });
    } catch (e) {
      debugPrint('Erro ao carregar info atual do SQLite: $e');
    } finally {
      if (mounted) setState(() => _loadingInfo = false);
    }
  }

  Future<void> _carregarClasses() async {
    try {
      final lista = await SQLiteManager.instance.buscarClassesProducaoSTP();
      if (!mounted) return;
      setState(() => _classes = lista);
    } catch (e) {
      debugPrint('Erro ao carregar classes: $e');
    }
  }

  // ==========================================
  // ENVIO
  // ==========================================
  Future<void> _enviarReprocessamento() async {
    if (_sending) return;
    if (_caixaSel == null) {
      _showSnack('Selecione a Caixa', Colors.orange);
      return;
    }
    if ((_novaClasseSel ?? '').isEmpty ||
        (_novaClasseNome ?? '').isEmpty ||
        (_novaOperacaoSel ?? '').isEmpty) {
      _showSnack('Selecione a Nova Classe e a Nova Operação', Colors.orange);
      return;
    }
    if ((_localSelecionado ?? '').isEmpty) {
      _showSnack('Selecione o Local', Colors.orange);
      return;
    }

    if (!_validarCodigos(_codA.take(_qtdCodigos).toList(), 'A')) return;
    if (!_validarCodigos(_codB.take(_qtdCodigos).toList(), 'B')) return;

    String dataTexto = _dataCtrl.text.trim();

    DateTime dataConvertida;

    if (dataTexto.length <= 10) {
      // formato: dd/MM/yyyy
      dataConvertida = DateFormat('dd/MM/yyyy').parse(dataTexto);
    } else {
      // formato: dd/MM/yyyy HH:mm
      dataConvertida = DateFormat('dd/MM/yyyy HH:mm').parse(dataTexto);
    }

    final dataFormatada =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dataConvertida);

    final payload = <String, dynamic>{
      'cliente': 'ALTRIA',
      'caixa': _caixaSel,
      //  NOVOS valores escolhidos
      'classe':
          _novaClasseNome, // NomeClasseProd — o servidor espera o nome, não o código
      'operacao': _novaOperacaoSel,
      'classe_antiga': _classeAtualDb,
      'operacao_antiga': _operacaoAtualDb,
      'data': dataFormatada,
      'localconferencia': _localSelecionado,
      'codigo1A': _codA[0].text,
      'codigo1B': _codB[0].text,
      'codigo2A': _codA[1].text,
      'codigo2B': _codB[1].text,
      'codigo3A': _codA[2].text,
      'codigo3B': _codB[2].text,
      'codigo4A': _codA[3].text,
      'codigo4B': _codB[3].text,
      'codigo5A': _codA[4].text,
      'codigo5B': _codB[4].text,
    };

    setState(() => _sending = true);
    try {
      final r = await ReprocessarConferenciaCall.call(payloadJson: payload);
      if (r.succeeded) {
        _showSnack('✅ Caixa relida com sucesso!', const Color(0xFF173F35));
        _limparCampos();
      } else {
        _showSnack('❌ Erro ${r.statusCode}: ${r.bodyText}', Colors.red);
      }
    } catch (e) {
      _showSnack('❌ Erro ao reprocessar: $e', Colors.red);
    } finally {
      setState(() => _sending = false);
    }
  }

  void _limparCampos() {
    for (final c in _codA) c.clear();
    for (final c in _codB) c.clear();

    _novaClasseSel = null;
    _novaClasseNome = null;
    _novaOperacaoSel = null;
    _caixaSel = null;
    _localSelecionado = null;
    _classeAtualDb = null;
    _operacaoAtualDb = null;

    // Destroi e recria os controllers para forçar limpeza visual dos dropdowns
    _novaClasseDdController = FormFieldController<String>(null);
    _novaOperacaoDdController = FormFieldController<String>(null);
    _caixaDdController = FormFieldController<String>(null);
    _localDdController = FormFieldController<String>(null);

    setState(() {});
  }

  // ==========================================
  // UI
  // ==========================================
  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
    ));
  }

  Future<void> _sincronizarClassesComSQLite() async {
    try {
      debugPrint('➡️ sync classes: iniciando chamada API');
      final response = await BuscarClassesProducaoCall
              .call() // garanta a URL certa p/ seu ambiente: 10.0.2.2/localhost/IP
          .timeout(const Duration(seconds: 12));

      debugPrint('classes.succeeded: ${response.succeeded}');
      debugPrint(
          'classes.jsonBody runtimeType: ${response.jsonBody.runtimeType}');

      if (!response.succeeded) return;

      // Pega JSON do jsonBody ou do bodyText (fallback)
      final dynamic bodyAny = response.jsonBody ??
          ((response.bodyText.isNotEmpty)
              ? jsonDecode(response.bodyText)
              : null);

      late final List<dynamic> items;
      if (bodyAny is List) {
        items = bodyAny;
      } else if (bodyAny is Map && bodyAny['data'] is List) {
        items = bodyAny['data'] as List;
      } else {
        throw Exception('Formato JSON inesperado: ${bodyAny.runtimeType}');
      }

      final classes = items
          .map((e) => ClasseProducaoSTP.fromApi(e as Map<String, dynamic>))
          .where((c) => c.codigo > 0) // filtra inválidos
          .toList();

      await SQLiteManager.instance.inserirClasseProducaoSTP(classes);

      debugPrint('✅ sync classes: inserção concluída');
      if (mounted) setState(() {});
    } on TimeoutException {
      debugPrint('⏱️ Timeout ao buscar classes (12s).');
    } catch (e, st) {
      debugPrint('❌ ERRO em _sincronizarClassesComSQLite: $e');
      debugPrint('$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Scaffold(
      backgroundColor: theme.info,
      appBar: AppBar(
        backgroundColor: const Color(0xFF76232F),
        title: Text('ALTRIA • Reprocessar',
            style: theme.headlineMedium.override(
              fontFamily: 'Open Sans',
              color: theme.primaryBackground,
              fontSize: 24,
            )),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Caixa
              Text('Caixa',
                  style: theme.bodyMedium.override(
                    fontFamily: 'Open Sans',
                    color: const Color(0xFF173F35),
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 6),
              _loadingCaixas
                  ? const LinearProgressIndicator()
                  : FlutterFlowDropDown<String>(
                      key: ValueKey('dd_caixa_${_caixas.length}'),
                      controller: _caixaDdController ??=
                          FormFieldController<String>(null),
                      options: _caixas,
                      onChanged: (v) async {
                        setState(() => _caixaSel = v);
                        if (v != null) {
                          await _carregarInfoAtualFromSQLite(v);
                        }
                      },
                      width: double.infinity,
                      height: 44,
                      hintText: 'Selecione a caixa',
                      searchHintText: 'Buscar...',
                      isSearchable: true,
                      fillColor: theme.secondaryBackground,
                      borderColor: const Color(0xFF173F35),
                      borderWidth: 1,
                      borderRadius: 8,
                      hidesUnderline: true,
                      textStyle: const TextStyle(fontFamily: "Open Sans"),
                      elevation: 0,
                      margin:
                          const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                    ),

              const SizedBox(height: 12),

              // Informações atuais (somente leitura)
              Text('Informações atuais',
                  style: theme.bodyMedium.override(
                    fontFamily: 'Open Sans',
                    color: const Color(0xFF173F35),
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 6),
              _loadingInfo
                  ? const LinearProgressIndicator()
                  : Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color(0xFF173F35), width: 0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Classe atual: ${_classeAtualDb ?? '-'}'),
                          Text('Operação atual: ${_operacaoAtualDb ?? '-'}'),
                        ],
                      ),
                    ),

              const SizedBox(height: 12),

              // Novos valores
              Text('Novos valores',
                  style: theme.bodyMedium.override(
                    fontFamily: 'Open Sans',
                    color: const Color(0xFF173F35),
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 6),

              // Nova Classe — usa lista de estado para evitar recriar o controller a cada setState
              if (_classes.isEmpty)
                const LinearProgressIndicator()
              else
                FlutterFlowDropDown<String>(
                  key: ValueKey('dd_nova_classe_${_novaClasseSel ?? "none"}'),
                  controller: _novaClasseDdController ??=
                      FormFieldController<String>(null),
                  // value = CodClasseProd (único por registro, evita duplicatas no dropdown)
                  options: _classes
                      .map((c) => (c['CodClasseProd'] ?? '').toString())
                      .toList(),
                  optionLabels: _classes
                      .map((c) =>
                          "${c['CodClasseProd']} - ${c['NomeClasseProd']}")
                      .toList(),
                  value: _novaClasseSel,
                  onChanged: (val) {
                    setState(() {
                      _novaClasseSel = val; // CodClasseProd
                      // resolve o NomeClasseProd correspondente para enviar no payload
                      final item = _classes.firstWhere(
                        (c) => (c['CodClasseProd'] ?? '').toString() == val,
                        orElse: () => {},
                      );
                      _novaClasseNome =
                          (item['NomeClasseProd'] ?? '').toString();
                      // limpa operação ao trocar classe
                      _novaOperacaoSel = null;
                      _novaOperacaoDdController?.value = null;
                    });
                  },
                  width: double.infinity,
                  height: 44,
                  hintText: 'Selecione a nova classe',
                  isSearchable: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  borderColor: const Color(0xFF173F35),
                  borderWidth: 1,
                  borderRadius: 8,
                  hidesUnderline: true,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium,
                  elevation: 2.0,
                  margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 0, 4),
                ),

              const SizedBox(height: 8),

              // Nova Operação (API)
              FutureBuilder<List<BuscaOperacaoALTRIARow>>(
                future: _novaClasseSel == null
                    ? Future.value([])
                    : SQLiteManager.instance.buscaOperacaoALTRIA(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const LinearProgressIndicator();
                  }

                  final operacoes = snapshot.data!;

                  return FlutterFlowDropDown<String>(
                    key: ValueKey('dd_nova_op_${operacoes.length}'),
                    controller: _novaOperacaoDdController ??=
                        FormFieldController<String>(null),
                    options: operacoes
                        .map((e) => e.operacao)
                        .whereType<String>()
                        .toList(),
                    value: _novaOperacaoSel,
                    onChanged: (val) {
                      setState(() {
                        _novaOperacaoSel = val;
                      });
                    },
                    width: double.infinity,
                    height: 44,
                    hintText: 'Selecione a nova operação',
                    isSearchable: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    borderColor: const Color(0xFF173F35),
                    borderWidth: 1,
                    borderRadius: 8,
                    hidesUnderline: true,
                    textStyle: FlutterFlowTheme.of(context)
                        .bodyMedium, // Or custom TextStyle
                    elevation: 2.0, // Default elevation for dropdown shadow
                    margin: EdgeInsetsDirectional.fromSTEB(12, 4, 0, 4),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Local & Data
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Local',
                            style: theme.bodyMedium.override(
                              fontFamily: 'Open Sans',
                              color: const Color(0xFF173F35),
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 6),
                        FlutterFlowDropDown<String>(
                          controller: _localDdController ??=
                              FormFieldController<String>(null),
                          options: _localValues,
                          onChanged: (v) =>
                              setState(() => _localSelecionado = v),
                          width: double.infinity,
                          height: 44,
                          hintText: 'Selecione',
                          fillColor: theme.secondaryBackground,
                          borderColor: const Color(0xFF173F35),
                          borderWidth: 1,
                          borderRadius: 8,
                          hidesUnderline: true,
                          textStyle: const TextStyle(fontFamily: "Open Sans"),
                          elevation: 0,
                          margin: const EdgeInsetsDirectional.fromSTEB(
                              12, 4, 12, 4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data',
                            style: theme.bodyMedium.override(
                              fontFamily: 'Open Sans',
                              color: const Color(0xFF173F35),
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _dataCtrl,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            _DateTimeInputFormatter(),
                          ],
                          cursorColor: const Color(0xFF173F35),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'dd/mm/aaaa hh:mm',
                            filled: true,
                            fillColor: theme.secondaryBackground,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF173F35), width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF173F35), width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              _tituloSecao(theme, 'Lado A'),

              for (int i = 0; i < 5; i++) ...[
                _rotulo(theme, 'Código ${i + 1}:'),
                _inputCodigo(
                  _codA[i],
                  theme,
                  index: i,
                  hint: i == 0 ? 'Siga a ordem habitual de leitura' : null,
                  focusNode: _focusA[i],
                  onNext: () {
                    if (i < 4) {
                      FocusScope.of(context).requestFocus(_focusA[i + 1]);
                    } else {
                      // último do A → vai pro primeiro do B
                      FocusScope.of(context).requestFocus(_focusB[0]);
                    }
                  },
                ),
                const SizedBox(height: 6),
              ],

              const SizedBox(height: 12),
              _tituloSecao(theme, 'Lado B'),

              for (int i = 0; i < 5; i++) ...[
                _rotulo(theme, 'Código ${i + 1}:'),
                _inputCodigo(
                  _codB[i],
                  theme,
                  index: i,
                  hint: i == 0 ? 'Siga a ordem habitual de leitura' : null,
                  focusNode: _focusB[i],
                  onNext: () {
                    if (i < 4) {
                      FocusScope.of(context).requestFocus(_focusB[i + 1]);
                    } else {
                      FocusScope.of(context).unfocus(); // último campo
                    }
                  },
                ),
                const SizedBox(height: 6),
              ],

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FFButtonWidget(
                    onPressed: _sending ? null : _enviarReprocessamento,
                    text: 'CORRIGIR',
                    iconData: Icons.add_task,
                    options: FFButtonOptions(
                      height: 44,
                      width: 160,
                      color: const Color(0xFF76232F),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: _sending ? null : _limparCampos,
                    text: 'LIMPAR',
                    iconData: Icons.cleaning_services_outlined,
                    options: FFButtonOptions(
                      height: 44,
                      width: 120,
                      color: const Color(0xFF173F35),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ======= UI auxiliares =======
  Widget _tituloSecao(FlutterFlowTheme theme, String t) {
    return Row(
      children: [
        Text(t,
            style: theme.bodyMedium.override(
              fontFamily: 'Open Sans',
              color: const Color(0xFF173F35),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(width: 6),
        const Icon(Icons.inventory_2, color: Color(0xFF173F35), size: 20),
      ],
    );
  }

  Widget _rotulo(FlutterFlowTheme theme, String t) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4),
      child: Text(t,
          style: theme.bodyMedium.override(
            fontFamily: 'Open Sans',
            color: const Color(0xFF173F35),
            fontWeight: FontWeight.bold,
          )),
    );
  }

  /// Cor da barra/texto conforme estado do campo
  Color _corIndicador(int atual, int min, int max) {
    if (atual == 0) return Colors.grey.shade300;
    if (atual > max) return Colors.red;
    if (atual >= min) return const Color(0xFF173F35);
    return Colors.orange;
  }

  /// Texto do contador exibido ao lado da barra
  String _textoContador(int atual, int min, int max) {
    if (atual == 0) return '$min–$max caracteres';
    if (atual > max) return 'Excedeu em ${atual - max}';
    if (atual >= min) return '✓ $atual/$max';
    return 'Faltam ${min - atual}';
  }

  Widget _inputCodigo(
    TextEditingController c,
    FlutterFlowTheme theme, {
    String? hint,
    FocusNode? focusNode,
    VoidCallback? onNext,
    required int index,
  }) {
    final regra = _regrasCodigos[index];
    final min = regra['min']!;
    final max = regra['max']!;
    final atual = c.text.length;
    final cor = _corIndicador(atual, min, max);
    final textoContador = _textoContador(atual, min, max);
    final ok = atual >= min && atual <= max;
    final excedeu = atual > max;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: c,
          focusNode: focusNode,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            filled: true,
            fillColor: theme.secondaryBackground,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: excedeu ? Colors.red : const Color(0xFF173F35),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: excedeu ? Colors.red : const Color(0xFF173F35),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: c.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    color: const Color(0xFF173F35),
                    onPressed: () {
                      c.clear();
                      FocusScope.of(context).requestFocus(focusNode);
                      setState(() {});
                    },
                  )
                : null,
          ),
          onFieldSubmitted: (_) {
            if (onNext != null) {
              onNext();
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          onChanged: (value) {
            setState(() {});
            if (value.length == max + 1) {
              _showSnack(
                'Código ${index + 1} excedeu o máximo de $max caracteres',
                Colors.red,
              );
            }
          },
        ),

        // Barra de progresso + contador de caracteres
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: atual == 0 ? 0 : (atual / max).clamp(0.0, 1.0),
                  minHeight: 4,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(cor),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              textoContador,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Open Sans',
                color: atual == 0 ? Colors.grey : cor,
                fontWeight: ok ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
