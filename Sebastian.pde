class Sebastian {
  PImage sheet;  // The sprite sheet for Sebastian
  int cols = 2, rows = 2;  // The sprite sheet is 2x2
  int frameW, frameH;  // Width and height of each frame
  int currentFrame = 0;
  int nextFrame = 0;
  int frameDelay = 2 * FPS;  // Delay between frame changes (for non-blink poses)
  int bounceTimer = 0;
  float bounceAmount = 10;  // How much Sebastian moves up and down
  float stretchAmount = 0.2;  // Amount to stretch when switching sprites
  
  Sebastian(PImage spriteSheet) {
    this.sheet = spriteSheet;
    this.frameW = spriteSheet.width / cols;
    this.frameH = spriteSheet.height / rows;
  }

  // Switch between frames based on frameCount
  void update() {
    // Based on frameCount, we change the frame after a certain number of frames
    int frameProgress = frameCount % frameDelay;

    // If it's time to switch frames
    if (frameProgress == 0) {
      if (currentFrame == 0) {
        nextFrame = int(random(1, 4));  // Randomly switch between Smile, Blush, or Side-eye
        currentFrame = nextFrame;
        if (nextFrame == 3) frameDelay = 2 * FPS;  // Side-eye is quick, 2 seconds
        else frameDelay = int(random(3, 7)) * FPS;  // Other frames stay for 3 to 7 seconds
      } else if (currentFrame == 3) {
        currentFrame = 2;  // After Side-eye, go to Blush
        frameDelay = int(random(3, 7)) * FPS;
      } else {
        currentFrame = 0;  // After Blush, go to Blink
        frameDelay = 2 * FPS;  // Blink stays for 2 seconds
      }
    }
  }

  // Get the current frame from the sprite sheet
  PImage getFrame() {
    int col = currentFrame % cols;
    int row = currentFrame / cols;
    return sheet.get(col * frameW, row * frameH, frameW, frameH);
  }

  // Draw Sebastian with bounce and stretch effect
  void render(float cx, float cy) {
    float time = frameCount / float(FPS);  // Time based on frame count
    float bounceOffset = sin(time * 2) * bounceAmount;  // Sine wave for smooth bounce
    float size = 100 + (sin(time * 2) * stretchAmount);  // Stretching effect

    pushMatrix();
    translate(cx, cy + bounceOffset);
    imageMode(CENTER);
    image(getFrame(), 0, 0, size, size * 1.125);  // Stretch vertically a bit
    imageMode(CORNER);
    popMatrix();
  }
}
