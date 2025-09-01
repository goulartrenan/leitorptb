import '';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
//import 'package:package_info_plus/package_info_plus.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePageTags';
  static String routePath = '/homePageTags';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  //String _version = '';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.instantTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 1000),
        callback: (timer) async {
          _model.horas = getCurrentTimestamp;
          safeSetState(() {});
        },
        startImmediately: true,
      );
    });
    // _loadAppVersion(); // <- Chamada para buscar a versão
  }

  // Future<void> _loadAppVersion() async {
  //   final info = await PackageInfo.fromPlatform();
  //   setState(() {
  //     _version = 'Versão ${info.version}';
  //   });
  // }

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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Color(0xFF76232F),
            automaticallyImplyLeading: true,
            title: const Text(
              "Leitor de Etiquetas",
              style: TextStyle(fontFamily: 'Open Sans', fontSize: 22),
            ),
            actions: [],
            centerTitle: false,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        // child: Image.asset(
                        //   'assets/images/logo_horizontal_colorido.png',
                        //   width: 330.0,
                        //   height: 81.39,
                        //   fit: BoxFit.fitHeight,
                        // ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 25.0),
                                child: Text(
                                  'Selecione o cliente:',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 20.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                        SelecaoMenusALTRIAWidget.routeName);
                                  },
                                  text: 'Altria',
                                  options: FFButtonOptions(
                                    width: 100.0,
                                    height: 100.0,
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
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 4.0,
                                            )
                                          ],
                                          lineHeight: 0.0,
                                        ),
                                    elevation: 20.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                        SelecaoMenusJMCWidget.routeName);
                                  },
                                  text: 'JMC',
                                  options: FFButtonOptions(
                                    width: 100.0,
                                    height: 100.0,
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
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 4.0,
                                        )
                                      ],
                                    ),
                                    elevation: 20.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Padding(
                  //     padding:
                  //         EdgeInsetsDirectional.fromSTEB(0.0, 110.0, 0.0, 0.0),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           dateTimeFormat(
                  //             "dd/MM/y",
                  //             _model.horas,
                  //             locale: FFLocalizations.of(context).languageCode,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //           style: FlutterFlowTheme.of(context)
                  //               .bodyMedium
                  //               .override(
                  //                 fontFamily: 'Open Sans',
                  //                 color: Color(0xFF76232F),
                  //                 fontSize: 20.0,
                  //                 fontWeight: FontWeight.w800,
                  //               ),
                  //         ),
                  //         SizedBox(height: 8),
                  //         Text(
                  //           _version, // <- Aqui exibe a versão
                  //           style:
                  //               FlutterFlowTheme.of(context).bodySmall.override(
                  //                     fontFamily: 'Open Sans',
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Color(0xFF173F35),
                  //                   ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,),
                  // Text(
                  //   'Versão de Homologação!',
                  //   style: TextStyle(
                  //     color: Colors.white, // cor da fonte
                  //     fontFamily: 'Open Sans',
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //     backgroundColor:
                  //         Color(0xFF173F35), // cor de "marca-texto"
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
