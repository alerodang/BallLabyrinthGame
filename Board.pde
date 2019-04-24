class Board{
  
  private List<Wall> walls;
  
  public Board(){
    walls = new ArrayList();
    walls.add(new Wall(0,-30,290,600,40,'x')); //front/dwon
    walls.add(new Wall(0,-30,-290,600,40,'x')); //bottom/up
    walls.add(new Wall(290,-30,0,600,40,'z')); //right
    walls.add(new Wall(-290,-30,0,600,40,'z')); //left
    walls.add(new Wall(0,-30,100,200,40,'x'));

  }
  
  void drawBoard(){
    box(600, 20, 600);
  }
  
  List<Wall> getWalls(){
    return walls;
  }
  
  void drawWalls(){
    for (Wall wall : walls){
      wall.drawWall();
    }
  }
}
