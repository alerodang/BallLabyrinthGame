class CollisionDetector{
  
  private final Board board;
  private final Ball ball;
  
  public CollisionDetector(Board board, Ball ball) {
    this.board = board;
    this.ball = ball;
  }
  
  void detectCollisions(){
    for (Wall wall : board.getWalls()){
      CollisionType collisionType = CollisionType.NONE;
      if (isAVerticalWall(wall)){
        collisionType = getHorizonalCollisionTypeWith(wall);
        updateCollisions(collisionType);
      } else if (isAnHorizontalWall(wall)){
        collisionType = getVerticalCollistionType(wall);
        updateCollisions(collisionType);
      }
      if (thereIsACollision(collisionType)) break;
    };
  }
  
  CollisionType getHorizonalCollisionTypeWith(Wall wall){
    if(wall.getInitialXCoordinate() < ball.getXCoordinate() + ball.getRadius() && ball.getXCoordinate() - ball.getRadius() < wall.getEndingXCoorinate()){
      if(detectCollisionBehind(wall)) {ball.frontalCollision(); return CollisionType.BEHIND;}
      else if(detectCollisionInFront(wall)) {ball.frontalCollision(); return CollisionType.INFRONT;}
    }
    return CollisionType.NONE;
  }
  
  boolean detectCollisionBehind(Wall wall){
    return(
      rotateX > 0 //Si va hacia arriba/el fondo
      && wall.getCentralZCoordinate() <= ball.getZCoordinate() //Si esta por debajo del muro/mas hacia la pantalla
      && abs(wall.getCentralZCoordinate() - ball.getZCoordinate()) <= wall.getWidth()/2 + ball.getRadius()); //Si toca el muro
  }
  
  boolean detectCollisionInFront(Wall wall){
    return(
      rotateX < 0 //Si va hacia abajo
      && wall.getCentralZCoordinate() >= ball.getZCoordinate() && //Si esta por encima del muro 
      abs(wall.getCentralZCoordinate() - ball.getZCoordinate()) <= wall.getWidth()/2 + ball.getRadius()); //Si toca el muro
  }
  
  CollisionType getVerticalCollistionType(Wall wall){
    if(wall.getInitialZCoorinate() < ball.getZCoordinate() - ball.getRadius() && ball.getZCoordinate()/2 < wall.getEndingZCoorinate()){
      if(detectCollisionRight(wall)) return CollisionType.RIGHT;
      else if(detectCollisionLeft(wall)) return CollisionType.LEFT;
    }
    return CollisionType.NONE;
  }
  
  boolean detectCollisionRight(Wall wall){
    println(wall.getCentralXCoordinate(), ball.getXCoordinate());
    return(
      rotateZ > 0 //Si va hacia la derecha
      && wall.getCentralXCoordinate() >= ball.getXCoordinate() && //Si la bola esta a la izq del muro 
      abs(wall.getCentralXCoordinate() - ball.getXCoordinate()) <= wall.getWidth()/2 + ball.getRadius()); //Si toca el muro
  }
  
  boolean detectCollisionLeft(Wall wall){
    println(wall.getCentralXCoordinate(), ball.getXCoordinate());
    return(
      rotateZ < 0 //Si va hacia izq
      && wall.getCentralXCoordinate() <= ball.getXCoordinate() && //Si esta a la derecha del muro 
      abs(wall.getCentralXCoordinate() - ball.getXCoordinate()) <= wall.getWidth()/2 + ball.getRadius()); //Si toca el muro
  }
  
  private boolean thereIsACollision(CollisionType collisionType) {
    return collisionType == CollisionType.BEHIND ||
           collisionType == CollisionType.INFRONT ||
           collisionType == CollisionType.RIGHT ||
           collisionType == CollisionType.LEFT;
  }
  
  private void updateCollisions(CollisionType collisionType) {
    if (collisionType == CollisionType.BEHIND) {
      ball.setCollisionBehind(true);
      ball.setCollisionInFront(false);
    } else if (collisionType == CollisionType.INFRONT) {
      ball.setCollisionBehind(false);
      ball.setCollisionInFront(true);
    } else if (collisionType == CollisionType.RIGHT) {
      ball.setCollisionRight(true);
      ball.setCollisionLeft(false);
    } else if (collisionType == CollisionType.LEFT) {
      ball.setCollisionRight(false);
      ball.setCollisionLeft(true);
    } else {
      ball.setCollisionInFront(false);
      ball.setCollisionBehind(false);
    }
  }
  
  private boolean isAVerticalWall(Wall wall) {
    return wall.getOrientation() == Orientation.X;
  }
  
  private boolean isAnHorizontalWall(Wall wall) {
    return wall.getOrientation() == Orientation.Z;
  }
}


/*void detectZAxisCollisions(){
  if(ball.getZCoordinate() >= board.getFrontWall().getZCoordinate()){ //Esto debe aplicarse a cada muro mas al frente que la bola
    ball.setCollisionDown(true);
    ball.setCollisionUp(false);
  }
  else if(ball.getZCoordinate() <= board.getBottomWall().getZCoordinate()){ //Esto debe aplicarse a cada muro mas al fondo que la bola
    ball.setCollisionDown(false);
    ball.setCollisionUp(true);
  } else {
    ball.setCollisionDown(false);
    ball.setCollisionUp(false);
  }
}
*/
