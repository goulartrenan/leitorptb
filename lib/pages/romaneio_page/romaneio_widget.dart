import 'package:flutter/material.dart';
export 'romaneio_widget.dart';

class RomaneioWidget extends StatefulWidget {
  final List<String> classesRomaneio;
  final List<String> obsRomaneio;

  const RomaneioWidget({
    super.key,
    this.classesRomaneio = const [],
    this.obsRomaneio = const [],
  });

  static String routeName = 'RomaneioPage';
  static String routePath = '/romaneioPage';

  @override
  State<RomaneioWidget> createState() => _RomaneioWidgetState();
}

class _RomaneioWidgetState extends State<RomaneioWidget> {
  String? selectedClasse;
  final TextEditingController obsController = TextEditingController();
  final TextEditingController deController = TextEditingController();
  final TextEditingController paraController = TextEditingController();

  int caixasLidas = 0; // contador de caixas

  void _salvar() {
    if (selectedClasse == null ||
        deController.text.isEmpty ||
        paraController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos obrigatórios!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      caixasLidas++; // incrementa contador sempre que salvar
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Classe: $selectedClasse\nObs: ${obsController.text}\nDE: ${deController.text}\nPARA: ${paraController.text}\nCaixas Lidas: $caixasLidas",
        ),
      ),
    );
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
            DropdownButtonFormField<String>(
              value: selectedClasse,
              decoration: InputDecoration(
                labelText: "Classe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                prefixIcon: const Icon(Icons.category),
              ),
              items: widget.classesRomaneio
                  .asMap()
                  .entries
                  .map(
                    (entry) => DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text("${entry.value}"),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedClasse = value;

                  // sincroniza a observação
                  int index = widget.classesRomaneio.indexOf(value!);
                  if (index >= 0 && index < widget.obsRomaneio.length) {
                    obsController.text = widget.obsRomaneio[index];
                  } else {
                    obsController.clear();
                  }
                });
              },
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: obsController,
              label: "Observação",
              icon: Icons.note,
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: deController,
              label: "Código DE",
              icon: Icons.qr_code,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: paraController,
              label: "Código PARA",
              icon: Icons.qr_code_2,
            ),
            const SizedBox(height: 24),

            Center(
              child: ElevatedButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.save),
                label: const Text("Salvar"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  backgroundColor: const Color(0xFF173F35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Exibe contador
            Center(
              child: Text(
                "Caixas Lidas: $caixasLidas",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173F35),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
