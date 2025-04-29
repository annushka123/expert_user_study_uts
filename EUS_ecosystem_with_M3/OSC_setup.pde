
float bSpeed, bSpeed2, gestures, bowPos, pitch, volume, density, pressure, spare, slider;
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
      density = theOscMessage.get(6).floatValue();
      //range
      pressure = theOscMessage.get(7).floatValue();
      spare = theOscMessage.get(8).floatValue();
      slider = theOscMessage.get(9).floatValue();


      
       
      volume = theOscMessage.get(5).floatValue();
      float mappedValue = map(volume, 1, 5, 1, 15);
      targetBees = int(pow(mappedValue, 2));


      volumeMemory.add(volume);
      if (volumeMemory.size() > maxMemorySize) {
        volumeMemory.remove(0);
      }


      gestureMemory.add(gestures);
      if (gestureMemory.size() > maxMemorySize) {
        gestureMemory.remove(0);
      }

      densityMemory.add(density);

      bowPosMemory.add(bowPos);

      if (densityMemory.size() > maxMemorySize) densityMemory.remove(0);

      if (bowPosMemory.size() > maxMemorySize) bowPosMemory.remove(0);



      // Optional: handle button 4 kill here
    }
  }

  if (theOscMessage.checkAddrPattern("/max/outputs/buttons") == true) {

    int buttonID = theOscMessage.get(0).intValue();

    println("button: " + buttonID);
      switch (buttonID) {
    case 5: // short press: manual mode
      useAutonomousSlider = false;
      println("✅ Manual Slider Mode (performer control)");
      break;

    case 6: // long press: autonomous mode
      useAutonomousSlider = true;
      println("✅ Autonomous Slider Mode (system decides)");
      sendAutonomousSliderToMax();
      break;


  }
}
}

void sendAutonomousSliderToMax() {
  if (toMax != null && oscP5 != null) {  // ✅ optional safe check
    OscMessage msg = new OscMessage("/processing/autonomousSlider");
    msg.add(autonomousSlider);  // 1, 2, or 3
    oscP5.send(msg, toMax);
  } else {
    println("❌ Cannot send autonomousSlider - OSC or toMax not ready");
  }
}
