class Tile {
  Category category;
  Owner owner;
  Type type;
  int posX;
  int posY;
  int health;
  int attack;
  int speed;
  boolean hasSpawned;
  float range = 1.5;
  int movesRemaining = 0;
  int attacksRemaining = 0;
  
  boolean glowing = false;
  int glow = 0;

  Tile(Category category, Owner owner, Type type, int posX, int posY){
    this.category = category;
    this.owner = owner;
    this.type = type;
    this.posX = posX;
    this.posY = posY;
  }

  void update(int health, int attack, int speed){
    this.health = health;
    this.attack = attack;
    this.speed = speed;
  }
  
  PImage getImage() {
    return null;
  }
  
  void updateInfo() {}
  void clearInfo(){}
 
  void draw() {
    
    
    if (category == Category.Unit){
        strokeWeight(4);
      if (owner == owner.White){
        stroke(255);
        noFill();
        rect(marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
        stroke(0);
      }
      else{
        stroke(0);
        noFill();
        rect(marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
      }
        strokeWeight(1);
        stroke(0);
      rect(marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
    }//Draw image
    if (type == Type.Pawn) {
      image(Image_pawn, marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
    }
    else if (type == Type.Knight) {
      image(Image_knight, marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
    }
    else if (type == Type.Horseman) {
      image(Image_horseman, marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
    }
    
    else if (type == Type.Spawner) {
      image(Image_spawner, marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
    }
    else if (type == Type.Wall) {
      image(Image_wall, marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
    }
    
    if (category != Category.Terrain){
      textAlign(LEFT);
      textSize(14);
      if (owner == Owner.White)
        fill(255);
      else if (owner == Owner.Black)
        fill(0); 
      text(attack + " " + health + " " + speed,marginLeft+tileSize*posX, marginTop+tileSize*posY + tileSize);
        fill(255);
    }
  }
 
  void drawAvailableMoves(){
 
  }
};
 
 
