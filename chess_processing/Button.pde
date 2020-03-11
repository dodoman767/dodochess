class Button {
  
 float x;
 float y;
 String name;

  
  Button(float x, float y, String name)
  {
    this.x = x;
    this.y = y;
    this.name = name;
    
  }
  
  void show ()
  {
   fill(50);
   rect(x,y,100,95);
   rect(x+5,y+5,90,90);
   if (name.equals("pawn")){
      image(Image_pawn,x+20,y+10,60,60);
   }
   else if (name.equals("knight")){
      image(Image_knight,x+20,y+10,60,60);
   }
   else if (name.equals("rider")){
      image(Image_rider,x+20,y+10,60,60);
   }
   else if (name.equals("spawner")){
      image(Image_spawner,x+20,y+10,60,60);
   }
   fill(255);
   textSize(18);
   textAlign(CENTER);
   text(name, x + 50, y + 85);
 }
 //////////////////////////////////////////////////////////////
 void update() 
  {
  }
}
