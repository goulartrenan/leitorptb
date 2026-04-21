import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN BUSCA CLASSE JMC
Future<List<BuscaClasseJMCRow>> performBuscaClasseJMC(
  Database database,
) {
  final query = '''
select classe from classejmc where classe is not null
''';
  return _readQuery(database, query, (d) => BuscaClasseJMCRow(d));
}

class BuscaClasseJMCRow extends SqliteRow {
  BuscaClasseJMCRow(Map<String, dynamic> data) : super(data);

  String? get classe => data['classe'] as String?;
}

/// END BUSCA CLASSE JMC

/// BEGIN BUSCA OPERACAO JMC
Future<List<BuscaOperacaoJMCRow>> performBuscaOperacaoJMC(
  Database database,
) {
  final query = '''
select operacao from operacaojmc where operacao is not null
''';
  return _readQuery(database, query, (d) => BuscaOperacaoJMCRow(d));
}

class BuscaOperacaoJMCRow extends SqliteRow {
  BuscaOperacaoJMCRow(Map<String, dynamic> data) : super(data);

  String? get operacao => data['operacao'] as String?;
}

/// END BUSCA OPERACAO JMC

/// BEGIN BUSCA CLASSE ALTRIA
Future<List<BuscaClasseALTRIARow>> performBuscaClasseALTRIA(
  Database database,
) {
  final query = '''
select classe from classealtria where classe is not null
''';
  return _readQuery(database, query, (d) => BuscaClasseALTRIARow(d));
}

class BuscaClasseALTRIARow extends SqliteRow {
  BuscaClasseALTRIARow(Map<String, dynamic> data) : super(data);

  String? get classe => data['classe'] as String?;
}

/// END BUSCA CLASSE ALTRIA

/// BEGIN BUSCA OPERACAO ALTRIA
Future<List<BuscaOperacaoALTRIARow>> performBuscaOperacaoALTRIA(
  Database database,
) {
  final query = '''
select operacao from operacaoaltria where operacao is not null
''';
  return _readQuery(database, query, (d) => BuscaOperacaoALTRIARow(d));
}

class BuscaOperacaoALTRIARow extends SqliteRow {
  BuscaOperacaoALTRIARow(Map<String, dynamic> data) : super(data);

  String? get operacao => data['operacao'] as String?;
}

/// END BUSCA OPERACAO ALTRIA

/// BEGIN BUSCA ULTIMA CAIXA ALTRIA
Future<List<BuscaUltimaCaixaALTRIARow>> performBuscaUltimaCaixaALTRIA(
  Database database,
) {
  final query = '''
SELECT caixa FROM conferenciaALTRIA WHERE enviado = 1 ORDER BY id DESC LIMIT 1
''';
  return _readQuery(database, query, (d) => BuscaUltimaCaixaALTRIARow(d));
}

class BuscaUltimaCaixaALTRIARow extends SqliteRow {
  BuscaUltimaCaixaALTRIARow(Map<String, dynamic> data) : super(data);

  String? get caixa => data['caixa'] as String?;
}

/// END BUSCA ULTIMA CAIXA ALTRIA

/// BEGIN BUSCA LOTE ROMANEIO ALTRIA
Future<List<BuscaLoteRomenioAltria>> performBuscaLoteRomenioAltria(
  Database database,
) {
  final query = '''
SELECT LoteRomaneio FROM loteRomaneio ORDER BY id 
''';
  return _readQuery(database, query, (d) => BuscaLoteRomenioAltria(d));
}

class BuscaLoteRomenioAltria extends SqliteRow {
  BuscaLoteRomenioAltria(Map<String, dynamic> data) : super(data);

  String? get loteRomaneio => data['LoteRomaneio'] as String?;
}

class BuscaLoteEmbarqueSTP extends SqliteRow {
  BuscaLoteEmbarqueSTP(Map<String, dynamic> data) : super(data);

  String? get loteEmbarque => data['loteEmbarqueSTP'] as String?;
}

/// END BUSCA LOTE ROMANEIO ALTRIA

/// BEGIN BUSCA OPERAÇÃO ROMANEIO ALTRIA
Future<List<BuscaOperacaoRomenioAltria>> performBuscaOperacaoRomenioAltria(
  Database database,
) {
  final query = '''
SELECT OperacaoRomaneio FROM operacaoRomaneio ORDER BY id 
''';
  return _readQuery(database, query, (d) => BuscaOperacaoRomenioAltria(d));
}

class BuscaOperacaoRomenioAltria extends SqliteRow {
  BuscaOperacaoRomenioAltria(Map<String, dynamic> data) : super(data);

  String? get operacaoRomaneio => data['OperacaoRomaneio'] as String?;
}

/// END BUSCA OPERAÇÃO ROMANEIO ALTRIA

/// /// BEGIN BUSCA CLASSE ROMANEIO ALTRIA
Future<List<BuscaClasseRomenioAltria>> performBuscaClasseRomenioAltria(
  Database database,
) {
  final query = '''
SELECT NomeClasse,CodigoClasse,Observacao,QtdeCaixa FROM classeRomaneio 
''';
  return _readQuery(database, query, (d) => BuscaClasseRomenioAltria(d));
}

class BuscaClasseRomenioAltria extends SqliteRow {
  BuscaClasseRomenioAltria(Map<String, dynamic> data) : super(data);

  String? get nomeClasse => data['NomeClasse'] as String?;
  int? get codigoClasse => data['CodigoClasse'] as int?;
  String? get observacao => data['Observacao'] as String?;
  int? get qtdeCaixa => data['QtdeCaixa'] as int?;
}

/// END BUSCA CLASSE ROMANEIO ALTRIA
