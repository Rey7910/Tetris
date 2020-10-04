int [] [] cuadrado = { {0,0} , {1,0} , {0,1} , {1,1} };
int [] [] linea = { {0,0} , {1,0} , {2,0} , {3,0} };
int [] [] triangulo = { {0,0} , {1,0} , {2,0} , {1,1} };
int [] [] Lizquierda = { {0,0} , {0,1} , {1,0} , {2,0} };
int [] [] Lderecha = { {0,0} , {1,0} , {2,0} , {2,1} };
int [] [] S1 = { {0,0} , {1,0} , {1,1} , {2,1} };
int [] [] S2 = { {0,1} , {1,1} , {1,0} , {2,0} };
int [][]figura,oF,figuran,oFn;
int [][][]colores = new int[12][24][3];
int c,r,g,b,turno,crot,puntaje=0,v=50,del=0,lineas=0,cambio = 150,nivel=1,x=0,y=0,k=1;
int cn,rn,bn,gn,crotn,t=1;
boolean on,boton = false,over=false;
float w=width/24;
void setup(){
  size(600,600);
  azar();
  on = true;
  textSize(30);
}

void draw(){
   if(!boton && !over){
      acceso();
   }else if(boton && !over){
      tetris();
   }else{
      game_over();
   }
}
void tetris(){
      cuadricula();
      lineas();
      fondoJ();
      detalles();
      fill(255);
      text("Nivel: "+nivel,width/2+10,height-240);
      fill(255);
      text("Puntuación: "+puntaje,width/2+10,height-100);
      fill(255);
      text("Lineas: "+lineas,width/2+10,height-170);
      juego();
}
void juego(){ 
    if(k==1){
      r = rn;
      g=  gn;
      b=  bn;
      figura= figuran;
      oF=oFn;
      c = cn;
      crot=crotn;
      k++;
    }
    figura();
    Siguiente();
    if(t==1){
      azar();
      t++;
    }
    if(fondo()){
      bajar(v);
    }else{
      on = false;
    }
    if(!on){  
      puntaje+=10;
      termino(); 
    }
    if(puntaje>cambio){
      cambio+=150;
      if(v>10){  
        v-=5;
      }
      nivel++;
    }
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
void fondoJ(){
  int r,g,b; 
  float w = width/24;
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
    turno = (int)random(7);
    switch(turno){
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
    crotn=0;
}
void figura(){
   fill(r,g,b);
   for(int i =0;i<4;i++){
       rect(figura[i][0]*w,figura[i][1]*w,w,w);
    }
}
void keyPressed(){
   if(keyCode == RIGHT){
       if(limite("derecha")==true){
        for(int i =0;i<4;i++){
             figura[i][0]++;
        }
       }
   }   
   if(keyCode== LEFT){
     if(limite("izquierda")==true){
      for(int i =0;i<4;i++){
             figura[i][0]--;
      }
     }
   }
   if(keyCode== DOWN){
     if(limite("abajo")==true){
      for(int i =0;i<4;i++){  
             figura[i][1]++;
      }
     }
   }
}
boolean limite (String dir){
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
void bajar(int v){
    if(c%v == 0){ 
       if(limite("abajo")==true){
        for(int i =0;i<4;i++){  
               figura[i][1]++;
        }
     }
   
  }
    c++;
}
 void rotate(){
    if(figura != cuadrado){   
        int[][] rotar = new int [4][2];
        if(crot % 4 == 0){  
            for(int i =0;i<4;i++){
               rotar[i][0] =oF[i][1]-figura[1][0];
               rotar[i][1] = -oF[i][0] -figura[1][1] ;
            }
        }else if(crot % 4 == 1){
            for(int i =0;i<4;i++){
               rotar[i][0] =oF[i][0]-figura[1][0];
               rotar[i][1] = -oF[i][1] -figura[1][1] ;
            }
        }else if(crot % 4 == 2){
            for(int i =0;i<4;i++){
               rotar[i][0] =-oF[i][0]-figura[1][0];
               rotar[i][1] = oF[i][1] -figura[1][1] ;
            }
        }else if(crot % 4 == 3){
            for(int i =0;i<4;i++){
               rotar[i][0] = oF[i][1]-figura[1][0];
               rotar[i][1] = oF[i][0] -figura[1][1] ;
            } 
        }
        figura = rotar;
    }
  }
boolean Checkfila (int fila){
   for(int i=0;i<12;i++){
     if(colores[i][fila][0]==0 && colores[i][fila][1]==0 && colores[i][fila][2]==0){
        return false;
      }
   }
   return true;
 }
 void borrar(int fila){
   puntaje+=50;
   lineas++;
   int [][][] actualizar = new int[12][24][3];
   for(int i = 0;i<12;i++){
     for(int j=23; j>fila;j--){
       for(int a = 0;a<3;a++){
         actualizar[i][j][a] = colores[i][j][a];
       }
     }
   }
   for(int r = fila;r>=1;r--){
     for(int j=0;j<12;j++){
       actualizar[j][r][0] = colores[j][r-1][0];
       actualizar[j][r][1] = colores[j][r-1][1];
       actualizar[j][r][2] = colores[j][r-1][2];
     }
   }
   colores = actualizar;
 }

void pintar(){
    for(int i=0;i<4;i++){
      if(y==1 || y==0){
         over=true;
      }
      x=figura[i][0];
      y=figura[i][1];
      colores[x][y][0] = r;
      colores[x][y][1] = g;
      colores[x][y][2] = b;     
    }
 }
 boolean fondo(){
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
void termino(){
  if(on == false){
      pintar();
      on = true;
      r = rn;
      g=  gn;
      b=  bn;
      figura= figuran;
      oF=oFn;
      c = cn;
      crot=crotn;
      figura();
      azar();
      bajar(v);
    }
}
void detalles(){
  fill(108,0,129);    
  rect(width/2,0,width/2,height);
}
void lineas(){
  for(int i=0;i<24;i++){
      if(Checkfila(i)){
         println("Fila Completada");
         borrar(i);
      };
    }
}
void Siguiente(){
    fill(0);
    fill(255);
    text("SIGUIENTE FIGURA",width/2+25,55);  
    fill(255);
    rect(390,120,120,100);
    for(int i=120;i<220;i+=20){
       fill(200);
       rect(370,i,20,20);
    }
    for(int i=120;i<220;i+=20){
       fill(200);
       rect(510,i,20,20);
    }
    for(int i=370;i<520;i+=20){
       fill(200);
       rect(i,100,20,20);
    }
    for(int i=370;i<520;i+=20){
       fill(200);
       rect(i,220,20,20);
    }
    fill(rn,gn,bn);
    for(int i=0;i<4;i++){
      if(figuran==cuadrado){
        rect(figuran[i][0]*w+width/2 +125,figuran[i][1]*w+140,w,w);
      }else{
        rect(figuran[i][0]*w+width/2 +100,figuran[i][1]*w+140,w,w);
      }
    }
  }
void keyReleased(){
   if(keyCode == UP){
     rotate();
     rotate();
   }
   crot++;
}
/// ------------------PANATLLA DE INICIO ----------------------------------------
void acceso(){
  finicio();
  T();
  E();
  T2();
  R();
  I();
  S();
  boton();
  texto();
  nombre();
}
void finicio(){
  fill(0);
  rect (0,0,600,600);
}

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
void boton(){ 
  if(mouseX>180 && mouseX<180+250 && mouseY>260 && mouseY<120+260){
     if(mousePressed){
       boton = true;
     }
    fill(255,128,0);
  }else{
     fill(140,0,75);
  }
  
  rect(180,260,250,120);
}
void texto(){
  fill(255);
  text("JUGAR ",260,330);
}
void nombre(){
  fill(255);
  text("Estudiante: Reinaldo Toledo ",20,440);
  text("Universidad Nacional  ",20,480);
  text("Programación Orientada a Objetos ",20,520);
  text("Grupo 4 ",20,560);
}
/// ------------------GAME OVER----------------
void game_over(){
  pantalla();
  GO(); 
  resultados();
  valores();
  gracias();
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
