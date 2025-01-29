
float bSpeed, bPos, bStart, bAccel, nDense, amp, pitch, p8, p9, p10;


void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if (theOscMessage.checkTypetag("ffffffffff")) {
      //bow speed
      bSpeed = theOscMessage.get(0).floatValue();
      //bow position
      bPos = theOscMessage.get(1).floatValue();
      //starting gesture
      bStart = theOscMessage.get(2).floatValue();
      //bow acceleration
      bAccel = theOscMessage.get(3).floatValue();
      //note density
      amp = theOscMessage.get(4).floatValue();
      //amplitude
       nDense = theOscMessage.get(5).floatValue();
      println("amp; ", amp);
      //pitches
      pitch = theOscMessage.get(6).floatValue();
      //range
      p8 = theOscMessage.get(7).floatValue();
      p9 = theOscMessage.get(8).floatValue();
      p10 = theOscMessage.get(9).floatValue();


            //// More gradual mapping for bee count
            //float normalizedAmp = constrain(amp, 1, 5);
            //float mappedValue = map(normalizedAmp, 1, 5, 1, 10);  // Reduced range
            //int targetBees = int(pow(mappedValue, 2));  // Square for nonlinear growth
            
            //println("Mapped to bee count: " + targetBees);
            //swarm.updateSwarmSize(targetBees);
            
        //            // Ensure we always have at least 1 bee
        //int numBees = int(pow(map(amp, 1, 5, 1, 2), 3) * 50); 

        //println("OSC amp: " + amp + " | Target bee count: " + numBees);
        //swarm.updateSwarmSize(numBees);
        
                    
            // More stable mapping that's less sensitive to small changes
            float normalizedAmp = constrain(amp, 1, 5);
            // Round to nearest 0.5 to reduce jitter
            normalizedAmp = round(normalizedAmp * 2) / 2.0;
            float mappedValue = map(normalizedAmp, 1, 5, 1, 5);
            int targetBees = int(pow(mappedValue, 2));
            
            swarm.updateSwarmSize(targetBees);


    }
  }
}
