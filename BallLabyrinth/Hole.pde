public class Hole {
  
  private final int xCoordinate;
  private final int zCoordinate;
  private final int holeWidth;
  
  public Hole(int xCoordinate, int zCoordinate) {
    this.xCoordinate = xCoordinate;
    this.zCoordinate = zCoordinate;
    this.holeWidth = 80;
  }
  
  public void drawHole() {
    pushMatrix();
    rotateX(PI/2);
    translate(0, 0, 11);
    pushStyle();
    fill(40, 40, 40);
    circle(xCoordinate, zCoordinate, holeWidth);
    popStyle();
    popMatrix();
  }
  
  public int getXCoordinate() {
    return this.xCoordinate;
  }
  
  public int getZCoordinate() {
    return this.zCoordinate;
  }
  
  public int getWidth() {
    return this.holeWidth;
  }
}
