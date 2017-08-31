
class vector{
  
  PVector position;
  PVector mouse;
  PVector velocity;
  PVector acceleration;

  float mass = random(0.5,4);

  vector(){
    position = new PVector(random(width), random(height));
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }

  void update(){
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void bounce(){
    if((position.x >= width) || (position.x <= 0)){velocity.x *= -1; }
    if((position.y >= height) || (position.y <= 0)){velocity.y *= -1;}
    
    if(position.y > height) position.y = height;
    if(position.x > width) position.x = width;
    if(position.y < 0) position.y = 0;
    if(position.x < 0) position.x = 0;
  }
  
  void display(){
    stroke(0,255,0);
    line(position.x,position.y,position.x + velocity.x * 5, position.y + velocity.y * 5);
    
    stroke(255);
    //fill(255);
    noFill();
    ellipse(position.x, position.y, mass*5, mass*5);
    
  }
  
}

vector[] v;

void setup(){
  size(640,480);
  v = new vector[100];
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
    float c_drag = 0.01;
    
    drag.mult(c_drag * speed * speed);
    
    v.applyForce(drag);
    
    // ---------- gravity force
    PVector g = new PVector(0,0.09);
    g.mult(v.mass);
    v.applyForce(g);
    
    // ---------- wind force
    PVector wind = new PVector(mouseX, mouseY);
    wind.sub(v.position);
    wind.setMag(0.8);    
    
    if(mousePressed){
      v.applyForce(wind);
    }
    
    v.update();
    v.bounce();
    v.display();
  }
}