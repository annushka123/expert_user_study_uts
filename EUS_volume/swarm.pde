

class Swarm {
    ArrayList<Bee> bees;

    Swarm() {
        bees = new ArrayList<Bee>();
        bees.add(new Bee(width/2, height/2, 1.0));
    }

    void updateSwarmSize(int numBees) {
        int currentSize = bees.size();
        
        if(numBees > currentSize) {
         for (int i = currentSize; i < numBees; i++) {
             bees.add(new Bee(width/2, height/2, 1.0));
          
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
