final int FPS = 24;

PImage wallpaper_border, wallpaper_background;
PImage[] sprites;
BGItem[][] bgItemRows;

Sebastian handsome;

void setup() {
  size(432, 960);
  noSmooth();
  frameRate(FPS);

  wallpaper_background = loadImage("./background_96x82.png");
  wallpaper_border = loadImage("./wallpaper_border.png");

  handsome = new Sebastian(loadImage("./Sebastian_spritesheet.png"), 3.0);

  sprites = new PImage[5];
  sprites[0] = loadImage("./Purple_Mushroom.png");
  sprites[1] = loadImage("./Frozen_Tear.png");
  sprites[2] = loadImage("./frog.png");
  sprites[3] = loadImage("./FairyRose.png");
  sprites[4] = loadImage("./junimo_stub.png");

  setupBGItems();
}

void draw() {
  renderBG();
  renderBGPatternItems();
  handsome.update();
  handsome.render(width / 2, height / 2);
}

void setupBGItems() {
  int totalRows = 5;
  bgItemRows = new BGItem[totalRows][];

  float borderScale = 0.05;
  int borderHeight = int(height * borderScale);
  int availableHeight = height - 2 * borderHeight;

  int itemSize = 48;
  int itemSpacing = 64;

  for (int row = 0; row < totalRows; row++) {
    int itemsInRow = (row % 2 == 0) ? 3 : 2;
    bgItemRows[row] = new BGItem[itemsInRow];

    float rowTotalWidth = itemSize * itemsInRow + itemSpacing * (itemsInRow - 1);
    float startX = (width - rowTotalWidth) / 2;

    float y = borderHeight + (row + 1) * (availableHeight / (totalRows + 1));

    for (int i = 0; i < itemsInRow; i++) {
      float x = startX + i * (itemSize + itemSpacing);
      bgItemRows[row][i] = new BGItem(x, y, itemSize, sprites[(row + i) % sprites.length]);
    }
  }
}

void renderBG() {
  if (wallpaper_background == null) return;

  float tilesDown = 4.0;
  float scaleFactor = height / (tilesDown * wallpaper_background.height);

  int tileWidth = int(wallpaper_background.width * scaleFactor);
  int tileHeight = int(wallpaper_background.height * scaleFactor);

  for (int y = 0; y < height; y += tileHeight) {
    for (int x = 0; x < width; x += tileWidth) {
      image(wallpaper_background, x, y, tileWidth, tileHeight);
    }
  }

  int borderHeight = int(height * 0.05);
  int borderWidth = width;

  image(wallpaper_border, 0, 0, borderWidth, borderHeight);
  image(wallpaper_border, 0, height - borderHeight, borderWidth, borderHeight);
}

void renderBGPatternItems() {
  for (int r = 0; r < bgItemRows.length; r++) {
    for (int i = 0; i < bgItemRows[r].length; i++) {
      bgItemRows[r][i].render();
    }
  }
}
