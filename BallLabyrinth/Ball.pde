class Ball {
  
  private float xCoordinate;
  private float zCoordinate;
  private boolean collisionBehind = false;
  private boolean collisionInfront = false;
  private boolean collisionLeft = false;
  private boolean collisionRight = false;
  private final int radius, ballSpeed;
  
  public Ball(int radius, int ballSpeed){
    this.radius = radius;
    this.ballSpeed = ballSpeed;
  }
    
  void drawBall(){
    updateBallPosition();
    pushMatrix();
    translate(xCoordinate,-45,zCoordinate);
    sphere(radius);
    popMatrix();
  }
  
  void updateBallPosition(){
    printPositionData();
            
    if (!ballIsCollisioningInfront() && !ballIsCollisioningBehind())
      zCoordinate -= ballSpeed * rotateX / 45;
    
    if (!ballIsCollisioningLeft() && !ballIsCollisioningRight())
      xCoordinate += ballSpeed * rotateZ / 45;
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
