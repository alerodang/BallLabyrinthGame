import peasy.*;

/**TODO:
 - Girar la pelota al moverse
 - Agujeros
 - Interacción con sensor refactor sacar del main
 - Choque por el lateral de los muros
  - Problema en la esquina viniendo desde fuera -|
 - Refactor sound to new file

*/

/** TOFIX
  - When collision with right or left wall, the ball remains stuck to that wall
*/
import java.util.List;
import java.util.Arrays;
import processing.serial.*;
import processing.sound.*;

private float x,y,z;
private float rotateX, rotateZ;
float speed, maxAngle;
private Ball ball;
private Board board;
private CollisionDetector collisionDetector;
private FallingDetector fallingDetector;
private VictoryDetector victoryDetector;
SoundFile winSound, hitSound, loseSound;
boolean soundPlaying, finishSoundPlaying;

Serial myPort;
String val;
float [] stackRotateZ = {0,0,0,0,0};
float [] stackRotateX = {0,0,0,0,0};
float maxRotateZ, maxRotateX;
PeasyCam peasyCam;

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
  soundPlaying=false;
  finishSoundPlaying=false;
  hitSound = new SoundFile(this, "sound/hit.wav");
  winSound = new SoundFile(this, "sound/win.wav");
  loseSound = new SoundFile(this, "sound/lose.wav");
  collisionDetector = new CollisionDetector(board, ball);
  fallingDetector = new FallingDetector(board, ball);
  peasyCam = new PeasyCam(this, width/2, height/2, 0, 1000);
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName,9600);
  victoryDetector = new VictoryDetector(board, ball);
}

void draw() {
  if (!board.getPlaying() || board.getWon()) {
    camera(width/2, 100, (height/2.0) / tan(PI*30.0 / 180.0), width/2, height/2, 0, 0, 1, 0);
    rotateZ = 0;
    rotateX = 0;
    maxRotateZ = 0;
    maxRotateX = 0;
    ball.reset();
    configureScene();
    if (board.getWon()) {
      showVictoryMessage();
    } else {
      showLoseMessage(); 
    }
  } else {
    camera(width/2, -200, (height/2.0) / tan(PI*30.0 / 180.0), width/2, height/2, 0, 0, 1, 0);
    configureScene();
  }
  
  board.drawBoard();
  collisionDetector.detectCollisions();
  fallingDetector.detectFalling();
  victoryDetector.checkVictory();
  ball.drawBall(rotateX, rotateZ);
  controlBoard();
}

void configureScene(){
  background(240);
  translate(x,y,z);
  rotateX(radians(rotateX));
  rotateZ(radians(rotateZ));
  lights();
  lightSpecular(255, 255, 255);
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
  
  if (key == 'r') {
    board.setPlaying(true);
    board.setWon(false);
    finishSoundPlaying=false;
  }
}

void showLoseMessage() {
  if(!finishSoundPlaying)thread("loseSound");
  textSize(40);
  pushStyle();
  fill(40, 40, 40);
  text("Perdiste! Para reiniciar pulsa r", -270, -300, 0);
  popStyle();
}

void showVictoryMessage() {
  if(!finishSoundPlaying)thread("winSound");
  textSize(40);
  pushStyle();
  fill(40, 40, 40);
  text("Felicidades, ganaste! Para reiniciar pulsa r", -400, -300, 0);
  popStyle();
}

void hitSound() {
  float hitSoundAmplitud = abs(ball.getHitSpeed()*ball.getHitSpeed()/290);
  println(abs(hitSoundAmplitud));

  if(hitSoundAmplitud > 1) hitSoundAmplitud = 1;
  if(hitSoundAmplitud < -1) hitSoundAmplitud = -1;
  hitSound.amp(hitSoundAmplitud);
  hitSound.play();
  soundPlaying=true;
}
void winSound() {
  winSound.play();
  finishSoundPlaying=true;
}
void loseSound() {
  loseSound.play();
  finishSoundPlaying=true;
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
       println(val);
        maxRotateZ = -90*float(split(val,' ')[3]);
        maxRotateX = 90*float(split(val,' ')[2]);
     }
  } 
  if(maxRotateZ>rotateZ+0.4) rotateZ+=0.4;
  else if(maxRotateZ<rotateZ-0.4) rotateZ-=0.4;
  if(maxRotateX>rotateX+0.4) rotateX+=0.4;
  else if(maxRotateX<rotateX-0.4) rotateX-=0.4;
}
