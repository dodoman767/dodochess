enum Owner { White, Black, Neutral };
enum Type { Empty, Wall, Spawner, Pawn, Knight, Horseman }; //Add more later
enum Category { Unit, Structure, Terrain };

//Settings variables
int boardSizeX = 30;
int boardSizeY = 20;
int tileSize = 40;
int marginTop = 20, marginLeft = 20, marginBot = 150, marginRight = 100;
int screenX = boardSizeX * tileSize;
int screenY = boardSizeY * tileSize;

//Program variables
boolean validTurn = false;
boolean selected = false;
int x1, x2, y1, y2;

Board board;
Player white;
Player black;

Owner playerTurn = Owner.White;
int remainingMoves = 3;

PImage Image_pawn, Image_knight, Image_horseman;

void setup(){
  size(1600, 900);
  background(#00E3FF);
  Image_pawn = loadImage("unit_hoodie.png");
  Image_knight = loadImage("unit_tree.png");
  Image_horseman = loadImage("unit_horseman.png");

  board = new Board();
  board.setup();
  white = new Player();
  black = new Player();
}

void draw(){
  board.draw();
}

void mousePressed()
{
    int xPos = (int)Math.floor((mouseX - marginLeft) / tileSize);
    int yPos = (int)Math.floor((mouseY - marginTop) / tileSize);
    
    //Tileclick animation
    if (0 <= xPos && xPos < boardSizeX && 0 <= yPos && yPos < boardSizeY){
      fill(10);
      rect(marginLeft + tileSize * xPos, marginTop+ tileSize * yPos, tileSize, tileSize);
    }
    
    //Initial selection
    if (!selected) {
        x1 = xPos;
        y1 = yPos;
        selected = board.select(x1, y1);
    } 
    //De-selection
    else if (xPos == x1 && yPos == y1){
        selected = false;
        System.out.println("DESELECT");
    }
    //Second selection
    else {
        x2 = xPos;
        y2 = yPos;
        selected = board.move(x1, y1, x2, y2);
        if (selected){
          remainingMoves--;
          selected = !selected;
          x1 = -1; x2 = -1; y1 = -1; y2 = -1;
        }
        else{
          board.selectedX = -1;
          board.selectedY = -1;
          System.out.println("bad move!");
        }
        //If moves have all been used, switch players and reset remaining moves counter
        if (remainingMoves == 0){
          if (playerTurn == Owner.White){
            playerTurn = Owner.Black;
            remainingMoves = black.getMaxMoves();
          }
          else{
            playerTurn = Owner.White;
            remainingMoves = white.getMaxMoves();
          }
        }
    }  
}
