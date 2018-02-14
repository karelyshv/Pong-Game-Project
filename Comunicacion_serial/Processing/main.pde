import processing.serial.*;

Serial puerto;
String data = null;
int header, most1, least1, high, low, data1, D1, D2, ValorY , X;
float inByte = 0;


void setup(){
  puerto = new Serial(this, Serial.list()[0], 115200); //El [0] se cambia segun el puerto en cuestion
  size(1000,500);
  frameRate(30);   // Define cantidad de cuadros por segundo que muestra en la grafica
  puerto.clear();  // Se elimina la primera lectura, en caso de que se haya comenzado a leer en el medio de una cadena
}

void draw(){

  while(puerto.available() > 0){
    header = puerto.read();    //lee el header F1=241
    most1 = puerto.read();     //lee los 8 bits mas significativos
    least1 = puerto.read();    //lee los 8 bits menos significativos
    D1 = most1>>6;
    D2 = (most1>>5)&1;
    println(header);
    println(D1);
    println(D2);
    println("los bits mas significativos:",most1);
    println("los bits menos significativos son:",least1);
    high = most1 & 31;        //[0 D1 D2 A1 A2 A3 A4 A5]&[00011111]=[000HHHHH]
    ValorY = conversion(high, least1);
    graficar(ValorY,X);  //Grafica el punto indicado
    X++;  //Incrementa la posición en el eje X de la grafica
  }
}

int conversion(int valor1, int valor2){
  high = valor1<<7;               //Shifteo hacia la izquierda [HHHHH0000000]
  low  = valor2;
  data1 = high|low;               //Para obtener la data1 (valor de 16 bits) en decimal uso or [HHHHH0000000]|[0LLLLLLL]=[HHHHHLLLLLLL]
  println(data1);
  return data1;
}

void graficar (int Y, int X){
  strokeWeight (4); // grosor del trazo
  strokeCap (PROJECT); //estilo de bordes proyect extendido, round redondeado, square cuadrado
  Y = (height/2) + Y  ; // Para definir eje cero a media altura
  point(X,Y);
  if (X > width) {    //Reinicie la grafica a la izquierda cuando llegue al extemo derecho
    X = 0;
    background(270);  // Quite la imagen de lo que se tenia de la grafica hasta el momento
    } 
}
