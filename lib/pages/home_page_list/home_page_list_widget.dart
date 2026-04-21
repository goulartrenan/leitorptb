//import 'package:leitorptb/pages/cadastro_romaneio/cadastro_romaneio.dart';
import 'package:leitorptb/pages/select_menus_romaneio/romaneio_menu_altria.dart';
//import 'package:leitorptb/pages/select_menus_romaneio/romaneio_menu_bat.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
//import '/index.dart';
import 'package:flutter/material.dart';
//import 'package:leitorptb/pages/home_page/home_page_new_widget.dart';

class HomePageRomaneioWidget extends StatefulWidget {
  const HomePageRomaneioWidget({super.key});

  static String routeName = 'HomePageList';
  static String routePath = '/homePageList';

  @override
  State<HomePageRomaneioWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageRomaneioWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
              "Romaneio de Conversão",
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
                                        RomaneioMenusALTRIAWidget.routeName);
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Flexible(
                  //   child: Align(
                  //     alignment: AlignmentDirectional(0.0, 1.0),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(24.0),
                  //       child: Row(
                  //         mainAxisSize: MainAxisSize.max,
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Flexible(
                  //             child: Padding(
                  //               padding: EdgeInsetsDirectional.fromSTEB(
                  //                   0.0, 0.0, 20.0, 0.0),
                  //               child: FFButtonWidget(
                  //                 onPressed: () async {
                  //                   context.pushNamed(
                  //                       RomaneioMenusBATWidget.routeName);
                  //                 },
                  //                 text: 'BAT',
                  //                 options: FFButtonOptions(
                  //                   width: 100.0,
                  //                   height: 100.0,
                  //                   padding: EdgeInsetsDirectional.fromSTEB(
                  //                       16.0, 0.0, 16.0, 0.0),
                  //                   iconPadding: EdgeInsetsDirectional.fromSTEB(
                  //                       0.0, 0.0, 0.0, 0.0),
                  //                   color: Color(0xFF173F35),
                  //                   textStyle: FlutterFlowTheme.of(context)
                  //                       .titleSmall
                  //                       .override(
                  //                         fontFamily: 'Open Sans',
                  //                         color: Colors.white,
                  //                         letterSpacing: 0.0,
                  //                         fontWeight: FontWeight.bold,
                  //                         shadows: [
                  //                           Shadow(
                  //                             color:
                  //                                 FlutterFlowTheme.of(context)
                  //                                     .secondaryText,
                  //                             offset: Offset(2.0, 2.0),
                  //                             blurRadius: 4.0,
                  //                           )
                  //                         ],
                  //                         lineHeight: 0.0,
                  //                       ),
                  //                   elevation: 20.0,
                  //                   borderRadius: BorderRadius.circular(8.0),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           //
                  //         ],
                  //       ),
                  //     ),
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
