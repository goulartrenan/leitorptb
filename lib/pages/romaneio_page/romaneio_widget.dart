import 'package:flutter/material.dart';
import 'package:leitorptb/backend/api_requests/api_calls.dart';
import 'package:leitorptb/backend/sqlite/sqlite_manager.dart';
import 'package:leitorptb/flutter_flow/flutter_flow_drop_down.dart';
import 'package:leitorptb/flutter_flow/flutter_flow_theme.dart';
import 'package:leitorptb/flutter_flow/flutter_flow_widgets.dart';
import 'package:leitorptb/flutter_flow/form_field_controller.dart';
import 'package:leitorptb/flutter_flow/nav/nav.dart';
import 'package:leitorptb/pages/romaneio_page/romaneio_cliente_config.dart';
export 'romaneio_widget.dart';

class RomaneioWidget extends StatefulWidget {
  /// Cliente selecionado no menu — define a regra de extração do código PARA.
  final ClienteRomaneioConfig cliente;

  RomaneioWidget({
    super.key,
    required ClienteRomaneioConfig cliente,
  }) : cliente = cliente;

  static String routeName = 'RomaneioPage';
  static String routePath = '/romaneioPage';

  @override
  State<RomaneioWidget> createState() => _RomaneioWidgetState();
}

class _RomaneioWidgetState extends State<RomaneioWidget> {
  // ── Controllers dos campos de resultado ───────────────────────────────────
  final TextEditingController obsController = TextEditingController();
  final TextEditingController deController = TextEditingController();
  final TextEditingController paraController = TextEditingController();

  // ── Controllers dos campos de leitura do scanner ──────────────────────────
  // Cada campo recebe o código COMPLETO do scanner e extrai o trecho correto.
  final TextEditingController fullCodeDeController = TextEditingController();
  final TextEditingController fullCodeParaController = TextEditingController();

  final FocusNode fullCodeDeFocusNode = FocusNode();
  final FocusNode fullCodeParaFocusNode = FocusNode();
  final FocusNode deFocusNode = FocusNode();
  final FocusNode paraFocusNode = FocusNode();

  bool _updatingDE = false;

  // ── Dropdowns ────────────────────────────────────────────────────────────
  String? selectedLoteEmbarque;
  FormFieldController<String>? loteEmbarqueController;

  String? selectedOperacaoRomaneio;
  FormFieldController<String>? operacaoRomaneioController;

  String? selectedClasseCodigoProd;
  FormFieldController<String>? classeProducaoController;
  FormFieldController<String>? classeRomaneioController;

  int? codClasseSelecionado;
  String? selectedClasseRomaneio;
  int caixasRestantes = 99999999999;
  int? totalCaixas;

  ClienteRomaneioConfig get _cliente => widget.cliente;

  // ── SQLite helpers ────────────────────────────────────────────────────────

  Future<void> carregarTotalCaixas() async {
    final total = await SQLiteManager.instance
        .contarCaixasPorClasse(selectedClasseCodigoProd ?? '');
    setState(() => totalCaixas = total);
  }

  Future<List<String>> _buscarOperacoesCadastradas() async {
    final operacoes = await SQLiteManager.instance.getOperacoesRomaneio();
    return operacoes
        .map((item) =>
            (item['OperacaoRomaneio'] ?? item['operacaoRomaneio'] ?? '')
                .toString()
                .trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  Future<List<Map<String, String>>> _buscarClassesParaRomaneio() async {
    final classesCadastradas =
        await SQLiteManager.instance.getClassesRomaneio();

    if (classesCadastradas.isNotEmpty) {
      return classesCadastradas
          .map((item) => {
                'codigo': (item['CodigoClasse'] ?? item['codigoClasse'] ?? '')
                    .toString(),
                'nome':
                    (item['NomeClasse'] ?? item['nomeClasse'] ?? '').toString(),
              })
          .where(
              (item) => item['codigo']!.isNotEmpty && item['nome']!.isNotEmpty)
          .toList();
    }

    final classesStp = await SQLiteManager.instance.buscarClassesProducaoSTP();
    return classesStp
        .map((item) => {
              'codigo': (item['CodClasseProd'] ?? '').toString(),
              'nome': (item['NomeClasseProd'] ?? '').toString(),
            })
        .where((item) => item['codigo']!.isNotEmpty && item['nome']!.isNotEmpty)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    loteEmbarqueController = FormFieldController<String>(null);
    operacaoRomaneioController = FormFieldController<String>(null);
    classeRomaneioController = FormFieldController<String>(null);
    classeProducaoController = FormFieldController<String>(null);
    carregarTotalCaixas();
  }

  // ── Processa o scanner do código DE (Premium) ─────────────────────────────
  // Regra fixa: substring(7, 12) — não depende do cliente.
  void _onFullBarcodeDeSubmitted(String value) {
    final raw = value.trim();
    if (raw.isEmpty) return;

    if (raw.length < 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Código de barras Premium muito curto (mín. 16).'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    final trechoDe = raw.substring(7, 12);

    setState(() {
      _updatingDE = true;
      deController.text = trechoDe;
      deController.selection = TextSelection.collapsed(offset: trechoDe.length);
      _updatingDE = false;
    });

    // Após ler o DE, move o foco para o scanner do PARA
    FocusScope.of(context).requestFocus(fullCodeParaFocusNode);
  }

  // ── Processa o scanner do código PARA (cliente) ───────────────────────────
  // Regra variável: definida em ClienteRomaneioConfig.extrairCodigoPara
  void _onFullBarcodeParaSubmitted(String value) {
    final raw = value.trim();
    if (raw.isEmpty) return;

    if (raw.length < _cliente.comprimentoMinimo) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '⚠️ Código de barras muito curto para ${_cliente.nome}. '
            'Esperado mínimo ${_cliente.comprimentoMinimo} caracteres.',
          ),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    late final String trechoPara;
    try {
      trechoPara = _cliente.extrairCodigoPara(raw);
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠️ Erro ao extrair código PARA: ${e.message}'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    setState(() {
      paraController.text = trechoPara;
      paraController.selection =
          TextSelection.collapsed(offset: trechoPara.length);
    });

    // Após preencher os dois campos, o foco pode ir para o botão Salvar
    // ou simplesmente ficar no campo PARA para conferência
    FocusScope.of(context).unfocus();
  }

  // ── Limpeza visual ────────────────────────────────────────────────────────

  void _clearVisualDe() {
    setState(() {
      fullCodeDeController.clear();
      deController.clear();
    });
    fullCodeDeFocusNode.requestFocus();
  }

  void _clearVisualPara() {
    setState(() {
      fullCodeParaController.clear();
      paraController.clear();
    });
    fullCodeParaFocusNode.requestFocus();
  }

  void _limparCamposDeCodigo() {
    setState(() {
      _updatingDE = true;
      if (mounted) {
        fullCodeDeController.clear();
        fullCodeParaController.clear();
        deController.clear();
        paraController.clear();
      }
      _updatingDE = false;
    });
    // Volta o foco para o primeiro scanner (DE)
    fullCodeDeFocusNode.requestFocus();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Romaneio — ${_cliente.nome}"),
        centerTitle: false,
        backgroundColor: const Color(0xFF76232F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Lote ──────────────────────────────────────────────────────
            _sectionLabel('Lote:'),
            const SizedBox(height: 16),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: SQLiteManager.instance.buscarLotesEmbarque(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final lotesemb = snapshot.data!;
                final optionsValues = lotesemb
                    .map((l) => (l['CodLoteEmb'] ?? '').toString())
                    .toList();
                final optionsLabels = lotesemb
                    .map((l) => "${l['CodLoteEmb']} - ${l['DescrLote']}")
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlutterFlowDropDown<String>(
                      controller: loteEmbarqueController,
                      options: optionsValues,
                      optionLabels: optionsLabels,
                      value: selectedLoteEmbarque,
                      onChanged: (val) =>
                          setState(() => selectedLoteEmbarque = val),
                      hintText: 'Selecione o Lote cadastrado do STP',
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.0,
                              ),
                      isSearchable: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      borderColor: const Color(0xFF173F35),
                      borderWidth: 1.0,
                      borderRadius: 8.0,
                      elevation: 2.0,
                      margin: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 0.0, 12.0, 0.0),
                      hidesUnderline: true,
                      isOverButton: false,
                      isMultiSelect: false,
                    ),
                    if (selectedLoteEmbarque == null ||
                        selectedLoteEmbarque!.isEmpty)
                      _campoObrigatorio(),
                  ],
                );
              },
            ),

            // ── Operação ──────────────────────────────────────────────────
            const SizedBox(height: 16),
            _sectionLabel('Operação:'),
            const SizedBox(height: 16),
            FutureBuilder<List<String>>(
              future: _buscarOperacoesCadastradas(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final operacoes = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlutterFlowDropDown<String>(
                      controller: operacaoRomaneioController ??=
                          FormFieldController<String>(null),
                      options: operacoes,
                      value: selectedOperacaoRomaneio,
                      onChanged: (val) =>
                          setState(() => selectedOperacaoRomaneio = val),
                      hintText: 'Selecione a operação...',
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.0,
                              ),
                      isSearchable: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      borderColor: const Color(0xFF173F35),
                      borderWidth: 1.0,
                      borderRadius: 8.0,
                      elevation: 2.0,
                      margin: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 0.0, 12.0, 0.0),
                      hidesUnderline: true,
                      isOverButton: false,
                      isMultiSelect: false,
                    ),
                    if (selectedOperacaoRomaneio == null ||
                        selectedOperacaoRomaneio!.isEmpty)
                      _campoObrigatorio(),
                  ],
                );
              },
            ),

            // ── Classe ────────────────────────────────────────────────────
            const SizedBox(height: 16),
            _sectionLabel('Classe:'),
            const SizedBox(height: 16),
            FutureBuilder<List<Map<String, String>>>(
              future: _buscarClassesParaRomaneio(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final classes = snapshot.data!;
                final optionsValues =
                    classes.map((c) => (c['codigo'] ?? '').toString()).toList();
                final optionsLabels = classes
                    .map((c) => "${c['codigo']} - ${c['nome']}")
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlutterFlowDropDown<String>(
                      controller: classeProducaoController,
                      options: optionsValues,
                      optionLabels: optionsLabels,
                      value: selectedClasseCodigoProd,
                      onChanged: (val) {
                        setState(() {
                          selectedClasseCodigoProd = val;
                          final idx = optionsValues.indexOf(val!);
                          final item = classes[idx];
                          codClasseSelecionado =
                              int.tryParse((item['codigo'] ?? '').toString());
                          selectedClasseRomaneio = item['nome'] ?? '';
                          carregarTotalCaixas();
                        });
                      },
                      hintText: 'Selecione a Classe de Produção STP',
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.0,
                              ),
                      isSearchable: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      borderColor: const Color(0xFF173F35),
                      borderWidth: 1.0,
                      borderRadius: 8.0,
                      elevation: 2.0,
                      margin: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 0.0, 12.0, 0.0),
                      hidesUnderline: true,
                      isOverButton: false,
                      isMultiSelect: false,
                    ),
                    if (selectedClasseCodigoProd == null ||
                        selectedClasseCodigoProd!.isEmpty)
                      _campoObrigatorio(),
                  ],
                );
              },
            ),

            // ── Observação ────────────────────────────────────────────────
            const SizedBox(height: 16),
            _sectionLabel('Observação:'),
            const SizedBox(height: 16),
            TextFormField(
              controller: obsController,
              maxLines: 3,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Observação",
                border: OutlineInputBorder(),
              ),
            ),

            // ── Contador de caixas ────────────────────────────────────────
            const SizedBox(height: 16),
            Text(
              selectedClasseCodigoProd == null
                  ? "Selecione uma classe para ver o total"
                  : "Total de caixas na classe código "
                      "$selectedClasseCodigoProd : ${totalCaixas ?? 0}",
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                fontFamily: 'Open Sans',
                color: Color(0xFF173F35),
              ),
            ),

            // ════════════════════════════════════════════════════════════
            // BLOCO DE LEITURA — CÓDIGO DE (Premium)
            // ════════════════════════════════════════════════════════════
            const SizedBox(height: 24),
            _sectionLabel('Leitura Premium (DE):'),
            const SizedBox(height: 8),

            // Scanner Premium — recebe o código completo
            _buildScannerField(
              controller: fullCodeDeController,
              focusNode: fullCodeDeFocusNode,
              label: 'Leia a etiqueta de Produção',
              onSubmitted: _onFullBarcodeDeSubmitted,
              onClear: _clearVisualDe,
            ),

            const SizedBox(height: 12),

            // Campo DE — preenchido automaticamente, somente leitura
            _buildTextField(
              controller: deController,
              label: 'Código DE (Premium)',
              icon: Icons.qr_code_2_rounded,
              focusNode: deFocusNode,
              readOnly: true,
              enableClear: true,
              onClear: () {
                deController.clear();
                fullCodeDeController.clear();
                fullCodeDeFocusNode.requestFocus();
              },
            ),

            // ════════════════════════════════════════════════════════════
            // BLOCO DE LEITURA — CÓDIGO PARA (cliente)
            // ════════════════════════════════════════════════════════════
            const SizedBox(height: 24),
            _sectionLabel('Leitura Cliente (PARA):'),
            const SizedBox(height: 8),

            // Scanner cliente — recebe o código completo e extrai o PARA
            _buildScannerField(
              controller: fullCodeParaController,
              focusNode: fullCodeParaFocusNode,
              label: 'Etiqueta ${_cliente.nome} ',
              onSubmitted: _onFullBarcodeParaSubmitted,
              onClear: _clearVisualPara,
            ),

            const SizedBox(height: 12),

            // Campo PARA — preenchido automaticamente, somente leitura
            _buildTextField(
              controller: paraController,
              label: 'Código PARA (${_cliente.nome})',
              icon: Icons.qr_code_2_rounded,
              focusNode: paraFocusNode,
              readOnly: true,
              enableClear: true,
              onClear: () {
                paraController.clear();
                fullCodeParaController.clear();
                fullCodeParaFocusNode.requestFocus();
              },
            ),

            // ── Botões ────────────────────────────────────────────────────
            const SizedBox(height: 24),
            Center(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: _salvar,
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
                      elevation: 10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 40),
                  FFButtonWidget(
                    onPressed: _voltarParaHome,
                    text: 'Inicio',
                    icon: const Icon(Icons.home_filled, size: 20.0),
                    options: FFButtonOptions(
                      width: 110.0,
                      height: 40.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFF173F35),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Lógica de salvar ──────────────────────────────────────────────────────

  Future<void> _salvar() async {
    if (selectedLoteEmbarque == null ||
        selectedOperacaoRomaneio == null ||
        selectedClasseCodigoProd == null ||
        deController.text.isEmpty ||
        paraController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Preencha todos os campos obrigatórios"),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    if (caixasRestantes <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Limite de caixas atingido!"),
          backgroundColor: Colors.deepOrangeAccent,
        ),
      );
      return;
    }

    final existe = await SQLiteManager.instance.existeCaixaRegistradaRomaneio(
      coddeController: deController,
      codparaController: paraController,
      classeSelecionada: selectedClasseCodigoProd,
    );

    if (existe) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              '⚠️ As caixas DE e PARA já foram lidas na Classe selecionada.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    await SQLiteManager.instance.insertRomaneioALTRIA(
      codde: int.tryParse(deController.text),
      codpara: int.tryParse(paraController.text),
      lote: selectedLoteEmbarque!,
      operacao: selectedOperacaoRomaneio!,
      classe: selectedClasseCodigoProd!,
      observacao: obsController.text,
      data: DateTime.now(),
      CodBarras: int.tryParse(fullCodeDeController.text),
    );

    final totalSalvas = await SQLiteManager.instance
        .contarCaixasPorClasse(selectedClasseCodigoProd!);
    setState(() => totalCaixas = totalSalvas);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ Dados gravados e enviados com sucesso!"),
        backgroundColor: Color(0xFF173F35),
      ),
    );

    try {
      await AdicionarRomaneioConvercaoCall.call(
        caixaDE: int.parse(deController.text),
        caixaPARA: int.parse(paraController.text),
        lote: selectedLoteEmbarque!,
        nomeClasse: selectedClasseRomaneio!,
        codClasse: codClasseSelecionado!,
        qtdeCaixaClasse: 1,
        operacao: selectedOperacaoRomaneio!,
        observacao: obsController.text,
        data: DateTime.now(),
        codBarras: int.parse(fullCodeDeController.text),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("⚠️ Falha ao enviar para o servidor: $e"),
          backgroundColor: Colors.orangeAccent,
        ),
      );
    }

    _limparCamposDeCodigo();
    carregarTotalCaixas();
  }

  // ── Navegar para home ─────────────────────────────────────────────────────

  Future<void> _voltarParaHome() async {
    final confirmDialogResponse = await showDialog<bool>(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              backgroundColor: const Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Text(
                'Você quer voltar?',
                style: TextStyle(
                    color: Color(0xFF173F35), fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'O que foi lido será perdido, quer continuar?',
                style: TextStyle(color: Color(0xFF173F35)),
              ),
              actions: [
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF76232F)),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                  ),
                  onPressed: () => Navigator.pop(alertDialogContext, false),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF173F35)),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                  ),
                  onPressed: () => Navigator.pop(alertDialogContext, true),
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!confirmDialogResponse) return;
    context.goNamed('HomePageTags');
  }

  // ── Helpers de UI ─────────────────────────────────────────────────────────

  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.bold,
          color: Color(0xFF173F35),
        ),
      );

  Widget _campoObrigatorio() => const Padding(
        padding: EdgeInsets.only(left: 16.0, top: 4.0),
        child: Text('Campo obrigatório',
            style: TextStyle(color: Colors.red, fontSize: 12)),
      );

  /// Campo que recebe o código completo do scanner.
  /// Ao pressionar Enter (onFieldSubmitted), chama [onSubmitted].
  Widget _buildScannerField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required void Function(String) onSubmitted,
    required void Function() onClear,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final hasText = value.text.isNotEmpty;
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          onFieldSubmitted: onSubmitted,
          cursorColor: const Color(0xFF173F35),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Color(0xFF173F35)),
            prefixIcon:
                const Icon(Icons.qr_code_scanner, color: Color(0xFF173F35)),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF173F35), width: 2.0),
            ),
            suffixIcon: hasText
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Color(0xFF173F35)),
                    tooltip: 'Limpar leitura',
                    onPressed: onClear,
                  )
                : null,
          ),
        );
      },
    );
  }

  /// Campo de resultado — somente leitura, preenchido automaticamente.
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    FocusNode? focusNode,
    bool enableClear = true,
    bool readOnly = false,
    void Function()? onClear,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final hasText = value.text.isNotEmpty;
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly,
          cursorColor: const Color(0xFF173F35),
          autovalidateMode: AutovalidateMode.always,
          validator: (text) =>
              (text == null || text.isEmpty) ? 'Campo Obrigatório!' : null,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Color(0xFF173F35)),
            prefixIcon: Icon(icon, color: const Color(0xFF173F35)),
            suffixIcon: enableClear && hasText
                ? IconButton(
                    tooltip: 'Limpar',
                    icon: const Icon(Icons.close),
                    color: const Color(0xFF173F35),
                    onPressed: onClear ?? () => controller.clear(),
                  )
                : null,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF173F35), width: 2.0),
            ),
          ),
        );
      },
    );
  }
}
