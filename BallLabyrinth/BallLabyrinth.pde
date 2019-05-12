import peasy.*;

/**TODO:
 - Reducir tamaño pelota
 - Girar la pelota al moverse
 - Agujeros
 - Interacción con sensor
 - Choque por el lateral de los muros
*/

/** TOFIX
  - When collision with right or left wall, the ball remains stuck to that wall
*/
import java.util.List;
import java.util.Arrays;
import processing.serial.*;

private float x,y,z;
private float rotateX, rotateZ;
float speed, maxAngle;
private Ball ball;
private Board board;
private CollisionDetector collisionDetector;
private FallingDetector fallingDetector;
private PeasyCam peasyCam;

Serial myPort;
String val;
float [] stackRotateZ = {0,0,0,0,0};
float [] stackRotateX = {0,0,0,0,0};
float maxRotateZ, maxRotateX;

void setup() {
  size(1000,1000,P3D);
  x = width/2;
  y = height/2;
  z = 0;
  rotateZ = 0;
  rotateX = 0;
  speed = 5;
  maxAngle = 45;
  ball = new Ball(30, 5);
  board = new Board();
  collisionDetector = new CollisionDetector(board, ball);
  fallingDetector = new FallingDetector(board, ball);
  peasyCam = new PeasyCam(this, width/2, height/2, 0, 1000);
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName,9600);
}

void draw() {
  noFill();
  if (!board.getPlaying()) {
    rotateZ = 0;
    rotateX = 0;
    maxRotateZ = 0;
    maxRotateX = 0;
    ball.reset();
    configureScene();
    showLoseMessage();
  } else {
    configureScene();
  }
  
  board.drawBoard();
  collisionDetector.detectCollisions();
  fallingDetector.detectFalling();
  ball.drawBall(rotateX, rotateZ);
  controlBoard();
}

void configureScene(){
  background(240);
  translate(x,y,z);
  rotateX(radians(rotateX));
  rotateZ(radians(rotateZ));
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT && rotateZ >= -maxAngle) {
      rotateZ -= speed;
    } else if (keyCode == RIGHT && rotateZ <= maxAngle) {
      rotateZ += speed;
    } else if (keyCode == DOWN && rotateX >= - maxAngle) {
      rotateX -= speed;
    } else if (keyCode == UP && rotateX <= maxAngle) {
      rotateX += speed;
    }
  }
  
  if (key == 'r') board.setPlaying(true);
}

void showLoseMessage() {
  textSize(40);
  text("Perdiste! Para reiniciar pulsa r", -270, -200, 0);
}
void controlBoardDirect(){
  if(myPort.available()>0){
     val = myPort.readStringUntil('\n');
     if(val!=null && split(val,' ').length > 2){
       arrayCopy(append(stackRotateZ,float(split(val,' ')[3])), 1, stackRotateZ = new float[5], 0, 5);
       arrayCopy(append(stackRotateX,float(split(val,' ')[2])), 1, stackRotateX = new float[5], 0, 5);
       rotateZ = -90*sort(stackRotateZ)[2];
       rotateX = 90*sort(stackRotateX)[2];
     }
  } 
}
void controlBoard(){
  if(myPort.available()>0){
     val = myPort.readStringUntil('\n');
     if(val!=null && split(val,' ').length > 2){
        maxRotateZ = -90*float(split(val,' ')[3]);
        maxRotateX = 90*float(split(val,' ')[2]);
     }
  } 
  if(maxRotateZ>rotateZ+0.4) rotateZ+=0.4;
  else if(maxRotateZ<rotateZ-0.4) rotateZ-=0.4;
  if(maxRotateX>rotateX+0.4) rotateX+=0.4;
  else if(maxRotateX<rotateX-0.4) rotateX-=0.4;
}
