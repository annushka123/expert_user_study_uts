
float bSpeed, bSpeed2, gestures, bowPos, pitch, volume, desnity, pressure, spare, spare_two;

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
      
      //pitches
      desnity = theOscMessage.get(6).floatValue();
      //range
      pressure = theOscMessage.get(7).floatValue();
      spare = theOscMessage.get(8).floatValue();
      spare_two = theOscMessage.get(9).floatValue();
      
      
      swarm.updateHeights(bowPos, flowers);
      println("bPos ;" + bowPos);
      
      //swarm.updateHeights(pitch, flowers);
      //println("pitch ;" + pitch);

    }
  }
}
