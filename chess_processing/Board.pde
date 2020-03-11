class Board {
 
  Tile positions[][];
  int selectedX = -1;
  int selectedY = -1;
 
  Board() {
    positions = new Tile[boardSizeX][boardSizeY];
  }
 
  void setup() {
    //Initiating board to be empty with 2 spawners
    for (int x = 0; x < boardSizeX; x++) {
      for (int y = 0; y < boardSizeY; y++) {
        positions[x][y] = new Tile(Category.Terrain, Owner.Neutral, Type.Empty, x, y);
      }
    }
    positions[0][boardSizeY/2].setType(Type.Spawner);
    positions[boardSizeX-1][boardSizeY/2].setType(Type.Spawner);
    
    positions[10][10].setType(Type.Pawn);
    positions[10][10].setCategory(Category.Unit);
    positions[10][10].update(1,1,2);
    
    positions[20][10].setType(Type.Knight);
    positions[20][10].setCategory(Category.Unit);
    positions[20][10].update(5,5,5);
  }
 
 
  void draw() {
    //GUI
    background(0);
    fill(100);
    rect(5, 5, width - 10, height - 10);
    fill(180);
    rect(10,10,screenX + 20,screenY + 20);
    fill(240, 201, 104);
 
    //Draw tiles 
    boolean flip = false;
    for (int x = 0; x < boardSizeX; x++) {
      for (int y = 0; y < boardSizeY; y++) {
        if (flip) {
          if (positions[x][y].glowing)
            fill(30,130,30);
           else
            fill(130);
        } else {
          if (positions[x][y].glowing)
            fill(30,180,30);
           else
            fill(180);
        }
        flip = !flip;
        rect(marginLeft + tileSize * x, marginTop+ tileSize * y, tileSize, tileSize);
      }
      flip = !flip;
    }
    //Hover color
    if (selectedX >= 0 && selectedY >= 0){
      fill(50,200,50);
      rect(marginLeft + tileSize * selectedX, marginTop+ tileSize * selectedY, tileSize, tileSize);
    }
    
    //Draw the tile contents
    for (int x = 0; x < boardSizeX; x++) {
      for (int y = 0; y < boardSizeY; y++) {
        positions[x][y].draw();
      }
    }
  }
 
 void replace(Tile dest, Tile start){
   dest.attack = start.attack;
   dest.health = start.health;
   dest.speed = start.speed;
   dest.category = start.category;
   dest.owner = start.owner ;
   dest.type = start.type ;
 }
  void empty(Tile target){
   target.attack = 0;
   target.health = 0;
   target.speed = 0;
   target.category = Category.Terrain;
   target.owner = Owner.Neutral ;
   target.type = Type.Empty;
 }
 
 //Performing actual move (returns false on bad move)
  boolean move(int x1, int y1, int x2, int y2){
    System.out.println("  x1y1: " + positions[x1][y1].type + " " + x1 + "," + y1);
    System.out.println("  x2y2: " + positions[x2][y2].type + " " + x2 + "," + y2);
    
    if (0 <= x2 && x2 < boardSizeX && 0 <= y2 && y2 < boardSizeY){
      
      //If destination is empty, and selection is a unit 
      if (positions[x2][y2].type == Type.Empty && positions[x1][y1].category == Category.Unit){
          if (Math.pow(Math.pow(x1-x2,2) + Math.pow(y1-y2,2),0.5) < positions[x1][y1].speed){
            System.out.println("sucessful");
            replace(positions[x2][y2], positions[x1][y1]);
            empty(positions[x1][y1]);
            
            selectedX = x2;
            selectedY = y2;    
            for (int x = 0; x < boardSizeX; x++) {
              for (int y = 0; y < boardSizeY; y++) {
                positions[x][y].glowing = false;
              }
            }
            return true;
          }
      }
      
      
    }
    for (int x = 0; x < boardSizeX; x++) {
       for (int y = 0; y < boardSizeY; y++) {
         positions[x][y].glowing = false;
       }
    }
    return false;
  }
  
  //Display available moves (returns false on bad selection)
  boolean select(int xs, int ys){
    //display availble
    for (int x = 0; x < boardSizeX; x++) {
      for (int y = 0; y < boardSizeY; y++) {
        if (Math.pow(Math.pow(x-xs,2) + Math.pow(y-ys,2),0.5) < positions[xs][ys].speed){
          positions[x][y].glowing = true;
        }
      }
    }
    
      
    selectedX = xs;
    selectedY = ys;
    return true;
  }
 
}
