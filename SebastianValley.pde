final int FPS = 24;

PImage wallpaper_border, wallpaper_background;
PImage[] bgPatternItems;

Sebastian handsome;

void setup() {
  size(432, 960);  // Set the window size (for testing purposes)
  noSmooth(); // Important for pixel art, prevents interpolation (blurring)
  frameRate(FPS);

  // Assets to build tiled and bordered background
  wallpaper_background = loadImage("./background_96x82.png"); // Base wallpaper texture
  wallpaper_border = loadImage("./wallpaper_border.png"); // Border texture

  // Wallpaper focal point (centered image)
  handsome = new Sebastian(loadImage("./Sebastian_spritesheet.png")); 

  // Items to pattern around the focal point
  bgPatternItems = new PImage[4];
  bgPatternItems[0] = loadImage("./Purple_Mushroom.png"); // Item 1 to pattern
  bgPatternItems[1] = loadImage("./Frozen_Tear.png"); // Item 2 to pattern
  bgPatternItems[2] = loadImage("./frog.png"); // Item 3 to pattern
  bgPatternItems[3] = loadImage("./FairyRose.png"); // Item 4 to pattern
}

void draw() {
  renderBG(); // Draw the background with border and tiling
  renderBGPatternItems(); // (Placeholder) Draw pattern items around the focal point
  handsome.update();
  handsome.render(width / 2, height / 2);  // Render Sebastian in the center
}

void renderBG() {
  if (wallpaper_background == null) return; // Prevents errors if the background isn't loaded

  // Height-based tiling
  float tilesDown = 4.0; // How many times to repeat the pattern vertically
  float scaleFactor = height / (tilesDown * wallpaper_background.height); // Scale factor to fit vertically

  int tileWidth = int(wallpaper_background.width * scaleFactor); // Scaled tile width
  int tileHeight = int(wallpaper_background.height * scaleFactor); // Scaled tile height

  // Tile the base wallpaper texture across the entire screen
  for (int y = 0; y < height; y += tileHeight) {
    for (int x = 0; x < width; x += tileWidth) {
      image(wallpaper_background, x, y, tileWidth, tileHeight); // Draw each tile
    }
  }
  
  // Top and Bottom Border
  float borderScale = 0.05; // 5% of screen height for the border
  int borderHeight = int(height * borderScale); // Calculate border height based on screen height
  int borderWidth = width; // Stretch border across the full screen width

  // Draw the top and bottom borders
  image(wallpaper_border, 0, 0, borderWidth, borderHeight); // Draw the top border
  image(wallpaper_border, 0, height - borderHeight, borderWidth, borderHeight); // Draw the bottom border
}

void renderBGPatternItems() {
  // Placeholder function for rendering pattern items like Sebastian or mushrooms
  // This function will loop through the pattern items and display them around the screen
}
