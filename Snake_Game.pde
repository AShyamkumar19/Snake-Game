PImage img, img2;
ArrayList<Integer> x = new ArrayList<Integer>();
ArrayList<Integer> y = new ArrayList<Integer>();
int w = 30, h = 30, b = 20, d = 2, fx = 15, fy = 15, s = 10; 
int[] x_d = {0,0,1,-1}, y_d = {1,-1,0,0};
boolean game_status = false;
// Basic Variables
void setup(){ // Setup
  size(600,600);
  img = loadImage("background.png");
  img2 = loadImage("Game Over.jpeg");
  x.add(0);
  y.add(15);
}

void draw(){ //main
  image(img,0,0);
  img.resize(600,600);//Background image
  fill(#5DAAA8);
  for(int i = 0; i < x.size(); i++){ // the snake formation
    rect(x.get(i)*b, y.get(i)*b, b, b);
  }
  frameRate(s); //speed
  if(!game_status){
    fill(#ED0C41);
    rect(fx*b,fy*b,b,b);
    textAlign(LEFT);// Next lines are the score text
    textSize(25);
    fill(#D9DBB3);
    text("Your Score: " + x.size(), 10, 10, width -20, 50);
  }
    //Code to run while alive
  if(!game_status){ //frameCount % s == 0
    x.add(0, x.get(0) + x_d[d]);
    y.add(0, y.get(0) + y_d[d]);
    if(x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || x.get(0) >= h){
      for(int i = 1; i < x.size(); i++){
        if(x.get(0) == x.get(i) && y.get(0) == y.get(i)){
          game_status = true;
        }// Adding blocks
      }
    }
    if(x.get(0)==fx && y.get(0)== fy){ //Food placement
     fx = (int)random(0,w);
     fy = (int)random(0,h);
     s +=2;
    }
    else{
      x.remove(x.size()-1);
      y.remove(y.size()-1);
    }
    if (x.get(x.size()-1) < 0 || y.get(y.size()-1) < 0 || x.get(0) < 0 || y.get(0) < 0 || x.get(x.size()-1) >= w || y.get(y.size()-1) >= h || x.get(0) >= w || y.get(0) >= h){
      game_status = true;
    }
  }
  else{ //once dead
    fill(#DBB3D6);//game over screen
    textSize(30);
    textAlign(CENTER);
    image(img2,200,110, 200, 110);
     text("\n Your Score is: "+ x.size() +"\n Press ENTER to play again", width/2, height/3);
    if (keyCode == ENTER) { //reset 
      x.clear(); 
      y.clear(); 
      x.add(0);  
      y.add(15);
      d = 2;
      s = 8;
      game_status = false;
    }
  }
    
}
// The controls
void keyPressed(){
  int movement = keyCode == DOWN? 0: (keyCode == UP?1:(keyCode == RIGHT?2: (keyCode == LEFT?3:-1)));
  if(movement != -1){
    d = movement;
  }
}
