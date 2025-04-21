class Sebastian {
  PImage sheet;           // Sprite sheet containing 4 poses (2x2 grid)
  int cols = 2, rows = 2; // Layout of the sprite sheet
  int frameW, frameH;     // Dimensions of each frame
  int currentFrame = 0;
  int nextFrame = 0;
  int frameDelay = 2 * FPS; // Duration (in frames) before switching pose
  float scaleMultiplier = 1.0; // Controls Sebastian’s rendered size
  float bounceAmount = 5;     // Bounce height in pixels
  float stretchAmount = 0.2;   // Amount of vertical squash/stretch

  // Constructor with default scale (1.0)
  Sebastian(PImage spriteSheet) {
    this(spriteSheet, 1.0);
  }

  // Constructor with optional scale multiplier
  // Allows customizing the size Sebastian is drawn on screen
  Sebastian(PImage spriteSheet, float scaleMultiplier) {
    this.sheet = spriteSheet;
    this.scaleMultiplier = scaleMultiplier;
    this.frameW = sheet.width / cols;
    this.frameH = sheet.height / rows;
  }

  // Handles pose switching logic
  // Uses frameCount to time transitions between poses
  void update() {
    int frameProgress = frameCount % frameDelay;

    // When it's time to switch pose, rotate through animations
    if (frameProgress == 0) {
      if (currentFrame == 0) {
        // From Blink, pick a new random expression
        nextFrame = int(random(1, 4));
        currentFrame = nextFrame;
        frameDelay = (nextFrame == 3) ? 2 * FPS : int(random(3, 7)) * FPS;
      } else if (currentFrame == 3) {
        // From Side-eye, go to Blush (short transition)
        currentFrame = 2;
        frameDelay = int(random(3, 7)) * FPS;
      } else {
        // Any other pose returns to Blink
        currentFrame = 0;
        frameDelay = 2 * FPS;
      }
    }
  }

  // Returns the current pose frame from the sprite sheet
  PImage getFrame() {
    int col = currentFrame % cols;
    int row = currentFrame / cols;
    return sheet.get(col * frameW, row * frameH, frameW, frameH);
  }

  // Draws Sebastian in the center of the screen with a bounce and stretch
  // Scale multiplier affects both size and bounce dynamics
  void render(float cx, float cy) {
    float time = frameCount / float(FPS);
    float bounceOffset = sin(time * 2) * bounceAmount * scaleMultiplier;
    float calcShit = (sin(time * 2) * stretchAmount * frameH);
    float w = frameW * scaleMultiplier - calcShit * 0.5;
    float h = frameH * scaleMultiplier + calcShit;

    pushMatrix();
    translate(cx, cy + bounceOffset);
    imageMode(CENTER);
    image(getFrame(), 0, 0, w, h);  // Stretch vertically using sine wave
    imageMode(CORNER);
    popMatrix();
  }
}
