# Pong-Game-Project
Desarrollo de una versión del video juego Pong controlado a partir de la detección de movimientos del jugador


Como indica el titulo se trata de diseñar un simulador del clásico juego Pong que tenga periféricos basados en las señales de movimientos corporales como controles. Este juego de dos dimensiones consiste en un tenis de mesa virtual , donde el jugador controla una paleta moviéndola verticalmente para pegarle a la pelota hacia un lado u otro. Si el jugador no logra alcanzar la pelota antes que sobrepase la paleta pierde.

Los sensores a usar en este proyecto son: un acelerometro de dos ejes, un fotodiodo y un pulsador. Con respecto a la adquisicion de señales obtenidas por los sensores, se usara un microcontrolador DEMOQE con CODEWARRIOR - Processor Expert.Se utilizará el software Processing para recrear el juego Pong de forma que se pueda apreciar visualmente el manejo de las señales obtenidas a través de sensores analógicos y digitales implementados desde la mano del usuario. 

Con el acelerometro, el usuario acciona el movimiento de la paleta a traves de movimientos angulares, es decir , la mano del usuario rotará sobre  los ejes X e Y para hacer que la paleta se mueva de manera horizontal o vertical respectivamente. Dado a que es extremadamente complejo tratar de hayar la posicion de un objeto a traves de la integracion de la gravedad como aceleracion, se opto por la tecnica mencionada anteriormente. 

El fotodiodo y el pulsador se usaran como sensores digitales. Estos actuaran como interruptores para activar cosas especiales en el juego o simplemente para navegar en el menu de opciones.

El juego contará con un menú de opciones: Jugar, Reiniciar partida, Salir. Para la selección se hará uso de dos switches, uno para desplazarse entre las opciones, de forma que cada vez que sea presionado pase a la siguiente opción en un bucle hasta que se seleccione la opción deseada, esto ocurrirá cuando se presiona el segundo switch. Mientras se está en el juego si es presionado este último switch saltará al menú. Sí en este caso se presiona la opción Jugar se continúa en la partida en proceso; si se selecciona Reiniciar partida, se reinicia el marcador del juego, y al presionar Salir, cierra el juego.

