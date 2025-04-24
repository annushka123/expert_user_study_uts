
float bSpeed, bSpeed2, gestures, bowPos, pitch, volume, desnity, pressure, spare, slider;
int targetBees = 25;  // default



void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if (theOscMessage.checkTypetag("ffffffffff")) {
      //bow speed
      bSpeed = theOscMessage.get(0).floatValue();
      //bow position
      bSpeed2 = theOscMessage.get(1).floatValue();
      //starting gesture
      gestures = theOscMessage.get(2).floatValue();
      //bow acceleration
      bowPos = theOscMessage.get(3).floatValue();
      //note density
      pitch = theOscMessage.get(4).floatValue();
      //amplitude
      volume = theOscMessage.get(5).floatValue();
      //println("volume; ", volume);
      //pitches
      desnity = theOscMessage.get(6).floatValue();
      //range
      pressure = theOscMessage.get(7).floatValue();
      spare = theOscMessage.get(8).floatValue();
      slider = theOscMessage.get(9).floatValue();
      
      volume = theOscMessage.get(5).floatValue();
      float mappedValue = map(volume, 1, 5, 1, 15);
      targetBees = int(pow(mappedValue, 2));


    
    //int sliderMode = (int)slider;
     
    // println(slider);

    //switch (sliderMode) {
    //  case 1:
    //    // Flower logic only

        
        //swarm.updateHeights(bowPos, flower);
        //swarm.updateSpeed(bSpeed);
    //    break;



    //}
      //swarm.updateHeights(bowPos, flower);
      //println("bPos ;" + bowPos);

      //float mappedValue = map(volume, 1, 5, 1, 15);
      //int targetBees = int(pow(mappedValue, 2));
      //println(volume);
      //swarm.updateSwarmSize(targetBees);

      //// 🌼 Flower logic (new and improved)
      //float mappedPressure = map(pressure, 1, 3, 0, 1);
      //int targetFlowers = int(pow(mappedPressure, 2) * 200);
      //flowers.updateFlowerCount(targetFlowers);
    }
  }
}
