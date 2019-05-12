public class FallingDetector {
  
  private final Board board;
  private final Ball ball;
  
  public FallingDetector(Board board, Ball ball) {
    this.board = board;
    this.ball = ball;
  }
  
  public void detectFalling() {
    for (Hole hole : board.getHoles()) {
      if (ballIsOverHole(hole)) board.stopGame();
    }
  }
  
  private boolean ballIsOverHole(Hole hole) {
    
    int maximumDistanceToFall = hole.getWidth() / 3;
    
    return abs(hole.getXCoordinate() - ball.getXCoordinate()) < maximumDistanceToFall &&
           abs(hole.getZCoordinate() - ball.getZCoordinate()) < maximumDistanceToFall;
  }
}
