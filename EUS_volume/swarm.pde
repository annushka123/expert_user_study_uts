//class Swarm {
//    ArrayList<Bee> bees;
//    int targetBeeCount;

//    Swarm() {
//        bees = new ArrayList<Bee>();
//        bees.add(new Bee(width/2, height/2, 1.0));
//        targetBeeCount = 1;
//    }

//    void updateSwarmSize(int numBees) {
//        targetBeeCount = numBees;
//        println("Target bee count: " + targetBeeCount + " | Current bee count: " + bees.size());

//        // First, handle adding new bees if needed
//        while (bees.size() < targetBeeCount) {
//            bees.add(new Bee(width/2, height/2, 1.0));
//        }

//        // Create a temporary list for bees to remove
//        ArrayList<Bee> beesToRemove = new ArrayList<Bee>();
        
//        // Update fade states
//        for (Bee b : bees) {
//            if (bees.indexOf(b) >= targetBeeCount) {
//                b.fadeOut();
//                if (b.isInvisible()) {
//                    beesToRemove.add(b);
//                }
//            } else {
//                b.fadeIn();
//            }
//        }
        
//        // Remove faded bees after iteration is complete
//        bees.removeAll(beesToRemove);
//    }

//    void applyBehaviors() {
//        // Create a temporary copy of the list for iteration
//        ArrayList<Bee> currentBees = new ArrayList<Bee>(bees);
//        for (Bee b : currentBees) {
//            b.applyBehaviors();
//        }
//    }

//    void display() {
//        // Create a temporary copy of the list for iteration
//        ArrayList<Bee> currentBees = new ArrayList<Bee>(bees);
//        for (Bee b : currentBees) {
//            b.display();
//        }
//    }
//}

class Swarm {
    ArrayList<Bee> bees;
    int targetBeeCount;
    int previousTargetCount;  // Track previous target to avoid unnecessary updates

    Swarm() {
        bees = new ArrayList<Bee>();
        bees.add(new Bee(width/2, height/2, 1.0));
        targetBeeCount = 1;
        previousTargetCount = 1;
    }

    void updateSwarmSize(int numBees) {
        // Only process update if the target count has changed
        if (numBees != previousTargetCount) {
            targetBeeCount = numBees;
            println("Target changed from " + previousTargetCount + " to " + targetBeeCount);
            
            // Add new bees if needed
            while (bees.size() < targetBeeCount) {
                Bee newBee = new Bee(width/2, height/2, 1.0);
                bees.add(newBee);
            }
            
            previousTargetCount = targetBeeCount;
        }

        // Always update fade states
        ArrayList<Bee> beesToRemove = new ArrayList<Bee>();
        for (int i = 0; i < bees.size(); i++) {
            Bee b = bees.get(i);
            if (i >= targetBeeCount) {
                b.fadeOut();
                if (b.isInvisible()) {
                    beesToRemove.add(b);
                }
            } else {
                b.fadeIn();
            }
        }
        
        // Remove fully faded bees
        if (!beesToRemove.isEmpty()) {
            bees.removeAll(beesToRemove);
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
