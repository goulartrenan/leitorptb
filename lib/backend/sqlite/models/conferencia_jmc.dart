class ConferenciaJMC {
  final int? id;
  final String? cliente;
  final int? caixa;
  final int? enviado;
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
    this.id,
    this.cliente,
    this.caixa,
    this.enviado,
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
      id: map['id'],
      cliente: map['cliente'] as String?,
      caixa: map['caixa'] is int
          ? map['caixa']
          : int.tryParse(map['caixa'].toString()),
      enviado: map['enviado'] is int
          ? map['enviado']
          : int.tryParse(map['enviado']?.toString() ?? ''),
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
      'enviado': enviado ?? 0,
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
