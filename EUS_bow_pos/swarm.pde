class Swarm {
  ArrayList<Bee> bees;
  
  Swarm() {
   bees = new ArrayList<Bee>();
       for (int i = 0; i < 5; i++) {
      bees.add(new Bee(random(width), random(height), 1.0));
    }
  }
  
//void updateHeights(float pitch, Flower[] flowers) {
//    for (Bee b : bees) {
//        b.updateTargetHeight(pitch, flowers);
//    }
//}

void updateHeights(float bowPos, Flower[] flowers) {
    for (Bee b : bees) {
        b.updateTargetHeight(bowPos, flowers);
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
