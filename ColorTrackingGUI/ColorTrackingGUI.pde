import controlP5.*;
import processing.video.*;

Capture video;
color targetColor;
PImage img;
ControlP5 cp5;

void setup() {
  size(640, 480);
  frameRate(30);
  colorMode(RGB, 255, 255, 255, 100);
  video = new Capture(this, width, height);
  video.start();
  targetColor = color(0, 0, 255);

  cp5 = new ControlP5(this);
  Group colorPannel = cp5.addGroup("colorPannel")
    .setPosition(10, 20)
    .setSize(150, 50)
    .setBackgroundColor(color(0,0,0));//color(255, 255, 255, 50))
    ;
  cp5.addSlider("sliderR", 0, 255, 100, 0, 0, 100, 14).setGroup(colorPannel);
  cp5.addSlider("sliderG", 0, 255, 100, 0, 15, 100, 14).setGroup(colorPannel);
  cp5.addSlider("sliderB", 0, 255, 100, 0, 30, 100, 14).setGroup(colorPannel);
  
  img = video;
}


void draw() {
  image(img, 0, 0);
  if (video.available()) {
    img = video;
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
        if (closestDist > d) {
          closestDist = d;
          closestX = x;
          closestY = y;
        }
      }
    }
    pushStyle();
    noStroke();
    fill(targetColor, 80);
    ellipse(closestX, closestY, closestDist, closestDist);
    popStyle();
  }
  
  fill(targetColor);
  rect(160, 20, 50, 50);
}
public void sliderR(int theValue) {
  //Textfield txt = ((Textfield)cp5.getController("sliderR"));
  //txt.setValue(""+theValue);
  targetColor = color(theValue, green(targetColor), blue(targetColor));
  //println(theValue);
}

public void sliderG(int theValue) {
  //Textfield txt = ((Textfield)cp5.getController("sliderR"));
  //txt.setValue(""+theValue);
  targetColor = color(red(targetColor), theValue, blue(targetColor));
  //println(theValue);
}

public void sliderB(int theValue) {
  //Textfield txt = ((Textfield)cp5.getController("sliderR"));
  //txt.setValue(""+theValue);
  targetColor = color(red(targetColor), green(targetColor), theValue);
  //println(theValue);
}

public void controlEvent(ControlEvent theEvent) {
  println("got a control event from controller with id "+theEvent.getId());
  switch(theEvent.getId()) {
    case(1): // numberboxA is registered with id 1
    //myColorRect = (int)(theEvent.getController().getValue());
    break;
    case(2):  // numberboxB is registered with id 2
    //myColorBackground = (int)(theEvent.getController().getValue());
    break;
  }
}