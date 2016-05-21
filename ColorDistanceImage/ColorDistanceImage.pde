import controlP5.*;

//view
PGraphics view;
float WORLD_SIZE = 200;
PVector pos;
PVector targetPos;
PVector offset, offsetSpeed;
ControlP5 cp5;
boolean isMove;

//imgView
PGraphics imgView;
PImage img;
int currentPix;
float imgScaleW, imgScaleH;

void setup() {
  size(1200, 600, P3D);
  
  //view
  view = createGraphics(600, 600, P3D);
  targetPos = new PVector(WORLD_SIZE, WORLD_SIZE, WORLD_SIZE);
  offset = new PVector(0, 10, 100);
  offsetSpeed = new PVector(0.01, 0.01, 0.01);
  float x = map(noise(offset.x), 0, 1, 0, WORLD_SIZE);
  float y = map(noise(offset.y), 0, 1, 0, WORLD_SIZE);
  float z = map(noise(offset.z), 0, 1, 0, WORLD_SIZE);
  pos = new PVector(x, y, z);
  
  cp5 = new ControlP5(this);
  Group colorPannel = cp5.addGroup("colorPannel")
    .setPosition(10, 20)
    .setSize(150, 70)
    .setBackgroundColor(color(255, 255, 255, 50))
    ;
  cp5.addSlider("sliderR", 0, 255, map(targetPos.x, 0, WORLD_SIZE, 0, 255), 0, 0, 100, 14).setGroup(colorPannel);
  cp5.addSlider("sliderG", 0, 255, map(targetPos.y, 0, WORLD_SIZE, 0, 255), 0, 15, 100, 14).setGroup(colorPannel);
  cp5.addSlider("sliderB", 0, 255, map(targetPos.z, 0, WORLD_SIZE, 0, 255), 0, 30, 100, 14).setGroup(colorPannel);
  cp5.addToggle("moveSwitch")
    .setGroup(colorPannel)
    .setPosition(0, 45)
    .setSize(50, 14)
    ;
  isMove = false;
  
  //imageView
  imgView = createGraphics(600, 600, P2D);
  img = loadImage("180px-Processing_Logo_Clipped.svg.png");
  currentPix = 0;
  //TODO
  //imgScaleW = imgView.width/img.width;
  //imgScaleH = imgView.height/img.height;
  //img.resize(int(imgScaleW * img.width), int(imgScaleH * img.height));
  img.resize(600, 600);
}

void draw() {
  
  drawView();
  float x = map(red(img.pixels[currentPix]), 0, 255, 0, WORLD_SIZE);
  float y = map(green(img.pixels[currentPix]), 0, 255, 0, WORLD_SIZE);
  float z = map(blue(img.pixels[currentPix]), 0, 255, 0, WORLD_SIZE);
  //TODO
  pos.set(x, y, z);
  println(pos);
  updateView();
  
  imgViewDraw();
  image(view, 0, 0);
  image(imgView, view.width, 0);
}

public void sliderR(int theValue) {
  //Textfield txt = ((Textfield)cp5.getController("sliderR"));
  //txt.setValue(""+theValue);
  targetPos.x = map(theValue, 0, 255, 0, WORLD_SIZE);
  //println(theValue);
}

public void sliderG(int theValue) {
  //Textfield txt = ((Textfield)cp5.getController("sliderR"));
  //txt.setValue(""+theValue);
  targetPos.y = map(theValue, 0, 255, 0, WORLD_SIZE);
  //println(theValue);
}

public void sliderB(int theValue) {
  //Textfield txt = ((Textfield)cp5.getController("sliderR"));
  //txt.setValue(""+theValue);
  targetPos.z = map(theValue, 0, 255, 0, WORLD_SIZE);
  //println(theValue);
}

void moveSwitch(boolean theFlag) {
  isMove = theFlag;
  println("a toggle event.");
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