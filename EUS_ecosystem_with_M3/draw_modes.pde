
void drawMode1() {


  targetBG = color(30, 40, 70);
  targetTint = color(200, 220, 255);
  targetTintAlpha = 180;
  alphaPulse = 0;

  for (int i = 0; i < flower.length; i++) {
    flower[i].updateDrift(false);  // return to original position
  }


  swarm.setErratic(false);  // reset to normal
  flowerSparkle = false;

  float mappedPressure = map(pressure, 1, 3, 0, 1);
  int targetFlowers = int(pow(mappedPressure, 2) * 200);
  flowers.updateFlowerCount(targetFlowers);

  flowers.display();
  for (int i = 0; i < flower.length; i++) {
    flower[i].display();
  }

  swarm.updateSwarmSize(targetBees);
  swarm.updateHeights(bowPos, flower);
  swarm.updateSpeed(bSpeed);
  swarm.applyBehaviors();
  swarm.display();
}


void drawMode2() {



  targetBG = color(255, 190, 150);
  targetTint = color(255, 230, 200);
  targetTintAlpha = 220;
  alphaPulse = sin(frameCount * 0.03) * 60;


  for (int i = 0; i < flower.length; i++) {
    flower[i].updateDrift(false);  // return to original position
  }

  flowerSparkle = true;

  //image(grass, 0, 0, width, height);
  swarm.setErratic(true);  // activate erratic mode
  float mappedPressure = map(pressure, 1, 3, 0, 1);
  int targetFlowers = int(pow(mappedPressure, 2) * 200);
  flowers.updateFlowerCount(targetFlowers);

  flowers.display();
  for (int i = 0; i < flower.length; i++) {
    flower[i].display();
  }
  swarm.updateSwarmSize(targetBees);
  swarm.updateHeights(bowPos, flower);
  swarm.updateSpeed(bSpeed);
  swarm.applyBehaviors();
  swarm.display();
}


void drawMode3() {

  float avgDensity = average(densityMemory);
  float avgVolume = average(volumeMemory);
  float avgBowPos = average(bowPosMemory);


  float normDensity = map(avgDensity, 1, 3, 0, 1);  // assuming density is 1-3
  float normVolume = map(avgVolume, 0.1, 5.0, 0, 1); // volume is 0.1-5
  float normBowPos = map(avgBowPos, 1, 4, 0, 1);     // bow position 1-4

  float beeMoodScore =
    (normDensity * 0.4) +
    (normVolume * 0.4) +
    ((1.0 - normBowPos) * 0.2);  // lower bow positions = higher agitation
    
    int swarmMood;

if (beeMoodScore < 0.3) {
  swarmMood = 1;  // calm
} else if (beeMoodScore < 0.6) {
  swarmMood = 2;  // focused
} else {
  swarmMood = 3;  // chaotic
}



  flowerSparkle = true;
  swarm.setErratic(false);
  alphaPulse = sin(frameCount * 0.01) * 30;
  targetTintAlpha = 180;
  gestureState = (int)gestures;



  switch (gestureState) {
  case 1:
    targetBG = color(30, 40, 70);
    targetTint = color(30, 220, 255);
    targetTintAlpha = 200;
    break;
  case 2:
    targetBG = color(80, 10, 30);
    targetTint = color(255, 150, 180);
    targetTintAlpha = 200;
    break;
  case 3:
    targetBG = color(10, 0, 0);
    targetTint = color(180, 100, 255);
    targetTintAlpha = 180;
    break;
  default:
    targetBG = color(20);
    targetTint = color(255);
    targetTintAlpha = 160;
  }


  currentBG = lerpColor(currentBG, targetBG, 0.05);
  currentTint = lerpColor(currentTint, targetTint, 0.05);
  currentTintAlpha = lerp(currentTintAlpha, targetTintAlpha, 0.05);

  background(currentBG);
  tint(red(currentTint), green(currentTint), blue(currentTint), currentTintAlpha);
  image(grass, 0, 0, width, height);
  noTint();




  // 👁️ Memory-based behavior
  float avgVol = constrain(average(volumeMemory), 0.05, 1.5);
  //float flowerPulse = map(avgVol, 0.2, 1.0, 1.0, 1.5);
  float beeSpeed = map(avgVol, 0.05, 1.0, 0.5, 6.0);

  for (int i = 0; i < flower.length; i++) {
    flower[i].updateDrift(true);  // 🌬 floating
    flower[i].display();          // 🖼 draw it!
  }

  flowers.display(); // 🌸 dynamic flower field

  swarm.updateSpeed(beeSpeed);
  swarm.setMood(swarmMood, flower);

  swarm.applyBehaviors();
  swarm.display();
}


float average(ArrayList<Float> data) {
  float sum = 0;
  for (float v : data) {
    sum += v;
  }
  return (data.size() > 0) ? sum / data.size() : 0;
}
