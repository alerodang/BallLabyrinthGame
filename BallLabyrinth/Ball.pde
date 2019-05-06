class Ball {
  
  private float xCoordinate;
  private float zCoordinate;
  private float xSpeed, zSpeed;
  private final int radius;
  private final float ballSpeed;
  
  public Ball(int radius, int ballSpeed){
    this.radius = radius;
    this.ballSpeed = (float)ballSpeed / 600.;
  }
    
  void drawBall(float rotateX, float rotateZ){
    updateBallSpeed(rotateX, rotateZ);
    pushMatrix();
    translate(xCoordinate,-45,zCoordinate);
    sphere(radius);
    popMatrix();
  }
  
  void updateBallSpeed(float rotateX, float rotateZ){
    zSpeed += ballSpeed * rotateX;
    xSpeed += ballSpeed * rotateZ;
    zSpeed *= 0.99; // rozamiento
    xSpeed *= 0.99;
  }
  
  void stopSpeed(boolean z){
    if (z) zSpeed = 0;
    else xSpeed = 0;
  }
  
  void noCollision(){
    zCoordinate -= zSpeed;
    xCoordinate += xSpeed;
  }
  
  void frontalCollision(){
    if (abs(zSpeed) > 0.4) zSpeed *= -0.6;
    else zSpeed = 0;
    zCoordinate -= zSpeed;
  }
  
  void lateralCollision(){
    if (abs(xSpeed) > 0.4) xSpeed *= -0.6;
    else xSpeed = 0;
    xCoordinate += xSpeed;
  }
  
  float getXSpeed(){
    return xSpeed;
  }
  
  float getZSpeed(){
    return zSpeed;
  }
  
  float getXCoordinate(){
    return xCoordinate;
  };
  
  float getZCoordinate(){
    return zCoordinate;
  };
  
  int getRadius(){
    return this.radius;
  }  
  
  public void reset() {
    zCoordinate = 0;
    xCoordinate = 0;
  }
  
}
