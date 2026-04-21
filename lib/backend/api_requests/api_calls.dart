import 'dart:convert';
import 'package:flutter/foundation.dart';
//import 'package:flutter/src/widgets/editable_text.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class AdicionarDadosConferenciaCall {
  static Future<ApiCallResponse> call({
    dynamic dadosJMCJson,
  }) async {
    final dadosJMC = _serializeJson(dadosJMCJson, true);

    return ApiManager.instance.makeApiCall(
      callName: 'Adicionar Dados Conferencia',
      apiUrl: 'http://192.168.0.15:5000/api/conferencia',
      callType: ApiCallType.POST,
      headers: {
        'content-type': 'application/json',
      },
      params: {},
      body: dadosJMC,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class BuscarLotesEmbarqueCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'Buscar Lotes Embarque',
      apiUrl: 'http://192.168.0.15:5000/api/lote-embarque',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'application/json',
      },
      params: {},
      returnBody: true,
      cache: false,
      isStreamingApi: false,
    );
  }
}

class BuscarClassesProducaoCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'Buscar Classes de Produção',
      apiUrl: 'http://192.168.0.15:5000/api/classes-producao',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'application/json',
      },
      params: {},
      returnBody: true,
      cache: false,
      isStreamingApi: false,
    );
  }
}

class ListarCaixasConferenciaCall {
  static Future<ApiCallResponse> call({
    required String cliente,
    String? termo,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Listar Caixas de Conferência',
      apiUrl: 'http://192.168.0.15:5000/api/conferencia/caixas',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'application/json',
      },
      params: {
        'cliente': cliente,
        if (termo != null) 'termo': termo,
      },
      returnBody: true,
      cache: false,
      isStreamingApi: false,
    );
  }
}

class DetalhesCaixaConferenciaCall {
  static Future<ApiCallResponse> call({
    required String cliente,
    required String caixa,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Detalhes Caixa Conferência',
      apiUrl: 'http://192.168.0.15:5000/api/conferencia/detalhes',
      callType: ApiCallType.GET,
      headers: const {},
      params: {
        'cliente': cliente,
        'caixa': caixa,
      },
      returnBody: true,
      cache: false,
      isStreamingApi: false,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      bodyType: BodyType.JSON,
      alwaysAllowBody: false,
    );
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

class AdicionarRomaneioConvercaoCall {
  static Future<ApiCallResponse> call({
    required int caixaDE,
    required int caixaPARA,
    required String lote,
    String? nomeClasse,
    required int codClasse,
    required int qtdeCaixaClasse,
    required String operacao,
    String? observacao,
    DateTime? data,
    required int codBarras,
  }) async {
    final bodyMap = <String, dynamic>{
      'CaixaDE': caixaDE,
      'CaixaPARA': caixaPARA,
      'Lote': lote.trim(),
      if (nomeClasse != null && nomeClasse.trim().isNotEmpty)
        'NomeClasse': nomeClasse.trim(),
      'CodClasse': codClasse,
      'QtdeCaixaClasse': qtdeCaixaClasse,
      'Operacao': operacao.trim(),
      if (observacao != null && observacao.trim().isNotEmpty)
        'Observacao': observacao.trim(),
      if (data != null) 'Data': data.toIso8601String(),
      'CodBarras': codBarras,
    };

    return ApiManager.instance.makeApiCall(
      callName: 'Adicionar Romaneio Convercao',
      apiUrl: 'http://192.168.0.15:5000/api/romaneio-convercao',
      callType: ApiCallType.POST,
      headers: {
        'content-type': 'application/json',
      },
      params: const {},
      body: json.encode(bodyMap),
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ReprocessarConferenciaCall {
  static Future<ApiCallResponse> call({
    dynamic payloadJson,
  }) async {
    final payload = _serializeJson(payloadJson, true);

    return ApiManager.instance.makeApiCall(
      callName: 'Reprocessar Conferência',
      apiUrl: 'http://192.168.0.15:5000/api/conferencia/reprocessar',
      callType: ApiCallType.POST,
      headers: const {
        'content-type': 'application/json',
      },
      params: const {},
      body: payload,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      // Se o teu ApiManager exigir, pode manter false.
      alwaysAllowBody: true,
    );
  }
}
