class AnimatedBGItem extends BGItem {
  int frameW, frameH;
  int cols, rows;
  int currentFrame = 0;
  int frameDelay = 8;
  int lastFrameUpdate = 0;
  PImage sheet;

  AnimatedBGItem(float x, float y, PImage spriteSheet, int cols, int rows, float size) {
    super(x, y, null, size); // Passing `null` because we won't use `sprite`
    this.sheet = spriteSheet;
    this.cols = cols;
    this.rows = rows;
    this.frameW = sheet.width / cols;
    this.frameH = sheet.height / rows;
  }

  @Override
    void update() {
    super.update();

    if (frameCount - lastFrameUpdate >= frameDelay) {
      currentFrame = (currentFrame + 1) % (cols * rows);
      lastFrameUpdate = frameCount;
    }
  }

  @Override
    void render() {
    resetMatrix();
    translate(pos.x, pos.y);
    imageMode(CENTER);
    int col = currentFrame % cols;
    int row = currentFrame / cols;
    PImage frame = sheet.get(col * frameW, row * frameH, frameW, frameH);
    image(frame, 0, 0, spriteSize, spriteSize);
    imageMode(CORNER);
    resetMatrix();
  }
}
