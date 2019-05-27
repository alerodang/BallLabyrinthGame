import java.util.List;
import java.util.Arrays;
import processing.serial.*;
import processing.sound.*;

private String state;
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
PImage backgroundImage;
PFont font, bigFont;

Serial myPort;
String val;
float [] stackRotateZ = {0,0,0,0,0};
float [] stackRotateX = {0,0,0,0,0};
float maxRotateZ, maxRotateX;

void setup() {
  font = createFont("andalemo.ttf", 40);
  bigFont = createFont("andalemo.ttf", 70);
  state = "menu";
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
  backgroundImage = loadImage("backgroundImage.jpg");
  
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName,9600);
  victoryDetector = new VictoryDetector(board, ball);
}

void draw() {
  if(state == "menu"){
    drawMenu();
    return;
  }
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

void drawMenu(){
  pushStyle();
  background(backgroundImage);
  textSize(90);
  textFont(bigFont);
  fill(0);
  text("BallLabyrinth", width/2 - 280, height/2 - 160);
  textFont(font);
  textSize(25);
  text("Trata de llegar con la bola a la bandera.", width/2 - 295, height/2 - 60);
  text("Mueve el controlador para mover el tablero.", width/2 - 295, height/2 - 30);
  text("Evita los agujeros para ganar la partida.", width/2 - 295, height/2);
  text("Pulsa S para empezar.", width/2 - 295, height/2 + 50);
  popStyle();
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
  
  if (key == 's') {
    state = "playing";
  }
}

void showLoseMessage() {
  if(!finishSoundPlaying)thread("loseSound");
  textSize(40);
  pushStyle();
  fill(40, 40, 40);
  text("Perdiste! Para reiniciar pulsa r", -380, -300, 0);
  popStyle();
}

void showVictoryMessage() {
  if(!finishSoundPlaying)thread("winSound");
  textSize(35);
  pushStyle();
  fill(40, 40, 40);
  text("Felicidades, ganaste! Para reiniciar pulsa r", -460, -300, 0);
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

void controlBoard(){
  if(myPort.available() > 0){
     val = myPort.readStringUntil('\n');
     if(val!=null && split(val,' ').length > 3){
        maxRotateZ = 90*float(split(val,' ')[3]);
        maxRotateX = -90*float(split(val,' ')[2]);
     }
  }
  if(maxRotateZ > rotateZ + 0.4) rotateZ += 0.4;
  else if(maxRotateZ < rotateZ - 0.4) rotateZ -= 0.4;
  if(maxRotateX > rotateX + 0.4) rotateX += 0.4;
  else if(maxRotateX < rotateX - 0.4) rotateX -= 0.4;
}
