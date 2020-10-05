// DECLARACION DE ARREGLOS PARA LA CREACION DE LAS FIGURAS
int [] [] cuadrado = { {0,0} , {1,0} , {0,1} , {1,1} };
int [] [] linea = { {0,0} , {1,0} , {2,0} , {3,0} };
int [] [] triangulo = { {0,0} , {1,0} , {2,0} , {1,1} };
int [] [] Lizquierda = { {0,0} , {0,1} , {1,0} , {2,0} };
int [] [] Lderecha = { {0,0} , {1,0} , {2,0} , {2,1} };
int [] [] S1 = { {0,0} , {1,0} , {1,1} , {2,1} };
int [] [] S2 = { {0,1} , {1,1} , {1,0} , {2,0} };
// DECLARACION DE ARREGLOS ESTANDARES QUE A LO LARGO DEL PROGRAMA IRAN ACTUALIZANDOSE 
int [][]figura,oF,figuran,oFn;
//DECLARACION DEL ARREGLO DE LA CUADRICULA CON SUS RESPECTIVAS DIMENSIONES
int [][][]colores = new int[12][24][3];
//DECLARACIÓN DE VARIABLES DE PUNTAJE, VELOCIDAD Y COORDENADAS
int c,r,g,b,turno,crot,puntaje=0,v=50,del=0,lineas=0,cambio = 150,nivel=1,x=0,y=0,k=1;
//DECLARACION DE VARIABLES DE LA SEGUNDA FIGURA EN COLA (n=next)
int cn,rn,bn,gn,crotn,t=1;
// DECLARACION DE VARIABLES PARA LA APARICION DE VENTANAS Y LAS DIFERENTES PARTES DEL JUEGO
boolean on,boton = false,over=false,ins=false;
float w=width/24;
void setup(){
  size(600,600);
  azar();
  on = true;
  textSize(30);
}

void draw(){
   if(!boton && !over && !ins){ 
      acceso(); // Ventana de inicio
   }else if(boton && !over && !ins){  
      tetris(); // Inicio del juego
   } else if(!boton && !over && ins){ // Ventana de Instrucciones
      ins(); // Ventana de Instrucciones
   }else{ 
      game_over(); // Fin del programa
   }
}
//---------------------------JUEGO INICIADO---------------------------------------//
void tetris(){
      cuadricula();
      lineas(); 
      fondoJ();
      detalles();
      fill(255);
      text("Nivel: "+nivel,width/2+10,height-240); // Nivel
      fill(255);
      text("Puntuación: "+puntaje,width/2+10,height-100); //puntuación
      fill(255);
      text("Lineas: "+lineas,width/2+10,height-170); // Lineas
      juego(); // Aparición, comportamiento y estructura d ela sfiguras
}
void juego(){ 
   if(k==1){   // La primera figura del juego adquirira los valores del azar del setup
      r = rn;
      g=  gn;
      b=  bn;
      figura= figuran;
      oF=oFn;
      c = cn;
      crot=crotn;
      k++; // solo ocurre una vez
    }
    figura(); // aparicion de las figuras
    Siguiente(); // Vista de la siguiente figura cuyas variables salen de la funcion azar 
    if(t==1){
      azar();
      t++;
    }
    if(fondo()){ // si el fondo es negro la figura puede bajar
      bajar(v);
    }else{
      on = false; // si el fondo no es negro se detecta colision 
    }
    if(!on){  
      puntaje+=10; // al detectar colision o limite se suma 10 a la variable del puntaje
      termino(); //Asignacion de valores estandares a la figura en cola y aparicion
    }
    if(puntaje>cambio){ 
      cambio+=150; // Si el jugador supera el limite entre niveles (150) subira de nivel
      if(v>10){  
        v-=5;  // si el jugador sube de nivel la velocidad de la figura automatica aumentara (Se usa condicional pq si llega a cero ocurre una excepcion aritmetica)
      }
      nivel++; //Sube de nivel
    }
}
void controles(){
  if(mouseX>430 && mouseX<430+150 && mouseY>540 && mouseY<540+50){ // Se menciona el area del boton por los ejes 
     if(mousePressed){
       ins = true; // si se da click en el recuadro activara la variable de la instruccion que ejecutara la función de la ventana
     }
    fill(255,128,0); // Color si el cursor esta encima
  }else{
    fill(0,143,57); // Color si el cursor no eta encima
  }
   rect(430,540,150,50); //  Dimensiones del boton
   fill(255);
   text("controles",440,575);
}

void cuadricula(){
  float w = width/24;
  stroke(155);
    for(int i=0;i<13;i++){
      line(0,i*w,width/2,i*w);
      line(0,(i+12)*w,width/2,(i+12)*w);
      line(i*w,0,i*w,height);
    }
}
void fondoJ(){ // Fondo del area de juego
  int r,g,b; 
  float w = width/24; // variable para ubicar segn la magnitud de la ventana
  for(int i=0;i<12;i++){
       for(int j=0;j<24;j++){
         r=colores[i][j][0];
         g=colores[i][j][1];
         b=colores[i][j][2];
         fill(r,g,b);
         rect(i*w,j*w,w,w);
       }
    }
}
void azar(){
w = width/24;
    turno = (int)random(7); // Numero azar entre 0 y 7
    switch(turno){ // Figura segun el numero con sus respectivos colores
      case 0:
        int [] [] cuadrado = { {0,0} , {1,0} , {0,1} , {1,1} }; 
        figuran = cuadrado;
        rn = 155;
        gn =0;
        bn =0;
        break;
      case 1:
        int [][]linea = { {0,0} , {1,0} , {2,0} , {3,0} };
        figuran = linea;
        rn=0;
        gn = 155;
        bn=0;
        break;
      case 2:
        int [] [] triangulo = { {0,0} , {1,0} , {2,0} , {1,1} };
        figuran = triangulo;
        rn =0;
        bn = 155;
        gn =0;
        break;
      case 3:
        int [] [] Lizquierda = { {0,0} , {0,1} , {1,0} , {2,0} };
        figuran =  Lizquierda;
        rn = 155;
        gn = 155;
        bn =0;
        break;
      case 4:
        int [] [] Lderecha = { {0,0} , {1,0} , {2,0} , {2,1} };
        figuran = Lderecha;
        rn=0;
        gn = 155;
        bn = 155;
        break;
      case 5:
        int [] [] S1 = { {0,0} , {1,0} , {1,1} , {2,1} };
        figuran = S1;
        rn = 155;
        gn=0;
        bn = 155;
        break;
      case 6:
        int [] [] S2 = { {0,1} , {1,1} , {1,0} , {2,0} };
        figuran = S2;
        rn = 155;
        gn = 60;
        bn = 60;
        break;
    }
    cn=1;
    oFn=figuran;
    crotn=0; // Varaibles next para mostrar la figura en cola
}
void figura(){
   fill(r,g,b); // Color de la figura
   for(int i =0;i<4;i++){
       rect(figura[i][0]*w,figura[i][1]*w,w,w);
    } //Creacion de la figura a partir del arreglo 
}
void keyPressed(){
   if(keyCode == RIGHT){
       if(limite("derecha")==true){
        for(int i =0;i<4;i++){
             figura[i][0]++; //Movimiento a la derecha
        }
       }
   }   
   if(keyCode== LEFT){
     if(limite("izquierda")==true){
      for(int i =0;i<4;i++){
             figura[i][0]--; //Movimiento a la Izquierda
      }
     }
   }
   if(keyCode== DOWN){
     if(limite("abajo")==true){
      for(int i =0;i<4;i++){  
             figura[i][1]++; //Movimiento hacia abajo
      }
     }
   }
}
boolean limite (String dir){ //Verificacion limites de la cuadricula para la creacion y asignacion de nuevas figuras
     switch(dir){
       case "derecha":
          for(int i=0;i<4;i++){
             if(figura[i][0]>10){
                return false;
             }
          }
          break;
       case "izquierda":
          for(int i =0; i<4;i++){
            if(figura[i][0]<1){
                 return false;
            }
          }
          break;
       case "abajo":
          for(int i=0;i<4;i++){
            if(figura[i][1]>22){
               on = false;
              return false;
            }
          }
          break;
    }
    return true;
  }
void bajar(int v){ // Funcion para bajar la figura de manera automatica
    if(c%v == 0){ 
       if(limite("abajo")==true){ //La variable v funciona como un acelerador por su función de acelerador sobre la variable c 
        for(int i =0;i<4;i++){  
               figura[i][1]++;
        }
     }
   
  }
    c++;
}
 void rotate(){
    if(figura != cuadrado){   // Si la figura es un cuadrado no hay necesidad de rotar
        int[][] rotar = new int [4][2]; // Se utiliza el arreglo rotar para reasignar los dichos valores al arreglo de figura 
        if(crot % 4 == 0){  // Se utiliza la variable crot para alguna de las 4 rotaciones
            for(int i =0;i<4;i++){
               rotar[i][0] =oF[i][1]-figura[1][0];
               rotar[i][1] = -oF[i][0] -figura[1][1] ;  //Las rotaciones se realizan a partir del ordenamiento de valores en el arreglo de las 4 posibles formas
            }
        }else if(crot % 4 == 1){
            for(int i =0;i<4;i++){
               rotar[i][0] =oF[i][0]-figura[1][0];
               rotar[i][1] = -oF[i][1] -figura[1][1] ; 
            }
        }else if(crot % 4 == 2){
            for(int i =0;i<4;i++){
               rotar[i][0] =-oF[i][1]-figura[1][0];
               rotar[i][1] = oF[i][0] -figura[1][1] ;
            }
        }else if(crot % 4 == 3){
            for(int i =0;i<4;i++){
               rotar[i][0] = oF[i][0]-figura[1][0];
               rotar[i][1] = oF[i][1] -figura[1][1] ;
            } 
        }
        figura = rotar;
    }
  }
boolean Checkfila (int fila){ // Funcion para verifica si las filas estan o no estan llenas mediante la busqueda de color negro en las mismas
   for(int i=0;i<12;i++){
     if(colores[i][fila][0]==0 && colores[i][fila][1]==0 && colores[i][fila][2]==0){
        return false;
      }
   }
   return true;
 }
 void borrar(int fila){
   puntaje+=50; //Actualizacion de variables por el evento
   lineas++;
   int [][][] actualizar = new int[12][24][3]; //Función para colorear de negro una fila que ya sehaya llenado
   for(int i = 0;i<12;i++){
     for(int j=23; j>fila;j--){
       for(int a = 0;a<3;a++){
         actualizar[i][j][a] = colores[i][j][a];
       }
     }
   }
   for(int r = fila;r>=1;r--){ //Ciclo para desplzar las filas superiores hacia abajo despintando y pintando a valor de -1
     for(int j=0;j<12;j++){
       actualizar[j][r][0] = colores[j][r-1][0];
       actualizar[j][r][1] = colores[j][r-1][1];
       actualizar[j][r][2] = colores[j][r-1][2];
     }
   }
   colores = actualizar;
 }

void pintar(){ // En caso de colision o limite los colores de la figura (r,g,b) se pintaran en el fondo para hacer mas sencillas las colisiones
    for(int i=0;i<4;i++){
      if(y==1 || y==0){
         over=true;
      }
      x=figura[i][0]; //Cordenadas de la figura
      y=figura[i][1];
      colores[x][y][0] = r;//Asignacion de los colores en la respectiva cuadricula
      colores[x][y][1] = g;
      colores[x][y][2] = b;     
    }
 }
 boolean fondo(){ //Verificacion si la coordenada siguiente y de la figura es de color negro o no para detenerse y 
     for(int i=0;i<4;i++){
        x=figura[i][0];
        y=figura[i][1];
        if(x >= 0 && x<12 && y>=0 && y<23){
          for(int a=0;a<3;a++){
            if(colores[x][y+1][a]!=0){
              return false;
            }
          }
        }
     }
     return true;
  }
void termino(){ //Funcion de creacion de nuevas figuras
  if(on == false){
      pintar(); //Se pinta la figura detenida
      on = true; // Se vuelve a activar la variable de figura activa
      r = rn; //Se asignan los colores en cola a la nueva figura
      g=  gn;
      b=  bn;
      figura= figuran; // Se asignan los valores de arreglo de la forma de la figura en cola a la nueva figura
      oF=oFn; //Se reinican los valores 
      c = cn;
      crot=crotn;
      figura(); // Aparicion de la figura
      azar(); // Creacion de la nueva figura en cola
      bajar(v); 
    }
}
void detalles(){ // Fondo morado para loas puntuaciones y figura en cola
  fill(108,0,129);    
  rect(width/2,0,width/2,height);
}
void lineas(){ // Funcion para buscar lineas llenas y sar el parametro de fila a la funcion e borrar en caso de que haya encontrado una
  for(int i=0;i<24;i++){
      if(Checkfila(i)){
         borrar(i);
      };
    }
}
void Siguiente(){ 
    fill(0);
    fill(0,156,140);
    text("SIGUIENTE FIGURA",width/2+25,55);  
    fill(255);
    rect(390,120,120,100);
    for(int i=120;i<220;i+=20){ //Fila de cuadrados de decoracion
       fill(200);
       rect(370,i,20,20);
    }
    for(int i=120;i<220;i+=20){ //Fila de cuadrados de decoracion
       fill(200);
       rect(510,i,20,20);
    }
    for(int i=370;i<520;i+=20){ //Fila de cuadrados de decoracion
       fill(200);
       rect(i,100,20,20);
    }
    for(int i=370;i<520;i+=20){ //Fila de cuadrados de decoracion
       fill(200);
       rect(i,220,20,20);
    }
    fill(rn,gn,bn); // Aparicion de la figura en cola con los valores de la funcion azar
    for(int i=0;i<4;i++){
      if(figuran==cuadrado){
        rect(figuran[i][0]*w+width/2 +300,figuran[i][1]*w+140,w,w);
      }else{
        rect(figuran[i][0]*w+width/2 +100,figuran[i][1]*w+140,w,w);
      }
    }
  }
void keyReleased(){ // Funcion de teclado para aumentar la variable crot para las respectivas rotaciones
   if(keyCode == UP){
     rotate();
     rotate();
   }
   crot++;
}
/// ------------------PANATLLA DE INICIO ----------------------------------------
void acceso(){
  finicio(); //Fondo de la pantalla de inicio
  T(); //Letra 'T'
  E(); //Letra 'E'
  T2(); // Segunda Letra 'T'
  R(); //Letra 'R'
  I(); // Letra 'I'
  S(); // Letra 'S'
  boton(); // Boton de inicio
  texto(); // Texto del boton
  nombre(); // Referencias del Autor
  controles(); //Boton de instrucciones
}
void finicio(){
  fill(0);
  rect (0,0,600,600);
}
//-------------LETRAS HECHAS CON FILA DE CUADRADOS--------------//
void T(){
  for(int i=30;i<120;i+=20){
     fill(155,0,155);
     rect(i,80,20,20);
  }
  for(int i=80;i<180;i+=20){
     fill(155,0,155);
     rect(70,i,20,20);
  }    
}
void E(){
  for(int i=140;i<220;i+=20){
     fill(0,155,155);
     rect(i,80,20,20);
  }
  for(int i=80;i<180;i+=20){
     fill(0,155,155);
     rect(140,i,20,20);
  }
  for(int i=140;i<220;i+=20){
     fill(0,155,155);
     rect(i,120,20,20);
  }
  for(int i=140;i<220;i+=20){
     fill(0,155,155);
     rect(i,160,20,20);
  }
}
void T2(){
  for(int i=240;i<340;i+=20){
     fill(155,155,0);
     rect(i,80,20,20);
  }
  for(int i=80;i<180;i+=20){
     fill(155,155,0);
     rect(280,i,20,20);
  }    
}
void R(){
  for(int i=380;i<440;i+=20){
     fill(57,255,20);
     rect(i,80,20,20);
  }
  for(int i=80;i<180;i+=20){
     fill(57,255,20);
     rect(360,i,20,20);
  }  
  for(int i=380;i<440;i+=20){
     fill(57,255,20);
     rect(i,120,20,20);
  }
  rect(400,160,20,20);
  rect(400,140,20,20);
  rect(420,100,20,20);
  
}
void I(){
  for(int i=80;i<180;i+=20){
     fill(255,128,0);
     rect(460,i,20,20);
  }    
}
void S(){
   for(int i=500;i<580;i+=20){
     fill(155,155,0);
     rect(i,80,20,20);
  }
  rect(500,100,20,20);
  for(int i=500;i<580;i+=20){
     fill(155,155,0);
     rect(i,120,20,20);
  }
  rect(560,140,20,20);
  for(int i=500;i<580;i+=20){
     fill(155,155,0);
     rect(i,160,20,20);
  }
}
//---------------------------
void boton(){ 
  if(mouseX>180 && mouseX<180+250 && mouseY>260 && mouseY<120+260){
     if(mousePressed){
       boton = true;//Asignacion del booleano en caso de oprimir el boton
     }
    fill(255,128,0);//Color si el cursor esta encima
  }else{
     fill(140,0,75); //Color del cursor si no esta encima
  }
  
  rect(180,260,250,120); //Dimesniones
}
void texto(){
  fill(255);
  text("JUGAR ",260,330);
}
void nombre(){ //Referencias
  fill(255);
  text("Estudiante: Reinaldo Toledo ",20,440);
  text("Universidad Nacional  ",20,480);
  text("Programación Orientada a Objetos ",20,520);
  text("Grupo 4 ",20,560);
}
/// ------------------GAME OVER----------------
void game_over(){
  pantalla(); //Fondo
  GO(); //Letras de GAME OVER
  resultados(); // Puntuacion obtenida, Lineas eliminadas y nivel alcanzado
  valores(); //Muestreo de variables
  gracias(); //Agradecimiento
}

void pantalla(){
  fill(0);
  rect(0,0,600,600);
}
void GO(){
  textSize(60);
  fill(81,209,246);
  text("GAME OVER",120,200);
}
void resultados(){
textSize(30);
fill(255,0,0);
text("Tus Resultados Son:",120,300);

}
void valores(){
 fill(255);
 textSize(20);
 text("* Nivel alcanzado: "+nivel,120,330);
 text("* Filas eliminadas: "+lineas,120,360);
 text("* Puntuación Total: "+puntaje,120,390);
}
void gracias(){
 textSize(30);
 fill(255,255,0);
 text("GRACIAS POR JUGAR :3",120,500);
}
//-----------------------instrucciones
void ins(){
  finicio();
  volver();
  cuadro();
  textoI();
}
void volver(){ //Boton para regresar al inicio por medio dle booleano
  if(mouseX>230 && mouseX<230+130 && mouseY>540 && mouseY<540+50){
     if(mousePressed){
       ins = false;
     }
    fill(255,128,0);
  }else{
    fill(0,143,57);
  }
   rect(230,540,130,50);
   fill(255);
   text("volver",250,575);
}
void cuadro(){ //Titulo "Instrucciones"
  fill(255,255,0);
  rect(200,40,200,70);
  fill(0);
  text("Instrucciones",205,80);
}
void textoI(){ //Controles del juego
  fill(255); 
  textSize(30);
  text("*Cruzeta-abajo: Baja la figura (rápido)",10,200);
  text("*Cruzeta-Izquierda: Desplaza la figura",10,280);
  text("*Cruzeta-Derecha: Desplaza la figura",10,360);
  text("*Cruzeta-Arriba: Rota la figura",10,440);
}


