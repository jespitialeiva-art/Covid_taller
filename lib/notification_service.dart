import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notificaciones = FlutterLocalNotificationsPlugin();

// Preparar las notificaciones
Future<void> iniciarNotificaciones() async {
  const android = AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  const configuracion = InitializationSettings(
    android: android,
  );

  await notificaciones.initialize(
    settings: configuracion,
  );

  await notificaciones
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}

// Mostrar una notificación
Future<void> mostrarNotificacion(
  String pais,
  int casos,
) async {
  const detalles = AndroidNotificationDetails(
    'covid_canal',
    'Notificaciones COVID',
    importance: Importance.high,
    priority: Priority.high,
  );

  await notificaciones.show(
    id: 1,
    title: 'COVID-19 en $pais',
    body: 'Casos registrados: $casos',
    notificationDetails: const NotificationDetails(
      android: detalles,
    ),
  );
}