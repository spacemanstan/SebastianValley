class BGItem {
  float x, y, size;
  PImage sprite;

  BGItem(float x, float y, float size, PImage sprite) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.sprite = sprite;
  }

  void render() {
    if (sprite != null) {
      image(sprite, x, y, size, size);
    }
  }
}
