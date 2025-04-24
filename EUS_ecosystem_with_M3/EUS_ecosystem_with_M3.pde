
import oscP5.*;
import netP5.*;

import java.util.ArrayList;
import java.util.List;

PImage grass;
Flower[] flower;
Flowers flowers;
Swarm swarm;

OscP5 oscP5;
NetAddress dest;
NetAddress maxAddr;

ArrayList<Flowers> flowerList = new ArrayList<Flowers>();
ArrayList<Float> volumeMemory = new ArrayList<Float>();
int gestureState = 0;
ArrayList<Float> gestureMemory = new ArrayList<Float>();
int maxMemorySize = 120;  // 2 seconds at 60fps
color currentBG;
color targetBG;

color currentTint;
color targetTint;
float currentTintAlpha = 180;
float targetTintAlpha = 180;
float alphaPulse = 0;  // dynamic part




boolean flowerSparkle = false;





void setup() {
  fullScreen(P2D);
  //size(600, 600);
  grass = loadImage("grass.png");
  //colorMode(HSB, 360, 100, 100);
  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6450);

  flower = new Flower[4];
  flower[0] = new Flower(width*0.63, height*0.18, 100, 0.4, 7);
  flower[1] = new Flower(width*0.4, height*0.4, 110, 0.9, 8);
  flower[2] = new Flower(width*0.6, height*0.60, 80, 0.5, 6);
  flower[3] = new Flower(width/2, height*0.83, 101, 0.63, 7);
  swarm = new Swarm(); // Initialize swarm
  flowers = new Flowers();


  currentBG = targetBG = color(30, 40, 70);  // default calm
  currentTint = targetTint = color(200, 220, 255);

  //bee.updateDimensions(width, height);
}

void draw() {
  // 👇 Smooth transition always
currentBG = lerpColor(currentBG, targetBG, 0.01);
currentTint = lerpColor(currentTint, targetTint, 0.01);
currentTintAlpha = lerp(currentTintAlpha, targetTintAlpha, 0.01);
//background(0);
background(currentBG);
//tint(red(currentTint), green(currentTint), blue(currentTint), currentTintAlpha);
float finalAlpha = currentTintAlpha + alphaPulse;
finalAlpha = constrain(finalAlpha, 0, 255);  // ensure it's valid
tint(red(currentTint), green(currentTint), blue(currentTint), finalAlpha);

image(grass, 0, 0, width, height);
noTint();



  //background(0);  // Reset every frame

  int sliderMode = (int)slider;  // Ensure consistent int type

  switch (sliderMode) {
  case 1:
    drawMode1();  // 🌼 Only flowers
    break;

  case 2:
    drawMode2();    // 🐝 Only swarm
    break;

  case 3:
    drawMode3(); // 🐝 + 🌼 Both
    break;

  default:
    // Optional: draw idle or debug screen
    fill(255);
    textAlign(CENTER, CENTER);
    text("Waiting for input...", width/2, height/2);
    break;
  }
}

void drawMode1() {
  alphaPulse = 0;

  targetBG = color(30, 40, 70);
targetTint = color(200, 220, 255);
targetTintAlpha = 180;

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
  alphaPulse = sin(frameCount * 0.03) * 60;
targetTintAlpha = 180; 

  targetBG = color(255, 190, 150);
targetTint = color(255, 230, 200);
targetTintAlpha = 220;


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
  flowerSparkle = true;
  swarm.setErratic(false);
alphaPulse = sin(frameCount * 0.01) * 30;
targetTintAlpha = 180;  
  gestureState = int(gestures);
  


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
