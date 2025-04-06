import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;
NetAddress maxAddr;
Flower[] flowers;
Swarm swarm;

void setup() {

  size(600, 800);

  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6450);
  
  flowers = new Flower[4];
  flowers[0] = new Flower(width*0.63, height*0.18, 100, 0.4, 7);
  flowers[1] = new Flower(width*0.4, height*0.4, 110, 0.9, 8);
  flowers[2] = new Flower(width*0.6, height*0.60, 80, 0.5, 6);
  flowers[3] = new Flower(width/2, height*0.83, 101, 0.63, 7);
  swarm = new Swarm(); 
}

void draw() {
  background(255);
  for(int i = 0; i < flowers.length; i++) {
    flowers[i].display();
  }
    swarm.applyBehaviors();
    swarm.display();
}
