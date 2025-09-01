// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CadastrojmcStruct extends BaseStruct {
  CadastrojmcStruct({
    String? classejmc,
    String? operacaojmc,
  })  : _classejmc = classejmc,
        _operacaojmc = operacaojmc;

  // "classejmc" field.
  String? _classejmc;
  String get classejmc => _classejmc ?? '-';
  set classejmc(String? val) => _classejmc = val;

  bool hasClassejmc() => _classejmc != null;

  // "operacaojmc" field.
  String? _operacaojmc;
  String get operacaojmc => _operacaojmc ?? '-';
  set operacaojmc(String? val) => _operacaojmc = val;

  bool hasOperacaojmc() => _operacaojmc != null;

  static CadastrojmcStruct fromMap(Map<String, dynamic> data) =>
      CadastrojmcStruct(
        classejmc: data['classejmc'] as String?,
        operacaojmc: data['operacaojmc'] as String?,
      );

  static CadastrojmcStruct? maybeFromMap(dynamic data) => data is Map
      ? CadastrojmcStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'classejmc': _classejmc,
        'operacaojmc': _operacaojmc,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'classejmc': serializeParam(
          _classejmc,
          ParamType.String,
        ),
        'operacaojmc': serializeParam(
          _operacaojmc,
          ParamType.String,
        ),
      }.withoutNulls;

  static CadastrojmcStruct fromSerializableMap(Map<String, dynamic> data) =>
      CadastrojmcStruct(
        classejmc: deserializeParam(
          data['classejmc'],
          ParamType.String,
          false,
        ),
        operacaojmc: deserializeParam(
          data['operacaojmc'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CadastrojmcStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CadastrojmcStruct &&
        classejmc == other.classejmc &&
        operacaojmc == other.operacaojmc;
  }

  @override
  int get hashCode => const ListEquality().hash([classejmc, operacaojmc]);
}

CadastrojmcStruct createCadastrojmcStruct({
  String? classejmc,
  String? operacaojmc,
}) =>
    CadastrojmcStruct(
      classejmc: classejmc,
      operacaojmc: operacaojmc,
    );
