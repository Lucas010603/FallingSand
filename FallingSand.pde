// ------------------------------
// ----------FalingSand--------------
// Made By: Lucas Hermus 
// ------------------------------

void setup(){
    fullScreen(1);
    // size(700, 500);
    init();
    background(0);
    frameRate(60);
    noCursor();
    println(ElementType.values());

}

void draw(){
    background(0);
    noStroke();
    for (int i = 0; i < gameSpeed; i++){
        grid.setpElements();
    }
    grid.drawElements();
    particleManager.draw();
    grid.mouseDown();
    drawPencilIndicator();
    drawInfoHud();
    updateMousePositions();
    // particleManager.add(mouseX,mouseY,color(255,0,0));
}

void drawInfoHud(){
    textSize(20);
    fill(200);
    text("Frame Rate: " + str(round(frameRate)), 10, 30);
    text("Element Selected: " + getTypeAsString(grid.drawSelection), 10, 55);
    text("Speed: " + gameSpeed + "x", 10, 80);
    if (grid.pause){ displayPause(); }
}

void displayPause(){
    fill(0);rect(width / 2 - 105, 65, 200, 50);fill(150);textSize(30);text("Paused", Math.round(width / 2 - 50), 100);
}

void updateMousePositions(){
    mouseXPrev = mouseX;
    mouseYPrev = mouseY;
}

void drawPencilIndicator(){
    stroke(255);
    strokeWeight(1);
    noFill();
    rectMode(CENTER);
    square(mouseX, mouseY, cursorSize * grid.cellSize + grid.cellSize);
    rectMode(CORNER);
}

void keyPressed(){
    grid.keyPressed();
}

void mouseWheel(MouseEvent event) {
  int delta = event.getCount();
  if (keyCode == 16){ delta *= 5;}
  cursorSize = constrain(cursorSize + delta, 0, 100);
}

void keyReleased() {
    keyCode = 0;
}