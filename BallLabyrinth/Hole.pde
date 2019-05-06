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
    translate(0, 0, 10);
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
  
  /*void drawCylinder(int sides, float r, float h) {
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // draw top shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight );    
    }
    endShape(CLOSE);
    // draw bottom shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight );    
    }
    endShape(CLOSE);
  } */
}
