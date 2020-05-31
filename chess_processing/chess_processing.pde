/*
To do:

- Display info
- Combat (damage)
- Structures
- Spells
- GUI
- Volume
- Cursor
- SFX
- Turns
- Maps
- Terrain
- Center
- Error message

*/
import java.util.*;
import javax.swing.JOptionPane;
import ddf.minim.*;
Minim minim;
AudioPlayer player;
AudioPlayer effect_bop;

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
boolean placingMode = false;

PImage cursor1, cursor2;
PImage Image_pawn, Image_knight, Image_horseman;
PImage Image_spawner, Image_wall;
Button button_pawn, button_knight, button_horseman;

EndTurn endTurn;

//Unit stats
int[] pawn_stats = {1,1,2};
int[] knight_stats = {2,3,4};
int[] horseman_stats = {2,2,7};

//Ongoing stats
Owner playerTurn = Owner.White;
int remainingMoves = 3;
int whiteGold = 10;
int blackGold = 10;
int whiteGoldIncome = 5;
int blackGoldIncome = 5;

void setup(){
  size(1500, 900);
  background(#00E3FF);
  
  minim = new Minim(this);
  player = minim.loadFile("OST1.mp3");
  player.setGain(-40);
  player.loop();
  effect_bop = minim.loadFile("bop.mp3");
  effect_bop.setGain(-30);
  
  cursor1 = loadImage("cursor.png");
  cursor2 = loadImage("cursor2.png");
  Image_pawn = loadImage("unit_hoodie.png");
  Image_knight = loadImage("unit_tree.png");
  Image_horseman = loadImage("unit_horseman.png");
  Image_spawner = loadImage("spawner.png");
  Image_wall = loadImage("wall.png");
  
  button_pawn = new Button(1265,100,"pawn");
  button_knight = new Button(1385,100,"knight");
  button_horseman = new Button(1265,200,"horseman");
  endTurn = new EndTurn();

  board = new Board();
  board.setup();
  white = new Player();
  black = new Player();
}

void draw(){
  if (marginLeft <= mouseX && mouseX <= marginLeft + tileSize * boardSizeX
    &&marginTop <= mouseY && mouseY <= marginTop + tileSize * boardSizeY){
    cursor(cursor1,6,0);
  }
  else{
    cursor(cursor2,0,0);
  }
  
  board.draw();
  endTurn.show();
  
  if (board.selectedX >= 0 && board.positions[board.selectedX][board.selectedY].type == Type.Spawner){
    button_pawn.show();
    button_knight.show();
    button_horseman.show();
  }
  
  textAlign(LEFT);
  fill(#C0C0C0);
  text("Moves: " + remainingMoves, 25, 860);
  
  if (playerTurn == Owner.White){
    text("White's turn", 25,880);
  }
  else if (playerTurn == Owner.Black){
    text("Black's turn", 25,880);
  }
  fill(#D4AF37);
  text("White Gold: " + whiteGold, 175, 860);
  text("Black Gold: " + blackGold, 175, 880);
  fill(#D4AF37);
  text("White Income: " + whiteGoldIncome, 325, 860);
  text("Black Income: " + blackGoldIncome, 325, 880);
  
}




void mouseReleased(){
    int xPos = (int)Math.floor((mouseX - marginLeft) / tileSize);
    int yPos = (int)Math.floor((mouseY - marginTop) / tileSize);
    
  if (0 <= xPos && xPos < boardSizeX && 0 <= yPos && yPos < boardSizeY){
    }
    else{ //for non board clicks
     //button_pawn.mouseAction();
     //button_knight.mouseAction();
     //button_horseman.mouseAction();
     endTurn.mouseAction();
     return;
    }
}

void mousePressed(){
    int xPos = (int)Math.floor((mouseX - marginLeft) / tileSize);
    int yPos = (int)Math.floor((mouseY - marginTop) / tileSize);
      effect_bop.play(1);
      
    //Tileclick animation
    if (0 <= xPos && xPos < boardSizeX && 0 <= yPos && yPos < boardSizeY){
      System.out.println("I'm on: " + xPos + ", " + yPos + " glow: + " + board.positions[xPos][yPos].glow);
      fill(10);
      rect(marginLeft + tileSize * xPos, marginTop+ tileSize * yPos, tileSize, tileSize);
    }
    else{ //for non board clicks
      
     button_pawn.mouseAction();
     button_horseman.mouseAction();
     button_knight.mouseAction();
     endTurn.mouseAction();
     return;
    }
    
    if (placingMode){
      
     return; 
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
        board.deselect(x1, y1);
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
        }
        //MOVE FINISHED
        if (remainingMoves == 0){
          //Black's turn
          if (playerTurn == Owner.White){
            playerTurn = Owner.Black;
            remainingMoves = black.getMaxMoves();
            blackGold += blackGoldIncome;
          } //White's turn
          else{
            playerTurn = Owner.White;
            remainingMoves = white.getMaxMoves();
            whiteGold += whiteGoldIncome;
          }
          
        }
        board.queuedTile = null;
    }  
}

void keyPressed() {
  if (keyCode == TAB) {
    endTurn.nextTurn();
  }
}
