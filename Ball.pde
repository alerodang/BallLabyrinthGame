class Ball{
  void drawBall(){
    pushMatrix();
    translate(xBall,-45,zBall);
    sphere(30);
    popMatrix();
    updateBallPosition();
  }
  
  void updateBallPosition(){
    xBall += ballSpeed * rotateZ / 45;
    zBall -= ballSpeed * rotateX / 45;
  }
}
