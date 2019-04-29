//Lecture: 3D Image Design
//HW_2_Drawing Famous Painting
//Name: June Kim
//Student ID: 20156260
//Due Date: 2018.10.06
//Introduction: Pick a artist and one of his paintings.
//Artist / Painting: Murakami Takashi / KaiKaiKiKi Flowers

int getRandomColor(){
return color(random(120,255), random(255),random(255));
}

boolean isBodyYellow = false;
boolean isBodyWhite = false;
float leafLenghtK = 5.5f;
float chordK = 10.9f;
float arcX = 5.2f;
void drawFlower(float x, float y, float flowerSize){
  
  float bodyColorPercent = random(0f,1.0f);
  float mouthColorPercent = random(0f,1.0f);
  float eyeColorPercent = random(0f,1.0f);
  float leafPercent = random(0.0f,1.0f);
  int alterLeaf = 0;
  //flower leaves(change later)
  strokeWeight(flowerSize*0.15f);
  stroke(0);
  translate(x,y); //x,y is Center of flower
  pushMatrix();
  if(leafPercent < 0.5f)
    alterLeaf = 0;
  else if(leafPercent < 1.0f)
    alterLeaf = 1;
  
  switch(alterLeaf){
    case 0: //single leaf color
    if(random(0,1) < 0.9f)
      stroke(0);
    else
      stroke(getRandomColor());
      
    if(bodyColorPercent > 0.6f && bodyColorPercent < 0.9f)
      fill(255);
    else
      fill(getRandomColor());
    for(int i=0; i<12; i++){
    rotate(PI / 6);
    //draw a leaf, one arc, 3 vertices
    beginShape();
    arc(arcX*flowerSize,0,chordK*flowerSize*sin(PI/12),chordK*flowerSize*sin(PI/12),-PI/2,PI/2);
    vertex(leafLenghtK*flowerSize*cos(PI/12),leafLenghtK*flowerSize*sin(PI/12));
    vertex(0,0);
    vertex(leafLenghtK*flowerSize*cos(-PI/12),leafLenghtK*flowerSize*sin(-PI/12));
    endShape();
    }
    break;
    
    case 1: //leaf color changes alternatively
    if(random(0,1) < 0.9f)
      stroke(0);
    else
      stroke(getRandomColor());
    if(bodyColorPercent > 0.5f)
      fill(255);
    else
      fill(getRandomColor());
    for(int i=0; i<12; i = i+2){
    rotate(PI / 3);
    //draw a leaf, one arc, 3 vertices
    beginShape();
    arc(arcX*flowerSize,0,chordK*flowerSize*sin(PI/12),chordK*flowerSize*sin(PI/12),-PI/2,PI/2);
    vertex(leafLenghtK*flowerSize*cos(PI/12),leafLenghtK*flowerSize*sin(PI/12));
    vertex(0,0);
    vertex(leafLenghtK*flowerSize*cos(-PI/12),leafLenghtK*flowerSize*sin(-PI/12));
    endShape();
    }
    rotate(PI / 6);
    fill(getRandomColor());
    for(int i=1; i<12; i = i+2){
    rotate(PI / 3);
    //draw a leaf, one arc, 3 vertices
    beginShape();
    arc(arcX*flowerSize,0,chordK*flowerSize*sin(PI/12),chordK*flowerSize*sin(PI/12),-PI/2,PI/2);
    vertex(leafLenghtK*flowerSize*cos(PI/12),leafLenghtK*flowerSize*sin(PI/12));
    vertex(0,0);
    vertex(leafLenghtK*flowerSize*cos(-PI/12),leafLenghtK*flowerSize*sin(-PI/12));
    endShape();
    }
    break;
  }
  popMatrix();
  //Flower Body
  //Body Stroke Color: 70% Black, 30% Other color except white
  if(bodyColorPercent < 0.7f)
    stroke(0);
  else
    stroke(getRandomColor());
    
  //Body color : 70% White, 20% Yellow, 10% other color fill
  if(bodyColorPercent < 0.6f){
    isBodyWhite = true;
    isBodyYellow = false;
    fill(255);
  }
  else if(bodyColorPercent < 0.9f){
    isBodyYellow = true;
    isBodyWhite = false;
    fill(255,255,0);
  }
  else{
    fill(getRandomColor());
    isBodyYellow = false;
    isBodyWhite = false;
  }
  //Drawing the Body shape with ellipse(Circle)
  ellipse(0,0,6*flowerSize,6*flowerSize); 
  
  //Drawing Mouth
  //Mouth Stroke Color: 70% Black, 30% Other color except white
  if(mouthColorPercent < 0.8f){
    stroke(0);
  }
  else{
    stroke(getRandomColor());
  }
  //Mouth Fill Color : percentage depends on bodyfill color(yellow), mouthStroke color(black)
  if(isBodyYellow)
    fill(255,0,0);
  else if(mouthColorPercent > 0.8f && mouthColorPercent < 1f)
    fill(0);
  else 
    fill(getRandomColor());
    
  //Drawing mouth using bezierVertex()
  beginShape();
  vertex(-flowerSize*2.2,0);
  bezierVertex(-flowerSize,-flowerSize*0.7,flowerSize,-flowerSize*0.7,flowerSize*2.2,0);
  bezierVertex(flowerSize,flowerSize*2.7,-flowerSize,flowerSize*2.7,-flowerSize*2.2,0);
  endShape();
  
  //Drawing the eyes(nostroke)
  noStroke();
  //LeftEye
  pushMatrix();
  translate(-flowerSize*1.2,-flowerSize*1.3);
  rotate(PI/6);
  if(isBodyYellow || eyeColorPercent < 0.3)
    fill(0);
  else if(eyeColorPercent < 1)
    fill(getRandomColor());
  ellipse(0,0,flowerSize/2,0.8*flowerSize); //Outside
  
  if(isBodyYellow || eyeColorPercent < 0.3)
    fill(255);
  else if(eyeColorPercent < 1)
    fill(getRandomColor());
  ellipse(-0.1*flowerSize,-0.15*flowerSize,(0.4*flowerSize)/2,0.32*flowerSize); //Upperside
  
  if(isBodyYellow || eyeColorPercent < 0.3)
    fill(255);
  else if(eyeColorPercent < 1)
    fill(getRandomColor());
  ellipse(0.1*flowerSize,0.2*flowerSize,(0.35*flowerSize)/2,0.25*flowerSize); //Lowerside
  popMatrix();
  
  //RightEye
  pushMatrix();
  translate(flowerSize*1.2,-flowerSize*1.3);
  rotate(-PI/6);
  if(isBodyYellow || eyeColorPercent < 0.3)
    fill(0);
  else if(eyeColorPercent < 1)
    fill(getRandomColor());
  ellipse(0,0,flowerSize/2,0.8*flowerSize);  //Outside
  
  if(isBodyYellow || eyeColorPercent < 0.3)
    fill(255);
  else if(eyeColorPercent < 1)
    fill(getRandomColor());
  ellipse(-0.05*flowerSize,-0.2*flowerSize,(0.45*flowerSize)/2,0.32*flowerSize); //Upperside
  
  if(isBodyYellow || eyeColorPercent < 0.3)
    fill(255);
  else if(eyeColorPercent < 1)
    fill(getRandomColor());
  ellipse(0.05*flowerSize,0.2*flowerSize,(0.35*flowerSize)/2,0.25*flowerSize); //Lowerside
  popMatrix();
  }

void setup(){
  background(255);
  fullScreen();
}

void draw(){
  if(keyPressed == true){
    drawFlower(random(width),random(height),random(3,30));
  }
}
