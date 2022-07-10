import processing.serial.*;
Serial myport;
String dataIn ;
int distUltra ; 
int incomingDist;

//score and game state
int score = 0;
int point = 1;
int highScore = 0;
boolean gameOver = false;
color birdColor = color(255,102,32);


//bird height and width location
float birdY = 46;
float birdX = 56;
float gravity  = 5;
int speed; // speed of pipe


Pipe p1 = new Pipe();
Pipe p2 = new Pipe();
Pipe p3 = new Pipe();





void setup()
{
 size(400,600);
 p1.x = width + 50;
 p2.x = width + 220;
 p3.x = width + 370; 
 myport = new Serial(this , "COM10", 9600);
 myport.bufferUntil(10);
 
}



void draw()
{
  background(0);
  p1.pipe();
  p2.pipe();
  p3.pipe();
  
  fill(birdColor);
  ellipse(birdX,birdY , 55,55);
  play();
  success(p1);
  success(p2);
  success(p3);
  if(incomingDist > 10 )
  {
    birdY -= gravity;  
  }
  
  else
  {  
  birdY += gravity;  
  }
 
   
}

void play()
{
 
 if(gameOver == false)
 {
  speed = 2;  
  p1.x -= speed;
  p2.x -= speed;
  p3.x -= speed;
  textSize(24);
  fill(255);
  text(score , width/2,30);

 }
 
 if(gameOver == true)
 { 
   speed = 0;
   p1.x -= speed;
   p2.x -= speed;
   p3.x -= speed;
   
   if(highScore < score)
   {
    highScore = score;
   }
   
  textSize(16);
  fill(0,102,153);
  textAlign(CENTER);
  text("CLICK : PLAY AGAIN" , width/2 , height/2);
  text("SCORE: " + score,width/2,height/2 - 20);
  text("HIGH SCORE:  " + highScore , width/2 , height/2 - 40);
  
   if(mousePressed)
   {
    delay(900);
    score = 0;
    gameOver = false;
    birdY = 100;
    birdX = 65;
    p1.x = width + 50;
    p2.x = width + 220;
    p3.x = width + 370;
    
    p1.top = random(height/2);
    p1.bottom = random(height/2);
    
    p2.top = random(height/2);
    p2.bottom = random(height/2);
    
    p3.top = random(height/2);
    p3.bottom = random(height/2);


    
   
   }
 }

}



void success(Pipe test)
{
 if(birdY < test.top || birdY > height - test.bottom)
 {
  if(birdX > test.x && birdX < test.x + test.w)
  {
    gameOver = true;
  
  }
   
 }


}



void serialEvent(Serial myport)
{
  
  dataIn = myport.readString();
  println(dataIn);
  incomingDist = int(trim(dataIn));
  println("INCOMING DISTANCE =  " + incomingDist);
  
  if(incomingDist > 1 && incomingDist < 100)
    {
  
     distUltra  = incomingDist;
  
    }

}





class Pipe
{
 
 float top = random(height/3 + 200 );
 float bottom = random(height/3 + 200 );
 float x = width + 150;
 float w = 70;
 color pipecolor = color(0,255,0);
 
 
 void pipe()
 {
   fill(pipecolor);
   rect(x,0,w,top);
   rect(x,height - bottom , w,bottom);
   if(x < -100)
   {
   
   score += point;
   x = width;
   top = random(height/2);
   bottom = random(height/2);
   
   }
 
 
 
 }








}
