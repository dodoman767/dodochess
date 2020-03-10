class Player{
  int maxMoves;
  boolean hasWon;
  int money;
  //insert player skill trees/econ, etc
  
  Player(){ 
    maxMoves = 3;
    hasWon = false;
    money = 5;
  }
  
  void setMaxMoves(int maxMoves){
     this.maxMoves = maxMoves; 
  }
  
  int getMaxMoves(){
    return this.maxMoves; 
  }
  
  void setMoney(int money){
     this.money = money; 
  }
  
  int getMoney(){
     return this.money; 
  }
  
}
