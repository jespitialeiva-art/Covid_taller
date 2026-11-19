# Taller Flutter - COVID-19

## Descripción

Esta aplicación fue desarrollada en Flutter como parte de
un taller práctico de consumo de APIs y notificaciones locales.

Permite consultar estadísticas de COVID-19 de diferentes
países y enviar una notificación con los resultados.

## Funcionalidades

- Seleccionar un país.
- Consultar estadísticas de COVID-19.
- Mostrar casos acumulados y casos del día.
- Mostrar muertes y recuperados.
- Mostrar la fecha de actualización.
- Enviar una notificación local en Android.
- Mostrar un mensaje de error cuando no hay internet.

## Tecnologías utilizadas

- Flutter y Dart.
- API pública disease.sh.
- Paquete http para consultar la API.
- Paquete flutter_local_notifications para las notificaciones.
- Paquete intl para mostrar las fechas.

## Estructura del proyecto

lib/
- main.dart: interfaz principal de la aplicación.
- covid_api.dart: consulta los datos de internet.
- covid_data.dart: organiza la información recibida.
- notification_service.dart: controla las notificaciones.

## ¿Cómo funciona?

1. El usuario abre la aplicación.
2. Selecciona un país.
3. Presiona el botón "Consultar estadísticas".
4. La aplicación consulta la API de COVID-19.
5. Los resultados aparecen en pantalla.
6. El usuario puede presionar "Enviar notificación"
   para recibir un resumen en su celular.

## API utilizada

https://disease.sh/v3/covid-19/countries/colombia

Los datos pueden ser históricos.

## Pruebas realizadas

- Se instaló la aplicación en un celular Android.
- Se consultaron estadísticas de diferentes países.
- Se comprobó el funcionamiento de las notificaciones.
- Se probó el manejo de errores sin conexión a internet.
- Se generó correctamente un APK mediante GitHub Actions.

## Conclusión

Con este taller aprendí a consumir una API pública en Flutter,
mostrar los datos recibidos y enviar notificaciones locales
en un dispositivo Android.

También aprendí a organizar el código en diferentes archivos
y a generar un APK utilizando GitHub Actions.
