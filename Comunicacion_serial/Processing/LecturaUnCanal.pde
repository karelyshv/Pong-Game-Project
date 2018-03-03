import processing.serial.*;

Serial puerto;
int bitsMost, bitsLeast, high, low, D1, D2, X = 0, N, i, Num, M, valor;

void setup(){
  puerto = new Serial(this, Serial.list()[0], 115200); //El [0] se cambia segun el puerto en cuestion
  size(800,400);     //Dimensiones de ventana (width, height)
  frameRate(30);    // Define cantidad de cuadros por segundo que muestra en la grafica
  grid();
}

void draw(){

  while(puerto.available() > 0){
    
    M = 0;                     //Contador de arreglo ordenado  ArrayOrdered
    i = 0;                     //Contador de arreglo de data   ArrayData
    Num = puerto.available();             //Tamaño arreglo de lectura ArrayRead
    int[] ArrayRead = new int[Num];
    int[] ArrayOrdered = new int[Num-Num/3];
    
    //*****Se guarda en un arreglo lo leído por puerto serial
    for (int N = 0; N < Num; N = N+1){
      ArrayRead[N] = puerto.read();
      //println(ArrayRead[N]);
    }
    
    //******Se ordena el arreglo sin los encabezados
    for (int N = 0; N < Num - 2; N = N + 1){
     if(ArrayRead[N] == 241 && ArrayRead[N+1] != 241){
       ArrayOrdered[M] = ArrayRead[N+1];
       M = M + 1;
       if(ArrayRead[N+2] != 241){
         ArrayOrdered[M] = ArrayRead[N+2];
         M = M + 1;
       }
      }
    }
    
    int[] ArrayData = new int[M/2];
    
    //println("M = " + M);
    //println("Ordenado:");
    //println(ArrayOrdered);
    
    //***Se define las tramas de interes y se decodifican
    for (int N = 0; N < M - 1 ; N = N+2){
      bitsMost = ArrayOrdered[N];        //Trama con los 8 bits mas significativos
      bitsLeast = ArrayOrdered[N+1];                 //Trama con los 8 bits menos significativos
      D1 = (bitsMost>>6)&1;                          //Se toma solo el bit de la señal del sensor digital 1   D1
      D2 = (bitsMost>>5)&1;      //Se toma solo el bit de la señal del sensor digital 2   D2
      bitsMost = bitsMost & 31;                      //Se toma los 5 bist correspondiente a la señal analógica
      ArrayData[i] = conversion(bitsMost,bitsLeast); //Decodifica y concatena las tramas
      //println(ArrayData[i],D1,D2);
      
      //***Graficar dato en el arreglo siempre que no se -1
                                      
        int grafic = (int)map(ArrayData[i], 0, 4000, 200, 60);
        strokeWeight (3);                                           // grosor del trazo
        stroke(0);                                                  // trazo color negro
        point(X,grafic);                                            //Grafica punto indicado   

      println("D1 = "+D1,"  D2 = "+D2,"   (X,Y) = ( " +X," , " +ArrayData[i], ")");
      X = X + 1;           //Contador de eje X de la gráfica
      
      //***Reinicie la grafica a la izquierda cuando llegue al extemo derecho
      if(X >= 600){ //width     
      X = 0;
      grid();           //Redibuja fondo para quitar la grafica que se tenia hasta el momento hasta el momento
      }
      i = i + 1;          //Contador de escritura en Arreglo de datos   ArrayData
    }
    
    //println("Data :");
    //println(ArrayData);
  }
}

int conversion(int valor1, int valor2){
  high = valor1<<7;       //Shifteo hacia la izquierda [HHHHH0000000]
  low  = valor2;
  valor = high|low;       //Para obtener la data (valor de 16 bits) en decimal uso or [HHHHH0000000]|[0LLLLLLL]=[HHHHHLLLLLLL]
  return valor;
}

void grid() {
  background(255);                 // Fondo de color blanco
  for (int i = 0; i <= width-50; i += 100) {
    //fill(0, 0, 0);               // Letras negras
    //text(i/2, i-10, height-15);  // Texto, coord X, Coord Y
    stroke(204);                     // Lineas verticales negras
    strokeWeight (1);     // grosor del trazo
    line(i, height, i, 0);
  }
  for (int j = 0; j < height; j += 100) {
   // fill(0, 0, 0);                 // Letras negras
    //text(5-j/(height/10), 5, j); // Texto, coord X, Coord Y
    strokeWeight (1);     // grosor del trazo
    stroke(204);                     // Lineas horizontales negras
    line(15, j, width, j);
  }
}
