class LoteEmbarqueSTP {
  final String codigo;
  final String descricao;

  LoteEmbarqueSTP({
    required this.codigo,
    required this.descricao,
  });

  factory LoteEmbarqueSTP.fromJson(Map<String, dynamic> json) {
    return LoteEmbarqueSTP(
      codigo: (json['CodLoteEmb'] ?? '').toString(),
      descricao: (json['DescrLote'] ?? '').toString(),
    );
  }
}
