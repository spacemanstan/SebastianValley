final int FPS = 24;

PImage wallpaper_border, wallpaper_background;
PImage[] sprites;

Sebastian handsome;

int cols = 3;
int rows = 9;
ArrayList<ArrayList<BGItem>> BGItems = new ArrayList<>();


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

  float maxCols = 7;
  float maxSpriteSize = width * 0.15;
  float margin = maxSpriteSize / 2.0;

  // Calculate spacing so sprites don’t go off the edge
  float usableWidth = width - margin * 2;
  float usableHeight = height - margin * 2;

  float xSpacing = usableWidth / (maxCols - 1);
  float ySpacing = usableHeight / (rows - 1);

  for (int r = 0; r < rows; r++) {
    int colsThisRow = (r % 2 == 0) ? 7 : 6;
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

  renderBorder();


  for (ArrayList<BGItem> row : BGItems) {
    for (BGItem item : row) {
      item.update();
      item.render();
    }
  }


  handsome.update();
  handsome.render(width / 2, height / 2);
}
