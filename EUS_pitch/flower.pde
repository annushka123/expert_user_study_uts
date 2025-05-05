class Flower {
    float x, y; // Position of the flower
    color baseColor; // Color of the flower
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
