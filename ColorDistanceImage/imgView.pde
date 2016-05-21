void imgViewDraw(){
  imgView.beginDraw();
  imgView.background(100);
  imgView.image(img, 0, 0);
  imgView.rectMode(CENTER);
  imgView.strokeWeight(3);
  imgView.fill(img.pixels[currentPix]);
  imgView.rect(currentPix%imgView.width, currentPix/imgView.width, 10, 10);
  imgView.endDraw();
  
  currentPix+=10;
  if(currentPix > img.pixels.length){
    currentPix = 0;
  }
}