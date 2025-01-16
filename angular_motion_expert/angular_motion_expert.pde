
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;


float angle = 0;
float aVelocity = 0;
float aAcceleration = 0.001;
float p1, p2, p3, p4, p5, p6, p7, p8, p9, p10;
float mX, mY, mZ, accelX, accelY, accelZ, fsr, slider;
float xMove, yMove, zMove, mappedAccelX, mappedAccelY, mappedFsr, mappedSlider;

Mover mover;

void setup() {
//size(500, 500);
fullScreen();
background(0);

setupOSC();
mover = new Mover();
}

void draw() {
//background(255);

if(fsr < 300) {
  background(0);
}
mover.display();
 mover.update(xMove, yMove);

}
