GameManager gameManager;

void setup() {
  size(1000, 700);
  frameRate(60);
  textFont(createFont("SansSerif", 18));

  gameManager = new GameManager();
}

void draw() {
  background(0);

  gameManager.update();
}

void keyPressed() {
  gameManager.handleKeyPressed(key, keyCode);
}

void keyReleased() {
  gameManager.handleKeyReleased(key, keyCode);
}

void mousePressed() {
  gameManager.handleMousePressed(mouseX, mouseY);
}
