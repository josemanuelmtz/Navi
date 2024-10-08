# Navi
# Medication Reminder for Smartwatch

## Enunciado de Visión
El objetivo de este proyecto es desarrollar una aplicación de recordatorios de medicamentos para smartwatches que ayude a los usuarios a gestionar su medicación de manera efectiva y puntual. La aplicación permitirá a los usuarios programar recordatorios, recibir notificaciones y llevar un registro de las dosis tomadas, mejorando así la adherencia al tratamiento y la salud general.

## Hardware Empleado
- ESP32
- MAX30102 - Pulso

## Software Empleado
- *Lenguaje de Programación*: Dart (usando Flutter)
- *IDE*: Android Studio, Visual Studio Code
- *Frameworks y Librerías*:
  - Flutter (para desarrollo de aplicaciones móviles y de smartwatch)
  - Provider (para gestión de estado)
  - SQLite (para almacenamiento local)
  - Flutter Local Notifications (para gestionar notificaciones)
  - Firebase (opcional, para sincronización de datos y autenticación)

## Hardware Empleado
- *Smartwatch*: Compatible con Wear OS o Apple Watch
- *Smartphone*: Para configuración inicial y sincronización de datos

## Historias de Usuario

### Historia de Usuario 1: Programación de Medicamentos
*Como usuario, quiero poder programar recordatorios para mis medicamentos, **para* asegurarme de no olvidar tomar mis dosis a tiempo.

*Criterios de aceptación*:
- El usuario puede añadir un nuevo medicamento especificando el nombre, dosis, frecuencia y horario.
- El usuario puede ver una lista de los medicamentos programados.

### Historia de Usuario 2: Notificaciones de Medicamentos
*Como usuario, quiero recibir notificaciones en mi smartwatch cuando sea hora de tomar mi medicamento, **para* no perder ninguna dosis.

*Criterios de aceptación*:
- El smartwatch envía una notificación con una alerta cuando es hora de tomar un medicamento.
- El usuario puede marcar la dosis como tomada directamente desde la notificación.

### Historia de Usuario 3: Historial de Medicamentos
*Como usuario, quiero llevar un registro de las dosis que he tomado, **para* poder revisar mi adherencia al tratamiento.

*Criterios de aceptación*:
- El usuario puede ver un historial de las dosis tomadas y las que han sido saltadas.
- El historial muestra la fecha y hora de cada dosis.

## Ruta del Tablero con el Acceso por Parte del Docente
Para seguir el desarrollo del proyecto y revisar el progreso de las tareas, puede acceder a nuestro tablero de gestión en Trello a través del siguiente enlace:

[Trello Board - Medication Reminder for Smartwatch](https://trello.com/invite/b/GvGM95fy/ATTI72d3b2f522cfb91c8284b2b3933c2f97AC43CC52/navi)

## Diseños de la aplicación
![Sin título](https://github.com/josemanuelmtz/Navi/assets/105257367/416e85e1-6ac4-4cad-91ef-a7d8a0a8d26e)
![Sin título](https://github.com/josemanuelmtz/Navi/assets/105257367/912fb12e-2a21-4720-be58-702a16fc0a6c)
![Sin título](https://github.com/josemanuelmtz/Navi/assets/105257367/95fb9580-9b05-4c46-819a-7a2c07e8a834)

## Integrantes
- José Manuel Martínez García
- Cristian Uriel Camacho Pérez
- Oscar Ricardo Villegas Martínez
- Alan Manuel Mendoza Arredondo
---

# Documentación

A continuación, se presentan las secciones de la documentación relacionadas con los distintos componentes del proyecto. Haz clic en cada uno de los temas para acceder al `README.md` correspondiente.

## [Flutter](https://github.com/josemanuelmtz/Navi/blob/main/navi/doc-appFlutter/Documentacion-Flutter.md)

Este módulo cubre la implementación de la aplicación utilizando el framework Flutter, incluyendo la configuración del entorno, la estructura del proyecto y las funcionalidades desarrolladas.

## [Broker Flutter](https://github.com/josemanuelmtz/Navi/blob/main/navi/doc-brokerFlutter/Documentacion-Broker.md)

En esta sección se documentan los problemas y soluciones relacionadas con la integración de Flutter en el proyecto. Se incluye un análisis detallado de los errores comunes y cómo solucionarlos.

## [ESP32](https://github.com/josemanuelmtz/Navi/blob/main/navi/doc-esp32/Documentacion-ESP32.md)

Aquí se detalla la implementación del microcontrolador ESP32 en el proyecto, incluyendo la configuración de los pines, la conexión de sensores y el código fuente utilizado para controlar el hardware.

## [Dashboard](https://github.com/josemanuelmtz/Navi/blob/main/navi/doc-dashboard/Documentacion-Dashboard.md)

En esta sección se cubre la creación y personalización del dashboard para la visualización de datos. Se incluye información sobre las tecnologías utilizadas y cómo se integran los diferentes módulos para mostrar la información en tiempo real.

# Aplicación Navi 

A continuación, agregamos el link para observar el video donde explicamos como funciona la aplicación y presentamos detalles.

## [Video](https://youtu.be/kEZiGtR2kCQ?si=PU9Wn-YxKiIhxpJg)


Gracias por su atención. Para cualquier duda o sugerencia, no dude en contactar con el equipo de desarrollo
