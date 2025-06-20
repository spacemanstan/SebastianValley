final int FPS = 24;

PImage wallpaper_border, wallpaper_background;
PImage[] sprites;

//BGItem[5][] BGItems;

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
}

void draw() {
  resetMatrix();

  renderBG();

  //testBGItem.update();
  //testBGItem.render();

  handsome.update();
  handsome.render(width / 2, height / 2);

  renderBorder();
}
