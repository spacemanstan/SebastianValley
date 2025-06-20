final int FPS = 24;

PImage wallpaper_border, wallpaper_background;
PImage[] sprites;

BGItem testBGItem;

Sebastian handsome;

boolean test = true;

int fuck = 3;

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

  testBGItem = new BGItem(width/2, height/4, sprites[2], width/6);
}

void draw() {
  resetMatrix();

  renderBG();

  testBGItem.update();
  testBGItem.render();

  handsome.update();
  handsome.render(width / 2, height / 2);

  renderBorder();
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    // left mouse
    if(fuck == 1) testBGItem.triggerStart(3,width/12,0);
    if(fuck == 2) testBGItem.triggerStart(3,-width/12,0);
    if(fuck == 3) testBGItem.triggerStart(3,0,width/12);
    if(fuck == 4) testBGItem.triggerStart(3,0,-width/12);
    
    fuck = fuck > 4 ? 3 : fuck + 1;
    
  } else if (mouseButton == RIGHT) {
    // right mouse
  } else {
    // middle mouse
  }
}
