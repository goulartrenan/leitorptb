class ConferenciaJMC {
  final String? cliente;
  final int? caixa;
  final DateTime? data;
  final String? classe;
  final String? localconferencia;
  final String? codigo1a;
  final String? codigo2a;
  final String? codigo3a;
  final String? codigo1b;
  final String? codigo2b;
  final String? codigo3b;
  final String? ladoA;
  final String? ladoB;
  final String? operacao;

  ConferenciaJMC({
    this.cliente,
    this.caixa,
    this.data,
    this.classe,
    this.localconferencia,
    this.codigo1a,
    this.codigo2a,
    this.codigo3a,
    this.codigo1b,
    this.codigo2b,
    this.codigo3b,
    this.ladoA,
    this.ladoB,
    this.operacao,
  });

  /// Converte um Map (SQLite) para um objeto ConferenciaJMC
  factory ConferenciaJMC.fromMap(Map<String, dynamic> map) {
    return ConferenciaJMC(
      cliente: map['cliente'] as String?,
      caixa: map['caixa'] is int
          ? map['caixa']
          : int.tryParse(map['caixa'].toString()),
      data: DateTime.tryParse(map['data'] ?? ''),
      classe: map['classe'] as String?,
      localconferencia: map['localconferencia'] as String?,
      codigo1a: map['codigo1a'] as String?,
      codigo2a: map['codigo2a'] as String?,
      codigo3a: map['codigo3a'] as String?,
      codigo1b: map['codigo1b'] as String?,
      codigo2b: map['codigo2b'] as String?,
      codigo3b: map['codigo3b'] as String?,
      ladoA: map['ladoA'] as String?,
      ladoB: map['ladoB'] as String?,
      operacao: map['operacao'] as String?,
    );
  }

  /// Converte o objeto para Map (usado para JSON)
  Map<String, dynamic> toMap() {
    return {
      'cliente': 'JMC',
      'caixa': caixa,
      'data': data?.toIso8601String(),
      'classe': classe,
      'localconferencia': localconferencia,
      'codigo1a': codigo1a,
      'codigo1b': codigo1b,
      'codigo2a': codigo2a,
      'codigo2b': codigo2b,
      'codigo3a': codigo3a,
      'codigo3b': codigo3b,
      'ladoA': 'A',
      'ladoB': 'B',
      'operacao': operacao,
    };
  }
}
