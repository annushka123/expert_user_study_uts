
import oscP5.*;
import netP5.*;

import java.util.ArrayList;
import java.util.List;

OscP5 oscP5;
NetAddress dest;
NetAddress maxAddr;

 ArrayList<Flowers> flowerList = new ArrayList<Flowers>();




Flower[] flower;
Flowers flowers;
Swarm swarm;

void setup() {

  size(600, 600);
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

  //bee.updateDimensions(width, height);
}

void draw() {
  background(0);  // Reset every frame

  int sliderMode = int(slider);  // Ensure consistent int type

  switch (sliderMode) {
    case 1:
      drawFlowers();  // 🌼 Only flowers
      break;

    case 2:
      drawSwarm();    // 🐝 Only swarm
      break;

    case 3:
      drawSwarmAndFlowers(); // 🐝 + 🌼 Both
      break;

    default:
      // Optional: draw idle or debug screen
      fill(255);
      textAlign(CENTER, CENTER);
      text("Waiting for input...", width/2, height/2);
      break;
  }
}

void drawSwarmAndFlowers() {
  background(0);
  flowers.display();
  for (int i = 0; i < flower.length; i++) {
    flower[i].display();
  }
  swarm.applyBehaviors();
  swarm.display();
}

void drawSwarm() {
  background(0);
  swarm.applyBehaviors();
  swarm.display();
}

void drawFlowers() {
  background(0);
  flowers.display();
  for (int i = 0; i < flower.length; i++) {
    flower[i].display();
  }
}




//void draw() {
//  background(0);
  

//   flowers.display();
//    for(int i = 0; i < flower.length; i++) {
//    flower[i].display();
//    } // You might remove this if you're drawing many flowers
  

//  //flower.display();
//  swarm.applyBehaviors();
//  swarm.display();
  
//}
