
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



      float mappedValue = map(amp, 1, 5, 1, 15);
      int targetBees = int(pow(mappedValue, 2));

      swarm.updateSwarmSize(targetBees);
    }
  }
}
