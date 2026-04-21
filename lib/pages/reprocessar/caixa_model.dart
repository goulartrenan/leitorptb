class CaixaModel {
  final String caixa;
  final String classe;
  final String operacao;
  final String cliente;

  CaixaModel({
    required this.caixa,
    required this.classe,
    required this.operacao,
    required this.cliente,
  });

  factory CaixaModel.fromJson(Map<String, dynamic> json) {
    return CaixaModel(
      caixa: json['caixa'].toString(),
      classe: json['classe'],
      operacao: json['operacao'],
      cliente: json['cliente'],
    );
  }
}
