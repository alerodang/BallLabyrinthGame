class Wall{
  private int centralXCoordinate, centralYCoordinate, centralZCoordinate;
  private int wallLength;
  private Orientation orientation;
  private int initialXCoordinate, endingXCoordinate, initialZCoorinate, endingZCoordinate;
  private int wallWidth;
  private final static int wallHeight = 40;
  
  public Wall(int x, int z, int wallLength, Orientation orientation){
    this.centralXCoordinate = x;
    this.centralYCoordinate = -30;
    this.centralZCoordinate = z;
    this.orientation = orientation;
    
    this.wallLength = wallLength;
    this.wallWidth = 20;
    
    this.initialXCoordinate = x - wallLength/2;
    this.endingXCoordinate = x + wallLength/2;
  
    this.initialZCoorinate = z - wallLength/2;
    this.endingZCoordinate = z + wallLength/2;
  }
  
  void drawWall(){
    pushMatrix();
    translate(this.centralXCoordinate,this.centralYCoordinate,this.centralZCoordinate);
    if(wallInXOrientation()) box(this.wallLength, wallHeight, this.wallWidth);
    else box(this.wallWidth, wallHeight, this.wallLength);
    popMatrix();
  }
  
  int getCentralXCoordinate(){
    return centralXCoordinate;
  }
    
  float getCentralZCoordinate(){
    return centralZCoordinate;
  }
  
  int getInitialXCoordinate(){
    return initialXCoordinate;
  }
  
  int getEndingXCoorinate(){
    return endingXCoordinate;
  }
  
  int getInitialXCoorinate(){
    return initialZCoorinate;
  }
  
  int getEndingZCoorinate(){
    return endingZCoordinate;
  }
  
  Orientation getOrientation(){
    return this.orientation;
  }
  
  int getWidth() {
    return this.wallWidth;
  }
  
  private boolean wallInXOrientation() {
    return this.orientation == Orientation.X;
  }
}
