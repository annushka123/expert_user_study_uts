class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float angle = 0.01;
  float aVelocity = 0;
  float aAcceleration = 0.001;
  float easing = 0.05; // Easing factor

  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0.01, 0.01);
  }

  void update(float xMove, float yMove) {
    // Apply easing to the x and y coordinates
    location.x = lerp(location.x, xMove, easing);
    location.y = lerp(location.y, yMove, easing);

    aVelocity += aAcceleration;
    angle += aVelocity;
  }

  void display() {
    fill(random(255), random(255), random(255));
    stroke(random(255), random(255), random(255), 100);
    strokeWeight(zMove);
    pushMatrix();
    translate(location.x, location.y); // Use the eased location for x and y coordinates
    rotate(angle);
    line(-(mappedSlider), 0, mappedSlider, 0);
    ellipse(mappedSlider, 0, 10, 10);
    ellipse(-(mappedSlider), 0, 10 + zMove, 10 + zMove);
    popMatrix();
  }
}
