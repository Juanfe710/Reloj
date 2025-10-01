# Reloj

Implementación de Reloj Analógico Dinámico en AutoCAD
Este código transforma el entorno de AutoCAD en un reloj analógico completamente funcional y dinámico, utilizando bloques para representar las manecillas del segundero, minutero y horario.

El mecanismo de funcionamiento se basa en la sincronización en tiempo real con la hora del sistema, siguiendo estos pasos clave:

Obtención de la hora: Se recuperan las horas, minutos y segundos actuales del sistema operativo.

Cálculo angular: A partir de la hora obtenida, se calculan los ángulos de rotación en radianes para cada manecilla, considerando su avance proporcional:

Segundero: Avanza π/30 radianes (6°) por cada segundo.

Minutero: Avanza π/30 radianes (6°) por cada minuto, más el desplazamiento fraccional correspondiente a los segundos.

Horario: Avanza π/6 radianes (30°) por cada hora, más la contribución proporcional de los minutos.

Actualización de la orientación: Los ángulos calculados se utilizan para actualizar la orientación de los bloques en el dibujo de AutoCAD, simulando la rotación de las manecillas en sentido horario.

Todo este proceso se ejecuta dentro de un ciclo que se repite cada segundo, garantizando que el reloj se mantenga sincronizado y operativo en tiempo real. En esencia, el código convierte AutoCAD, un software de diseño estático, en una plataforma dinámica capaz de reproducir fielmente el movimiento de un reloj analógico.

Se muestra a continuación el diagrama de flujo del respectivo código:

```mermaid
flowchart TD
    A[Inicio] --> B[Obtener hora actual del sistema]
    B --> C[Calcular ángulo del segundero en radianes]
    B --> D[Calcular ángulo del minutero en radianes]
    B --> E[Calcular ángulo del horario en radianes]
    C --> F[Actualizar bloque del segundero con ángulo]
    D --> G[Actualizar bloque del minutero con ángulo]
    E --> H[Actualizar bloque del horario con ángulo]
    F --> I[Esperar 1 segundo]
    G --> I
    H --> I
    I --> B


