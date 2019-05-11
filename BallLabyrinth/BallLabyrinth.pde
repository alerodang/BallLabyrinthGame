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

private float x,y,z;
private float rotateX, rotateZ;
float speed, maxAngle;
private Ball ball;
private Board board;
private CollisionDetector collisionDetector;
private FallingDetector fallingDetector;
private VictoryDetector victoryDetector;

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
  victoryDetector = new VictoryDetector(board, ball);
}

void draw() {
  if (!board.getPlaying() || board.getWon()) {
    camera(width/2, 100, (height/2.0) / tan(PI*30.0 / 180.0), width/2, height/2, 0, 0, 1, 0);
    rotateZ = 0;
    rotateX = 0;
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
  }
}

void showLoseMessage() {
  textSize(40);
  pushStyle();
  fill(40, 40, 40);
  text("Perdiste! Para reiniciar pulsa r", -270, -300, 0);
  popStyle();
}

void showVictoryMessage() {
  textSize(40);
  pushStyle();
  fill(40, 40, 40);
  text("Felicidades, ganaste! Para reiniciar pulsa r", -400, -300, 0);
  popStyle();
}
