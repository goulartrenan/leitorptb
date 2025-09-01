import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class AdicionarDadosConferenciaCall {
  static Future<ApiCallResponse> call({
    dynamic dadosJMCJson,
  }) async {
    final dadosJMC = _serializeJson(dadosJMCJson, true);

    return ApiManager.instance.makeApiCall(
      callName: 'Adicionar Dados Conferencia',
      apiUrl: 'http://192.168.0.159:5000/api/conferencia',
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
