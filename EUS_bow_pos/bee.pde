class Bee {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector target;


  float maxSpeed = 3;   // Maximum speed
  float maxForce = 0.1; // Maximum steering force

  float size;           // Current size of the bee
  float headWidth;
    // Adjusted wandering parameters for Swarm
    float wanderRadius = 50;
    float wanderDistance = 250;
    float wanderStrength = 0.9;
    float attractionStrength = 0.3;
 

  // Wing properties
  float wingMovementR = 4;
  float wingMovementL = 4;
  float wingSpeedR = 0.1;
  float wingSpeedL = 0.1;
  
    float targetHeight;
  float heightLerp = 0.0;
  float lerpSpeed = 0.02;


  Bee(float x, float y, float initialSize) {
    position = new PVector(x, y);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    acceleration = new PVector(0, 0);
    target = new PVector(x, y);
    size = initialSize;
    headWidth = 10 * size;
    targetHeight = y;
  }


    void setTarget(float x, float y) {
        target.set(x, y);
    }
    
  //  void updateTargetHeight(float bowPos, float pitch,Flower[] flowers) {
  //  float newTargetHeight;
    
  //  // Map the discrete values to different height ranges
  //  if (bowPos == 4.0 || pitch == 4.0) { // Top quarter
  //    newTargetHeight = random(0, height * 0.25);
  //  } else if (bowPos == 3.0 || pitch == 3.0) { // Second quarter
  //    newTargetHeight = random(height * 0.25, height * 0.5);
  //  } else if (bowPos == 2.0 || pitch == 2.0) { // Third quarter
  //    newTargetHeight = random(height * 0.5, height * 0.75);
  //  } else if (bowPos == 1.0 || pitch == 1.0) { // Bottom quarter
  //    newTargetHeight = random(height * 0.75, height);
  //  } else { // Default to middle if no matching value
  //    newTargetHeight = random(height * 0.4, height * 0.6);
  //  }
    
  //  //targetHeight = newTargetHeight;//    if (flowerIndex >= 0 && flowerIndex < flowers.length) {
  //   if (flowerIndex >= 0 && flowerIndex < flowers.length) {
  //      target.set(flowers[flowerIndex].x, flowers[flowerIndex].y);
  //  }
  //}
void updateTargetHeight(float bowPos, Flower[] flowers) {
    int flowerIndex = -1; // Default to no valid flower

    // Map pitch to the correct flower index
    if (bowPos == 1.0) { flowerIndex = 3; }
    else if (bowPos == 2.0 ) { flowerIndex = 2; }
    else if (bowPos == 3.0 ) { flowerIndex = 1; }
    else if (bowPos == 4.0 ) { flowerIndex = 0; }

    // If a valid flower index was found, update the target position
    // If a valid flower index was found, move toward that flower
    if (flowerIndex >= 0 && flowerIndex < flowers.length) {
        target.set(flowers[flowerIndex].x, flowers[flowerIndex].y);
    }

}

//void updateTargetHeight(float pitch, Flower[] flowers) {
//    int flowerIndex = -1; // Default to no valid flower

//    // Map pitch to the correct flower index
//    if (pitch == 4.0) { flowerIndex = 3; }
//    else if (pitch == 3.0 ) { flowerIndex = 2; }
//    else if (pitch == 2.0 ) { flowerIndex = 1; }
//    else if (pitch == 1.0 ) { flowerIndex = 0; }

//    // If a valid flower index was found, update the target position
//    // If a valid flower index was found, move toward that flower
//    if (flowerIndex >= 0 && flowerIndex < flowers.length) {
//        target.set(flowers[flowerIndex].x, flowers[flowerIndex].y);
//    }

//}





    //void seek(PVector target) {
    //    PVector desired = PVector.sub(target, position);
    //    float distance = desired.mag();
    //    desired.normalize();

    //    if (distance < 200) {
    //        float m = map(distance, 0, 200, 0, maxSpeed * attractionStrength);
    //        desired.mult(m);
    //    } else {
    //        desired.mult(maxSpeed);
    //    }

    //    PVector steer = PVector.sub(desired, velocity);
    //    steer.limit(maxForce);
    //    acceleration.add(steer);
    //}
    void seek(PVector target) {
    PVector desired = PVector.sub(target, position); 
    float distance = desired.mag();
    desired.normalize();

    if (distance < 150) { // Slow down when close
        float m = map(distance, 0, 150, 0, maxSpeed);
        desired.mult(m);
    } else {
        desired.mult(maxSpeed * 1.); // Increase speed when far
    }

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce * 1.8); // Slightly increase force
    acceleration.add(steer);
}


    void wander() {
        PVector wanderCenter = velocity.copy();
        wanderCenter.setMag(wanderDistance);

        PVector wanderOffset = PVector.random2D();
        wanderOffset.mult(wanderRadius);

        PVector wanderTarget = PVector.add(wanderCenter, wanderOffset);
        seek(PVector.add(position, wanderTarget));
    }

    void applyBehaviors() {
        wander();
        seek(target);
        update();
    }
    
  //    void applyBehaviors() {
  //  // Lerp the current target's y position towards the targetHeight
  //  heightLerp = lerp(heightLerp, targetHeight, lerpSpeed);
  //  target.y = heightLerp;
    
  //  wander();
  //  seek(target);
  //  update();
    
  //  // Keep horizontal position within bounds while maintaining vertical position
  //  position.x = constrain(position.x, 0, width);
  //  position.y = constrain(position.y, 0, height);
  //}


  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);

    // Wing flapping motion
    wingMovementR += wingSpeedR;
    if (wingMovementR < 3 || wingMovementR > 6) {
      wingSpeedR *= -1;
    }
    wingMovementL += wingSpeedL;
    if (wingMovementL < 3 || wingMovementL > 6) {
      wingSpeedL *= -1;
    }
  }


  // Make sure your display method uses alpha correctly:
  void display() {
    //update();

    float theta = velocity.heading() + PI / 2;

    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);

    drawTentacles(0, 0);



    drawHead(0, 0);


    drawBody(0, 0);


    drawWings(0, 0);

    popMatrix();
  }

  void drawHead(float localX, float localY) {
    strokeWeight(2);
    //stroke(0, 0);
    fill(0, 0, 0, 255);
    circle(localX, localY, headWidth);
  }

  void drawTentacles(float localX, float localY) {
    noFill();
    stroke(0, 255);
    strokeWeight(2);
    arc(localX + headWidth * 0.75, localY - headWidth / 2, headWidth, headWidth * 0.75, PI, PI + HALF_PI);
    arc(localX - headWidth * 0.75, localY - headWidth / 2, headWidth, headWidth * 0.75, PI + HALF_PI, TWO_PI);
  }

  void drawBody(float localX, float localY) {
    fill(250, 250, 10, 255);
    ellipse(localX, localY + headWidth * 1.8, headWidth * 1.7, headWidth * 2.7);
    noFill();
    strokeWeight(2);
  }

  void drawWings(float localX, float localY) {
    // Left wing
    pushMatrix();
    translate(localX - headWidth * 0.8, localY + headWidth * 1.1); // Adjusted to move wings slightly down

    wingMovementR += wingSpeedR;
    rotate(PI / wingMovementR);
    if (wingMovementR < 3 || wingMovementR > 6) {
      wingSpeedR *= -1;
    }

    fill(0, 255);
    ellipse(0, 0, headWidth * 1.35, headWidth * 2.35);
    popMatrix();

    // Right wing
    pushMatrix();
    translate(localX + headWidth * 0.8, localY + headWidth * 1.1); // Adjusted to move wings slightly down

    wingMovementL += wingSpeedL;
    rotate(-PI / wingMovementL);
    if (wingMovementL < 3 || wingMovementL > 6) {
      wingSpeedL *= -1;
    }

    fill(0, 255);
    ellipse(0, 0, headWidth * 1.35, headWidth * 2.35);
    popMatrix();
  }
}
