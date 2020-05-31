class Button {
  
 int x;
 int y;
 String name;
 Type type;
 int[] stats;
 int cost;
 float size = 80;
 boolean isHover = false;
 PImage image;
 Tile queuedTile;
 
  Button(int x, int y, String name)
  {
    this.x = x;
    this.y = y;
    this.name = name;
    
  }
  
  void show ()
  {
    checkHover();
    if (isHover){
      fill(255);
      rect(x-4,y-4,size+8,size+8);
    }
   
    if (board.queuedTile != null){
     if (type == board.queuedTile.type){
       fill(0,255,0);
       rect(x-4,y-4,size+8,size+8);
     }}
    
   fill(50);
   rect(x,y,size,size);
   rect(x+5,y+5,size-10,size-10);
   if (name.equals("pawn")){
     image = Image_pawn;
     type = Type.Pawn;
     stats = pawn_stats;
     cost = 1;
   }
   else if (name.equals("knight")){
      image = Image_knight;
     type = Type.Knight;
     stats = knight_stats;
     cost = 3;
   }
   else if (name.equals("horseman")){
      image = Image_horseman;
     type = Type.Horseman;
     stats = horseman_stats;
     cost = 5;
   }
  
   image(image,x+10,y+10,60,60);
   fill(255);
   textSize(18);
   textAlign(CENTER);
   text(name, x + 40, y + 90);

 }
 //////////////////////////////////////////////////////////////
 void update() 
  {
  }
  
  void checkHover(){
    if (x <= mouseX && mouseX <= x + size && y <= mouseY && mouseY <= y + size){
      isHover = true;
    }
    else{
      isHover = false;
    }
  }
  
  void mouseAction(){
      if (isHover){
          queuedTile = new Tile(Category.Unit, playerTurn, type, -1, -1);
          queuedTile.update(stats[0],stats[1],stats[2]); 
          board.queuedTile = queuedTile;
          board.queuedCost = cost;
      }
  }
  
}
