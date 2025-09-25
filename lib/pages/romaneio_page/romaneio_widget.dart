// import 'dart:ffi';

//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:leitorptb/backend/api_requests/api_calls.dart';
import 'package:leitorptb/backend/sqlite/sqlite_manager.dart';
import 'package:leitorptb/flutter_flow/flutter_flow_drop_down.dart';
import 'package:leitorptb/flutter_flow/flutter_flow_theme.dart';
import 'package:leitorptb/flutter_flow/flutter_flow_widgets.dart';
import 'package:leitorptb/flutter_flow/form_field_controller.dart';
import 'package:leitorptb/flutter_flow/nav/nav.dart';
import 'package:leitorptb/pages/home_page_tags/home_page_widget.dart';
//import 'package:leitorptb/pages/romaneio_page/lote_embarque_stp.dart';
export 'romaneio_widget.dart';

class RomaneioWidget extends StatefulWidget {
  const RomaneioWidget({super.key});

  static String routeName = 'RomaneioPage';
  static String routePath = '/romaneioPage';

  @override
  State<RomaneioWidget> createState() => _RomaneioWidgetState();
}

class _RomaneioWidgetState extends State<RomaneioWidget> {
  final TextEditingController obsController = TextEditingController();
  final qtdCaixaController = TextEditingController();
  final TextEditingController deController = TextEditingController();
  final TextEditingController paraController = TextEditingController();
  final TextEditingController fullCodeController = TextEditingController();
  final FocusNode fullCodeFocusNode = FocusNode();
  bool _updatingDE =
      false; // evita loop ao mudar deController programaticamente

  final deFocusNode = FocusNode();
  final paraFocusNode = FocusNode();

  String? selectedLoteRomaneio;
  FormFieldController<String>? loteRomaneioController;

  String? selectedLoteEmbarque;
  FormFieldController<String>? loteEmbarqueController;

  String? selectedOperacaoRomaneio;
  FormFieldController<String>? operacaoRomaneioController;

  String? selectedClasseRomaneio;
  FormFieldController<String>? classeRomaneioController;

  String? selectedClasseCodigoProd;
  FormFieldController<String>? classeProducaoController;

  int? codClasseSelecionado;
  String? selectedLote;

  String? selectedOperacao;
  Map<String, dynamic>? selectedClasse;
  int caixasRestantes = 99999999999;

  int? totalCaixas;

  Future<void> carregarTotalCaixas() async {
    final total = await SQLiteManager.instance
        .contarCaixasPorClasse(selectedClasseCodigoProd ?? '');

    setState(() {
      totalCaixas = total;
    });
  }

  @override
  void initState() {
    super.initState();

    loteRomaneioController = FormFieldController<String>(null);
    loteEmbarqueController = FormFieldController<String>(null);
    operacaoRomaneioController = FormFieldController<String>(null);
    classeRomaneioController = FormFieldController<String>(null);
    classeProducaoController = FormFieldController<String>(null);

    carregarTotalCaixas();

    //_sincronizarLotesComSQLite();
  }

  // Future<void> _sincronizarLotesComSQLite() async {
  //   try {
  //     final response = await BuscarLotesEmbarqueCall.call();

  //     debugPrint('succeeded: ${response.succeeded}');
  //     debugPrint('jsonBody runtimeType: ${response.jsonBody.runtimeType}');

  //     if (!response.succeeded) return;

  //     final body = response.jsonBody;
  //     late final List<dynamic> items;

  //     if (body is List) {
  //       items = body;
  //     } else if (body is Map && body['data'] is List) {
  //       items = body['data'] as List;
  //     } else if (body is String) {
  //       final decoded = jsonDecode(body);
  //       if (decoded is List) {
  //         items = decoded;
  //       } else if (decoded is Map && decoded['data'] is List) {
  //         items = decoded['data'] as List;
  //       } else {
  //         throw Exception('JSON inesperado (string): ${decoded.runtimeType}');
  //       }
  //     } else {
  //       throw Exception('jsonBody inesperado: ${body.runtimeType}');
  //     }

  //     final lotes = items
  //         .map((e) => LoteEmbarqueSTP.fromJson(e as Map<String, dynamic>))
  //         .toList();

  //     //for (final lote in lotes) {
  //     await SQLiteManager.instance.inserirLoteEmbarque(
  //       lotes,
  //     );
  //     //}

  //     setState(() {});
  //   } catch (e, st) {
  //     debugPrint('ERRO em _sincronizarLotesComSQLite: $e');
  //     debugPrint('$st');
  //   }
  // }

  // Quando o scanner enviar Enter (\n) neste campo, processamos
  void _onFullBarcodeSubmitted(String value) {
    final raw = value.trim(); // remove \n e espaços
    if (raw.isEmpty) return;

    // Mantive sua regra original: só processa com >=16 para segurança
    if (raw.length < 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Código de barras muito curto.'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    // Extrai o número da caixa para o "CAIXA DE"
    // (sua regra original: substring(3, 10))
    final trecho = raw.substring(3, 10);

    setState(() {
      _updatingDE = true;
      deController.text = trecho;
      deController.selection = TextSelection.collapsed(offset: trecho.length);
      _updatingDE = false;
    });

    // Seguir o fluxo para o campo PARA
    FocusScope.of(context).requestFocus(paraFocusNode);
  }

// Limpeza somente visual (não mexe no banco)
  void _clearVisualOnly() {
    setState(() {
      fullCodeController.clear();
      deController.clear();
    });
    // Re-foca para a próxima leitura
    fullCodeFocusNode.requestFocus();
  }

  void _limparCamposDeCodigo() {
    setState(() {
      _updatingDE = true;
      // Limpeza somente visual
      if (mounted) {
        fullCodeController.clear();
        deController.clear();
        paraController.clear();
      }
      _updatingDE = false;
    });

    fullCodeFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Romaneio de Conversão"),
        centerTitle: true,
        backgroundColor: const Color(0xFF76232F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown de Lote
            // FutureBuilder<List<BuscaLoteRomenioAltria>>(
            //   future: SQLiteManager.instance.buscaLoteRomenioAltria(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) return const CircularProgressIndicator();
            //     final lotes = snapshot.data!;
            //     return FlutterFlowDropDown<String>(
            //       controller: loteRomaneioController,
            //       options: lotes.map((l) => l.loteRomaneio.toString()).toList(),
            //       onChanged: (val) {
            //         setState(() => selectedLoteRomaneio = val);
            //       },
            //       value: selectedLoteRomaneio,
            //       hintText: 'Selecione o Lote cadastro local',
            //       textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            //             fontFamily: 'Open Sans',
            //             letterSpacing: 0.0,
            //           ),
            //       isSearchable: true,
            //       fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            //       borderColor: const Color(0xFF173F35),
            //       borderWidth: 1.0,
            //       borderRadius: 8.0,
            //       elevation: 2.0,
            //       margin: const EdgeInsetsDirectional.fromSTEB(
            //           12.0, 0.0, 12.0, 0.0),
            //       hidesUnderline: true,
            //       isOverButton: false,
            //       isMultiSelect: false,
            //     );
            //   },
            // ),

            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: _sincronizarLotesComSQLite,
            //   child: Text('Atualizar Lotes'),
            // ),
            const Text(
              'Lote:',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173F35)),
            ),

            const SizedBox(
              height: 16,
            ),

            // FutureBuilder<List<Map<String, dynamic>>>(
            //   future: SQLiteManager.instance.buscarLotesEmbarque(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) return const CircularProgressIndicator();
            //     final lotesemb = snapshot.data!;

            //     final optionsValues = lotesemb
            //         .map((l) => (l['CodLoteEmb'] ?? '').toString())
            //         .toList();

            //     // Texto exibido na UI
            //     final optionsLabels = lotesemb
            //         .map((l) => "${l['CodLoteEmb']} - ${l['DescrLote']}")
            //         .toList();

            //     return FlutterFlowDropDown<String>(
            //       controller: loteEmbarqueController,
            //       options: optionsValues,
            //       optionLabels: optionsLabels,
            //       value: selectedLoteEmbarque,
            //       onChanged: (val) {
            //         setState(() {
            //           selectedLoteEmbarque = val; // código do lote
            //         });
            //       },
            //       hintText: 'Selecione o Lote cadastrado do STP',
            //       textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            //             fontFamily: 'Open Sans',
            //             letterSpacing: 0.0,
            //           ),
            //       isSearchable: true,
            //       fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            //       borderColor: const Color(0xFF173F35),

            //       borderWidth: 1.0,
            //       borderRadius: 8.0,
            //       elevation: 2.0,
            //       margin: const EdgeInsetsDirectional.fromSTEB(
            //           12.0, 0.0, 12.0, 0.0),
            //       hidesUnderline: true,
            //       isOverButton: false,
            //       isMultiSelect: false,
            //     );
            //   },
            // ),

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
                      onChanged: (val) {
                        setState(() {
                          selectedLoteEmbarque = val;
                        });
                      },
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
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 4.0),
                        child: Text(
                          'Campo obrigatório',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 16),
            const Text(
              'Operação:',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173F35)),
            ),

            const SizedBox(
              height: 16,
            ),

            // Dropdown de Operação
            FutureBuilder<List<BuscaOperacaoRomenioAltria>>(
              future: SQLiteManager.instance.buscaOperacaoRomenioAltria(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final operacao = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlutterFlowDropDown<String>(
                      controller: operacaoRomaneioController ??=
                          FormFieldController<String>(null),
                      options: operacao
                          .map((l) => l.operacaoRomaneio.toString())
                          .toList(),
                      value: selectedOperacaoRomaneio,
                      onChanged: (val) {
                        setState(() {
                          selectedOperacaoRomaneio = val;
                        });
                      },
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
                    if ((selectedOperacaoRomaneio == null ||
                        selectedOperacaoRomaneio!.isEmpty))
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 4.0),
                        child: Text(
                          'Campo obrigatório',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 16),

            const Text(
              'Classe:',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173F35)),
            ),

            const SizedBox(
              height: 16,
            ),
            // Dropdown de Classe
            // FutureBuilder<List<BuscaClasseRomenioAltria>>(
            //   future: SQLiteManager.instance.buscaClasseRomenioAltria(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) return const CircularProgressIndicator();
            //     final classe = snapshot.data!;

            //     // Listas paralelas: valores (ids) e labels (nomes)
            //     final optionsValues = classe
            //         .map((l) => (l.codigoClasse ?? 0).toString())
            //         .toList();
            //     final optionsLabels =
            //         classe.map((l) => l.nomeClasse?.toString() ?? '').toList();

            //     return FlutterFlowDropDown<String>(
            //       searchCursorColor: const Color(0xFF173F35),
            //       controller: classeRomaneioController ??=
            //           FormFieldController<String>(null),
            //       options: optionsValues, // ✅ valor = CÓDIGO (string)
            //       optionLabels: optionsLabels, // ✅ label = NOME
            //       onChanged: (val) {
            //         setState(() {
            //           // Guarda o valor selecionado (código, em string)
            //           selectedClasseRomaneio = val;

            //           // Converte p/ int e guarda no estado
            //           codClasseSelecionado = int.tryParse(val!);

            //           // Recupera o item completo pelo código
            //           final idx = optionsValues.indexOf(val);
            //           final classeSelecionada = classe[idx];

            //           // Atualizações existentes
            //           obsController.text = classeSelecionada.observacao ?? '';
            //           qtdCaixaController.text =
            //               (classeSelecionada.qtdeCaixa ?? 0).toString();
            //           caixasRestantes = classeSelecionada.qtdeCaixa ?? 0;
            //         });
            //       },
            //       value: selectedClasseRomaneio, // aqui fica o código (string)
            //       hintText: 'Selecione a classe',
            //       textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            //             fontFamily: 'Open Sans',
            //             letterSpacing: 0.0,
            //           ),
            //       isSearchable: true,
            //       fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            //       borderColor: const Color(0xFF173F35),
            //       borderWidth: 1.0,
            //       borderRadius: 8.0,
            //       elevation: 2.0,
            //       margin: const EdgeInsetsDirectional.fromSTEB(
            //           12.0, 0.0, 12.0, 0.0),
            //       hidesUnderline: true,
            //       isOverButton: false,
            //       isMultiSelect: false,
            //     );
            //   },
            // ),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: SQLiteManager.instance.buscarClassesProducaoSTP(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final classes = snapshot.data!;

                final optionsValues = classes
                    .map((c) => (c['CodClasseProd'] ?? '').toString())
                    .toList();

                final optionsLabels = classes
                    .map(
                        (c) => "${c['CodClasseProd']} - ${c['NomeClasseProd']}")
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
                              int.tryParse(item['CodClasseProd'].toString());
                          selectedClasseRomaneio =
                              (item['NomeClasseProd'] ?? '').toString();
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
                    if ((selectedClasseCodigoProd == null ||
                        selectedClasseCodigoProd!.isEmpty))
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 4.0),
                        child: Text(
                          'Campo obrigatório',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 16),

            const Text(
              'Observação:',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173F35)),
            ),
            const SizedBox(height: 16),
            // Campo observação
            TextFormField(
              controller: obsController,
              maxLines: 3,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Observação",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Contador de caixas restantes
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedClasseCodigoProd == null
                      ? "Selecione uma classe para ver o total"
                      : "Total de caixas na classe código $selectedClasseCodigoProd : ${totalCaixas ?? 0}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    fontFamily: 'Open Sans',
                    color: Color(0xFF173F35),
                  ),
                ),

                // Text(
                //   "Total de caixas na classe cod $selectedClasseCodigoProd : ${totalCaixas}",
                //   style: const TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontFamily: 'Open Sans',
                //     color: Color(0xFF173F35),
                //   ),
                // ),
                //const SizedBox(height: 8),
                // Text(
                //   "Caixas salvas: $totalCaixas",
                //   style: const TextStyle(
                //     fontFamily: 'Open Sans',
                //     fontWeight: FontWeight.bold,
                //     color: Color(0xFF173F35),
                //   ),
                // ),
              ],
            ),

            const SizedBox(height: 16),

            // Código de barras completo (o scanner digita aqui)
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: fullCodeController,
              builder: (context, value, child) {
                final hasText = value.text.isNotEmpty;

                return TextFormField(
                  controller: fullCodeController,
                  focusNode: fullCodeFocusNode,
                  onFieldSubmitted: _onFullBarcodeSubmitted,
                  cursorColor: const Color(0xFF173F35),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Campo Obrigátorio!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Código de Barras (completo)',
                    labelStyle: const TextStyle(color: Color(0xFF173F35)),
                    prefixIcon: const Icon(Icons.qr_code_scanner,
                        color: Color(0xFF173F35)),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF173F35), width: 2.0),
                    ),
                    suffixIcon: hasText
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Color(0xFF173F35),
                            ),
                            tooltip: 'Limpar leitura (somente visual)',
                            onPressed: _clearVisualOnly,
                          )
                        : null,
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            const SizedBox(height: 16),

            // Código DE
            _buildTextField(
              controller: deController,
              label: "Código DE (Premium)",
              icon: Icons.qr_code_2_rounded,
              focusNode: deFocusNode,
              onFieldSubmitted: (p0) {
                FocusScope.of(context).requestFocus(paraFocusNode);
              },
              onChanged: (value) {
                if (_updatingDE) return;
              },
              readOnly: true,
              enableClear: true,
            ),

            const SizedBox(height: 16),

            _buildTextField(
              controller: paraController,
              label: "Código PARA (Cliente)",
              icon: Icons.qr_code_2_rounded,
              focusNode: paraFocusNode,
              onChanged: (value) {
                final partes = value.split('-');
                if (partes.length >= 2) {
                  paraController.text = partes[1];
                }
              },
              enableClear: true,
            ),

            const SizedBox(height: 24),
            Center(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      if (selectedLoteEmbarque == null ||
                          selectedOperacaoRomaneio == null ||
                          selectedClasseCodigoProd == null ||
                          deController.text.isEmpty ||
                          paraController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "⚠️ Preencha todos os campos obrigatórios"),
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

                      // ✅ Salvar no banco
                      await SQLiteManager.instance.insertRomaneioALTRIA(
                        codde: int.tryParse(deController.text),
                        codpara: int.tryParse(paraController.text),
                        lote: selectedLoteEmbarque!,
                        operacao: selectedOperacaoRomaneio!,
                        classe: selectedClasseCodigoProd!,
                        observacao: obsController.text,
                        data: DateTime.now(),
                        CodBarras: int.tryParse(fullCodeController.text),
                      );

                      // ✅ Atualizar contador de caixas salvas
                      final totalSalvas = await SQLiteManager.instance
                          .contarCaixasPorClasse(selectedClasseCodigoProd!);
                      setState(() {
                        //caixasRestantes--;
                        totalCaixas = totalSalvas;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("✅ Dados gravados e enviados com sucesso!"),
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
                          qtdeCaixaClasse: 1, // fixo conforme sua observação
                          operacao: selectedOperacaoRomaneio!,
                          observacao: obsController.text,
                          data: DateTime.now(),
                          codBarras: int.parse(fullCodeController.text),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("⚠️ Falha ao enviar para o servidor: $e"),
                            backgroundColor: Colors.orangeAccent,
                          ),
                        );
                      }

                      _limparCamposDeCodigo();
                      carregarTotalCaixas();
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
                      elevation: 10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      final confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                backgroundColor: const Color(0xFFF5F5F5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: const Text(
                                  'Você quer voltar?',
                                  style: TextStyle(
                                    color: Color(0xFF173F35),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: const Text(
                                  'O que foi lido será perdido, quer continuar?',
                                  style: TextStyle(
                                    color: Color(0xFF173F35),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Color(0xFF76232F)),
                                      foregroundColor:
                                          WidgetStatePropertyAll(Colors.white),
                                      padding: WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Color(0xFF173F35)),
                                      foregroundColor:
                                          WidgetStatePropertyAll(Colors.white),
                                      padding: WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                      ),
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: const Text('Confirmar'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;

                      if (!confirmDialogResponse) return;

                      // go_router (FlutterFlow): navega para a Home limpando a rota atual
                      context.goNamed(HomePageWidget.routeName);
                    },
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
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                              fontFamily: 'Open Sans',
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold),
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    FocusNode? focusNode,
    void Function(String)? onFieldSubmitted,
    void Function(String)? onChanged,
    bool enableClear = true,
    bool readOnly = false,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final hasText = value.text.isNotEmpty;

        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          readOnly: readOnly,
          cursorColor: const Color(0xFF173F35),
          autovalidateMode: AutovalidateMode.always,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Campo Obrigátorio!';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: Color(0xFF173F35),
            ),
            prefixIcon: Icon(icon, color: const Color(0xFF173F35)),
            suffixIcon: enableClear && hasText
                ? IconButton(
                    tooltip: 'Limpar',
                    icon: const Icon(Icons.close),
                    color: const Color(0xFF173F35),
                    onPressed: () {
                      controller.clear();
                      Future.microtask(() {
                        if (focusNode?.canRequestFocus ?? false) {
                          focusNode!.requestFocus();
                        }
                      });
                      onChanged?.call('');
                    },
                  )
                : null,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF173F35),
                width: 2.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
