import 'package:flutter/foundation.dart';
import 'package:leitorptb/pages/romaneio_page/classe_producao_stp.dart';
import 'package:leitorptb/pages/romaneio_page/lote_embarque_stp.dart';
import '/backend/sqlite/init.dart';
import 'queries/read.dart';
import 'queries/update.dart';
import 'package:sqflite/sqflite.dart';
import 'models/conferencia_jmc.dart';
import 'models/conferencia_altria.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static Database? _database;
  static bool _isInitialized = false;

  Future<List<ConferenciaJMC>> buscarConferenciasJMC() async {
    final db = SQLiteManager.database();

    final List<Map<String, dynamic>> maps = await db.query('conferenciaJMC');

    return maps.map((map) {
      return ConferenciaJMC(
        ladoA: map['ladoA'],
        cliente: map['cliente'],
        caixa: map['caixa'],
        data: DateTime.tryParse(map['data'] ?? ''),
        classe: map['classe'],
        localconferencia: map['localconferencia'],
        codigo1a: map['codigo1a'],
        codigo2a: map['codigo2a'],
        codigo3a: map['codigo3a'],
        codigo1b: map['codigo1b'],
        codigo2b: map['codigo2b'],
        codigo3b: map['codigo3b'],
        ladoB: map['ladoB'],
        operacao: map['operacao'],
      );
    }).toList();
  }

  Future<List<ConferenciaALTRIA>> buscarConferenciasALTRIA() async {
    final db = SQLiteManager.database();

    final List<Map<String, dynamic>> maps = await db.query('conferenciaALTRIA');

    return maps.map((map) {
      return ConferenciaALTRIA(
        ladoA: map['ladoA'],
        cliente: map['cliente'],
        caixa: map['caixa'],
        data: DateTime.tryParse(map['data'] ?? ''),
        classe: map['classe'],
        localconferencia: map['localconferencia'],
        codigo1a: map['codigo1a'],
        codigo2a: map['codigo2a'],
        codigo3a: map['codigo3a'],
        codigo4a: map['codigo4a'],
        codigo5a: map['codigo5a'],
        codigo1b: map['codigo1b'],
        codigo2b: map['codigo2b'],
        codigo3b: map['codigo3b'],
        codigo4b: map['codigo4b'],
        codigo5b: map['codigo5b'],
        ladoB: map['ladoB'],
        operacao: map['operacao'],
      );
    }).toList();
  }

  static Database database() {
    if (!_isInitialized || _database == null) {
      throw Exception(
          'O banco de dados ainda não foi inicializado. Chame SQLiteManager.initialize() antes de usá-lo.');
    }
    return _database!;
  }

  static Future<void> initialize() async {
    if (kIsWeb) {
      return;
    }

    // Carrega o banco de dados do arquivo
    _database = await initializeDatabaseFromDbFile(
      'bdleitorptb',
      'bd_leitorptb.db',
    );
    _isInitialized = true;

    if (_database != null) {
      print("Caminho do banco de dados: ${_database!.path}");

      // Verifica e cria a tabela classeJMC (se necessário)
      var tablesClasseJMC = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='classeJMC'");
      if (tablesClasseJMC.isEmpty) {
        await _database!.execute(
          "CREATE TABLE classeJMC(id INTEGER PRIMARY KEY AUTOINCREMENT, classe TEXT)",
        );
        print("Tabela classeJMC criada com sucesso!");
      } else {
        print("Tabela classeJMC já existe.");
      }

      // Verifica e cria a tabela operacaoJMC (se necessário)
      var tablesOperacaoJMC = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='operacaoJMC'");
      if (tablesOperacaoJMC.isEmpty) {
        await _database!.execute(
          "CREATE TABLE operacaoJMC(id INTEGER PRIMARY KEY AUTOINCREMENT, operacao TEXT)",
        );
        print("Tabela operacaoJMC criada com sucesso!");
      } else {
        print("Tabela operacaoJMC já existe.");
      }

      // Verifica e cria a tabela classeALTRIA (se necessário)
      var tablesClasseALTRIA = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='classeALTRIA'");
      if (tablesClasseALTRIA.isEmpty) {
        await _database!.execute(
          "CREATE TABLE classeALTRIA(id INTEGER PRIMARY KEY AUTOINCREMENT, classe TEXT)",
        );
        print("Tabela classeALTRIA criada com sucesso!");
      } else {
        print("Tabela classeALTRIA já existe.");
      }

      // Verifica e cria a tabela operacaoALTRIA (se necessário)
      var tablesOperacaoALTRIA = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='operacaoALTRIA'");
      if (tablesOperacaoALTRIA.isEmpty) {
        await _database!.execute(
          "CREATE TABLE operacaoALTRIA(id INTEGER PRIMARY KEY AUTOINCREMENT, operacao TEXT)",
        );
        print("Tabela operacaoALTRIA criada com sucesso!");
      } else {
        print("Tabela operacaoALTRIA já existe.");
      }

      // Verifica e cria a tabela conferenciaJMC (se necessário)
      var tablesConferenciaJMC = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='conferenciaJMC'");
      if (tablesConferenciaJMC.isEmpty) {
        await _database!.execute('''
          CREATE TABLE conferenciaJMC(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ladoA TEXT,
      cliente TEXT,
      caixa INTEGER,
      data TEXT,
      classe TEXT,
      localconferencia TEXT,
      codigo1a TEXT,
      codigo2a TEXT,
      codigo3a TEXT,
      codigo1b TEXT,
      codigo2b TEXT,
      codigo3b TEXT,
      ladoB TEXT,
      operacao TEXT
    )
    ''');
        print("Tabela conferenciaJMC criada com sucesso!");
      } else {
        print("Tabela conferenciaJMC já existe.");
      }

      // Verifica e cria a tabela conferenciaJMC (se necessário)
      var tablesConferenciaALTRIA = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='conferenciaALTRIA'");
      if (tablesConferenciaALTRIA.isEmpty) {
        await _database!.execute('''
    CREATE TABLE conferenciaALTRIA(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ladoA TEXT,
      cliente TEXT,
      caixa INTEGER,
      data TEXT,
      classe TEXT,
      localconferencia TEXT,
      codigo1a TEXT,
      codigo2a TEXT,
      codigo3a TEXT,
      codigo4a TEXT,
      codigo5a TEXT,
      codigo1b TEXT,
      codigo2b TEXT,
      codigo3b TEXT,
      codigo4b TEXT,
      codigo5b TEXT,
      ladoB TEXT,
      operacao TEXT)''');
        print("Tabela conferenciaALTRIA criada com sucesso!");
      } else {
        print("Tabela conferenciaALTRIA já existe.");
      }

      // Verifica e cria a tabela romaneioALTRIA
      var tablesromaneioALTRIA = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='romaneioALTRIA'");
      if (tablesromaneioALTRIA.isEmpty) {
        await _database!.execute('''
            CREATE TABLE romaneioALTRIA (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              CodDe       INTEGER ,
              CodPara     INTEGER ,
              Lote        TEXT ,
              Operacao    TEXT ,
              Classe      TEXT ,
              CodBarras   INTEGER ,
              Observacao  TEXT ,
              Data        TEXT );
    )
    ''');
        print("Tabela romaneioALTRIA criada com sucesso!");
      } else {
        print("Tabela romaneioALTRIA já existe.");
      }

      var loteRomaneio = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='loteRomaneio'");
      if (loteRomaneio.isEmpty) {
        await _database!.execute(
          "CREATE TABLE loteRomaneio(id INTEGER PRIMARY KEY AUTOINCREMENT, LoteRomaneio TEXT)",
        );
        print("Tabela loteRomaneio criada com sucesso!");
      } else {
        print("Tabela loteRomaneio já existe!");
      }

      var operacaoRomaneio = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='operacaoRomaneio'");
      if (operacaoRomaneio.isEmpty) {
        await _database!.execute(
          "CREATE TABLE operacaoRomaneio(id INTEGER PRIMARY KEY AUTOINCREMENT, OperacaoRomaneio TEXT)",
        );
        print("Tabela operacaoRomaneio criada com sucesso!");
      } else {
        print("Tabela  operacaoRomaneio já existe!");
      }

      var classeRomaneio = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='classeRomaneio'");
      if (classeRomaneio.isEmpty) {
        await _database!.execute(
          "CREATE TABLE classeRomaneio(id INTEGER PRIMARY KEY AUTOINCREMENT, NomeClasse TEXT, CodigoClasse INTEGER, Observacao TEXT, QtdeCaixa INTEGER)",
        );
        print("Tabela classeRomaneio criada com sucesso!");
      } else {
        print("Tabela classeRomaneio já existe!");
      }

      var lotesSTP = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='loteEmbarqueSTP'");
      if (lotesSTP.isEmpty) {
        await _database!.execute(
          "CREATE TABLE IF NOT EXISTS loteEmbarqueSTP  (id INTEGER PRIMARY KEY AUTOINCREMENT, CodLoteEmb TEXT UNIQUE, DescrLote TEXT)",
        );
        print("Tabela loteEmbarqueSTP criada com sucesso!");
      } else {
        print("Tabela loteEmbarqueSTP já existe!");
      }

      var classesSTP = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='classeProducaoSTP'");
      if (classesSTP.isEmpty) {
        await _database!.execute(
          "CREATE TABLE IF NOT EXISTS classeProducaoSTP (id INTEGER PRIMARY KEY AUTOINCREMENT, CodClasseProd TEXT UNIQUE, NomeClasseProd TEXT)",
        );
        print("Tabela classeProducaoSTP criada com sucesso!");
      } else {
        print("Tabela classeProducaoSTP já existe!");
      }

      // Lista todas as tabelas do banco (para depuração)
      var allTables = await _database!
          .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
      print("Tabelas no banco: $allTables");
    } else {
      print("Erro: O banco de dados não foi inicializado corretamente.");
    }
  }

  /// START READ QUERY CALLS

  Future<List<BuscaClasseJMCRow>> buscaClasseJMC() =>
      performBuscaClasseJMC(database());

  Future<List<BuscaOperacaoJMCRow>> buscaOperacaoJMC() =>
      performBuscaOperacaoJMC(database());

  /* Future<List<BuscaUltimaCaixaJMCRow>> buscaUltimaCaixaJMC() =>
      performBuscaUltimaCaixaJMC(database); */

  Future<List<BuscaClasseALTRIARow>> buscaClasseALTRIA() =>
      performBuscaClasseALTRIA(database());

  Future<List<BuscaOperacaoALTRIARow>> buscaOperacaoALTRIA() =>
      performBuscaOperacaoALTRIA(database());

  Future<List<BuscaUltimaCaixaALTRIARow>> buscaUltimaCaixaALTRIA() =>
      performBuscaUltimaCaixaALTRIA(database());

  ///
  Future<List<BuscaLoteRomenioAltria>> buscaLoteRomenioAltria() =>
      performBuscaLoteRomenioAltria(database());

  ///
  Future<List<BuscaOperacaoRomenioAltria>> buscaOperacaoRomenioAltria() =>
      performBuscaOperacaoRomenioAltria(database());

  Future<List<BuscaClasseRomenioAltria>> buscaClasseRomenioAltria() =>
      performBuscaClasseRomenioAltria(database());

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  Future insertConferenciaJMC({
    String? ladoA,
    String? cliente,
    int? caixa,
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
  }) =>
      performInsertConferenciaJMC(database(),
          ladoA: ladoA,
          cliente: cliente,
          caixa: caixa,
          data: data,
          classe: classe,
          localconferencia: localconferencia,
          codigo1a: codigo1a,
          codigo2a: codigo2a,
          codigo3a: codigo3a,
          codigo1b: codigo1b,
          codigo2b: codigo2b,
          codigo3b: codigo3b,
          ladoB: ladoB,
          operacao: operacao);

  Future classeJMC({String? classe}) =>
      performClasseJMC(database(), classe: classe);

  Future operacaoJMC({String? operacao}) =>
      performOperacaoJMC(database(), operacao: operacao);

  Future classeALTRIA({String? classe}) =>
      performClasseALTRIA(database(), classe: classe);

  Future operacaoALTRIA({String? operacao}) =>
      performOperacaoALTRIA(database(), operacao: operacao);

  Future<int> insertLoteRomaneio(String lote) async {
    return await _database!.insert('loteRomaneio', {
      'loteRomaneio': lote,
    });
  }

  Future<int> insertOperacaoRomaneio(String operacao) async {
    return await _database!.insert('operacaoRomaneio', {
      'operacaoRomaneio': operacao,
    });
  }

  Future<int> insertClasseRomaneio({
    required String nomeClasse,
    required int codigoClasse,
    required String observacao,
    required int qtdeCaixa,
  }) async {
    return await _database!.insert('classeRomaneio', {
      'nomeClasse': nomeClasse,
      'codigoClasse': codigoClasse,
      'observacao': observacao,
      'qtdeCaixa': qtdeCaixa,
    });
  }

  Future insertRomaneioALTRIA(
          {int? codde,
          int? codpara,
          String? lote,
          String? operacao,
          String? classe,
          String? observacao,
          DateTime? data,
          int? CodBarras}) =>
      performinsertRomaneioALTRIA(
        database(),
        codde: codde,
        codpara: codpara,
        lote: lote,
        operacao: operacao,
        classe: classe,
        observacao: observacao,
        data: data,
        CodBarras: CodBarras,
      );

  Future insertConferenciaALTRIA({
    String? ladoA,
    String? cliente,
    int? caixa,
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
  }) =>
      performInsertConferenciaALTRIA(database(),
          ladoA: ladoA,
          cliente: cliente,
          caixa: caixa,
          data: data,
          classe: classe,
          localconferencia: localconferencia,
          codigo1a: codigo1a,
          codigo2a: codigo2a,
          codigo3a: codigo3a,
          codigo1b: codigo1b,
          codigo2b: codigo2b,
          codigo3b: codigo3b,
          ladoB: ladoB,
          codigo4a: codigo4a,
          codigo5a: codigo5a,
          codigo4b: codigo4b,
          codigo5b: codigo5b,
          operacao: operacao);

  // Future<void> inserirLoteEmbarque(
  //     List<LoteEmbarqueSTP> lotes, String descricao) async {
  //   final db = await database();
  //   final batch = db.batch();
  //   for (final lote in lotes) {
  //     batch.insert(
  //       'loteEmbarqueSTP',
  //       {'CodLoteEmb': lote.codigo, 'DescrLote': lote.descricao},
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   }
  //   await batch.commit(noResult: true);
  // }

  Future<void> inserirLoteEmbarque(List<LoteEmbarqueSTP> lotes) async {
    final db = await database();
    // (opcional) garantir tabela e índice únicos
    await db.execute("delete from loteEmbarqueSTP");
    await db.execute(
      "CREATE TABLE IF NOT EXISTS loteEmbarqueSTP ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "CodLoteEmb TEXT UNIQUE, "
      "DescrLote TEXT"
      ")",
    );
    await db.execute(
      "CREATE UNIQUE INDEX IF NOT EXISTS idx_loteEmbarque_cod "
      "ON loteEmbarqueSTP(CodLoteEmb)",
    );

    final batch = db.batch();
    for (final l in lotes) {
      batch.insert(
        'loteEmbarqueSTP',
        {'CodLoteEmb': l.codigo, 'DescrLote': l.descricao},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<void> inserirClasseProducaoSTP(List<ClasseProducaoSTP> classes) async {
    final db = await database();

    await db.execute("DELETE FROM classeProducaoSTP");
    await db.execute(
      "CREATE TABLE IF NOT EXISTS classeProducaoSTP (id INTEGER PRIMARY KEY AUTOINCREMENT, CodClasseProd INTEGER UNIQUE, NomeClasseProd TEXT)",
    );
    await db.execute(
      "CREATE UNIQUE INDEX IF NOT EXISTS idx_classeProducao_cod "
      "ON classeProducaoSTP(CodClasseProd)",
    );

    final batch = db.batch();
    for (final c in classes) {
      batch.insert(
        'classeProducaoSTP',
        {
          'CodClasseProd': c.codigo,
          'NomeClasseProd': c.descricao,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  /// END UPDATE QUERY CALLS
  Future<List<ConferenciaJMC>> getConferenciasJMCFromDB() async {
    final db = SQLiteManager.database();

    final List<Map<String, dynamic>> maps = await db.query('conferenciaJMC');

    return maps.map((map) {
      return ConferenciaJMC(
        ladoA: map['ladoA'],
        cliente: map['cliente'],
        caixa: map['caixa'],
        data: DateTime.tryParse(map['data'] ?? ''),
        classe: map['classe'],
        localconferencia: map['localconferencia'],
        codigo1a: map['codigo1a'],
        codigo2a: map['codigo2a'],
        codigo3a: map['codigo3a'],
        codigo1b: map['codigo1b'],
        codigo2b: map['codigo2b'],
        codigo3b: map['codigo3b'],
        ladoB: map['ladoB'],
        operacao: map['operacao'],
      );
    }).toList();
  }

  Future<int> contarCaixasLidasJMC() async {
    final db = await database();
    final resultado =
        await db.rawQuery('SELECT COUNT(*) as total FROM conferenciaJMC');

    if (resultado.isNotEmpty) {
      return resultado.first['total'] as int;
    }
    return 0;
  }

  Future<int> contarCaixasLidasAltria() async {
    final db = await database();
    final resultado =
        await db.rawQuery('SELECT COUNT(*) as total FROM conferenciaALTRIA');

    if (resultado.isNotEmpty) {
      return resultado.first['total'] as int;
    }
    return 0;
  }

  Future<int> contarCaixasPorClasse(String codClasse) async {
    final db = await database();
    final resultado = await db.rawQuery(
      'SELECT COUNT(*) as total FROM romaneioALTRIA WHERE Classe = ?',
      [codClasse],
    );

    if (resultado.isNotEmpty) {
      return resultado.first['total'] as int;
    }
    return 0;
  }

  Future<List<Map<String, dynamic>>> buscarLotesEmbarque() async {
    final db = await database();

    return await db.query(
      'loteEmbarqueSTP',
      orderBy: 'CodLoteEmb ASC',
    );
  }

  Future<List<Map<String, dynamic>>> buscarClassesProducaoSTP() async {
    final db = await database();

    return await db.query(
      'classeProducaoSTP',
      orderBy: 'CodClasseProd ASC',
    );
  }

  Future<void> limparLotesEmbarque() async {
    final db = await database();
    await db.delete('classeProducaoSTP');
  }

  Future<bool> existeCaixaRegistradaRomaneio({
    required int codde,
    required String codpara,
    required String classe,
  }) async {
    final db = await database();
    final resultado = await db.rawQuery(
      '''
    SELECT 1 FROM romaneioALTRIA
    WHERE codde = ? AND codpara = ?  AND classe = ?
    LIMIT 1
    ''',
      [codde, codpara, classe],
    );

    return resultado.isNotEmpty;
  }

  Future<bool> existeCaixaRegistradaJMC({
    required int caixa,
    required String operacao,
    required String classe,
  }) async {
    final db = await database();
    final resultado = await db.rawQuery(
      '''
    SELECT 1 FROM conferenciaJMC
    WHERE caixa = ? AND operacao = ? AND classe = ?
    LIMIT 1
    ''',
      [caixa, operacao, classe],
    );

    return resultado.isNotEmpty;
  }

  Future<bool> existeCaixaRegistradaALTRIA({
    required int caixa,
    required String operacao,
    required String classe,
  }) async {
    final db = await database();
    final resultado = await db.rawQuery(
      '''
    SELECT 1 FROM conferenciaALTRIA
    WHERE caixa = ? AND operacao = ? AND classe = ?
    LIMIT 1
    ''',
      [caixa, operacao, classe],
    );

    return resultado.isNotEmpty;
  }

  // Buscar todos os Lotes cadastrados
  Future<List<Map<String, dynamic>>> getLotesRomaneio() async {
    final db = await database();
    return await db.query('loteRomaneio'); // substitua pelo nome real da tabela
  }

// Buscar todas as Operações cadastradas
  Future<List<Map<String, dynamic>>> getOperacoesRomaneio() async {
    final db = await database();
    return await db.query('operacaoRomaneio');
  }

// Buscar todas as Classes cadastradas
  Future<List<Map<String, dynamic>>> getClassesRomaneio() async {
    final db = await database();
    return await db.query('classeRomaneio');
  }

  Future<int> deleteLoteRomaneio(int id) async {
    return await _database!
        .delete('loteRomaneio', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteOperacaoRomaneio(int id) async {
    return await _database!
        .delete('operacaoRomaneio', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteClasseRomaneio(int id) async {
    return await _database!
        .delete('classeRomaneio', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> performinsertRomaneioALTRIA(
    Database database, {
    int? codde,
    int? codpara,
    String? lote,
    String? operacao,
    String? classe,
    String? observacao,
    DateTime? data,
    int? CodBarras,
  }) async {
    await database.insert(
      'romaneioALTRIA',
      {
        'CodDe': codde,
        'CodPara': codpara,
        'Lote': lote,
        'Operacao': operacao,
        'Classe': classe,
        'Observacao': observacao,
        'Data': (data ?? DateTime.now()).toIso8601String(),
        'CodBarras': CodBarras,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
