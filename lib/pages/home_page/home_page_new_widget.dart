import 'package:flutter/material.dart';
import 'package:leitorptb/pages/home_page_list/home_page_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:leitorptb/pages/home_page_tags/home_page_widget.dart';
import 'package:flutter/scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/flutter_flow/instant_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
//import 'package:leitorptb/pages/cadastro_romaneio/cadastro_romaneio.dart';
// import 'package:leitorptb/pages/romaneio_page/romaneio_widget.dart';

class HomePageNewWidget extends StatefulWidget {
  const HomePageNewWidget({super.key});

  @override
  State<HomePageNewWidget> createState() => _HomePageNewWidgetState();
}

class _HomePageNewWidgetState extends State<HomePageNewWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _version = '';

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
    _loadAppVersion(); // <- Chamada para buscar a versão
  }

  Future<void> _loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = 'Versão ${info.version}';
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu Principal",
          style: FlutterFlowTheme.of(context).headlineLarge.override(
              fontFamily: 'Open Sans',
              fontSize: 22.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF76232F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo entre a AppBar e os botões
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'assets/images/logo_horizontal_colorido.png',
                height: 100, // ajusta o tamanho conforme necessário
              ),
            ),
            SizedBox(height: 22),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    title: "Leitura de Etiquetas",
                    icon: Icons.qr_code_scanner,
                    color: const Color(0xFF173F35),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomePageWidget(), // chama direto
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: "Romaneio de Conversão",
                    icon: Icons.assignment,
                    color: const Color(0xFF173F35),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePageRomaneioWidget(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dateTimeFormat(
                      "dd/MM/y",
                      _model.horas,
                      locale: FFLocalizations.of(context).languageCode,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF76232F),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _version,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Open Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF173F35),
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

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        shadowColor: color.withValues(alpha: 0.4),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF173F35), Color(0xFF173F35)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 60, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
