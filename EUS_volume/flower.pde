class Flower {
    float x, y; // Position of the flower
    color baseColor; // Color of the flower
    int petalCount; // Number of petals
    float len; // Length of the petals
    float wid; // Width scaling of the petals
    int rowCount; // Number of petal rows

    Flower(float x, float y) {
        this.x = x;
        this.y = y;
        this.baseColor = color(random(100, 255), random(100, 250), random(100, 255));
        this.petalCount = 8; // Fixed petal count for simplicity
        this.len = 100; // Petal length
        this.wid = 0.6; // Petal width scaling
        this.rowCount = 7; // Number of rows of petals
    }

    void display() {
        stroke(0);
        strokeWeight(1);
        float deltaA = (2 * PI) / petalCount;
        float petalLen = len;

        pushMatrix();
        translate(x, y); // Draw the flower at its position
        for (int r = 0; r < rowCount; r++) {
            fill(lerpColor(baseColor, color(255, 130, 150), r / (float) rowCount)); // Gradient effect
            pushMatrix();
            for (float angle = 0; angle < 2 * PI; angle += deltaA) {
                rotate(deltaA);
                ellipse(petalLen * 0.75, 0, petalLen, petalLen * wid);
            }
            popMatrix();
            petalLen *= 0.8; // Shrink petals in each row
        }
        popMatrix();
    }
}
