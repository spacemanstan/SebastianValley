class BGItem {
  PVector pos, startPos;
  PVector vel, tarVel;

  float easing = 0.05;
  int laps, tarLaps;

  float spriteSize;
  PImage sprite;
  
  boolean stop;

  BGItem(float px, float py, PImage spriteRef, float sSize) {
    this.pos = new PVector(px, py);
    this.startPos = this.pos.copy();

    this.vel = new PVector();
    this.tarVel = new PVector();

    this.sprite = spriteRef;
    this.spriteSize = sSize;

    this.laps = 0;
    this.tarLaps = 1;
    this.stop = false;
  }

  void update() {
    // stop
    if (this.stop) {
      if (PVector.dist(this.pos, this.startPos) < (this.spriteSize * 0.05)) {
        this.tarVel.set(0, 0);
        this.vel.set(0, 0);
        this.laps = 0;
        this.stop = false;
        return;
      }
    }

    // velocity code
    PVector dVel = PVector.sub(this.tarVel, this.vel);
    dVel.mult(this.easing);
    this.vel.add(dVel);
    
    if (this.laps == this.tarLaps) {
      this.tarVel.mult(0.05);
      this.stop = true;
    }

    // update pos
    this.pos.add(this.vel);
    wrapAround();
  }

  void render() {
    resetMatrix();
    translate(this.pos.x, this.pos.y);
    imageMode(CENTER);
    image(this.sprite, 0, 0, this.spriteSize, this.spriteSize);
    imageMode(CORNER);
    resetMatrix();
  }

  void wrapAround() {
    boolean newLap = false;

    if (pos.x > width + spriteSize * 1.5)
    {
      pos.x = -spriteSize * 1.5;
      newLap = true;
    }
    if (pos.x < -spriteSize * 1.5)
    {
      pos.x = width + spriteSize * 1.5;
      newLap = true;
    }
    if (pos.y > height + spriteSize * 1.5)
    {
      pos.y = -spriteSize * 1.5;
      newLap = true;
    }
    if (pos.y < -spriteSize * 1.5)
    {
      pos.y = height + spriteSize * 1.5;
      newLap = true;
    }

    if (newLap) laps += 1;

    //println("Laps: " + this.laps);
  }

  void triggerStart(int laps, float dirX, float dirY) {
    this.tarLaps = laps;
    this.tarVel.set(dirX, dirY);
    this.stop = false;
  }
}
