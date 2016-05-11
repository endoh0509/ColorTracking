import processing.video.*;

Capture video;
color targetColor;

void setup() {
  size(640, 480);
  frameRate(30);
  colorMode(RGB, 255, 255, 255, 100);
  video = new Capture(this, width, height);
  video.start();
  targetColor = color(255, 0, 0);
}

void draw() { 
  if (video.available()) {
    image(video, 0, 0);
    video.read();
    video.loadPixels();
    int closestX = 0;
    int closestY = 0;
    float closestDist = dist(0, 0, 0, 255, 255, 255);
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        float r = red(video.pixels[y * width + x]);
        float g = green(video.pixels[y * width + x]);
        float b = blue(video.pixels[y * width + x]);
        float tr = red(targetColor);
        float tg = green(targetColor);
        float tb = blue(targetColor);
        float d = dist(r, g, b, tr, tg, tb);
        if(closestDist > d){
          closestDist = d;
          closestX = x;
          closestY = y;
        }
      }
    }
    fill(targetColor, 80);
    ellipse(closestX, closestY, closestDist, closestDist);
  }
}