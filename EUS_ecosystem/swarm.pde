

class Swarm {
    ArrayList<Bee> bees;
    ArrayList<Float> speedHistory;  //a list that stores all recent bSpeed values
    int maxHistorySize = 50; //number of frames used for smoothing

    Swarm() {
        bees = new ArrayList<Bee>();
        speedHistory = new ArrayList<Float>();
      for (int i = 0; i < 25; i++) {
      bees.add(new Bee(random(width), random(height), 1.0));
    }
    }
    
    void updateHeights(float bowPos, Flower[] flower) {
    for (Bee b : bees) {
        b.updateTargetHeight(bowPos, flower);
    }
}

  void updateSpeed(float bSpeed) {
    speedHistory.add(bSpeed); // Add new speed

    // Keep only the last `maxHistorySize` values
    if (speedHistory.size() > maxHistorySize) {
        speedHistory.remove(0);
    }

    float smoothedSpeed = getSmoothedSpeed(); // Compute the average speed

    // Update each bee with the smoothed speed
    for (Bee b : bees) {
        b.updateTargetSpeed(smoothedSpeed);
    }
}

float getSmoothedSpeed() {
    float sum = 0;
    
    for (float speed : speedHistory) { 
        sum += speed; // Add each speed to the sum
    }
    
    return sum / speedHistory.size(); // Get the average
}

    void updateSwarmSize(int numBees) {
      
        int currentSize = bees.size();
        
        if(numBees > currentSize) {
         for (int i = currentSize; i < numBees; i++) {
             bees.add(new Bee(random(width), random(height), 1.0));
          
          }
        }else if(numBees < currentSize) {
          for (int i = currentSize -1; i >= numBees; i--) {
            //bees.remove(i);
            bees.get(i).fadingOut = true; 
          
        }
      }
    }

    //void applyBehaviors() {
    //    ArrayList<Bee> currentBees = new ArrayList<Bee>(bees);
    //    for (Bee b : currentBees) {
    //        b.applyBehaviors();
    //    }
    //}
    
    void applyBehaviors() {
      
    for (int i = bees.size() - 1; i >= 0; i--) {
        Bee b = bees.get(i);
        if (b.fadingOut && b.opacity <= 0) {
            bees.remove(i); // Remove only after fading is complete
        } else {
            b.applyBehaviors();
        }
    }
      
}


    void display() {
        ArrayList<Bee> currentBees = new ArrayList<Bee>(bees);
        for (Bee b : currentBees) {
            b.display();
        }
    }
}
