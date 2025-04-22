class Flowers {
  ArrayList<Flowers> flowerList = new ArrayList<Flowers>();
  
  float x, y;
  float size;
  color c;
  float alpha;
  boolean fadingIn;

  Flowers() {
    // Random position (tweak to fit your canvas)
    x = random(width);
    y = random(height);
    
    // Random size
    size = random(20, 50);
    
    // Random color
    c = color(random(100, 255), random(100, 255), random(100, 255));
    
    // Transparency settings
    alpha = 0;
    fadingIn = true;
  }

  void update() {
    if (fadingIn && alpha < 255) {
      alpha += 5;
    }
  }

  void display() {
    noStroke();
    fill(c, alpha);
    ellipse(x, y, size, size); // simple flower shape for now
  }

  void fadeIn() {
    fadingIn = true;
  }

  boolean isFullyVisible() {
    return alpha >= 255;
  }
}
