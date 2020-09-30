int [] [] cuadrado = { {0,0} , {1,0} , {0,1} , {1,1} };
int [] [] linea = { {0,0} , {1,0} , {2,0} , {3,0} };
int [] [] triangulo = { {0,0} , {1,0} , {1,1} , {2,1} };
int [] [] Lizquierda = { {0,0} , {0,1} , {1,0} , {2,0} };
int [] [] Lderecha = { {0,0} , {1,0} , {2,0} , {2,1} };
int [] [] S1 = { {0,0} , {1,0} , {1,1} , {2,1} };
int [] [] S2 = { {0,1} , {1,1} , {1,0} , {2,0} };
int [][]figura,oF;
int r,g,b,turno,crot;
boolean on;
float w;
int c;
int x,y;
  
void setup(){
  size(600,600);
  azar();
  
}

void draw(){
  cuadricula();
  fondoJ();
  figura();
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
  int [][][] colores;
  colores = new int [12] [24] [3];
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
        figura = cuadrado;
        r = 155;
        break;
      case 1:
        figura = linea;
        g = 155;
        break;
      case 2:
        figura = triangulo;
        b = 155;
        break;
      case 3:
        figura =  Lizquierda;
        r = 155;
        g = 155;
        break;
      case 4:
        figura = Lderecha;
        g = 155;
        b = 155;
        break;
      case 5:
        figura = S1;
        r = 155;
        b = 155;
        break;
      case 6:
        figura = S2;
        r = 155;
        g = 60;
        b = 155;
        break;
    }
    c=1;
    oF=figura;
    crot=0;
}
void figura(){
   fill(r,g,b);
   for(int i =0; i<4;i++){
       rect(figura[i][0]*w,figura[i][1]*w,w,w);
    }
}
void keyPressed(){
   if(keyCode == RIGHT){
       for(int i =0;i<4;i++){
             figura[i][0]++;
        }
   }
   if(keyCode== LEFT){
      for(int i =0;i<4;i++){
             figura[i][0]--;
      }
   }
   if(keyCode== DOWN){
      for(int i =0;i<4;i++){  
             figura[i][1]++;
      }
   }
}
