class Board{
  
  private List<Wall> walls;
  
  public Board(){
    walls = new ArrayList();
    walls.add(new Wall(0, 290, 600, Orientation.X)); //front/dwon
    walls.add(new Wall(0, -290, 600, Orientation.X)); //bottom/up
    walls.add(new Wall(290, 0, 600, Orientation.Z)); //right
    walls.add(new Wall(-290, 0, 600, Orientation.Z)); //left
    walls.add(new Wall(0, 100, 200, Orientation.X));

  }
  
  void drawBoard(){
    box(600, 20, 600);
    this.drawWalls();
  }
  
  List<Wall> getWalls(){
    return walls;
  }
  
  private void drawWalls(){
    for (Wall wall : walls) wall.drawWall();
  }
}
