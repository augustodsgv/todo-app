/**
 * Programa : back_end.dart
 * Descrição : programa que conecta à api do notion
 * Autor : Augusto dos Santos
 * Última edição : 21/05/2023
 */
///
import 'package:http/http.dart' as http;
import 'dart:convert';

// Constantes da API
const database = 'de6b05c4fbf34b3e92a74b7f1c380b6a';
const token = 'secret_zqkq44nNPRwIaHHVQGlk2dlVsGgUeyHR5XbFiUXRKF2';
final url = Uri.https('api.notion.com', '/v1/databases/$database/query');

Future<String> APIPost() async {
  const header = {
    'Authorization': 'Bearer $token',
    'Notion-Version': '2022-06-28'
  };

  var response = await http.post(url, headers: header);

  return response.body;
}
