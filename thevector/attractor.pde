class attractor{
  
  PVector position;
  float mass;
  float G;
  PVector dragOffset;

  attractor(){
    position = new PVector(width/2, height/2);
    mass = 20;
    G = 1;
    dragOffset = new PVector(0.0,0.0);
  }
  
  PVector attract(vector v){
    PVector force = PVector.sub(position, v.position);
    float d = force.mag();
    
    d = constrain(d, 5, 25);
    
    force.normalize();
    float strength = G * (mass * v.mass) / (d * d);
    force.mult(strength);
    
    return force;
  }
  
  void display(){
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    //if (dragging) fill (50);
    //else if (rollover) fill(100);
    //else fill(175,200);
    //ellipse(location.x, location.y, mass*2, mass*2);
  }

}