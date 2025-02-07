
class Flower {
    float x, y; 
    color baseColor; 
    int petalCount; 
    float len; 
    float wid; 
    int rowCount;
    color[] petalColors;

    Flower(float x, float y) {
        this.x = x;
        this.y = y;
        this.petalCount = 8; 
        this.len = 100; 
        this.wid = 0.6; 
        this.rowCount = 7; 
        
        // Define color palette
        color[] colorPalette = {
            color(255, 50, 50),   // Bright red
            color(255, 200, 0),   // Warm yellow
            color(200, 0, 255),   // Vibrant purple
            color(0, 200, 255),   // Electric blue
            color(50, 255, 100)   // Bright green
        };
        
        // Pick random base color
        baseColor = colorPalette[int(random(colorPalette.length))];
        
        // Generate fixed per-petal colors
        petalColors = new color[petalCount];
        for (int i = 0; i < petalCount; i++) {
            float rShift = random(-40, 40);
            float gShift = random(-30, 30);
            float bShift = random(-40, 40);
            petalColors[i] = adjustPetalColor(baseColor, rShift, gShift, bShift);
        }
    }
    
    void display() {
        stroke(0);
        strokeWeight(1);
        float deltaA = TWO_PI / petalCount;
        float petalLen = len;
        
        pushMatrix();
        translate(x, y); 
        
        for (int r = 0; r < rowCount; r++) {
            for (int i = 0; i < petalCount; i++) {
                float angle = i * deltaA; 
                float oscillation = sin(frameCount * 0.02 + i) * 5; 
                
                pushMatrix();
                rotate(angle + radians(oscillation)); 
                fill(petalColors[i]);
                ellipse(petalLen * 0.7, 0, petalLen, petalLen * wid);
                popMatrix();
            }
            petalLen *= 0.8;
        }
        popMatrix();
    }
    
    color adjustPetalColor(color baseCol, float rShift, float gShift, float bShift) {
        float r = constrain(red(baseCol) + rShift, 0, 255);
        float g = constrain(green(baseCol) + gShift, 0, 255);
        float b = constrain(blue(baseCol) + bShift, 0, 255);
        return color(r, g, b);
    }
}
