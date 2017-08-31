vector[] v;
attractor a;

void setup(){
  size(640,480);
  v = new vector[2];
  a = new attractor();
  for (int i = 0; i < v.length; i++){
    v[i] = new vector();
  }
  translate(width/2,height/2);
}

void draw(){
  background(0);
  
  for(vector v : v){    
    // ---------- friction force
    
    PVector friction = v.velocity.get();
    friction.normalize();
    friction.mult(-1);
    
    float c_friction = 0.01;
    friction.mult(c_friction);
    if (v.position.y >= height-1 ){
      v.applyForce(friction);
    }
    
    // ---------- drag force
    
    PVector drag = v.velocity.get();
    drag.normalize();
    drag.mult(-1);
    
    float speed = v.velocity.mag();
    float c_drag = 0.001;
    
    drag.mult(c_drag * speed * speed);
    
    //v.applyForce(drag);
    
    // ---------- gravity force
    PVector g = new PVector(0,0.09);
    g.mult(v.mass);
    //v.applyForce(g);
    
    // ---------- wind force
    PVector wind = new PVector(mouseX, mouseY);
    wind.sub(v.position);
    wind.setMag(0.1);    
    
    if(mousePressed){
      v.applyForce(wind);
    }
    
    // ---------- attractor force
      PVector attract_force = a.attract(v);
      a.display();
    
      v.applyForce(attract_force);
    
    // ---------- go right force
    
    PVector right_force = new PVector(0.05,0);
    //v.applyForce(right_force);
    v.update();
    //v.bounce();
    v.display();
  }

}