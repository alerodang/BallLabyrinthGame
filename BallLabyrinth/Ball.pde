class Ball {
  
  private float xCoordinate;
  private float zCoordinate;
  private float xSpeed, zSpeed;
  private boolean collisionBehind = false;
  private boolean collisionInfront = false;
  private boolean collisionLeft = false;
  private boolean collisionRight = false;
  private final int radius;
  private final float ballSpeed;
  
  public Ball(int radius, int ballSpeed){
    this.radius = radius;
    this.ballSpeed = (float)ballSpeed / 400.;
  }
    
  void drawBall(){
    updateBallPosition();
    pushMatrix();
    translate(xCoordinate,-45,zCoordinate);
    sphere(radius);
    println(zSpeed);
    popMatrix();
  }
  
  void updateBallPosition(){
    //printPositionData();
    zSpeed += ballSpeed * rotateX;
    xSpeed += ballSpeed * rotateZ;
            
    if (!ballIsCollisioningInfront() && !ballIsCollisioningBehind())
      zCoordinate -= zSpeed;
    
    if (!ballIsCollisioningLeft() && !ballIsCollisioningRight())
      xCoordinate += xSpeed;
  }
  
  void frontalCollision(){
    if (zSpeed > 0.1) zSpeed *= -0.6;
    else zSpeed = 0;
    zCoordinate -= zSpeed;
  }
  
  boolean ballIsCollisioningInfront(){
    return collisionInfront; // rotateX > 0 va hacia delante la bola
  } 
  boolean ballIsCollisioningBehind(){
    return collisionBehind; // rotateX < 0 va hacia atras la bola
  } 
  boolean ballIsCollisioningLeft (){
    return collisionLeft;
  } 
  boolean ballIsCollisioningRight(){
    return collisionRight;
  } 
  
  void printPositionData(){
    println(rotateX, collisionInfront, collisionBehind, ";", 
            rotateZ, collisionLeft, collisionRight, ";", 
            ballIsCollisioningInfront(), ballIsCollisioningBehind(), ";",
            ballIsCollisioningLeft(), ballIsCollisioningRight());
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
  
  void setCollisionBehind(boolean collisionBehind){
    this.collisionBehind = collisionBehind;
  }
  
  void setCollisionInFront(boolean collisionInfront){
    this.collisionInfront = collisionInfront;
  }
  
  void setCollisionLeft(boolean collisionLeft){
    this.collisionLeft = collisionLeft;
  }
  
  void setCollisionRight(boolean collisionRight){
    this.collisionRight = collisionRight;
  }
  
  void resetCollisions() {
    this.collisionRight = false;
    this.collisionLeft = false;
    this.collisionBehind = false;
    this.collisionInfront = false;
  }
  
}
