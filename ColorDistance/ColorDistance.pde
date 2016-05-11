import controlP5.*;

float WORLD_SIZE = 200;

PVector pos;
PVector targetPos;

PVector offset, offsetSpeed;

ControlP5 cp5;
boolean isRotate;
void setup() {
  size(600, 600, P3D);

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
  cp5.addSlider("sliderR", 0, 255, 100, 0, 0, 100, 14).setGroup(colorPannel);
  cp5.addSlider("sliderG", 0, 255, 100, 0, 15, 100, 14).setGroup(colorPannel);
  cp5.addSlider("sliderB", 0, 255, 100, 0, 30, 100, 14).setGroup(colorPannel);
  cp5.addToggle("rotateSwitch")
    .setGroup(colorPannel)
    .setPosition(0, 45)
    .setSize(50, 14)
    ;
  isRotate = false;
}

void draw() {
  background(50);

  pushMatrix();
  translate(width/2, height/2, -100);
  if (isRotate) {
    rotateX(map(mouseY, 0, height, 0, PI * 2));
    rotateY(map(mouseX, 0, width, 0, PI * 2));
  }else{
    rotateX(PI/2);
  }
  translate(-WORLD_SIZE/2, -WORLD_SIZE/2, -WORLD_SIZE/2);
  noStroke();
  pushStyle();
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  fill(pos.x, pos.y, pos.z);
  sphere(10);
  popMatrix();
  popStyle();

  noStroke();
  pushStyle();
  pushMatrix();
  float d = PVector.dist(pos, targetPos);
  float maxDist = PVector.dist(new PVector(0, 0, 0), new PVector(WORLD_SIZE, WORLD_SIZE, WORLD_SIZE));
  //colorMode(HSB, 360, 255, 255);
  stroke(map(d, 0, maxDist, 255, 0));
  beginShape(LINES);
  vertex(pos.x, pos.y, pos.z);
  vertex(targetPos.x, targetPos.y, targetPos.z);
  endShape();
  popMatrix();
  popStyle();

  pushStyle();
  pushMatrix();
  translate(targetPos.x, targetPos.y, targetPos.z);
  fill(targetPos.x, targetPos.y, targetPos.z);
  sphere(10);
  popMatrix();
  popStyle();

  drawAxis();

  offset.add(offsetSpeed);
  float x = map(noise(offset.x), 0, 1, 0, WORLD_SIZE);
  float y = map(noise(offset.y), 0, 1, 0, WORLD_SIZE);
  float z = map(noise(offset.z), 0, 1, 0, WORLD_SIZE);
  pos.set(x, y, z);

  popMatrix();
}

void drawAxis() {

  pushStyle();

  pushMatrix();
  stroke(255);
  noFill();
  translate(WORLD_SIZE/2, WORLD_SIZE/2, WORLD_SIZE/2);
  box(WORLD_SIZE);
  popMatrix();

  stroke(255, 0, 0);
  beginShape(LINES);
  vertex(0, 0, 0);
  vertex(WORLD_SIZE, 0, 0);
  endShape();

  stroke(0, 255, 0);
  beginShape(LINES);
  vertex(0, 0, 0);
  vertex(0, WORLD_SIZE, 0);
  endShape();

  stroke(0, 0, 255);
  beginShape(LINES);
  vertex(0, 0, 0);
  vertex(0, 0, WORLD_SIZE);
  endShape();
  popStyle();
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

void rotateSwitch(boolean theFlag) {
  isRotate = theFlag;
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
