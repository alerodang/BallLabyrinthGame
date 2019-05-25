class Board{
  
  private List<Wall> walls;
  private List<Hole> holes;
  private boolean playing;
  private boolean won;
  private PImage texture;
  private PImage flagTexture;
  private PShape endFlag;
  private PShape box;
  
  public Board(){
    texture = loadImage("wood.jpg");
    walls = createWalls();
    holes = createHoles();
    playing = true;
    won = false;
    endFlag = loadShape("Flag/obj/objFlag.obj");
    flagTexture = loadImage("flag.jpg");
    endFlag.setTexture(flagTexture);
    box = createShape(BOX, 600, 20, 600);
    box.setTexture(texture);
  }
  
  void drawBoard(){
    shape(box);
    this.drawWalls();
    this.drawHoles();
    drawFlag();
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
  
  public boolean getWon() {
    return won;
  }
  
  public void setPlaying(boolean playing) {
    this.playing = playing;
  }
  
  public void setWon(boolean won) {
    this.won = won;
  }
  
  private void drawWalls(){
    for (Wall wall : walls) wall.drawWall();
  }
  
  private void drawHoles() {
    for (Hole hole : holes) hole.drawHole();
  }
  
  private List<Wall> createWalls() {
    List<Wall> walls = new ArrayList();
    walls.add(new Wall(0, 290, 600, Orientation.X, texture)); 
    walls.add(new Wall(0, -290, 600, Orientation.X, texture));
    walls.add(new Wall(290, 0, 600, Orientation.Z, texture));
    walls.add(new Wall(-290, 0, 600, Orientation.Z, texture));
    
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
  
  
  
  private void drawFlag() {
    pushMatrix();
    pushStyle();
    rotateX(PI);
    translate(230, 10, 230);
    scale(8);
    shape(endFlag);
    popStyle();
    popMatrix();
  }
}
