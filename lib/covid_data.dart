
class CovidData {
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final DateTime updated;

  CovidData({
    required this.country,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.updated,
  });

  factory CovidData.fromJson(Map<String, dynamic> json) {
    int numero(dynamic valor) => (valor as num?)?.toInt() ?? 0;

    return CovidData(
      country: json['country'] ?? '',
      cases: numero(json['cases']),
      todayCases: numero(json['todayCases']),
      deaths: numero(json['deaths']),
      todayDeaths: numero(json['todayDeaths']),
      recovered: numero(json['recovered']),
      updated: DateTime.fromMillisecondsSinceEpoch(
        numero(json['updated']),
      ),
    );
  }
}
