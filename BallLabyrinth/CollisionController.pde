class CollisionController{
  
  void detectCollisions(){
    for (Wall wall : walls){
      if (wall.getOrientation() == 'x' && detectCollisionsWithHorizontalWall(wall)) break;
    };
    for (Wall wall : walls){
      if (wall.getOrientation() == 'z' && detectCollisionsWithVerticalWall(wall)) break;
    };
  }
  
  boolean detectCollisionsWithHorizontalWall(Wall wall){
    if(wall.getX0() < ball.getXCoordinate() && ball.getXCoordinate() < wall.getX1()){
      if(detectCollisionUp(wall)){
        ball.setCollisionUp(true);
        ball.setCollisionDown(false);
        return true;
      }
      else if(detectCollisionDown(wall)){
        ball.setCollisionUp(false);
        ball.setCollisionDown(true);
        return true;
      } else {
        ball.setCollisionDown(false);
        ball.setCollisionUp(false);
      }
    }
    return false;
  }
  
  boolean detectCollisionUp(Wall wall){
    return(
      rotateX > 0 //Si va hacia arriba/el fondo
      && wall.getZCoordinate() <= ball.getZCoordinate() //Si esta por debajo del muro/mas hacia la pantalla
      && abs(wall.getZCoordinate() - ball.getZCoordinate()) < wall.getWidth()); //Si toca el muro
  }
  
  boolean detectCollisionDown(Wall wall){
    return(
      rotateX < 0 //Si va hacia abajo
        && wall.getZCoordinate() >= ball.getZCoordinate() && //Si esta por encima del muro 
        abs(wall.getZCoordinate() - ball.getZCoordinate()) < wall.getWidth()); //Si toca el muro
  }
  
  boolean detectCollisionsWithVerticalWall(Wall wall){
    if(wall.getZ0() < ball.getZCoordinate() && ball.getZCoordinate() < wall.getZ1()){
      if(detectCollisionRight(wall)){
        ball.setCollisionRight(true);
        ball.setCollisionLeft(false);
        return true;
      }
      else if(detectCollisionLeft(wall)){
        ball.setCollisionRight(false);
        ball.setCollisionLeft(true);
        return true;
      } else {
        ball.setCollisionRight(false);
        ball.setCollisionLeft(false);
      }
    }
    return false;
  }
  
  boolean detectCollisionRight(Wall wall){
    println(wall.getXCoordinate(), ball.getXCoordinate());
    return(
      rotateZ > 0 //Si va hacia la derecha
      && wall.getXCoordinate() >= ball.getXCoordinate() && //Si la bola esta a la izq del muro 
      abs(wall.getXCoordinate() - ball.getXCoordinate()) <= wall.getWidth()); //Si toca el muro
  }
  
  boolean detectCollisionLeft(Wall wall){
    println(wall.getXCoordinate(), ball.getXCoordinate());
    return(
      rotateZ < 0 //Si va hacia izq
      && wall.getXCoordinate() <= ball.getXCoordinate() && //Si esta a la derecha del muro 
      abs(wall.getXCoordinate() - ball.getXCoordinate()) < wall.getWidth()); //Si toca el muro
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
