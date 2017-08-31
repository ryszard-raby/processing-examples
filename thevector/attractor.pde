class attractor{
  
  PVector position;
  float mass;
  float G;
  PVector dragOffset;

  attractor(){
    position = new PVector(width/2, height/2);
    mass = 10;
    G = 1;
    dragOffset = new PVector(0.2,0.2);
  }
  
  PVector attract(vector v){
    PVector force = PVector.sub(position, v.position);
    float d = force.mag();
    //d = d/2;
    d = constrain(d, 5,20);
    //d = 20;
    println(d);
    
    force.normalize();
    float strength = G * (mass * v.mass) / (d * d);
    force.mult(strength);
    
    return force;
  }
  
  void display(){
    ellipseMode(CENTER);
    stroke(0,255,0);
    //if (dragging) fill (50);
    //else if (rollover) fill(100);
    //else fill(175,200);
    ellipse(position.x, position.y, mass*2, mass*2);
  }

}