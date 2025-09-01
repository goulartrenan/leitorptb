import 'package:flutter/material.dart';
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
                  decoration:
                      const InputDecoration(labelText: "Nome da Classe"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: codigoClasseController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: "Código da Classe"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: observacaoController,
                  decoration: const InputDecoration(labelText: "Observação"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: qtdeCaixaController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: "Quantidade por Caixa"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _salvarClasse,
                  child: const Text("Salvar Classe"),
                ),
              ],
            ),
          ),
        ));
  }
}
