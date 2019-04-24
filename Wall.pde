class Wall{
  private int xCoordinate, yCoordinate, zCoordinate;
  private int wallLength;
  private int xLength, zLength;
  private char orientation;
  private int x0, x1, z0, z1;
  private int wallWidth;
  
  public Wall(int x, int y, int z, int wallLength, int wallWidth, char orientation){
    this.xCoordinate = x;
    this.yCoordinate = y;
    this.zCoordinate = z;
    this.wallLength = wallLength;
    this.orientation = orientation;
    this.wallWidth = wallWidth;
    if (orientation == 'x'){
      xLength = wallLength;
      zLength = 20;
      x0 = x - wallLength/2;
      x1 = x + wallLength/2;
    } else if (orientation == 'z'){
      xLength = 20;
      zLength = wallLength;
      z0 = z - wallLength/2;
      z1 = z + wallLength/2;
    }
  }
  
  void drawWall(){
    pushMatrix();
    translate(this.xCoordinate,this.yCoordinate,this.zCoordinate);
    box(xLength,40,zLength);
    popMatrix();
  }
  
  int getXCoordinate(){
    return xCoordinate;
  }
    
  float getZCoordinate(){
    return zCoordinate;
  }
  
  int getX0(){
    return x0;
  }
  
  int getX1(){
    return x1;
  }
  
  int getZ0(){
    return z0;
  }
  
  int getZ1(){
    return z1;
  }
  
  char getOrientation(){
    return this.orientation;
  }
  
  int getWidth(){
    return this.wallWidth;
  }
}
