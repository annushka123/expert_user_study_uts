import static processing.core.PApplet.*;


class Bee {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector target; // Target position (flower)

  float maxSpeed = 3;   // Maximum speed
  float maxForce = 0.1; // Maximum steering force
  float size;           // Current size of the bee
  float headWidth;      // Dynamic head width

  // Adjusted wandering parameters for Swarm
  float wanderRadius = 5;
  float wanderDistance = 90;
  float wanderStrength = 0.1;
  float attractionStrength = 0.9;

  // Wing properties
  float wingMovementR = 4;
  float wingMovementL = 4;
  float wingSpeedR = 0.1;
  float wingSpeedL = 0.1;

  float opacity;
  boolean fadingOut;
  
  //bow_position behaviours
  float targetHeight;
  float heightLerp = 0.0;
  float lerpSpeed = 0.02;

  //bow_speed behaviours
  PVector targetSpeed;
  PVector newTargetSpeed;
  boolean erratic = false;



  Bee(float x, float y, float initialSize) {
    position = new PVector(x, y);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    acceleration = new PVector(0, 0);
    target = new PVector(x, y);
    size = initialSize;
    headWidth = 10 * size;
    opacity = 0;
    fadingOut = false;
    targetHeight = y;
    targetSpeed = velocity.copy();
  }

  void fadeIn() {
    if (opacity < 255) {
      opacity += 2; // Gradually increase opacity
      opacity = constrain(opacity, 0, 255);
    }
  }

  void fadeOut() {
    if (opacity > 0) {
      opacity -= 2; // Gradually decrease opacity
      opacity = constrain(opacity, 0, 255);
    }
  }




  void setTarget(float x, float y) {
    target.set(x, y);
  }
  
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

void updateTargetSpeed(float smoothedSpeed) {
  float targetSpeed = constrain(smoothedSpeed * 3.0, 0.5, 6.0);
  maxSpeed = lerp(maxSpeed, targetSpeed, 0.1);

  // ✨ NEW: scale steering force with speed
  maxForce = map(maxSpeed, 0.5, 6.0, 0.05, 0.3);  // feel free to tweak limits
}



//void updateTargetSpeed(float smoothedSpeed) {
//    float newWanderStrength, newAttractionStrength, newMaxSpeed;

//    // Smoothly transition between speed states
//    if (smoothedSpeed >= 2.5) {
//        newWanderStrength = 2.0;
//        newAttractionStrength = 1.5;
//        newMaxSpeed = 6.0;
//    } else if (smoothedSpeed >= 1.5) {
//        newWanderStrength = 1.2;
//        newAttractionStrength = 1.0;
//        newMaxSpeed = 3.;
//    } else {
//        newWanderStrength = 0.3;
//        newAttractionStrength = 0.8;
//        newMaxSpeed = 1.5;
//    }

//    // Interpolate changes
//    wanderStrength = lerp(wanderStrength, newWanderStrength, 0.05);
//    attractionStrength = lerp(attractionStrength, newAttractionStrength, 0.05);
//    maxSpeed = lerp(maxSpeed, newMaxSpeed, 0.05);
//}



  void wander() {
    PVector wanderCenter = velocity.copy();
    wanderCenter.setMag(wanderDistance);

    PVector wanderOffset = PVector.random2D();
    //wanderOffset.mult(wanderRadius);
    float scaledRadius = map(maxSpeed, 0.5, 6.0, wanderRadius, 2);
    wanderOffset.mult(scaledRadius);


    PVector wanderTarget = PVector.add(wanderCenter, wanderOffset);
    seek(PVector.add(position, wanderTarget));
  }
  
    void seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    float distance = desired.mag();
    desired.normalize();

    if (distance < 150) {
      float m = map(distance, 0, 150, maxSpeed * attractionStrength, maxSpeed);
      desired.mult(m);
    } else {
      desired.mult(maxSpeed*1);
    }

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    acceleration.add(steer);
  }
  
  void jitter() {
  PVector noiseOffset = PVector.random2D();
  noiseOffset.mult(random(0.5, 1.5));
  acceleration.add(noiseOffset);
}



  void applyBehaviors() {
    //wander();
    
      if (erratic) {
    jitter(); // ✨ add subtle unpredictability
  } else {
    wander(); // regular behavior
  }

    seek(target);
    update();
    //may not need??
    position.x = constrain(position.x, 0, width);
    position.y = constrain(position.y, 0, height);
  }

  void update() {
  acceleration.limit(maxForce); // ✨ added
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

    if (fadingOut) {
      fadeOut();
    } else {
      fadeIn();
    }

    
  }

  // Make sure your display method uses alpha correctly:
  void display() {
    //update();

    float theta = velocity.heading() + PI / 2;

    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    stroke(0, opacity);
    drawTentacles(0, 0);



    fill(250, 250, 10, opacity); // Yellow body
    drawBody(0, 0);

    fill(0, opacity); // Black head
    drawHead(0, 0);

    fill(0, opacity); // Transparent wings
    drawWings(0, 0);

    popMatrix();
  }

  void drawHead(float localX, float localY) {
    strokeWeight(2);
    circle(localX, localY, headWidth);
  }

  void drawTentacles(float localX, float localY) {
    noFill();
    strokeWeight(2);
    arc(localX + headWidth * 0.75, localY - headWidth / 2, headWidth, headWidth * 0.75, PI, PI + HALF_PI);
    arc(localX - headWidth * 0.75, localY - headWidth / 2, headWidth, headWidth * 0.75, PI + HALF_PI, TWO_PI);
  }

  void drawBody(float localX, float localY) {
    ellipse(localX, localY + headWidth * 1.8, headWidth * 1.7, headWidth * 2.7);
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


    ellipse(0, 0, headWidth * 1.35, headWidth * 2.35);
    popMatrix();
  }
}
