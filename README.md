# Pong-Game-Project
Desarrollo de una versión del video juego Pong controlado a partir de la detección de movimientos del jugador


Como indica el titulo se trata de diseñar un simulador del clásico juego Pong que tenga periféricos basados en las señales de movimientos corporales como controles. Este juego de dos dimensiones consiste en un tenis de mesa virtual (Figura 1), donde el jugador controla una paleta moviéndola verticalmente para pegarle a la pelota hacia un lado u otro, si el jugador no logra alcanzar la pelota antes que sobrepase la paleta pierde.
 
Se utilizará el software Processing para recrear el juego Pong de forma que se pueda apreciar visualmente el manejo de las señales obtenidas a través de sensores analógicos y digitales implementados desde la mano del usuario.

También se contará con un acelerómetro de tres ejes ubicado en el dorso de la mano del jugador. Debido a que la mano rotará sobre  los ejes X e Y para diferenciar si la paleta se mueve horizontalmente o verticalmente , se requiere un acelerómetro de 2 ejes En función a esto, el usuario acciona el movimiento de la paleta a traves de movimientos angulares del acelerometro. Dado a que es extremadamente complejo tratar de hayar la posicion de un objeto a traves la integracion de la gravedad como aceleracion, se opto por la tecnica mencionada anteriormente. 

El juego contará con un menú de opciones: Jugar, Reiniciar partida, Salir. Para la selección se hará uso de dos switches, uno para desplazarse entre las opciones, de forma que cada vez que sea presionado pase a la siguiente opción en un bucle hasta que se seleccione la opción deseada, esto ocurrirá cuando se presiona el segundo switch. Mientras se está en el juego si es presionado este último switch saltará al menú. Sí en este caso se presiona la opción Jugar se continúa en la partida en proceso; si se selecciona Reiniciar partida, se reinicia el marcador del juego, y al presionar Salir, cierra el juego.
