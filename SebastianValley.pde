final int FPS = 24;

PImage wallpaper_border, wallpaper_background;
PImage[] sprites;

Sebastian handsome;

int cols = 5;
int rows = 9;
ArrayList<ArrayList<BGItem>> BGItems = new ArrayList<>();

int timer = 0;

float maxSpriteSize;

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

  maxSpriteSize = width * 0.15;
  float margin = maxSpriteSize / 2.0;

  // Maximum columns in any row (even rows have full cols)
  int maxCols = cols;

  float usableWidth = width - margin * 2;
  float usableHeight = height - margin * 2;

  // Calculate xSpacing based on maxCols - 1 gaps
  float xSpacing = (maxCols > 1) ? usableWidth / (maxCols - 1) : usableWidth;
  float ySpacing = (rows > 1) ? usableHeight / (rows - 1) : usableHeight;

  for (int r = 0; r < rows; r++) {
    if (r == 0 || r == rows - 1) {
      // Skip first and last row: add empty placeholder (or skip adding anything)
      BGItems.add(new ArrayList<BGItem>());
      continue;
    }

    int colsThisRow = (r % 2 == 0) ? cols : max(1, cols - 1);
    ArrayList<BGItem> row = new ArrayList<>();

    for (int c = 0; c < colsThisRow; c++) {
      float x = margin + c * xSpacing;
      float y = margin + r * ySpacing;

      if (r % 2 == 1) {
        x += xSpacing / 2.0;
      }

      BGItem item = new BGItem(x, y, sprites[int(random(sprites.length))], maxSpriteSize);
      row.add(item);
    }

    BGItems.add(row);
  }
}

void draw() {
  resetMatrix();

  renderBG();

  for (int r = 0; r < BGItems.size(); r++) {
    // Skip first and last row (empty)
    if (r == 0 || r == BGItems.size() - 1) continue;

    for (BGItem item : BGItems.get(r)) {
      item.update();
      item.render();
    }
  }

  handsome.update();
  handsome.render(width / 2, height / 2);

  renderBorder();

  handleLogic();
}

void handleLogic() {
}

void mouseClicked() {
  for (int r = 0; r < BGItems.size(); r++) {
    if (r == 0 || r == BGItems.size() - 1) continue;
    for (BGItem item : BGItems.get(r)) {
      int randomLapCount = (int)random(3, 8);
      float speed = maxSpriteSize * 0.65;
      int randomDirection = (int)random(1, 5);
      if (randomDirection == 1) item.triggerStart(randomLapCount, maxSpriteSize, 0);
      if (randomDirection == 2) item.triggerStart(randomLapCount, -maxSpriteSize, 0);
      if (randomDirection == 3) item.triggerStart(randomLapCount, 0, maxSpriteSize);
      if (randomDirection == 4) item.triggerStart(randomLapCount, 0, -maxSpriteSize);
    }
  }
}
