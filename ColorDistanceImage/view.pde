void drawView() {
  view.beginDraw();
  view.background(50);

  view.pushMatrix();
  view.translate(view.width/2, view.height/2, -100);
  if (isMove) {
    view.rotateX(map(map(mouseY, 0, width, 0, view.width), 0, view.height, 0, PI * 2));
    view.rotateY(map(map(mouseX, 0, height, 0, view.height), 0, view.height, 0, PI * 2));
  } else {
    view.rotateX(PI/2);
  }
  view.translate(-WORLD_SIZE/2, -WORLD_SIZE/2, -WORLD_SIZE/2);
  view.noStroke();
  view.pushStyle();
  view.pushMatrix();
  view.translate(pos.x, pos.y, pos.z);
  view.fill(pos.x, pos.y, pos.z);
  view.sphere(10);
  view.popMatrix();
  view.popStyle();

  view.noStroke();
  view.pushStyle();
  view.pushMatrix();
  float d = PVector.dist(pos, targetPos);
  float maxDist = PVector.dist(new PVector(0, 0, 0), new PVector(WORLD_SIZE, WORLD_SIZE, WORLD_SIZE));
  //colorMode(HSB, 360, 255, 255);
  view.stroke(map(d, 0, maxDist, 255, 0));
  view.beginShape(LINES);
  view.vertex(pos.x, pos.y, pos.z);
  view.vertex(targetPos.x, targetPos.y, targetPos.z);
  view.endShape();
  view.popMatrix();
  view.popStyle();

  view.pushStyle();
  view.pushMatrix();
  view.translate(targetPos.x, targetPos.y, targetPos.z);
  view.fill(targetPos.x, targetPos.y, targetPos.z);
  view.sphere(10);
  view.popMatrix();
  view.popStyle();

  drawAxis(view);
  view.popMatrix();
  view.endDraw();
  
  float x = map(noise(offset.x), 0, 1, 0, WORLD_SIZE);
  float y = map(noise(offset.y), 0, 1, 0, WORLD_SIZE);
  float z = map(noise(offset.z), 0, 1, 0, WORLD_SIZE);
  //TODO
  //pos.set(x, y, z);
}

void updateView(){
  offset.add(offsetSpeed);
}

void drawAxis(PGraphics _pg) {

  _pg.pushStyle();

  _pg.pushMatrix();
  
  _pg.stroke(255, 5);
  //_pg.fill(255, 10);
  _pg.noFill();
  _pg.translate(WORLD_SIZE/2, WORLD_SIZE/2, WORLD_SIZE/2);
  _pg.box(WORLD_SIZE);
  _pg.popMatrix();

  _pg.stroke(255, 0, 0);
  _pg.beginShape(LINES);
  _pg.vertex(0, 0, 0);
  _pg.vertex(WORLD_SIZE, 0, 0);
  _pg.endShape();

  _pg.stroke(0, 255, 0);
  _pg.beginShape(LINES);
  _pg.vertex(0, 0, 0);
  _pg.vertex(0, WORLD_SIZE, 0);
  _pg.endShape();

  _pg.stroke(0, 0, 255);
  _pg.beginShape(LINES);
  _pg.vertex(0, 0, 0);
  _pg.vertex(0, 0, WORLD_SIZE);
  _pg.endShape();
  _pg.popStyle();
}