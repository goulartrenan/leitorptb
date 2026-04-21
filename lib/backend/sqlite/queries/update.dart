import 'package:sqflite/sqflite.dart';

/// BEGIN INSERTCONFERENCIA JMC
Future performInsertConferenciaJMC(
  Database database, {
  String? ladoA,
  String? cliente,
  int? caixa,
  int? enviado,
  DateTime? data,
  String? classe,
  String? localconferencia,
  String? codigo1a,
  String? codigo2a,
  String? codigo3a,
  String? codigo1b,
  String? codigo2b,
  String? codigo3b,
  String? ladoB,
  String? operacao,
}) {
  final query = '''
INSERT INTO conferenciaJMC (
                               cliente,
                               caixa,
                               enviado,
                               data,
                               classe,
                               operacao,
                               localconferencia,
                               ladoA,
                               codigo1a,
                               codigo2a,
                               codigo3a,
                               ladoB,
                               codigo1b,
                               codigo2b,
                               codigo3b
                           )
                           VALUES (
                               "$cliente",
                               $caixa,
                               ${enviado ?? 0},
                               "$data",
                               "$classe",
                               "$operacao",
                               "$localconferencia",
                               "$ladoA",
                               "$codigo1a",
                               "$codigo2a",
                               "$codigo3a",
                               "$ladoB",
                               "$codigo1b",
                               "$codigo2b",
                               "$codigo3b"
                           );

''';
  return database.rawQuery(query);
}

/// END INSERTCONFERENCIA JMC

/// BEGIN CLASSE JMC
Future performClasseJMC(
  Database database, {
  String? classe,
}) {
  final query = '''
insert into classeJMC (classe)
values ('${classe}')
''';
  return database.rawQuery(query);
}

/// END CLASSE JMC

/// BEGIN OPERACAO JMC
Future performOperacaoJMC(
  Database database, {
  String? operacao,
}) {
  final query = '''
insert into operacaoJMC  (operacao)
values ('${operacao}')
''';
  return database.rawQuery(query);
}

/// END OPERACAO JMC

/// BEGIN CLASSE ALTRIA
Future performClasseALTRIA(
  Database database, {
  String? classe,
}) {
  final query = '''
insert into classealtria (classe)
values ('${classe}')
''';
  return database.rawQuery(query);
}

/// END CLASSE ALTRIA

/// BEGIN OPERACAO ALTRIA
Future performOperacaoALTRIA(
  Database database, {
  String? operacao,
}) {
  final query = '''
insert into operacaoaltria  (operacao)
values ('${operacao}')
''';
  return database.rawQuery(query);
}

/// END OPERACAO ALTRIA

/// BEGIN INSERTCONFERENCIA ALTRIA
Future performInsertConferenciaALTRIA(
  Database database, {
  String? ladoA,
  String? cliente,
  int? caixa,
  int? enviado,
  DateTime? data,
  String? classe,
  String? localconferencia,
  String? codigo1a,
  String? codigo2a,
  String? codigo3a,
  String? codigo1b,
  String? codigo2b,
  String? codigo3b,
  String? ladoB,
  String? codigo4a,
  String? codigo5a,
  String? codigo4b,
  String? codigo5b,
  String? operacao,
}) {
  final query = '''
INSERT INTO conferenciaALTRIA (
                                  cliente,
                                  caixa,
                                  enviado,
                                  data,
                                  classe,
                                  operacao,
                                  localconferencia,
                                  ladoA,
                                  codigo1a,
                                  codigo2a,
                                  codigo3a,
                                  codigo4a,
                                  codigo5a,
                                  ladoB,
                                  codigo1b,
                                  codigo2b,
                                  codigo3b,
                                  codigo4b,
                                  codigo5b
                              )
                              VALUES (
                                  "$cliente",
                                  $caixa,
                                  ${enviado ?? 0},
                                  "$data",
                                  "$classe",
                                  "$operacao",
                                  "$localconferencia",
                                  "$ladoA",
                                  "$codigo1a",
                                  "$codigo2a",
                                  "$codigo3a",
                                  "$codigo4a",
                                  "$codigo5a",
                                  "$ladoB",
                                  "$codigo1b",
                                  "$codigo2b",
                                  "$codigo3b",
                                  "$codigo4b",
                                  "$codigo5b"
                              );

''';
  return database.rawQuery(query);
}

/// END INSERTCONFERENCIA ALTRIA
