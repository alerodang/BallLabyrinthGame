public class VictoryDetector {
  
  private final Board board;
  private final Ball ball;
  
  public VictoryDetector (Board board, Ball ball) {
    this.board = board;
    this.ball = ball;
  }
  
  public void checkVictory() {
    if (abs(ball.getXCoordinate() - 230) < ball.getRadius() && 
        abs(ball.getZCoordinate() + 230) < ball.getRadius()) {
          
      board.setWon(true);
    }
  }
  
}
