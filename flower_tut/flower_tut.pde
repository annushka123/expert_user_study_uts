void setup() {
    size(600, 600);
}

void draw() {
    background(240);
    
    int petalCount = 8;
    float angleStep = TWO_PI / petalCount;
    
    translate(width / 2, height / 2);
    
    for (int i = 0; i < petalCount; i++) {
        float oscillation = sin(frameCount * 0.02 + i) * 5; 
        
        pushMatrix();
        rotate(i * angleStep + radians(oscillation)); // Animate rotation
        fill(255, 150, 0);
        ellipse(50, 0, 100, 60);
        popMatrix();
    }
    
    // Draw center
    fill(255, 220, 50);
    ellipse(0, 0, 40, 40);
}
