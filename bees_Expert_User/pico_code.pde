


void setupOSC() {
    oscP5 = new OscP5(this, 12000);
    dest = new NetAddress("127.0.0.1", 6450);
    //maxAddr = new NetAddress("127.0.0.1", 12001); 
}

void sendZMoveToMax(float zMoveValue) {
    OscMessage msg = new OscMessage("/zMove");
    msg.add(zMoveValue);
    oscP5.send(msg, dest);
}
void oscEvent(OscMessage theOscMessage) {
    if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
        if (theOscMessage.checkTypetag("ffffffffff")) {
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

            println("xMove:", xMove, "yMove:", yMove, "zMove:", zMove, "mappedAccelX:", mappedAccelX, "mappedAccelY:", mappedAccelY, "mappedAccelZ:", mappedAccelZ);
            println("mX:", mX, "mY:", mY);

         // Normalize and map accelerometer values to screen coordinates
            // Normalize and map accelerometer values to screen coordinates
            xMove = map(mX, -24, 4, 0, width); // Adjust the range based on actual data
            xMove = constrain(xMove, 0, width);
            
            yMove = map(mY, -4, 24, 0, height); // Adjust the range based on actual data
            yMove = constrain(yMove, 0, height);


            zMove = map(mZ, -10, 10, -1, 1); // Adjust the range based on actual data

            mappedAccelX = map(accelX, -1, 1.5, 0.01, 1);
            mappedAccelY = map(accelY, -1, 1.5, 0.01, 1);

            mappedSlider = map(slider, 0, 1023, 50, 150);
            mappedFsr = map(fsr, 0, 580, 0.01, 1.5);

            // Use the mapped data to update the state and visuals
            updateState();


            
            
        float additionalRotationSpeed = mappedFsr;
       float additionalRotationSpeedY = mappedFsr;
            for (Flower flower : flowers) {
                flower.updateAdditionalRotation(additionalRotationSpeed, additionalRotationSpeedY);
            }
            
            sendZMoveToMax(zMove);
        }
    }
}

void updateState() {
    // Print current and previous values to debug
    //println("mX:", mX, "prevX:", prevX);
    //println("mY:", mY, "prevY:", prevY);

    // Calculate the changes in x and y
    float deltaX = abs(mX - prevX);
    float deltaY = abs(mY - prevY);

    // Print delta values for debugging
    //println("deltaX:", deltaX);
    //println("deltaY:", deltaY);

    // Update previous values for next comparison
    prevX = mX;
    prevY = mY;

    // Check if the changes are less than the threshold
    if (deltaX < 5 && deltaY < 5) {
        if (state != 2) { // Only switch to resting state if not already moving
            state = 1;  // Resting state
        }
    } else {
        state = 2;  // Moving state
    }

    // Print state for debugging
    //println("state:", state);
}

float mapAccelToScreen(float value, float srcMin, float srcMax, float dstMin, float dstMax) {
    return map(value, srcMin, srcMax, dstMin, dstMax);
}

//float mapAccelToScreen(float value, float srcMin, float srcMax, float dstMin, float dstMax) {
//    float normValue = (value - srcMin) / (srcMax - srcMin);
//    float nonLinearValue = pow(normValue, 2);
//    return lerp(dstMin, dstMax, nonLinearValue);
//}

//void printRawBytes(byte[] data) {
//    StringBuilder sb = new StringBuilder("Raw bytes: ");
//    for (byte b : data) {
//        sb.append(String.format("%02X ", b));
//    }
//    println(sb.toString());
//}
