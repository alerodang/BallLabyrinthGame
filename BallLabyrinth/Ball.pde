class Ball {
  
  private float xCoordinate;
  private float zCoordinate;
  private float xSpeed, zSpeed;
  private final int radius;
  private final float ballSpeed;
  private float hitSpeed;
  
  public Ball(int radius, int ballSpeed){
    this.radius = radius;
    this.ballSpeed = (float)ballSpeed / 600.;
    xCoordinate = 240;
    zCoordinate = 240;
    hitSpeed = 0;
  }
    
  void drawBall(float rotateX, float rotateZ){
    updateBallSpeed(rotateX, rotateZ);
    pushMatrix();
    pushStyle();
    fill(200, 200, 200);
    translate(xCoordinate,-35,zCoordinate);
    directionalLight(100, 100, 100, -50, 200, -1);
    shininess(100);
    sphere(radius);
    popStyle();
    popMatrix();

  }
  
  float getHitSpeed(){
    return hitSpeed;
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
    soundPlaying=false;
    zCoordinate -= zSpeed;
    xCoordinate += xSpeed;
  }
  
  void frontalCollision(){
    if(abs(zSpeed) < 0.5){ 
      zSpeed = 0; 
      return;
    }
    if(!soundPlaying){
      hitSpeed = zSpeed;
      thread("hitSound");
    }
    if(abs(zSpeed) > 0.1){
      zSpeed -= ballSpeed * rotateX;
      zSpeed *= -0.6; 
    }
    else zSpeed = 0;
    zCoordinate -= zSpeed;
  }
  
  void lateralCollision(){
    if(abs(xSpeed) < 0.5){ 
      xSpeed = 0; 
      return;
    }
    if(!soundPlaying){
      hitSpeed = xSpeed;
      thread("hitSound");
    }
    if (abs(xSpeed) > 0.1){ 
      xSpeed -= ballSpeed * rotateZ;
      xSpeed *= -0.6;
    }
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
    zCoordinate = 240;
    xCoordinate = 240;
  }
  
}
