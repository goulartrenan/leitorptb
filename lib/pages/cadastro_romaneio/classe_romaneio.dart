import 'package:flutter/material.dart';
import 'package:leitorptb/pages/romaneio_page/romaneio_cliente_config.dart';
import 'package:leitorptb/pages/romaneio_page/romaneio_widget.dart';
import '/backend/sqlite/sqlite_manager.dart';

class CadastroClasseRomaneioPage extends StatefulWidget {
  const CadastroClasseRomaneioPage({super.key});

  @override
  State<CadastroClasseRomaneioPage> createState() =>
      _CadastroClasseRomaneioPageState();
}

class _CadastroClasseRomaneioPageState
    extends State<CadastroClasseRomaneioPage> {
  final TextEditingController nomeClasseController = TextEditingController();
  final TextEditingController codigoClasseController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();
  final TextEditingController qtdeCaixaController = TextEditingController();

  Future<void> _salvarClasse() async {
    if (nomeClasseController.text.isNotEmpty &&
        codigoClasseController.text.isNotEmpty &&
        qtdeCaixaController.text.isNotEmpty) {
      await SQLiteManager.instance.insertClasseRomaneio(
        nomeClasse: nomeClasseController.text,
        codigoClasse: int.parse(codigoClasseController.text),
        observacao: observacaoController.text,
        qtdeCaixa: int.parse(qtdeCaixaController.text),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Dados salvos com sucesso!'),
          backgroundColor: Color(0xFF173F35),
        ),
      );

      nomeClasseController.clear();
      codigoClasseController.clear();
      observacaoController.clear();
      qtdeCaixaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Cadastro de Classe"),
          backgroundColor: Color(0xFF76232F),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: nomeClasseController,
                  decoration: InputDecoration(
                    labelText: "Nome da classe",
                    labelStyle: const TextStyle(
                      color: Color(0xFF173F35), // Cor do label
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF173F35), // Cor da borda quando focado
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(8), // deixa arredondado
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
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                  ),
                  cursorColor: const Color(0xFF173F35),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: codigoClasseController,
                  decoration: InputDecoration(
                    labelText: "Codigo classe",
                    labelStyle: const TextStyle(
                      color: Color(0xFF173F35), // Cor do label
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF173F35), // Cor da borda quando focado
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(8), // deixa arredondado
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
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                  ),
                  cursorColor: const Color(0xFF173F35),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: observacaoController,
                  decoration: InputDecoration(
                    labelText: "Observação",
                    labelStyle: const TextStyle(
                      color: Color(0xFF173F35), // Cor do label
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF173F35), // Cor da borda quando focado
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(8), // deixa arredondado
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
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                  ),
                  cursorColor: const Color(0xFF173F35),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: qtdeCaixaController,
                  decoration: InputDecoration(
                    labelText: "Qtde caixas por classe",
                    labelStyle: const TextStyle(
                      color: Color(0xFF173F35), // Cor do label
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF173F35), // Cor da borda quando focado
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(8), // deixa arredondado
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
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                  ),
                  cursorColor: const Color(0xFF173F35),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Salvar Classe",
                  icon: Icons.save,
                  color: Color(0xFF76232F),
                  fontSize: 14,
                  iconSize: 16,
                  onPressed: _salvarClasse,
                  buttonWidth: 260,
                  buttonHeight: 40,
                  hasShadow: true,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Ir para o Romaneio",
                  icon: Icons.list_alt,
                  color: Color(0xFF173F35),
                  fontSize: 14,
                  iconSize: 16,
                  buttonWidth: 260,
                  buttonHeight: 40,
                  hasShadow: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RomaneioWidget(cliente: clientesRomaneio[0]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

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
