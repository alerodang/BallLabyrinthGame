class Board{
  
  private List<Wall> walls;
  private List<Hole> holes;
  
  public Board(){
    walls = createWalls();
    holes = createHoles();
  }
  
  void drawBoard(){
    box(600, 20, 600);
    this.drawWalls();
    this.drawHoles();
  }
  
  List<Wall> getWalls(){
    return walls;
  }
  
  List<Hole> getHoles(){
    return holes;
  }
  
  public void stopGame() {
    println("End of game");
    delay(5000);
  }
  
  private void drawWalls(){
    for (Wall wall : walls) wall.drawWall();
  }
  
  private void drawHoles() {
    for (Hole hole : holes) hole.drawHole();
  }
  
  private List<Wall> createWalls() {
    List<Wall> walls = new ArrayList();
    walls.add(new Wall(0, 290, 600, Orientation.X)); //front/dwon
    walls.add(new Wall(0, -290, 600, Orientation.X)); //bottom/up
    walls.add(new Wall(290, 0, 600, Orientation.Z)); //right
    walls.add(new Wall(-290, 0, 600, Orientation.Z)); //left
    walls.add(new Wall(0, 100, 200, Orientation.X));
    return walls;
  }
  
  private List<Hole> createHoles() {
    List<Hole> holes = new ArrayList();
    holes.add(new Hole(-240, 240));
    return holes;
  }
}
