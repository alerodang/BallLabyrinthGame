class Board{
  
  private List<Wall> walls;
  private List<Hole> holes;
  private boolean playing;
  
  public Board(){
    walls = createWalls();
    holes = createHoles();
    playing = true;
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
    this.playing = false;
  }
  
  public boolean getPlaying() {
    return playing;
  }
  
  public void setPlaying(boolean playing) {
    this.playing = playing;
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
    
    walls.add(new Wall(100, 0, 400, Orientation.X));
    walls.add(new Wall(200, 150, 200, Orientation.X));
    walls.add(new Wall(-110, 150, 140, Orientation.X));
    
    walls.add(new Wall(0, -200, 200, Orientation.Z));
    walls.add(new Wall(-50, 210, 140, Orientation.Z));
    
    return walls;
  }
  
  private List<Hole> createHoles() {
    List<Hole> holes = new ArrayList();
    holes.add(new Hole(-230, 150));
    holes.add(new Hole(-230, -200));
    holes.add(new Hole(150, -60));
    return holes;
  }
}
