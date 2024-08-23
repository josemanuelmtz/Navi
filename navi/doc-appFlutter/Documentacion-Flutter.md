# Documentación de la Aplicación Flutter

## Descripción General
Esta aplicación Flutter ofrece una solución integrada para monitorear datos de sensores y gestionar recordatorios. A continuación, se detallan las características principales de la aplicación.

## Características Principales

### 1. DashBoard
El **DashBoard** es la pantalla principal donde se muestran los datos de los sensores en tiempo real. Las características incluyen:

- **Sensor de Ritmo Cardiaco**: Muestra el ritmo cardíaco del usuario con una animación que refleja los latidos del corazón.
- **Sensor de Temperatura**: Muestra la temperatura ambiente con un efecto de cambio de color que representa el cambio de temperatura.
- **Sensor de Humedad**: Muestra el nivel de humedad con una pequeña animación.

### 2. Añadir Recordatorios
La aplicación permite al usuario **añadir recordatorios** personalizados para recordar tomar sus medicamentos. Las características de esta sección incluyen:

- **Formulario para añadir recordatorios**: El formulario incluye campos para ingresar el nombre del recordatorio, cantidad, duración, unidad de duración, y ciclo.
- **Almacenamiento en MySQL**: Los recordatorios añadidos se almacenan en una base de datos MySQL, asegurando que los datos estén disponibles en cualquier momento.

### 3. Ver Lista de Recordatorios
La aplicación ofrece la opción de **ver una lista completa de recordatorios** añadidos. Las características de esta sección incluyen:

- **Lista de Recordatorios**: Muestra todos los recordatorios almacenados en la base de datos, permitiendo al usuario revisar o eliminar cualquier recordatorio.
- **Actualización en tiempo real**: Los cambios en los recordatorios se reflejan instantáneamente en la lista, garantizando que la información esté siempre actualizada.

## Tecnologías Utilizadas
- **Flutter**: Para la interfaz de usuario y lógica de la aplicación.
- **MySQL**: Para el almacenamiento de datos de recordatorios.
- **MQTT, Broker y Node-Red**: Para la comunicación en tiempo real con los sensores.

## Instalación
1. Clona el repositorio desde GitHub:
    ```sh
    git clone https://github.com/josemanuelmtz/Navi.git
    ```
2. Navega al directorio del proyecto:
    ```sh
    cd Navi
    ```
3. Instala las dependencias:
    ```sh
    flutter pub get
    ```
4. Conecta tu dispositivo o emulador y ejecuta la aplicación:
    ```sh
    flutter run
    ```

## Configuración Adicional
Para que la aplicación funcione correctamente, asegúrate de configurar las credenciales de acceso a la base de datos MySQL y a los servicios MQTT en el archivo de configuración correspondiente.