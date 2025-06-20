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
  fullScreen();
  orientation(PORTRAIT);
  noSmooth();
  frameRate(FPS);

  wallpaper_background = loadImage("background96x82.png");
  wallpaper_border = loadImage("wallpaperborder.png");

  handsome = new Sebastian(loadImage("Sebastianspritesheet.png"), 15.0);

  sprites = new PImage[5];
  sprites[0] = loadImage("PurpleMushroom.png");
  sprites[1] = loadImage("FrozenTear.png");
  sprites[2] = loadImage("frog.png");
  sprites[3] = loadImage("FairyRose.png");
  sprites[4] = loadImage("junimospritesheet.png");

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

      BGItem item;
      int randomSpriteIndex = int(random(sprites.length));

      if (randomSpriteIndex == 4) {
        item = new AnimatedBGItem(x, y, sprites[randomSpriteIndex], 1, 4, maxSpriteSize);
      } else {
        item = new BGItem(x, y, sprites[randomSpriteIndex], maxSpriteSize);
      }

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

  if (touches.length > 0) bigFuckOffNastyFunction();
}

boolean thisReturnsFalseIfNoBGItemsAreMovingAndCanMoveAgain() {
  for (int r = 0; r < BGItems.size(); r++) {
    // Skip first and last row (empty)
    if (r == 0 || r == BGItems.size() - 1) continue;

    for (BGItem item : BGItems.get(r)) {
      if (item.stop == true) {
        return true;
      }
    }
  }

  return false;
}

void bigFuckOffNastyFunction() {
  if (thisReturnsFalseIfNoBGItemsAreMovingAndCanMoveAgain()) {
    return;
  }

  int chaosMode = (int)random(0, 3);      // 0, 1, or 2
  int chaosVertOrHorz = (int)random(0, 2); // 0 = vertical split, 1 = horizontal split
  float speed = maxSpriteSize * 0.65;

  // For chaosMode 2, pick one random direction for all items
  int groupDirection = (chaosMode == 2) ? (int)random(1, 5) : -1;

  for (int r = 0; r < BGItems.size(); r++) {
    if (r == 0 || r == BGItems.size() - 1) continue; // skip first and last rows

    ArrayList<BGItem> row = BGItems.get(r);

    for (int c = 0; c < row.size(); c++) {
      BGItem item = row.get(c);
      int randomLapCount = (int)random(3, 8);
      int randomDirection;

      if (chaosMode == 0) {
        // Fully random directions per item
        randomDirection = (int)random(1, 5);
      } else if (chaosMode == 1) {
        // Split directions based on row or column parity
        if (chaosVertOrHorz == 0) {
          // vertical split: even rows up, odd rows down
          randomDirection = (r % 2 == 0) ? 4 : 3; // 4=up, 3=down
        } else {
          // horizontal split: even cols right, odd cols left
          randomDirection = (c % 2 == 0) ? 1 : 2; // 1=right, 2=left
        }
      } else if (chaosMode == 2) {
        // All move same direction
        randomDirection = groupDirection;
      } else {
        // Fallback to random if more modes are added later
        randomDirection = (int)random(1, 5);
      }

      // Trigger movement based on chosen direction
      if (randomDirection == 1) item.triggerStart(randomLapCount, speed, 0);
      else if (randomDirection == 2) item.triggerStart(randomLapCount, -speed, 0);
      else if (randomDirection == 3) item.triggerStart(randomLapCount, 0, speed);
      else if (randomDirection == 4) item.triggerStart(randomLapCount, 0, -speed);
    }
  }
}
