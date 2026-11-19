
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'covid_data.dart';

// Consulta los datos y devuelve el JSON.
// Esta función la sigue usando nuestra aplicación.
Future<Map<String, dynamic>> consultarCovid(String pais) async {
  final url = Uri.parse(
    'https://disease.sh/v3/covid-19/countries/$pais',
  );

  final respuesta = await http.get(url).timeout(
    const Duration(seconds: 10),
  );

  if (respuesta.statusCode == 200) {
    return jsonDecode(respuesta.body) as Map<String, dynamic>;
  } else {
    throw Exception('No se pudieron obtener los datos');
  }
}

// Convierte el JSON en un objeto CovidData.
Future<CovidData> consultarCovidModelo(String pais) async {
  final datos = await consultarCovid(pais);
  return CovidData.fromJson(datos);
}
