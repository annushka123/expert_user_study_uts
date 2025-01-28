
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


      if (amp == 1.0) {
        bee.setSize(1.0); // Default size
      } else if (amp == 2.0) {
        bee.setSize(2.0); // Slightly larger
      } else if (amp == 3.0) {
        bee.setSize(3.0); // Even larger
      } else if (amp == 4.0) {
        bee.setSize(4.0);
      } else if (amp == 5.0) {
        bee.setSize(5.0);
      }
    }
  }
}
