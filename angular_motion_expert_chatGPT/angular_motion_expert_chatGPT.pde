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
PVector prevPosition;

void setup() {
  fullScreen();
  background(0);

  setupOSC();
  mover = new Mover();
  prevPosition = new PVector(width/2, height/2);
}

void draw() {
  // Clear background if fsr value is low
  if(fsr < 300) {
    background(0);
  }

  // Update and display mover
  mover.update(xMove, yMove);
  mover.display();

  // Draw trajectory
  drawTrajectory(xMove, yMove, zMove);
}
