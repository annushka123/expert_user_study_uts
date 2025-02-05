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
    float wanderRadius = 50;
    float wanderDistance = 250;
    float wanderStrength = 0.9;
    float attractionStrength = 0.3;

    // Wing properties
    float wingMovementR = 4;
    float wingMovementL = 4;
    float wingSpeedR = 0.1;
    float wingSpeedL = 0.1;
    
    float opacity;
    boolean fadingOut = false;
    


    Bee(float x, float y, float initialSize) {
        position = new PVector(x, y);
        velocity = new PVector(random(-1, 1), random(-1, 1));
        acceleration = new PVector(0, 0);
        target = new PVector(x, y);
        size = initialSize;
        headWidth = 10 * size;
        opacity = 0;

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

    void seek(PVector target) {
        PVector desired = PVector.sub(target, position);
        float distance = desired.mag();
        desired.normalize();

        if (distance < 200) {
            float m = map(distance, 0, 200, 0, maxSpeed * attractionStrength);
            desired.mult(m);
        } else {
            desired.mult(maxSpeed);
        }

        PVector steer = PVector.sub(desired, velocity);
        steer.limit(maxForce);
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
        
                if (fadingOut) {
            fadeOut();
        } else {
            fadeIn();
        }
        
        println("opacity is; " + opacity);
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
