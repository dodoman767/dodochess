class EndTurn{
  boolean isHover = false;
  boolean isClick = false;
  int x = screenX + 30;
  int y = screenY + 30;
  int sizeX = width - x-5;
  int sizeY = height-y-5;
  int xLen = 180;
  int yLen = 50;
  
  void nextTurn(){
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
  
  void show(){
    
       if (playerTurn == Owner.White)
          fill(255);
       if (playerTurn == Owner.Black)
          fill(0);
       rect(x, y, sizeX, sizeY);
       fill(250,100,75);
       rect(x+5, y+5, width - x-15, height-y-15);
       
    if (x <= mouseX && mouseX <= x + sizeX && y <= mouseY && mouseY <= y + sizeY){
       isHover = true;
       fill(250,175,50);
       rect(x+5, y+5, width - x-15, height-y-15);
    }
    if (isClick){
       fill(50,200,50);
       rect(x+5, y+5, width - x-15, height-y-15);
    }
  }
  void mouseAction(){
    isHover = (x <= mouseX && mouseX <= x + sizeX && y <= mouseY && mouseY <= y + sizeY);
      if (isHover){
        isClick = !isClick;
        if (!isClick){
         nextTurn();
        }
      }
  }
}
