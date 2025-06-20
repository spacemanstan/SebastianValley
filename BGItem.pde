class BGItem {
  PVector pos, tarPos, startPos;
  PVector vel, tarVel;

  float easing = 0.05;
  int laps;

  float spriteSize;
  PImage sprite;

  BGItem(float px, float py, PImage spriteRef, float sSize) {
    this.pos = new PVector(px, py);
    this.tarPos = this.pos.copy();
    this.startPos = this.pos.copy();

    this.vel = new PVector();
    this.tarVel = new PVector();

    this.sprite = spriteRef;
    this.spriteSize = sSize;
  }

  void update() {
    PVector dVel = PVector.sub(this.tarVel, this.vel);
    dVel.mult(this.easing);
    this.vel.add(dVel);
    this.pos.add(this.vel);
    wrapAround();
  }

  void render() {
    resetMatrix();
    translate(this.pos.x, this.pos.y);
    imageMode(CENTER);
    image(this.sprite, 0, 0, this.spriteSize, this.spriteSize);  // Stretch vertically using sine wave
    imageMode(CORNER);
    resetMatrix();
  }

  void wrapAround() {
    if (pos.x > width + spriteSize * 1.5) pos.x = -spriteSize * 1.5;
    if (pos.x < -spriteSize * 1.5) pos.x = width + spriteSize * 1.5;
    if (pos.y > height + spriteSize * 1.5) pos.y = -spriteSize * 1.5;
    if (pos.y < -spriteSize * 1.5) pos.y = height + spriteSize * 1.5;
  }
}
