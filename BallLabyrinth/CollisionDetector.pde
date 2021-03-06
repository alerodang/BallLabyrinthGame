class CollisionDetector{
  
  private final Board board;
  private final Ball ball;
  private boolean frontalCollision, lateralCollision;
  
  public CollisionDetector(Board board, Ball ball) {
    this.board = board;
    this.ball = ball;
  }
  
  void detectCollisions(){    
    frontalCollision = false;
    lateralCollision = false;
    for (Wall wall : board.getWalls()){
      if (!frontalCollision && ball.getZSpeed() > 0) horizontalCollisionController(wall.getBottomCollider());
      else if (!frontalCollision && ball.getZSpeed() < 0) horizontalCollisionController(wall.getTopCollider());
      if (!lateralCollision && ball.getXSpeed() < 0) verticalCollisionController(wall.getRightCollider());
      else if (!lateralCollision && ball.getXSpeed() > 0) verticalCollisionController(wall.getLeftCollider());
      if (frontalCollision && lateralCollision) return;
    }
    ball.noCollision();
  }
  
  void horizontalCollisionController(int[] collider){
    if (abs(ball.getZCoordinate() - collider[0]) <= ball.getRadius()
    && (ball.getXCoordinate() + ball.getRadius()> collider[1]) && (ball.getXCoordinate() - ball.getRadius() < collider[2])) {
      ball.frontalCollision();
      frontalCollision = true;
    }
  }
  
  void verticalCollisionController(int[] collider){
    if (abs(ball.getXCoordinate() - collider[0]) <= ball.getRadius()
    && (ball.getZCoordinate() + ball.getRadius()> collider[1]) && (ball.getZCoordinate() - ball.getRadius()< collider[2])) {
      ball.lateralCollision();
      lateralCollision = true;
    }
  }
}
