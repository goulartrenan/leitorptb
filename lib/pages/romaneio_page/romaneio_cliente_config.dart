/// Configuração de clientes para o Romaneio de Conversão.
///
/// Cada cliente define como extrair o número da etiqueta (PARA) do
/// código de barras lido pelo scanner.
///
/// O código DE (Premium) é sempre extraído com substring(7, 12)
/// e **não** depende desta configuração.
///
/// Para adicionar um novo cliente, basta incluir uma nova entrada
/// em [clientesRomaneio] com a regra de extração correta.

class ClienteRomaneioConfig {
  /// Nome exibido na tela e nos dados gravados
  final String nome;

  /// Comprimento mínimo do código de barras do CLIENTE (validação do PARA)
  final int comprimentoMinimo;

  /// Extrai o número da etiqueta do cliente a partir do código bruto.
  /// Lança [FormatException] se o código não atender aos requisitos.
  final String Function(String raw) extrairCodigoPara;

  const ClienteRomaneioConfig({
    required this.nome,
    required this.comprimentoMinimo,
    required this.extrairCodigoPara,
  });
}

// ---------------------------------------------------------------------------
// Regras por cliente — baseadas no documento "Relação códigos de barra"
// ---------------------------------------------------------------------------
//
// CONVENÇÃO DE ÍNDICES (Dart substring):
//   substring(a, b)  →  caracteres nas posições a até b-1  (base-0)
//   "a partir do Nº caractere" no doc  →  substring(N-1)
//   "do Nº ao Mº caractere"   no doc  →  substring(N-1, M)
// ---------------------------------------------------------------------------

final List<ClienteRomaneioConfig> clientesRomaneio = [
  // ── BAT ─────────────────────────────────────────────────────────────────
  // Exemplo: 2401034533B100000000819
  // A partir do 14º caractere → substring(13)
  ClienteRomaneioConfig(
    nome: 'BAT',
    comprimentoMinimo: 14,
    extrairCodigoPara: (raw) {
      if (raw.length < 14)
        throw FormatException('Código curto demais para BAT (mín. 14)');
      return raw.substring(13).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── KAPNOS / ITMS — Tipo 1 ───────────────────────────────────────────────
  // Exemplo: 2401034533B100000000595
  // A partir do 14º caractere → substring(13)
  ClienteRomaneioConfig(
    nome: 'KAPNOS / ITMS (Tipo 1)',
    comprimentoMinimo: 14,
    extrairCodigoPara: (raw) {
      if (raw.length < 14)
        throw FormatException(
            'Código curto demais para KAPNOS Tipo 1 (mín. 14)');
      return raw.substring(13).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── KAPNOS / ITMS — Tipo 2 ───────────────────────────────────────────────
  // Exemplo: 2402510013110000000000130200
  // Entre os caracteres 14° e 23° → substring(13, 23)
  ClienteRomaneioConfig(
    nome: 'KAPNOS / ITMS (Tipo 2)',
    comprimentoMinimo: 23,
    extrairCodigoPara: (raw) {
      if (raw.length < 23)
        throw FormatException(
            'Código curto demais para KAPNOS Tipo 2 (mín. 23)');
      return raw.substring(14, 24).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── DJARUM — Tipo 1 ─────────────────────────────────────────────────────
  // Exemplo: 24BRVBMO300001
  // A partir do 9º caractere → substring(8)
  ClienteRomaneioConfig(
    nome: 'DJARUM (Tipo 1)',
    comprimentoMinimo: 9,
    extrairCodigoPara: (raw) {
      if (raw.length < 9)
        throw FormatException(
            'Código curto demais para DJARUM Tipo 1 (mín. 9)');
      return raw.substring(10).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── DJARUM — Tipo 2 ─────────────────────────────────────────────────────
  // Exemplo: 23BRSBLS000001
  // A partir do 10º caractere → substring(9)
  ClienteRomaneioConfig(
    nome: 'DJARUM (Tipo 2)',
    comprimentoMinimo: 10,
    extrairCodigoPara: (raw) {
      if (raw.length < 10)
        throw FormatException(
            'Código curto demais para DJARUM Tipo 2 (mín. 10)');
      return raw.substring(10).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── IMPERIAL / ITV / GHT ─────────────────────────────────────────────────
  // Exemplo: 00001
  // A partir do 1º caractere → o código inteiro (sem zeros à esquerda)
  ClienteRomaneioConfig(
    nome: 'IMPERIAL / ITV / GHT',
    comprimentoMinimo: 1,
    extrairCodigoPara: (raw) {
      if (raw.isEmpty)
        throw FormatException('Código vazio para IMPERIAL/ITV/GHT');
      return raw.replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── JTI ──────────────────────────────────────────────────────────────────
  // Exemplo: 13562329.0015019060.19000.000001
  // A partir do 21º caractere → substring(20)
  ClienteRomaneioConfig(
    nome: 'JTI',
    comprimentoMinimo: 21,
    extrairCodigoPara: (raw) {
      if (raw.length < 21)
        throw FormatException('Código curto demais para JTI (mín. 21)');
      return raw.substring(27).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── KT&G ─────────────────────────────────────────────────────────────────
  // Exemplo: 043802257250000012000
  // Entre os caracteres 12° e 17° → substring(11, 17)
  ClienteRomaneioConfig(
    nome: 'KT&G',
    comprimentoMinimo: 17,
    extrairCodigoPara: (raw) {
      if (raw.length < 17)
        throw FormatException('Código curto demais para KT&G (mín. 17)');
      return raw.substring(11, 17).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── KTI ──────────────────────────────────────────────────────────────────
  ClienteRomaneioConfig(
    nome: 'KTI',
    comprimentoMinimo: 20,
    extrairCodigoPara: (raw) {
      if (raw.length < 20)
        throw FormatException('Código curto demais para KTI (mín. 20)');
      return raw.substring(17, 20).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── Regie Libanaise ──────────────────────────────────────────────────────
  ClienteRomaneioConfig(
    nome: 'Regie Libanaise',
    comprimentoMinimo: 21,
    extrairCodigoPara: (raw) {
      if (raw.length < 21)
        throw FormatException(
            'Código curto demais para Regie Libanaise (mín. 21)');
      return raw.substring(19, 21).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── RJR ──────────────────────────────────────────────────────────────────
  ClienteRomaneioConfig(
    nome: 'RJR',
    comprimentoMinimo: 15,
    extrairCodigoPara: (raw) {
      if (raw.length < 15)
        throw FormatException('Código curto demais para RJR (mín. 15)');
      return raw.substring(11, 15).replaceAll(RegExp(r'^0+'), '');
    },
  ),

  // ── TPIF ─────────────────────────────────────────────────────────────────
  ClienteRomaneioConfig(
    nome: 'TPIF',
    comprimentoMinimo: 9,
    extrairCodigoPara: (raw) {
      if (raw.length < 9)
        throw FormatException('Código curto demais para TPIF (mín. 9)');
      return raw.substring(5, 9).replaceAll(RegExp(r'^0+'), '');
    },
  ),
];
