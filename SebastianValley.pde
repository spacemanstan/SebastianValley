PImage wallpaper_border, wallpaper_background;
PImage[] bgPatternItems;

void setup() {
  size(432, 960);
  noSmooth(); // important for pixel art

  wallpaper_background = loadImage("./background_96x82.png");
  wallpaper_border = loadImage("./wallpaper_border.png");

  bgPatternItems = new PImage[5];

  bgPatternItems[0] = loadImage("./Sebastian.png");
  bgPatternItems[1] = loadImage("./Purple_Mushroom.png");
  bgPatternItems[2] = loadImage("./Frozen_Tear.png");
  bgPatternItems[3] = loadImage("./frog.png");
  bgPatternItems[4] = loadImage("./FairyRose.png");
}

void draw() {
  renderBG();
}

void renderBG() {
  if (wallpaper_background == null) return;

  // height based
  float tilesDown = 4.0;
  float scaleFactor = height / (tilesDown * wallpaper_background.height);

  int tileWidth = int(wallpaper_background.width * scaleFactor);
  int tileHeight = int(wallpaper_background.height * scaleFactor);

  for (int y = 0; y < height; y += tileHeight) {
    for (int x = 0; x < width; x += tileWidth) {
      image(wallpaper_background, x, y, tileWidth, tileHeight);
    }
  }
  
  // Top and Bottom Border
  float borderScale = 0.05; // 5% of screen height
  int borderHeight = int(height * borderScale);
  int borderWidth = width; // Stretch to full screen width

  image(wallpaper_border, 0, 0, borderWidth, borderHeight); // top
  image(wallpaper_border, 0, height - borderHeight, borderWidth, borderHeight); // bottom
}
