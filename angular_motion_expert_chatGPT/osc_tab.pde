void setupOSC() {
  oscP5 = new OscP5(this, 12000);
  //oscP5 = new OscP5(this, 12001);
  dest = new NetAddress("127.0.0.1", 6450);
}


void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if (theOscMessage.checkTypetag("ffffffffff")) { // Now looking for 6 parameters
      //bow speed
      p1 = theOscMessage.get(0).floatValue();
      //bow position
      p2 = theOscMessage.get(1).floatValue();
      //starting gesture
      p3 = theOscMessage.get(2).floatValue();
      //bow acceleration
      p4 = theOscMessage.get(3).floatValue();
      //note density
      p5 = theOscMessage.get(4).floatValue();
      //println("p5;", p5);
      //amplitude
      p6 = theOscMessage.get(5).floatValue();
      //pitches
      p7 = theOscMessage.get(6).floatValue();
      //range
      p8 = theOscMessage.get(7).floatValue();
      p9 = theOscMessage.get(8).floatValue();
      p10 = theOscMessage.get(9).floatValue();
    }
    
      } else if (theOscMessage.checkAddrPattern("/max/input") == true) {
    if (theOscMessage.checkTypetag("ffffffff")) {
      mX = theOscMessage.get(0).floatValue();
      mY = theOscMessage.get(1).floatValue();
      mZ = theOscMessage.get(2).floatValue();
      accelX = theOscMessage.get(3).floatValue();
      accelY = theOscMessage.get(4).floatValue();
      accelZ = theOscMessage.get(5).floatValue();
      
      fsr = theOscMessage.get(6).floatValue();
      slider = theOscMessage.get(7).floatValue();
      
      
      println("mX:", mX, "mY:", mY, "mZ:", mZ, "accelX:", accelX, "accelY:", accelY, "accelZ:", accelZ);

            // Normalize and map accelerometer values to screen coordinates
       xMove = mapAccelToScreen(abs(mX), 0, 15, 0, width);
       xMove=constrain(xMove,10, width-10);
       yMove = mapAccelToScreen(abs(mY), 0, 15, height, 0);
     
       zMove = map(abs(mZ), 0, 17, 1, 7);
       
       mappedAccelX = map(abs(accelX), 0., 1.5, 0.001, 0.01);
       mappedAccelY = map(abs(accelY), 0., 1.5, 0.001, 0.01);
       
       mappedSlider = map(slider, 0, 1023, 50, 150);

    }
  }
}

//float mapAccelToScreen(float value, float srcMin, float srcMax, float dstMin, float dstMax) {
//  // Custom mapping to account for non-linearity
//  // Normalize the value to 0-1 range
//  float normValue = (value - srcMin) / (srcMax - srcMin);
//  // Apply non-linear transformation (exponential scaling in this case)
//  float nonLinearValue = pow(normValue, 2); // Adjust the exponent as needed
//  // Map the non-linear value to the destination range
//  return lerp(dstMin, dstMax, nonLinearValue);
//}


float mapAccelToScreen(float value, float srcMin, float srcMax, float dstMin, float dstMax) {
  float normValue = constrain((value - srcMin) / (srcMax - srcMin), 0, 1);
  float nonLinearValue = sqrt(normValue); // Square root for smoother transition
  return lerp(dstMin, dstMax, nonLinearValue);
}


void drawTrajectory(float x, float y, float z) {
  // Draw trajectory point
  stroke(getColor(z));
  strokeWeight(2);
  point(x, y);

  // Draw lines connecting previous points for a continuous trajectory
  if (prevPosition != null) {
    line(prevPosition.x, prevPosition.y, x, y);
  }

  // Update previous position
  prevPosition.set(x, y);
}

int getColor(float z) {
  if (z < 2) return color(0, 255, 0); // Green for low z values
  else if (z < 7) return color(255, 255, 0); // Yellow for medium z values
  else return color(255, 0, 0); // Red for high z values
}
