class Flower {
    float x, y; // Position of the flower
    int baseColor; // Color of the flower
    int petalCount; // Number of petals
    float len; // Length of the petals
    float wid; // Width scaling of the petals
    int rowCount; // Number of petal rows

    Flower(float x, float y, float len, float wid, int rowCount) {
        this.x = x;
        this.y = y;
        this.baseColor = color(random(100, 255), random(100, 250), random(100, 255));
        this.petalCount = 8; // Fixed petal count for simplicity
        this.len = len; // Petal length
        this.wid = wid; // Petal width scaling
        this.rowCount = rowCount; // Number of rows of petals
    }

    void display() {
        stroke(0);
        strokeWeight(1);
        float deltaA = (2 * PI) / petalCount;
        float petalLen = len;

        pushMatrix();
        translate(x, y); // Draw the flower at its position
        for (int r = 0; r < rowCount; r++) {
            for (int i = 0; i < petalCount; i++) {
              float angle = i * deltaA;
              float oscillation = sin(frameCount * 0.02 + i) * 5;
              
            fill(lerpColor(baseColor, color(255, 130, 150), r / (float) rowCount)); // Gradient effect
            pushMatrix();
            rotate(angle + radians(oscillation));
            
                            ellipse(petalLen * 0.7, 0, petalLen, petalLen * wid);
            popMatrix();
            }
            petalLen *= 0.8; // Shrink petals in each row
        }
        popMatrix();
    }
}


//class Flower {
//  float x, y;
//  int baseColor;
//  int petalCount;
//  float len;
//  float wid;
//  int rowCount;
//  float[] swaySpeeds;
//  float[] swayOffsets;

//  Flower(float x, float y) {
//    this.x = x;
//    this.y = y;
//    this.petalCount = 8;
//    this.len = 120;
//    this.wid = 0.7;
//    this.rowCount = 8;

//    // VIBRANT RGB COLORS (high contrast combos)
//    int r = (int)random(180, 255);
//    int g = (int)random(30, 180);
//    int b = (int)random(150, 255);
//    baseColor = color(r, g, b);

//    swaySpeeds = new float[petalCount];
//    swayOffsets = new float[petalCount];
//    for (int i = 0; i < petalCount; i++) {
//      swaySpeeds[i] = random(0.01, 0.02);
//      swayOffsets[i] = random(TWO_PI);
//    }
//  }

//  void display() {
//    stroke(0, 120);
//    strokeWeight(1);
//    float angleStep = TWO_PI / petalCount;
//    float petalLen = len;

//    pushMatrix();
//    translate(x, y);

//    for (int r = 0; r < rowCount; r++) {
//      fill(lerpColor(baseColor, color(255, 200, 220), r / (float) rowCount)); // gentle RGB fade

//      for (int i = 0; i < petalCount; i++) {
//        float baseAngle = i * angleStep;
//        float sway = sin(frameCount * swaySpeeds[i] + swayOffsets[i]) * 0.15;

//        float totalAngle = baseAngle + sway;

//        pushMatrix();
//        rotate(totalAngle);
//        float px = petalLen * 0.75;
//        float py = 0;
//        ellipse(px, py, petalLen, petalLen * wid);
//        popMatrix();
//      }

//      petalLen *= 0.8;
//    }

//    popMatrix();
//  }
//}
