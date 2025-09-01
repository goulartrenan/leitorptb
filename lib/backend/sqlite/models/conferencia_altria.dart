class ConferenciaALTRIA {
  final String? ladoA;
  final String? cliente;
  final int? caixa;
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
    this.ladoA,
    this.cliente,
    this.caixa,
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

  Map<String, dynamic> toMap() => {
        'ladoA': 'A',
        'cliente': 'ALTRIA',
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
        'codigo4a': codigo4a,
        'codigo4b': codigo4b,
        'codigo5a': codigo5a,
        'codigo5b': codigo5b,
        'ladoB': 'B',
        'operacao': operacao,
      };
}
