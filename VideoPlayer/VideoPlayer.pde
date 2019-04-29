/*
Lecture: 3D Image Design
HW_VideoPlayer
Name: June Kim
Student ID: 20156260
Due Date: 2018.11.16
Introduction: Make a video player (Pseudo Youtube Interface)
*/
import processing.video.*; // load library
Movie myMovie;
float jumpValue;
boolean pauseToggle = false;
boolean mouseOntheBar = false;
boolean isDragging = false;
boolean subtitleOn = false;
int uiTime = 200;
float width_timeRate = 3.15270935961;
PImage[] thumbNails;  
String[] lines;
int thum_mouseX;
int thumCount;
int subNum = 0;
void setup() {
  size(640, 360, P3D);
  myMovie = new Movie(this, "KDA.mp4");
  lines = loadStrings("subs.txt");
  thumbNails = new PImage[4869];
  for (int i = 0; i < 4869; i++) {
    String filename = "PopStars-" + nf(i) + ".png";
    thumbNails[i] = loadImage(filename);
  }
  myMovie.loop();
  jumpValue = myMovie.duration() / 40.6;
  textSize(15);
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  switch(keyCode){
    case RIGHT:
    uiTime = 200;
    myMovie.jump(myMovie.time() + jumpValue);
    break;
    
    case LEFT:
    uiTime = 200;
    myMovie.jump(myMovie.time() - jumpValue);
    break;
    
    case 32: //SpaceBar
    uiTime = 200;
    pauseToggle = !pauseToggle;
    break;
    
    case UP:
    uiTime = 200;
    //Volume up
    break;
    
    case DOWN:
    uiTime = 200;
    //Volume down
    break;
    
    case TAB:
    uiTime =200;
    subtitleOn = !subtitleOn;
    break;
  }
  
  if(pauseToggle) myMovie.pause();
  else myMovie.play();
}

void mouseMoved() {
  uiTime = 200;
}

void mouseReleased(){
  if(isDragging) myMovie.jump(mouseX * 0.3171875); 
  isDragging = false;  
  if(pauseToggle) myMovie.pause();
  else myMovie.play();
}
void mouseDragged(){  
  uiTime = 200;  
  if(mouseOntheBar){
  isDragging = true;
 } 
  if(isDragging) myMovie.pause();
  else myMovie.play();
}
void mousePressed(){  
  uiTime = 200;  
  if(!isDragging && mouseOntheBar) myMovie.jump(mouseX * 0.3171875); 
  if((mouseY < (height - height/10) - 5) || (mouseX > 10 && mouseX < 25 && mouseY < height - 10 && mouseY > (height - 10) - (height / 25))){
    pauseToggle = !pauseToggle;    
  }
}

void textBox(){
  rectMode(CENTER);
  fill(20);
  rect(width/2,height - height/20,500,30);
}
void draw() {  
  thum_mouseX = mouseX;
  thumCount = (int)(mouseX * 7.60625);
  if(thumCount > 4868) thumCount = 4868;
  else if(thumCount < 0) thumCount = 0;
  if(thumbNails[thumCount] != null)
  if(thum_mouseX > 583) thum_mouseX = 583; //screenwidth - imagewidth/2 
  if(thum_mouseX < 57) thum_mouseX = 57; //screenwidth - imagewidth/2 
  
  if(!isDragging) image(myMovie, 0, 0);
  else image(thumbNails[thumCount],0,0,width,height - height/10);
  if(uiTime > 0){
  stroke(210);
  strokeWeight(3);
  line(0, height - height/10, width, height - height/10);
  stroke(255, 0, 0);
  if(!isDragging) line(0, height - height/10, myMovie.time() * width_timeRate , height - height/10);// line to show speed
  else line(0, height - height/10, mouseX , height - height/10);// line to show speed
    if(mouseY < (height - height/10) + 5 && mouseY > height - height/10 - 5)
    {
      if(!isDragging){
        fill(255,0,0);
        ellipse(myMovie.time() * width_timeRate , height - height/10, 6, 6);
      } else ellipse(mouseX , height - height/10, 6, 6);  
      image(thumbNails[thumCount],thum_mouseX - 57,(height - height/10) - (thumbNails[thumCount].height + 3));
    
      mouseOntheBar = true;
    } else mouseOntheBar = false;
      if(pauseToggle) 
      { 
        fill(255);
        noStroke();
        triangle(10,height - 10,10,(height - 10) - (height / 25), 22,(height - 10) - (height / 50)); // Triangle
      }
      else
      {
        fill(255);
        noStroke();
        rectMode(CORNER);
        rect(10,(height - 10) - (height / 25), 5,15);
        rect(18,(height - 10) - (height / 25), 5,15);
      }
  }
  uiTime --;
  if(subtitleOn){
    textBox(); 
    fill(255); 
    subNum = (int)myMovie.time() / 2;
    println(subNum);
    text(lines[subNum],80,height - (height / 20));
  }
}
