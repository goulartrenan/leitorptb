class ConferenciaALTRIA {
  final int? id;
  final String? ladoA;
  final String? cliente;
  final int? caixa;
  final int? enviado;
  final DateTime? data;
  final String? classe;
  final String? localconferencia;
  final String? codigo1a;
  final String? codigo2a;
  final String? codigo3a;
  final String? codigo4a;
  final String? codigo5a;
  final String? codigo1b;
  final String? codigo2b;
  final String? codigo3b;
  final String? codigo4b;
  final String? codigo5b;
  final String? ladoB;
  final String? operacao;

  ConferenciaALTRIA({
    this.id,
    this.ladoA,
    this.cliente,
    this.caixa,
    this.enviado,
    this.data,
    this.classe,
    this.localconferencia,
    this.codigo1a,
    this.codigo2a,
    this.codigo3a,
    this.codigo4a,
    this.codigo5a,
    this.codigo1b,
    this.codigo2b,
    this.codigo3b,
    this.codigo4b,
    this.codigo5b,
    this.ladoB,
    this.operacao,
  });

  factory ConferenciaALTRIA.fromMap(Map<String, dynamic> map) {
    return ConferenciaALTRIA(
      id: map['codconf'],
      ladoA: map['ladoA'] as String?,
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
      codigo4a: map['codigo4a'] as String?,
      codigo5a: map['codigo5a'] as String?,
      codigo1b: map['codigo1b'] as String?,
      codigo2b: map['codigo2b'] as String?,
      codigo3b: map['codigo3b'] as String?,
      codigo4b: map['codigo4b'] as String?,
      codigo5b: map['codigo5b'] as String?,
      ladoB: map['ladoB'] as String?,
      operacao: map['operacao'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'ladoA': 'A',
        'cliente': 'ALTRIA',
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
        'codigo4a': codigo4a,
        'codigo4b': codigo4b,
        'codigo5a': codigo5a,
        'codigo5b': codigo5b,
        'ladoB': 'B',
        'operacao': operacao,
      };
}
