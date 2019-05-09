class Wall{
  private int centralXCoordinate, centralYCoordinate, centralZCoordinate;
  private int wallLength;
  private Orientation orientation;
  private int leftXCoord, rightXCoord;
  private int topZCoord, bottomZCoord;
  private final static int wallHeight = 40, wallWidth = 20;
  private final PShape box;
  
  public Wall(int x, int z, int wallLength, Orientation orientation, PImage texture){
    this.centralXCoordinate = x;
    this.centralYCoordinate = -30;
    this.centralZCoordinate = z;
    this.orientation = orientation;
    
    this.wallLength = wallLength;
    
    if (wallInXOrientation()){
      leftXCoord = x - wallLength / 2;
      rightXCoord = x + wallLength / 2;
      topZCoord = z - wallWidth / 2;
      bottomZCoord = z + wallWidth / 2;
      box = createShape(BOX, this.wallLength, wallHeight, wallWidth);
    } else {
      leftXCoord = x - wallWidth / 2;
      rightXCoord = x + wallWidth / 2;
      topZCoord = z - wallLength / 2;
      bottomZCoord = z + wallLength / 2;
      box = createShape(BOX, wallWidth, wallHeight, this.wallLength);
    }
    box.setTexture(texture);
  }
  
  void drawWall(){
    pushMatrix();
    translate(this.centralXCoordinate, this.centralYCoordinate, this.centralZCoordinate);
    noStroke();
    shape(box);
    popMatrix();
  }
  private boolean wallInXOrientation() {
    return this.orientation == Orientation.X;
  }
  
  int[] getTopCollider(){
    return new int[]{topZCoord, leftXCoord, rightXCoord};
  }
  
  int[] getBottomCollider(){
    return new int[]{bottomZCoord, leftXCoord, rightXCoord};
  }
  
  int[] getLeftCollider(){
    return new int[]{leftXCoord, topZCoord, bottomZCoord};
  }
  
  int[] getRightCollider(){
    return new int[]{rightXCoord, topZCoord, bottomZCoord};
  }  
}
