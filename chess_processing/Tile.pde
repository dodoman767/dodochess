class Tile {
  Category category;
  Owner owner;
  Type type;
  int posX;
  int posY;
  int health;
  int attack;
  int speed;
  
  boolean glowing = false;

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
  
  void setType(Type type){
    this.type = type;
  }  
  Type getType(){
    return this.type;
  }
  void setCategory(Category category){
    this.category = category;
  }
  
  Category getCategory(){
    return this.category;
  }
 
  PImage getImage() {
    return null;
  }
 
  void draw() {
    if (type == Type.Pawn) {
      image(Image_pawn, marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
    }
    else if (type == Type.Knight) {
      image(Image_knight, marginLeft+tileSize*posX, marginTop+tileSize*posY, tileSize, tileSize);
    }
    
    if (category != Category.Terrain){
      textSize(14);
      fill(255);
      text(health + " " + attack + " " + speed,marginLeft+tileSize*posX, marginTop+tileSize*posY + tileSize);
    }
  }
 
  void drawAvailableMoves(){
 
  }
};
 
class Pawn extends Tile {
  Pawn(Owner owner, int x, int y) {
    super(Category.Unit, owner, Type.Pawn, x, y);
  }
  PImage getImage() {
    return Image_pawn;
  }
  void drawAvailableMoves(){
    fill(240);
 
  }
};

class Knight extends Tile {
  Knight(Owner owner, int x, int y) {
    super(Category.Unit, owner, Type.Knight, x, y);
  }
  PImage getImage() {
    return Image_knight;
  }
  void drawAvailableMoves(){
    fill(240);
  }
};
