
import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';

import 'covid_api.dart';
import 'covid_data.dart';
import 'notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await iniciarNotificaciones();
  }

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
  CovidData? datosCovid;
  String mensaje = '';
  bool cargando = false;

  final List<String> paises = [
    'Colombia',
    'Mexico',
    'Argentina',
    'Brazil',
    'Spain',
    'USA',
  ];

  // Consultar la API
  Future<void> buscarDatos() async {
    setState(() {
      cargando = true;
      mensaje = '';
      datosCovid = null;
    });

    try {
      final datos = await consultarCovidModelo(paisSeleccionado);

      if (!mounted) return;

      setState(() {
        datosCovid = datos;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        mensaje = 'Error al consultar los datos. Revisa tu internet.';
      });
    } finally {
      if (mounted) {
        setState(() {
          cargando = false;
        });
      }
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

      body: SingleChildScrollView(
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
                    datosCovid = null;
                    mensaje = '';
                  });
                }
              },
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: cargando ? null : buscarDatos,
              icon: const Icon(Icons.search),
              label: const Text('Consultar estadísticas'),
            ),

            const SizedBox(height: 20),

            // Mostrar carga
            if (cargando)
              const Center(
                child: CircularProgressIndicator(),
              ),

            // Mostrar error
            if (mensaje.isNotEmpty) ...[
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: buscarDatos,
                child: const Text('Reintentar'),
              ),
            ],

            // Mostrar estadísticas
            if (datosCovid != null) ...[
              const SizedBox(height: 10),

              Text(
                'País: ${datosCovid!.country}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text('Casos acumulados: ${datosCovid!.cases}'),
              Text('Casos del día: ${datosCovid!.todayCases}'),

              const SizedBox(height: 10),

              Text('Muertes acumuladas: ${datosCovid!.deaths}'),
              Text('Muertes del día: ${datosCovid!.todayDeaths}'),

              const SizedBox(height: 10),

              Text('Recuperados: ${datosCovid!.recovered}'),

              const SizedBox(height: 15),

              Text(
                'Actualizado: ${DateFormat('dd/MM/yyyy HH:mm').format(
                  datosCovid!.updated.toLocal(),
                )}',
              ),

              const SizedBox(height: 10),

              const Text(
                'Nota: los datos pueden ser históricos.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              // Notificaciones en Android
              if (!kIsWeb) ...[
                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    mostrarNotificacion(
                      datosCovid!.country,
                      datosCovid!.cases,
                    );
                  },
                  icon: const Icon(Icons.notifications),
                  label: const Text('Enviar notificación'),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
