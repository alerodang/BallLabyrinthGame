class Ball{
  
  private float xCoordinate;
  private float zCoordinate;
  private boolean collisionUp = false;
  private boolean collisionDown = false;
  private boolean collisionLeft = false;
  private boolean collisionRight = false;
  private int radio;
  
  public Ball(int radio){
    this.radio = radio;
  }
    
  void drawBall(){
    updateBallPosition();
    pushMatrix();
    translate(xCoordinate,-45,zCoordinate);
    sphere(radio);
    popMatrix();
  }
  
  void updateBallPosition(){
    printPositionData();
            
    if (!ballIsCollisioningDown() && !ballIsCollisioningUp())
      zCoordinate -= ballSpeed * rotateX / 45;
    
    if (!ballIsCollisioningLeft() && !ballIsCollisioningRight())
      xCoordinate += ballSpeed * rotateZ / 45;
  }
  
  boolean ballIsCollisioningDown(){
    return collisionDown; // rotateX > 0 va hacia delante la bola
  } 
  boolean ballIsCollisioningUp(){
    return collisionUp; // rotateX < 0 va hacia atras la bola
  } 
  boolean ballIsCollisioningLeft (){
    return collisionLeft;
  } 
  boolean ballIsCollisioningRight(){
    return collisionRight;
  } 
  
  void printPositionData(){
    println(rotateX, collisionDown, collisionUp, ";", 
            rotateZ, collisionLeft, collisionRight, ";", 
            ballIsCollisioningDown(), ballIsCollisioningUp(), ";",
            ballIsCollisioningLeft(), ballIsCollisioningRight());
  }
  
  float getXCoordinate(){
    return xCoordinate;
  };
  
  float getZCoordinate(){
    return zCoordinate;
  };
  
  int getRadio(){
    return this.radio;
  }
  
  void setCollisionUp(boolean collisionUp){
    this.collisionUp = collisionUp;
  }
  
  void setCollisionDown(boolean collisionDown){
    this.collisionDown = collisionDown;
  }
  
  void setCollisionLeft(boolean collisionLeft){
    this.collisionLeft = collisionLeft;
  }
  
  void setCollisionRight(boolean collisionRight){
    this.collisionRight = collisionRight;
  }
  
}
