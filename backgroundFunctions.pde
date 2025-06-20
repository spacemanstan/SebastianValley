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
}

void renderBorder() {
  int borderHeight = int(height * 0.05);
  int borderWidth = width;

  image(wallpaper_border, 0, 0, borderWidth, borderHeight);
  image(wallpaper_border, 0, height - borderHeight, borderWidth, borderHeight);
}
