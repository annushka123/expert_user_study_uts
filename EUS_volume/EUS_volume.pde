
import oscP5.*;
import netP5.*;

import java.util.ArrayList;
import java.util.List;

OscP5 oscP5;
NetAddress dest;
NetAddress maxAddr;

Bee bee;

void setup() {

  size(600, 600);

  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6450);

  bee = new Bee(width/2, height/2, 1.0);
  //bee.updateDimensions(width, height);
}



void draw() {
  background(255);
  bee.display();

  
}
