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