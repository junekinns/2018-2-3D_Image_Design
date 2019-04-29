/*
Lecture: 3D Image Design
HW_4_Using Recursion Algorithm Make Beautiful Generative Image 
Name: June Kim
Student ID: 20156260
Due Date: 2018.10.19
Introduction: Using Recursion Algorithm Make Beautiful Generative Image 
Project name: RecursiveRaichu
Control : Press 'g'-> turn on glow effect
*/

ArrayList<strike> s = new ArrayList<strike>();
strike s_random;
Animation anim1;
float theta;
boolean glowMode=false;
void setup() {
  fullScreen(P3D);
  blur = loadShader("blur.glsl");
  frameRate(30);
  anim1 = new Animation("raichu",38);
}
float test;
void draw() {
  if(key == 'g')
  glowMode = true;
   
   background(0);
   translate(width/2,height/2);
   if(frameCount > 10){
     for(int i = s.size() - 1; i >= 0; i --){
       for(theta = 0; theta < TWO_PI; theta += PI/6){
         pushMatrix();
         rotate(theta);
         s.get(i).update(2.5);
         s.get(i).show();
         popMatrix();
     }
     if(s.get(i).dead) s.remove(i);
     }
     if(s.size() < 4) {
     s.add(new strike(new PVector(0, 0), 200, 0, 5));
     } 
   }
   pushMatrix();
   scale(1.3f);
   anim1.display(-95,-115);
   popMatrix();
}
