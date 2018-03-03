import processing.serial.*;

Serial puerto;
int bitsMost, bitsLeast, X = 0, i, Num, valor;



void setup(){
  //puerto = new Serial(this, Serial.list()[0], 115200); //El [0] se cambia segun el puerto en cuestion
  puerto = new Serial(this, "COM6", 115200);
  size(800,400);     //Dimensiones de ventana (width, height)
  frameRate(30);    // Define cantidad de cuadros por segundo que muestra en la grafica
  grid();
}

void draw(){

  while(puerto.available() > 0){
    Num = puerto.available();             //Tamaño arreglo de lectura ArrayRead
    int[] ArrayRead = new int[Num];
    int[] D = new int[4];                 //Arreglo con datos digitales 
    int[] ArrayDataX = new int[Num];
    int[] ArrayDataY = new int[Num];
    
    i = 0;                     //Contador de arreglo de data   ArrayData
    
    //*****Se guarda en un arreglo lo leído por puerto serial
    for (int N = 0; N < Num; N = N+1){     //Se lee 0xF2 0D1D2AAAAA 0AAAAAAA 0D3D4BBBBB 0BBBBBBB
      ArrayRead[N] = puerto.read();
      //println(ArrayRead[N]);
    }
    
    //******Se ordena los dos arreglos sin los encabezados, se decodifican y grafican
    for (int N = 0; N < Num - 2; N = N + 1){
       if(ArrayRead[N] == 241){
          i = i + 1 ;
          ArrayDataX[i] = Decodificar (ArrayRead[N+1],ArrayRead[N+2]); //Decodifica y concatena las tramas
          ArrayDataY[i] = Decodificar (ArrayRead[N+3],ArrayRead[N+4]); 
          println("   EjeX = " +ArrayDataX[i]);
          println("   EjeY = " +ArrayDataY[i]);
          println("D1 = "+D[0],"  D2 = "+D[1],"   EjeX = " +ArrayDataX[i]);
          println("D3 = "+D[2],"  D4 = "+D[3],"   EjeY = " +ArrayDataY[i]);
          X = PlotXY (ArrayDataX[i], ArrayDataY[i], X);
          }
      }
   }
}

int Decodificar (int bitsMost, int bitsLeast){
  D[n-1] = (bitsMost>>6)&1;                          //Se toma solo el bit de la señal del sensor digital 1 
  D[n] = (bitsMost>>5)&1;                          //Se toma solo el bit de la señal del sensor digital 2 
  bitsMost = (bitsMost & 31)<<7;                      //Se toma los 5 bist correspondiente a la señal analógica y se shiftea hacia la izquierda [HHHHH0000000]
  valor = bitsMost|bitsLeast;
  return valor;
}

void grid() {
  background(255);                 // Fondo de color blanco
  for (int i = 0; i <= width-50; i += 100) {
    stroke(204);                     // Lineas verticales negras
    strokeWeight (1);     // grosor del trazo
    line(i, height, i, 0);
  }
  for (int j = 0; j < height; j += 100) {
    strokeWeight (1);     // grosor del trazo
    stroke(204);                     // Lineas horizontales negras
    line(15, j, width, j);
  }
}

int PlotXY (int EjeX, int EjeY, int X){
      EjeX = (int)map(EjeX, 0, 4000, 200, 60);
      EjeY = (int)map(EjeY, 0, 4000, 60, 200);
      strokeWeight (3);                                           // grosor del trazo
      stroke(0);                                                  // trazo color negro
      point(X,EjeX);                                            //Grafica punto indicado   
      point(X,EjeY); 
      
      X = X + 1;           //Contador de eje X de la gráfica
      
      //***Reinicie la grafica a la izquierda cuando llegue al extemo derecho
      if(X >= width){      
      X = 0;
      grid();           //Redibuja fondo para quitar la grafica que se tenia hasta el momento hasta el momento
      }
      return X;
}
