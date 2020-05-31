class Board {
 
  Tile positions[][];
  int selectedX = -1;
  int selectedY = -1;
  Tile queuedTile;
  int queuedCost;
 
  int[][] map1 = {
{0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0},
{0,0,0,0,0,0,0,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
{0,0,1,0,0,1,0,0,1,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,1,0},
{0,0,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0},
{0,0,1,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,1,1,0},
{0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0},
{0,0,0,0,0,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,1,0,0,1,0,0},
{0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0},
{0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
{0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
{0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
{0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
{0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
{0,0,0,0,0,1,0,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0},
{0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0},
{0,0,0,0,0,1,1,1,1,1,1,1,0,1,0,0,0,0,1,1,1,1,1,1,1,0,0,1,0,0},
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,0,0},
{0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,0,0,0,1,0,0},
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0}};
 
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
    positions[0][boardSizeY/2].type = Type.Spawner;
    positions[0][boardSizeY/2].owner = Owner.White;
    positions[boardSizeX-1][boardSizeY/2].type = Type.Spawner;
    positions[boardSizeX-1][boardSizeY/2].owner = Owner.Black;
    
    //Map generation
    for (int i= 0; i < map1.length; i++){
      for (int j= 0; j < map1[0].length; j++){
        if (map1[i][j] == 1){
          positions[j][i].type = Type.Wall;
          positions[j][i].owner = Owner.Neutral;
          positions[j][i].category = Category.Terrain;
        }
      }
    }
    
  }
 
 
  void draw() {
    //GUI
    background(0);
    fill(100);
    rect(5, 5, width - 10, height - 10);
    
    if (playerTurn == Owner.White)
      fill(255);
    if (playerTurn == Owner.Black)
      fill(0);
    rect(10,10,screenX + 20,screenY + 20);
    fill(240, 201, 104);
 
    //Draw tiles 
    boolean flip = false;
    for (int x = 0; x < boardSizeX; x++) {
      for (int y = 0; y < boardSizeY; y++) {
        //Tile pattern
        if (flip) {
          if (x >= boardSizeX/2){ fill(50);  }
             else{ fill(180);  }
        } else {
           if (x >= boardSizeX/2){  fill(80); }
           else{ fill(210);  }
        }
        flip = !flip;
        if (positions[x][y].glowing){
              fill(30,130 + positions[x][y].glow,30);
          }
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
 void clearGlowing(){
   System.out.println("CLEAR");
  for (int x = 0; x < boardSizeX; x++) {
              for (int y = 0; y < boardSizeY; y++) {
                positions[x][y].glowing = false;
                positions[x][y].glow = 0;
              }
            } 
 }
 
 
 //Performing actual move (returns false on bad move)
  boolean move(int x1, int y1, int x2, int y2){
    
    if (0 <= x2 && x2 < boardSizeX && 0 <= y2 && y2 < boardSizeY){
      
      //If destination is empty, and selection is a unit 
      if (positions[x2][y2].type == Type.Empty && positions[x1][y1].category == Category.Unit){
          if (positions[x2][y2].glowing){
            replace(positions[x2][y2], positions[x1][y1]);
            empty(positions[x1][y1]);
            selectedX = -1;
            selectedY = -1;   
            clearGlowing();
            return true;
          }
      }
      
      //Unit attack/interact Unit (MELEE)
      else if (positions[x2][y2].category == Category.Unit && positions[x1][y1].category == Category.Unit &&
               Math.pow(Math.pow(x1-x2,2) + Math.pow(y1-y2,2),0.5) <= positions[x1][y1].range){
          //Attacking own teammate
         if (positions[x2][y2].owner == positions[x1][y1].owner){ }
         //Attacking Opponent unit
         else{ 
           if (positions[x2][y2].health <= positions[x1][y1].attack){ //Can kill
             replace(positions[x2][y2], positions[x1][y1]);
             empty(positions[x1][y1]);
           }
           else{
             positions[x2][y2].health -= positions[x1][y1].attack;
           }
         }
        
      } //Unit attack/interact structure
      else if (positions[x2][y2].category == Category.Structure && positions[x1][y1].category == Category.Unit){
          //Interact own structure
         if (positions[x2][y2].owner == positions[x1][y1].owner){
           
         }
         //Attacking Opponent structure
         else{
           
         }
      }
      //Spawn new unit
        else if (positions[x2][y2].type == Type.Empty && positions[x1][y1].type == Type.Spawner){
          if (positions[x1][y1].owner != playerTurn){
            clearGlowing();
            JOptionPane.showMessageDialog(null,  
              "Not your spawner!", "Hey thats cheating!",JOptionPane.INFORMATION_MESSAGE);
            return false;
          }
          if (Math.pow(Math.pow(x1-x2,2) + Math.pow(y1-y2,2),0.5) > 2){
            clearGlowing();
            JOptionPane.showMessageDialog(null, 
              "Too far from that spawner!", "Hey thats cheating!", JOptionPane.INFORMATION_MESSAGE);
            return false;
          }
          if (playerTurn == Owner.White && whiteGold >= queuedCost){
            whiteGold -= queuedCost;
          }
          else if (playerTurn == Owner.Black && blackGold >= queuedCost){
            blackGold -= queuedCost;
          }
          else { 
            JOptionPane.showMessageDialog(null, 
              "Get more money peasant!", "Hey thats cheating!", JOptionPane.INFORMATION_MESSAGE);
              clearGlowing();
            return false;
          }
           try{
             positions[x2][y2].owner = playerTurn;
             positions[x2][y2].category = queuedTile.category;
             positions[x2][y2].type = queuedTile.type;
             positions[x2][y2].health = queuedTile.health;
             positions[x2][y2].attack = queuedTile.attack;
             positions[x2][y2].speed = queuedTile.speed;
           }catch
              (Exception E){
                clearGlowing();
            JOptionPane.showMessageDialog(null, 
              "Select a unit first!", "You're trolling!", JOptionPane.INFORMATION_MESSAGE);
              return false; 
           }
           queuedTile = null;
      }
    }
    selectedX = -1;
    selectedY = -1;
    clearGlowing();
    return true;
  }
  //Remove disjointed glowing
  void fixGlowing(int xs, int ys)  {
    for (int x = 0; x < boardSizeX; x++) {
      for (int y = 0; y < boardSizeY; y++) {
        if (positions[x][y].glowing){
          Point start = new Point(xs,ys);
          Point end = new Point(x,y);
          int distance = BFS(positions, start, end);
          //System.out.println("start:" +x+ " " +y+ " end:" +xs+ " " +ys+ " >" + distance);
          
            positions[x][y].glow = 10 * distance;
          if (distance > positions[xs][ys].speed){
            positions[x][y].glowing = false;
          }
        }
      }
    }
    draw();
  }
  
  //Display available moves (returns false on bad selection)
  boolean select(int xs, int ys){
    if (positions[xs][ys].owner != playerTurn)
      return false;
    
    //Spawner select
    if (positions[xs][ys].type == Type.Spawner){
      if (positions[xs][ys].owner != playerTurn){
        clearGlowing();
        return false;
      }
      for (int x = 0; x < boardSizeX; x++) {
        for (int y = 0; y < boardSizeY; y++) {
          if (Math.pow(Math.pow(x-xs,2) + Math.pow(y-ys,2),0.5) <= 2
          && !(x == xs && y == ys)){
            positions[x][y].glowing = true;
          } } }
      selectedX = xs;
      selectedY = ys;
      return true;
    }
    
    //Move select
    for (int x = 0; x < boardSizeX; x++) {
      for (int y = 0; y < boardSizeY; y++) {
        if (Math.pow(Math.pow(x-xs,2) + Math.pow(y-ys,2),0.5) <= positions[xs][ys].speed
        && !(x == xs && y == ys)){
          positions[x][y].glowing = true;
        } } }
    fixGlowing(xs, ys);
   
    selectedX = xs;
    selectedY = ys;
    positions[xs][ys].updateInfo();
    return true;
  }
  void deselect(int xs, int ys){
    clearGlowing();
    selectedX = -1;
    selectedY = -1;
    positions[xs][ys].clearInfo();
  }
 
}
