//TODO:
// Reducir tamaño pelota
import java.util.List;
import java.util.Arrays;

float x,y,z;
float rotateX, rotateZ;
float speed, maxAngle, ballSpeed;
Ball ball;
Board board;
List <Wall> walls = new ArrayList();
CollisionController collisionController;

void setup() {
  size(1000,1000,P3D);
  x = width/2;
  y = height/2;
  z = 0;
  rotateZ = 0;
  rotateX = 0;
  speed = 5;
  maxAngle = 45;
  ballSpeed = 5;
  collisionController = new CollisionController();
  ball = new Ball(30);
  board = new Board();
  walls.addAll(board.getWalls());
}

void draw() {
  noFill();
  configureScene();
  board.drawBoard();
  ball.drawBall();
  board.drawWalls();
  collisionController.detectCollisions();
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
}
