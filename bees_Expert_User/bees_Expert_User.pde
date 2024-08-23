
import oscP5.*;
import netP5.*;

import java.util.ArrayList;
import java.util.List;

OscP5 oscP5;
NetAddress dest;
NetAddress maxAddr;

int state;  // Initialize the state variable for the single accelerometer

float prevX, prevY, prevZ;

String receivedData = "";
List<HexagonGrid> grids;
PGraphics honeycombLayer;
ArrayList<Vehicle> vehicles;
ArrayList<PVector> centers = new ArrayList<PVector>();
ArrayList<Flower> flowers = new ArrayList<Flower>();
int maxAttempts = 100;

float mX, mY, mZ, accelX, accelY, accelZ, fsr, slider;
float xMove, yMove, zMove, mappedAccelX, mappedAccelY, mappedAccelZ, mappedFsr, mappedSlider;
float p1, p2, p3, p4, p5, p6, p7, p8, p9, p10;

float easedX;
float easedY;

PImage bgImage;
PVector[] flowerPositions;

ArrayList<HoneyCombBee> honeyCombBees;

float beeThreshold = 0.5;  // Threshold for bees
float flowerThreshold = 0.5;  // Threshold for flowers

void setup() {
    fullScreen(2);
    bgImage = loadImage("grass.png");

    // Resize the image to fit the screen
    bgImage.resize(width, height);

    // Apply a blur filter
    bgImage.filter(BLUR, 5);
    
    grids = new ArrayList<HexagonGrid>();
    grids.add(new HexagonGrid(7, 60, 10, 30));
    grids.add(new HexagonGrid(10, 30, width * 0.7, height / 2));
    grids.add(new HexagonGrid(10, 15, width * 0.5, height * 0.1));

    flowerPositions = new PVector[3];
    flowerPositions[0] = new PVector(width * 0.85, height * 0.25);
    flowerPositions[1] = new PVector(width - width * 0.44, height * 0.55);
    flowerPositions[2] = new PVector(width - width * 0.7, height * 0.75);

    flowers.add(new Flower(flowerPositions[0].x, flowerPositions[0].y, 0));
    flowers.add(new Flower(flowerPositions[1].x, flowerPositions[1].y, 1));
    flowers.add(new Flower(flowerPositions[2].x, flowerPositions[2].y, 2));

    vehicles = new ArrayList<Vehicle>();
    for (int i = 0; i < 800; i++) {
        int swarm = i % 3;
        vehicles.add(new Vehicle(random(width), random(height), swarm));
    }

easedX = mappedAccelX;
easedY = mappedAccelY;

    setupOSC();
    
}

void draw() {
    background(150);
    
    // Draw the blurred background image
    image(bgImage, 0, 0);

    // Draw honeycombs with RGB color mode
    colorMode(RGB, 255);
    for (HexagonGrid grid : grids) {
        grid.draw();
    }
    
    // Update and display flowers with new rotations
    colorMode(HSB, 255);
    for (int i = 0; i < flowers.size(); i++) {
        int flowerId = flowers.get(i).id;
        flowers.get(i).updateAdditionalRotation(mappedAccelX, mappedAccelY);
        flowers.get(i).update(); 
        flowers.get(i).drawStem();
        flowers.get(i).display();
    }

    // Update and display vehicles
    colorMode(RGB, 255);
    for (Vehicle v : vehicles) {
        v.applyBehaviors(vehicles);
        v.update();
        v.display();
    }

    // Easing for the ellipse position
// Easing for the ellipse position
float easing = 0.1;
easedX = lerp(easedX, xMove, easing);
easedY = lerp(easedY, yMove, easing);


    if (fsr > 150) {
        drawWavyWindLines(fsr);
    }
     //sendZMoveToMax(zMove);
}

void drawWavyWindLines(float accelValue) {
    stroke(255, 255, 255, 150);
    strokeWeight(2);
    noFill();
    int numLines = int(map(abs(accelValue), 0, 800, 10, 50));

    for (int i = 0; i < numLines; i++) {
        float startX = random(width);
        float startY = random(height);
        float amplitude = random(10, 30);
        float wavelength = random(50, 130);
        float endX = startX + wavelength;
        float endY = startY + random(-20, 20);

        beginShape();
        for (float x = startX; x <= endX; x += 5) {
            float t = map(x, startX, endX, 0, 1);
            float y = lerp(startY, endY, t) + amplitude * sin(TWO_PI * (x - startX) / wavelength);
            vertex(x, y);
        }
        endShape();
    }
}
