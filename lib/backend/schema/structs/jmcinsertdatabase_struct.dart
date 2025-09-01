// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class JmcinsertdatabaseStruct extends BaseStruct {
  JmcinsertdatabaseStruct({
    String? codigo1A,
    String? codigo1B,
    String? codigo2A,
    String? codigo2B,
    String? codigo3A,
    String? codigo3B,
    String? ladoA,
    String? cliente,
    int? nrcaixa,
    DateTime? data,
    String? classebd,
    String? local,
    String? operacaobd,
    String? ladoB,
    int? caixa,
    String? classe,
    String? localconferencia,
    String? codigo2a,
    String? codigo1a,
    String? codigo3a,
    String? codigo1b,
    String? codigo2b,
    String? codigo3b,
    String? operacao,
  })  : _codigo1A = codigo1A,
        _codigo1B = codigo1B,
        _codigo2A = codigo2A,
        _codigo2B = codigo2B,
        _codigo3A = codigo3A,
        _codigo3B = codigo3B,
        _ladoA = ladoA,
        _cliente = cliente,
        _nrcaixa = nrcaixa,
        _data = data,
        _classebd = classebd,
        _local = local,
        _operacaobd = operacaobd,
        _ladoB = ladoB;

  // "codigo1_a" field.
  String? _codigo1A;
  String get codigo1A => _codigo1A ?? '';
  set codigo1A(String? val) => _codigo1A = val;

  bool hasCodigo1A() => _codigo1A != null;

  // "codigo1_b" field.
  String? _codigo1B;
  String get codigo1B => _codigo1B ?? '';
  set codigo1B(String? val) => _codigo1B = val;

  bool hasCodigo1B() => _codigo1B != null;

  // "codigo2_a" field.
  String? _codigo2A;
  String get codigo2A => _codigo2A ?? '';
  set codigo2A(String? val) => _codigo2A = val;

  bool hasCodigo2A() => _codigo2A != null;

  // "codigo2_b" field.
  String? _codigo2B;
  String get codigo2B => _codigo2B ?? '';
  set codigo2B(String? val) => _codigo2B = val;

  bool hasCodigo2B() => _codigo2B != null;

  // "codigo3_a" field.
  String? _codigo3A;
  String get codigo3A => _codigo3A ?? '';
  set codigo3A(String? val) => _codigo3A = val;

  bool hasCodigo3A() => _codigo3A != null;

  // "codigo3_b" field.
  String? _codigo3B;
  String get codigo3B => _codigo3B ?? '';
  set codigo3B(String? val) => _codigo3B = val;

  bool hasCodigo3B() => _codigo3B != null;

  // "ladoA" field.
  String? _ladoA;
  String get ladoA => _ladoA ?? 'ladoA';
  set ladoA(String? val) => _ladoA = val;

  bool hasLadoA() => _ladoA != null;

  // "cliente" field.
  String? _cliente;
  String get cliente => _cliente ?? 'JMC';
  set cliente(String? val) => _cliente = val;

  bool hasCliente() => _cliente != null;

  // "nrcaixa" field.
  int? _nrcaixa;
  int get nrcaixa => _nrcaixa ?? 0;
  set nrcaixa(int? val) => _nrcaixa = val;

  void incrementNrcaixa(int amount) => nrcaixa = nrcaixa + amount;

  bool hasNrcaixa() => _nrcaixa != null;

  // "data" field.
  DateTime? _data;
  DateTime? get data => _data;
  set data(DateTime? val) => _data = val;

  bool hasData() => _data != null;

  // "classebd" field.
  String? _classebd;
  String get classebd => _classebd ?? '';
  set classebd(String? val) => _classebd = val;

  bool hasClassebd() => _classebd != null;

  // "local" field.
  String? _local;
  String get local => _local ?? '';
  set local(String? val) => _local = val;

  bool hasLocal() => _local != null;

  // "operacaobd" field.
  String? _operacaobd;
  String get operacaobd => _operacaobd ?? '';
  set operacaobd(String? val) => _operacaobd = val;

  bool hasOperacaobd() => _operacaobd != null;

  // "ladoB" field.
  String? _ladoB;
  String get ladoB => _ladoB ?? 'ladoB';
  set ladoB(String? val) => _ladoB = val;

  bool hasLadoB() => _ladoB != null;

  static JmcinsertdatabaseStruct fromMap(Map<String, dynamic> data) =>
      JmcinsertdatabaseStruct(
        codigo1A: data['codigo1_a'] as String?,
        codigo1B: data['codigo1_b'] as String?,
        codigo2A: data['codigo2_a'] as String?,
        codigo2B: data['codigo2_b'] as String?,
        codigo3A: data['codigo3_a'] as String?,
        codigo3B: data['codigo3_b'] as String?,
        ladoA: data['ladoA'] as String?,
        cliente: data['cliente'] as String?,
        nrcaixa: castToType<int>(data['nrcaixa']),
        data: data['data'] as DateTime?,
        classebd: data['classebd'] as String?,
        local: data['local'] as String?,
        operacaobd: data['operacaobd'] as String?,
        ladoB: data['ladoB'] as String?,
      );

  static JmcinsertdatabaseStruct? maybeFromMap(dynamic data) => data is Map
      ? JmcinsertdatabaseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'codigo1_a': _codigo1A,
        'codigo1_b': _codigo1B,
        'codigo2_a': _codigo2A,
        'codigo2_b': _codigo2B,
        'codigo3_a': _codigo3A,
        'codigo3_b': _codigo3B,
        'ladoA': _ladoA,
        'cliente': _cliente,
        'nrcaixa': _nrcaixa,
        'data': _data,
        'classebd': _classebd,
        'local': _local,
        'operacaobd': _operacaobd,
        'ladoB': _ladoB,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'codigo1_a': serializeParam(
          _codigo1A,
          ParamType.String,
        ),
        'codigo1_b': serializeParam(
          _codigo1B,
          ParamType.String,
        ),
        'codigo2_a': serializeParam(
          _codigo2A,
          ParamType.String,
        ),
        'codigo2_b': serializeParam(
          _codigo2B,
          ParamType.String,
        ),
        'codigo3_a': serializeParam(
          _codigo3A,
          ParamType.String,
        ),
        'codigo3_b': serializeParam(
          _codigo3B,
          ParamType.String,
        ),
        'ladoA': serializeParam(
          _ladoA,
          ParamType.String,
        ),
        'cliente': serializeParam(
          _cliente,
          ParamType.String,
        ),
        'nrcaixa': serializeParam(
          _nrcaixa,
          ParamType.int,
        ),
        'data': serializeParam(
          _data,
          ParamType.DateTime,
        ),
        'classebd': serializeParam(
          _classebd,
          ParamType.String,
        ),
        'local': serializeParam(
          _local,
          ParamType.String,
        ),
        'operacaobd': serializeParam(
          _operacaobd,
          ParamType.String,
        ),
        'ladoB': serializeParam(
          _ladoB,
          ParamType.String,
        ),
      }.withoutNulls;

  static JmcinsertdatabaseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      JmcinsertdatabaseStruct(
        codigo1A: deserializeParam(
          data['codigo1_a'],
          ParamType.String,
          false,
        ),
        codigo1B: deserializeParam(
          data['codigo1_b'],
          ParamType.String,
          false,
        ),
        codigo2A: deserializeParam(
          data['codigo2_a'],
          ParamType.String,
          false,
        ),
        codigo2B: deserializeParam(
          data['codigo2_b'],
          ParamType.String,
          false,
        ),
        codigo3A: deserializeParam(
          data['codigo3_a'],
          ParamType.String,
          false,
        ),
        codigo3B: deserializeParam(
          data['codigo3_b'],
          ParamType.String,
          false,
        ),
        ladoA: deserializeParam(
          data['ladoA'],
          ParamType.String,
          false,
        ),
        cliente: deserializeParam(
          data['cliente'],
          ParamType.String,
          false,
        ),
        nrcaixa: deserializeParam(
          data['nrcaixa'],
          ParamType.int,
          false,
        ),
        data: deserializeParam(
          data['data'],
          ParamType.DateTime,
          false,
        ),
        classebd: deserializeParam(
          data['classebd'],
          ParamType.String,
          false,
        ),
        local: deserializeParam(
          data['local'],
          ParamType.String,
          false,
        ),
        operacaobd: deserializeParam(
          data['operacaobd'],
          ParamType.String,
          false,
        ),
        ladoB: deserializeParam(
          data['ladoB'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'JmcinsertdatabaseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is JmcinsertdatabaseStruct &&
        codigo1A == other.codigo1A &&
        codigo1B == other.codigo1B &&
        codigo2A == other.codigo2A &&
        codigo2B == other.codigo2B &&
        codigo3A == other.codigo3A &&
        codigo3B == other.codigo3B &&
        ladoA == other.ladoA &&
        cliente == other.cliente &&
        nrcaixa == other.nrcaixa &&
        data == other.data &&
        classebd == other.classebd &&
        local == other.local &&
        operacaobd == other.operacaobd &&
        ladoB == other.ladoB;
  }

  @override
  int get hashCode => const ListEquality().hash([
        codigo1A,
        codigo1B,
        codigo2A,
        codigo2B,
        codigo3A,
        codigo3B,
        ladoA,
        cliente,
        nrcaixa,
        data,
        classebd,
        local,
        operacaobd,
        ladoB
      ]);
}

JmcinsertdatabaseStruct createJmcinsertdatabaseStruct({
  String? codigo1A,
  String? codigo1B,
  String? codigo2A,
  String? codigo2B,
  String? codigo3A,
  String? codigo3B,
  String? ladoA,
  String? cliente,
  int? nrcaixa,
  DateTime? data,
  String? classebd,
  String? local,
  String? operacaobd,
  String? ladoB,
}) =>
    JmcinsertdatabaseStruct(
      codigo1A: codigo1A,
      codigo1B: codigo1B,
      codigo2A: codigo2A,
      codigo2B: codigo2B,
      codigo3A: codigo3A,
      codigo3B: codigo3B,
      ladoA: ladoA,
      cliente: cliente,
      nrcaixa: nrcaixa,
      data: data,
      classebd: classebd,
      local: local,
      operacaobd: operacaobd,
      ladoB: ladoB,
    );
