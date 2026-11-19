import 'package:material_ui/material_ui.dart';
import 'covid_api.dart';

void main() {
  runApp(const CovidApp());
}

class CovidApp extends StatelessWidget {
  const CovidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const CovidHomePage(),
    );
  }
}

class CovidHomePage extends StatefulWidget {
  const CovidHomePage({super.key});

  @override
  State<CovidHomePage> createState() => _CovidHomePageState();
}

class _CovidHomePageState extends State<CovidHomePage> {
  String paisSeleccionado = 'Colombia';
  Map<String, dynamic>? datosCovid;
String mensaje = '';

  final List<String> paises = [
    'Colombia',
    'Mexico',
    'Argentina',
    'Brazil',
    'Spain',
    'USA',
  ];

  Future<void> buscarDatos() async {
  try {
    final datos = await consultarCovid(paisSeleccionado);

    setState(() {
      datosCovid = datos;
      mensaje = '';
    });
  } catch (e) {
    setState(() {
      datosCovid = null;
      mensaje = 'Error al consultar los datos';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Tracker'),
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.coronavirus,
              size: 90,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              'Estadísticas de COVID-19',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Selecciona un país:',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              initialValue: paisSeleccionado,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: paises.map((pais) {
                return DropdownMenuItem(
                  value: pais,
                  child: Text(pais),
                );
              }).toList(),
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    paisSeleccionado = valor;
                  });
                }
              },
            ),

            const SizedBox(height: 25),

ElevatedButton.icon(
  onPressed: buscarDatos,
  icon: const Icon(Icons.search),
  label: const Text('Consultar estadísticas'),
),

            const SizedBox(height: 20),

           if (mensaje.isNotEmpty)
  Text(mensaje),

if (datosCovid != null) ...[
  Text('País: ${datosCovid!['country']}'),
  Text('Casos: ${datosCovid!['cases']}'),
  Text('Muertes: ${datosCovid!['deaths']}'),
  Text('Recuperados: ${datosCovid!['recovered']}'),
],
          ],
        ),
      ),
    );
  }
}