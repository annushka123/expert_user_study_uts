
import oscP5.*;
import netP5.*;

import java.util.ArrayList;
import java.util.List;

OscP5 oscP5;
NetAddress dest;
NetAddress maxAddr;


Flower flower;
Swarm swarm;

void setup() {

  size(600, 600);

  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6450);
  flower = new Flower(width/2, height/2);
  swarm = new Swarm(); // Initialize swarm
  //bee.updateDimensions(width, height);
}



void draw() {
  background(255);
  flower.display();
    swarm.applyBehaviors();
    swarm.display();

  
}
