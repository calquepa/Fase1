Fase uno de la aplicación consistirá en una pantalla principal con un listado de tarjetas
que muestran información, una pantalla de detalles que muestra más información sobre un
elemento seleccionado y una pantalla de formulario para agregar nuevos elementos al listado.
La tecnologías utilizadas son Dart como lenguaje de desarrollo con Flutter como framework.

Para el desarrollo de la aplicacion se uso la arquitectura mvc;

El manejador de estados usado es BLOC.

Flujo de la Aplicación :
1. Usuario abre la aplicacion llevandolo a la pantalla principal donde se muestran las tarjetas almacenadas, con un contador de las tarjetas debajo del titulo de la vista
2. Al seleccionar alguna de las tarjetas mostradas en la pantalla principal esta navega a la vista de detalle donde nos muestra la info completa de la tarjeta con 2 botones
   en la parte inferior de la pantalla donde podemos eliminar la tarjeta y editar la informacion mostrada en la tarjeta
3. En la pantalla principal podemos ver en la parte superior un boton para agregar o crear una nueva tarjeta, presionandolo iremos a la vista donde podemos guardar un nuevo elemento.

