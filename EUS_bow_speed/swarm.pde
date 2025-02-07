class Swarm {
  ArrayList<Bee> bees;
  
  Swarm() {
   bees = new ArrayList<Bee>();
       for (int i = 0; i < 25; i++) {
      bees.add(new Bee(random(width), random(height), 1.0));
    }
  }
  
    void updateSpeed(float bSpeed) {
    for (Bee b : bees) {
      b.updateTargetSpeed(bSpeed);
    }
  }
  
      void applyBehaviors() {
        ArrayList<Bee> currentBees = new ArrayList<Bee>(bees);
        for (Bee b : currentBees) {
            b.applyBehaviors();
        }
    }

    void display() {
        ArrayList<Bee> currentBees = new ArrayList<Bee>(bees);
        for (Bee b : currentBees) {
            b.display();
        }
    }
  
  
  
}
