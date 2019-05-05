class Wall{
  private int centralXCoordinate, centralYCoordinate, centralZCoordinate;
  private int wallLength;
  private Orientation orientation;
  private int leftXCoord, rightXCoord;
  private int topZCoord, bottomZCoord;
  private final static int wallHeight = 40, wallWidth = 20;
  
  public Wall(int x, int z, int wallLength, Orientation orientation){
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
    } else {
      leftXCoord = x - wallWidth / 2;
      rightXCoord = x + wallWidth / 2;
      topZCoord = z - wallLength / 2;
      bottomZCoord = z + wallLength / 2;
    }
  }
  
  void drawWall(){
    pushMatrix();
    translate(this.centralXCoordinate,this.centralYCoordinate,this.centralZCoordinate);
    if(wallInXOrientation()) box(this.wallLength, wallHeight, wallWidth);
    else box(wallWidth, wallHeight, this.wallLength);
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
