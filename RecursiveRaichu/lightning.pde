PShader blur;
class strike {
  PVector start, end;
  boolean split = false;
  boolean both = false;
  boolean dead = false;
  float a, r = 0;
  float h, d;
  strike s1, s2;
  int n, max;
  strike(PVector start, float h, int n, int max) {
    this.start = start;
    this.d = h;
    this.h = h;
    this.n = n;
    this.max = max;
    a = random(PI / 4, 3 * PI / 4);
    end = new PVector(start.x + cos(a) * this.d, start.y + sin(a) * this.d);
  }
  
  void update(float spd) {
    if(r < d) {
      r += spd;
    } else {
      r = d;
      if(!split && n < max) {
        split = true;
        if(random(1) > 0.5) {
          both = true;
          s1 = new strike(end, h, n + 1, max);
          s2 = new strike(end, h, n + 1, max);
        }  else {
          both = false;
          s1 = new strike(end, h, n + 1, max);
        }
      } if(n >= max) {
          dead = true;
      } else {
        if(both) dead = s1.dead && s2.dead;
        else dead = s1.dead;
      }
    }
   if(split) {
      s1.update(spd);
      if(both) {
        s2.update(spd);
      }
    }
  }
  
  void show() {    
    if(glowMode){
      strokeWeight(random(r/(d*10),r/d*3));
      for( int j=0; j<10; j++) {
      if(random(1) > 0.2)
        stroke(random(200,255)*noise(j/1.0),random(180,220)*noise(j/1.0),noise(j/1.0));
       else
        stroke(255*noise(j/1.0), 255*noise(j/1.0), 255*noise(j/1.0));
      }
    }
    else{
      if(random(1) > 0.01){
      strokeWeight(0);
      }
      else{
      strokeWeight(random(r/(d*10),r/d*3));
      stroke(255, 255,150);
      }
    }
    line(start.x, start.y, start.x + cos(a) * r, start.y + sin(a) * r);
    if(split) {
      s1.show();
      if(both) {
        s2.show();
      }
    }
  }  
}
