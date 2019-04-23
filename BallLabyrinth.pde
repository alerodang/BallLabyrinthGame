float x,y,z;
float rotateX, rotateZ;
float speed, maxAngle, ballSpeed;
float xBall, zBall;
Ball ball;
Board board;

void setup() {
  ball = new Ball();
  board = new Board();
  size(1000,1000,P3D);
  x = width/2;
  y = height/2;
  z = 0;
  rotateZ = 0;
  rotateX = 0;
  speed = 5;
  maxAngle = 45;
  ballSpeed = 5;
}

void draw() {
  foo();
  board.drawBoard();
  ball.drawBall();
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
    print(rotateX);
  }
}

void foo(){
  background(240);
  translate(x,y,z);
  rotateX(radians(rotateX));
  rotateZ(radians(rotateZ));
}
