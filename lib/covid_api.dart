import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> consultarCovid(String pais) async {
  final url = Uri.parse(
    'https://disease.sh/v3/covid-19/countries/$pais',
  );

  final respuesta = await http.get(url);

  if (respuesta.statusCode == 200) {
    return jsonDecode(respuesta.body);
  } else {
    throw Exception('No se pudieron obtener los datos');
  }
}