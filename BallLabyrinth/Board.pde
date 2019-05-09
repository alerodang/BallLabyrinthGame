class Board{
  
  private List<Wall> walls;
  private List<Hole> holes;
  private boolean playing;
  private PImage texture;
  
  public Board(){
    texture = loadImage("wood.jpg");
    walls = createWalls();
    holes = createHoles();
    playing = true;
  }
  
  void drawBoard(){
    PShape box = createShape(BOX, 600, 20, 600);
    box.setTexture(texture);
    shape(box);
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
    walls.add(new Wall(0, 290, 600, Orientation.X, texture)); //front/dwon
    walls.add(new Wall(0, -290, 600, Orientation.X, texture)); //bottom/up
    walls.add(new Wall(290, 0, 600, Orientation.Z, texture)); //right
    walls.add(new Wall(-290, 0, 600, Orientation.Z, texture)); //left
    
    walls.add(new Wall(100, 0, 400, Orientation.X, texture));
    walls.add(new Wall(200, 150, 200, Orientation.X, texture));
    walls.add(new Wall(-112, 150, 140, Orientation.X, texture));
    
    walls.add(new Wall(0, -200, 200, Orientation.Z, texture));
    walls.add(new Wall(-50, 210, 140, Orientation.Z, texture));
    
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
