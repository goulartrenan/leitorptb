class ClasseProducaoSTP {
  final int codigo; // -> CodClasseProd
  final String descricao; // -> NomeClasseProd

  const ClasseProducaoSTP({required this.codigo, required this.descricao});

  factory ClasseProducaoSTP.fromApi(Map<String, dynamic> json) {
    // API pode devolver string p/ código (ex.: "11457")
    final rawCod = json['CodClasseProd'] ??
        json['CodClasse'] ??
        json['codigo'] ??
        json['id'];
    final rawNome = json['NomeClasseProd'] ??
        json['NomeClasse'] ??
        json['descricao'] ??
        json['nome'];

    return ClasseProducaoSTP(
      codigo: (rawCod is int) ? rawCod : int.tryParse('$rawCod') ?? 0,
      descricao: (rawNome ?? '').toString(),
    );
  }
}
