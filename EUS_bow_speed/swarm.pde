//class Swarm {
//  ArrayList<Bee> bees;
  
//  Swarm() {
//   bees = new ArrayList<Bee>();
//       for (int i = 0; i < 25; i++) {
//      bees.add(new Bee(random(width), random(height), 1.0));
//    }
//  }
  
//    void updateSpeed(float bSpeed) {
//    for (Bee b : bees) {
//      b.updateTargetSpeed(bSpeed);
//    }
//  }
  
//      void applyBehaviors() {
//        ArrayList<Bee> currentBees = new ArrayList<Bee>(bees);
//        for (Bee b : currentBees) {
//            b.applyBehaviors();
//        }
//    }

//    void display() {
//        ArrayList<Bee> currentBees = new ArrayList<Bee>(bees);
//        for (Bee b : currentBees) {
//            b.display();
//        }
//    }
  
  
  
//}

class Swarm {
  ArrayList<Bee> bees; //an arraylist that stores all Bee objects in the swarm
  ArrayList<Float> speedHistory;  //a list that stores all recent bSpeed values
  int maxHistorySize = 50; //number of frames used for smoothing

  Swarm() {
    bees = new ArrayList<Bee>(); // initiates an empty list to store Bee objects
    speedHistory = new ArrayList<Float>();  

    for (int i = 0; i < 25; i++) {
      bees.add(new Bee(random(width), random(height), 1.0)); //runs through a loop, creating 25 bee objects and adds them to a swarm
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

void applyBehaviors() {
    for (Bee b : bees) { 
        b.applyBehaviors(); // Make the bee behave
    }
}

void display() {
    for (Bee b : bees) { 
        b.display(); // Make the bee visible
    }
}



}
