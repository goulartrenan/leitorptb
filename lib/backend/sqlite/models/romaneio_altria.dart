// lib/models/romaneio_convercao.dart
import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class RomaneioConvercao {
  final int caixaDE;
  final int caixaPARA;
  final String lote;
  final String? nomeClasse;
  final int codClasse;
  final int qtdeCaixaClasse;
  final String operacao;
  final String? observacao;
  final int codBarras;
  final DateTime? data;

  const RomaneioConvercao({
    required this.caixaDE,
    required this.caixaPARA,
    required this.lote,
    this.nomeClasse,
    required this.codClasse,
    required this.qtdeCaixaClasse,
    required this.operacao,
    this.observacao,
    required this.codBarras,
    this.data,
  });

  Map<String, dynamic> toJsonMap(
      {bool omitNulls = true, bool serverDefinesDate = true}) {
    final map = <String, dynamic>{
      'CaixaDE': caixaDE,
      'CaixaPARA': caixaPARA,
      'Lote': lote.trim(),
      'CodClasse': codClasse,
      'QtdeCaixaClasse': qtdeCaixaClasse,
      'Operacao': operacao.trim(),
      'CodBarras': codBarras,
      'Data': data?.toIso8601String(),
    };

    if (!omitNulls || (nomeClasse != null && nomeClasse!.trim().isNotEmpty)) {
      map['NomeClasse'] = nomeClasse?.trim();
    }
    if (!omitNulls || (observacao != null && observacao!.trim().isNotEmpty)) {
      map['Observacao'] = observacao?.trim();
    }

    return map;
  }

  String toJsonString({bool omitNulls = true, bool serverDefinesDate = true}) =>
      jsonEncode(toJsonMap(
          omitNulls: omitNulls, serverDefinesDate: serverDefinesDate));

  RomaneioConvercao copyWith({
    int? caixaDE,
    int? caixaPARA,
    String? lote,
    String? nomeClasse,
    int? codClasse,
    int? qtdeCaixaClasse,
    String? operacao,
    String? observacao,
    int? codBarras,
    DateTime? data,
  }) {
    return RomaneioConvercao(
      caixaDE: caixaDE ?? this.caixaDE,
      caixaPARA: caixaPARA ?? this.caixaPARA,
      lote: lote ?? this.lote,
      nomeClasse: nomeClasse ?? this.nomeClasse,
      codClasse: codClasse ?? this.codClasse,
      qtdeCaixaClasse: qtdeCaixaClasse ?? this.qtdeCaixaClasse,
      operacao: operacao ?? this.operacao,
      observacao: observacao ?? this.observacao,
      codBarras: codBarras ?? this.codBarras,
      data: data ?? this.data,
    );
  }

  @override
  String toString() => 'RomaneioConvercao(${toJsonMap()})';
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RomaneioConvercao &&
          runtimeType == other.runtimeType &&
          caixaDE == other.caixaDE &&
          caixaPARA == other.caixaPARA &&
          lote == other.lote &&
          nomeClasse == other.nomeClasse &&
          codClasse == other.codClasse &&
          qtdeCaixaClasse == other.qtdeCaixaClasse &&
          operacao == other.operacao &&
          observacao == other.observacao &&
          codBarras == other.codBarras &&
          data == other.data;
  @override
  int get hashCode =>
      caixaDE.hashCode ^
      caixaPARA.hashCode ^
      lote.hashCode ^
      (nomeClasse?.hashCode ?? 0) ^
      codClasse.hashCode ^
      qtdeCaixaClasse.hashCode ^
      operacao.hashCode ^
      (observacao?.hashCode ?? 0) ^
      codBarras.hashCode ^
      (data?.hashCode ?? 0);
}
