import 'dart:async';

import 'package:leitorptb/backend/api_requests/api_calls.dart';
import 'package:leitorptb/backend/sqlite/sqlite_manager.dart';
import 'package:leitorptb/pages/cadastro_romaneio/cadastro_romaneio.dart';
import 'package:leitorptb/pages/romaneio_page/classe_producao_stp.dart';
import 'package:leitorptb/pages/romaneio_page/lote_embarque_stp.dart';
import 'package:leitorptb/pages/romaneio_page/romaneio_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';

class RomaneioMenusALTRIAWidget extends StatefulWidget {
  const RomaneioMenusALTRIAWidget({super.key});

  static String routeName = 'RomaneioMenusALTRIAWidget';
  static String routePath = '/romaneioMenusALTRIAWidget';

  @override
  _RomaneioMenusALTRIAWidgetState createState() =>
      _RomaneioMenusALTRIAWidgetState();
}

class _RomaneioMenusALTRIAWidgetState extends State<RomaneioMenusALTRIAWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _sincronizarLotesComSQLite();
    _sincronizarClassesComSQLite();
  }

  Future<void> _sincronizarLotesComSQLite() async {
    try {
      final response = await BuscarLotesEmbarqueCall.call();

      debugPrint('succeeded: ${response.succeeded}');
      debugPrint('jsonBody runtimeType: ${response.jsonBody.runtimeType}');

      if (!response.succeeded) return;

      final body = response.jsonBody;
      late final List<dynamic> items;

      if (body is List) {
        items = body;
      } else if (body is Map && body['data'] is List) {
        items = body['data'] as List;
      } else if (body is String) {
        final decoded = jsonDecode(body);
        if (decoded is List) {
          items = decoded;
        } else if (decoded is Map && decoded['data'] is List) {
          items = decoded['data'] as List;
        } else {
          throw Exception('JSON inesperado (string): ${decoded.runtimeType}');
        }
      } else {
        throw Exception('jsonBody inesperado: ${body.runtimeType}');
      }

      final lotes = items
          .map((e) => LoteEmbarqueSTP.fromJson(e as Map<String, dynamic>))
          .toList();

      //for (final lote in lotes) {
      await SQLiteManager.instance.inserirLoteEmbarque(
        lotes,
      );
      //}

      setState(() {});
    } catch (e, st) {
      debugPrint('ERRO em _sincronizarLotesComSQLite: $e');
      debugPrint('$st');
    }
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Color(0xFF76232F),
            automaticallyImplyLeading: true,
            title: Text(
              'Menus ALTRIA',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Open Sans',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'Clique no que deseja fazer:',
                                textAlign: TextAlign.center,
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
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: FFButtonWidget(
                              onPressed: () async {
                                context
                                    .pushNamed(CadastroRomaneioPage.routeName);
                              },
                              text: 'Cadastro',
                              icon: Icon(
                                Icons.edit,
                                size: 20.0,
                              ),
                              options: FFButtonOptions(
                                width: 120.0,
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF173F35),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  fontFamily: 'Open Sans',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  shadows: [
                                    Shadow(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 4.0,
                                    )
                                  ],
                                ),
                                elevation: 10.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          Flexible(
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed(RomaneioWidget.routeName);
                              },
                              text: 'Romaneio',
                              icon: Icon(
                                Icons.list,
                                size: 20.0,
                              ),
                              options: FFButtonOptions(
                                width: 120.0,
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF173F35),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  fontFamily: 'Open Sans',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  shadows: [
                                    Shadow(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 4.0,
                                    )
                                  ],
                                ),
                                elevation: 10.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed(HomePageWidget.routeName);
                              },
                              text: 'Inicio',
                              icon: Icon(
                                Icons.home_filled,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                width: 100.0,
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
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
                                  shadows: [
                                    Shadow(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 4.0,
                                    )
                                  ],
                                ),
                                elevation: 10.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),

                          // ElevatedButton(
                          //   onPressed: _sincronizarLotesComSQLite,
                          //   child: Text('Atualizar Lotes'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: FFButtonWidget(
                    onPressed: _sincronizarLotesComSQLite,
                    text: ('Atualizar Lotes'),
                    icon: Icon(
                      Icons.replay_outlined,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      width: 180.0,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFF76232F),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Open Sans',
                        color: Colors.white,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        shadows: [
                          Shadow(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0,
                          )
                        ],
                      ),
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: FFButtonWidget(
                    onPressed: _sincronizarClassesComSQLite,
                    text: ('Atualizar Classes'),
                    icon: Icon(
                      Icons.replay_outlined,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      width: 180.0,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFF76232F),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Open Sans',
                        color: Colors.white,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        shadows: [
                          Shadow(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0,
                          )
                        ],
                      ),
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
