import 'package:flutter/material.dart';
import '/backend/sqlite/sqlite_manager.dart';
import 'package:leitorptb/pages/cadastro_romaneio/classe_romaneio.dart';
import 'package:leitorptb/pages/romaneio_page/romaneio_widget.dart';
import 'package:leitorptb/flutter_flow/flutter_flow_theme.dart';

class CadastroRomaneioPage extends StatefulWidget {
  const CadastroRomaneioPage({super.key});

  @override
  State<CadastroRomaneioPage> createState() => _CadastroRomaneioPageState();

  static String routeName = 'CadastroRomaneioPage';
  static String routePath = '/cadastroromaneioPage';
}

class _CadastroRomaneioPageState extends State<CadastroRomaneioPage> {
  final TextEditingController loteController = TextEditingController();
  final TextEditingController operacaoController = TextEditingController();

  Future<void> _salvarLote() async {
    if (loteController.text.isNotEmpty) {
      await SQLiteManager.instance.insertLoteRomaneio(loteController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Lote salvo com sucesso!'),
          backgroundColor: Color(0xFF173F35),
        ),
      );
      loteController.clear();
    }
  }

  Future<void> _salvarOperacao() async {
    if (operacaoController.text.isNotEmpty) {
      await SQLiteManager.instance
          .insertOperacaoRomaneio(operacaoController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Operação salva com sucesso!'),
          backgroundColor: Color(0xFF173F35),
        ),
      );
      operacaoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Cadastro de Lote e Operação"),
        backgroundColor: const Color(0xFF76232F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Lote',
                    textAlign: TextAlign.left,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF173F35),
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: loteController,
                decoration: InputDecoration(
                  labelText: "Cadastre o lote...",
                  labelStyle: const TextStyle(
                    color: Color(0xFF173F35), // Cor do label
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF173F35), // Cor da borda quando focado
                      width: 2,
                    ),
                    borderRadius:
                        BorderRadius.circular(8), // deixa arredondado se quiser
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF173F35), // cor da borda normal
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF173F35),
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                ),
                cursorColor: const Color(0xFF173F35),
              ),

              const SizedBox(height: 12),

              // Botão personalizado 1
              CustomButton(
                text: "Salvar Lote",
                icon: Icons.save,
                color: Color(0xFF76232F),
                fontSize: 14,
                iconSize: 16,
                onPressed: _salvarLote,
                buttonWidth: 260,
                buttonHeight: 40,
                hasShadow: true,
              ),

              const SizedBox(height: 20),
              Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Operação',
                    textAlign: TextAlign.left,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF173F35),
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: operacaoController,
                decoration: InputDecoration(
                  labelText: "Cadastre a operação...",
                  labelStyle: const TextStyle(
                    color: Color(0xFF173F35), // Cor do label
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF173F35), // Cor da borda quando focado
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8), // deixa arredondado
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF173F35), // cor da borda normal
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF173F35),
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                ),
                cursorColor: const Color(0xFF173F35),
              ),

              const SizedBox(height: 16),

              // Botão personalizado 2
              CustomButton(
                text: "Salvar Operação",
                icon: Icons.save,
                color: Color(0xFF76232F),
                fontSize: 14,
                iconSize: 16,
                onPressed: _salvarOperacao,
                buttonWidth: 260,
                buttonHeight: 40,
                hasShadow: true,
              ),

              const SizedBox(height: 30),

              // Botão personalizado 3
              CustomButton(
                text: "Cadastrar Classe",
                icon: Icons.list,
                color: Color(0xFF76232F),
                fontSize: 14,
                iconSize: 16,
                buttonWidth: 210,
                buttonHeight: 35,
                hasShadow: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CadastroClasseRomaneioPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Botão personalizado 4
              CustomButton(
                text: "Ir para o Romaneio",
                icon: Icons.list_alt,
                color: Color(0xFF173F35),
                fontSize: 14,
                iconSize: 16,
                buttonWidth: 210,
                buttonHeight: 35,
                hasShadow: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RomaneioWidget(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget reutilizável para botão personalizado

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final double fontSize;
  final double iconSize;
  final VoidCallback onPressed;
  final double? buttonWidth;
  final double? buttonHeight;
  final bool hasShadow;

  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.fontSize,
    required this.iconSize,
    required this.onPressed,
    this.buttonWidth,
    this.buttonHeight,
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize),
        label: Text(
          text,
          style: TextStyle(fontSize: fontSize, fontFamily: 'Open Sans'),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: hasShadow ? 6 : 0, // controla sombra
          shadowColor: hasShadow ? Colors.black54 : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // cantos arredondados
          ),
        ),
      ),
    );
  }
}
