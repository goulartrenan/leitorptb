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

/// BEGIN BUSCA ULTIMA CAIXA JMC
/* Future<List<BuscaUltimaCaixaJMCRow>> performBuscaUltimaCaixaJMC(
  Database database,
) {
  final query = '''
SELECT * FROM conferenciajmc ORDER BY caixa DESC LIMIT 1
''';
  return _readQuery(database, query, (d) => BuscaUltimaCaixaJMCRow(d));
}

class BuscaUltimaCaixaJMCRow extends SqliteRow {
  BuscaUltimaCaixaJMCRow(Map<String, dynamic> data) : super(data);

  String? get caixa => data['caixa'] as String?;
} */

/// END BUSCA ULTIMA CAIXA JMC

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
SELECT caixa FROM conferenciaALTRIA ORDER BY id DESC LIMIT 1
''';
  return _readQuery(database, query, (d) => BuscaUltimaCaixaALTRIARow(d));
}

class BuscaUltimaCaixaALTRIARow extends SqliteRow {
  BuscaUltimaCaixaALTRIARow(Map<String, dynamic> data) : super(data);

  String? get caixa => data['caixa'] as String?;
}

/// END BUSCA ULTIMA CAIXA ALTRIA
