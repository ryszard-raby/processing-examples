
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
    mouse = new PVector(mouseX, mouseY);
  }

  void update(){
    mouse.x = mouseX;
    mouse.y = mouseY;
    mouse.sub(position);
    mouse.setMag(4);
    
    velocity.add(acceleration);

    position.add(velocity);
    
    acceleration.mult(0);
    println(velocity);
    
  }
  
  void accelerate(){
    velocity.add(mouse);
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
  }
  
  void display(){

    stroke(0,0,255);
    line(position.x,position.y,position.x + mouse.x * 5, position.y + mouse.y * 5);
       
    stroke(0,255,0);
    line(position.x,position.y,position.x + velocity.x * 5, position.y + velocity.y * 5);
    
    noStroke();
    fill(255);
    ellipse(position.x, position.y, mass*5, mass*5);
    
  }
  
}

vector[] v;

void setup(){
  size(640,480);
  v = new vector[5];
  for (int i = 0; i < v.length; i++){
    v[i] = new vector();
  }
  
  translate(width/2,height/2);
}

void draw(){
  background(0);
  
  PVector w = new PVector(0.1,0);
  
  for(vector v : v){
    PVector g = new PVector(0,0.09);
    PVector friction = v.velocity.get();
    friction.normalize();
    friction.mult(-1);
    
    float c = 0.01;
    friction.mult(c);
    
    v.applyForce(friction);
    
    g.mult(v.mass);
    v.applyForce(g);
    
    if(mousePressed){
      v.applyForce(w);
    }
    
    v.update();
    v.bounce();
    v.display();
  }
}