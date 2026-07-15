GameManager gameManager;

void setup() {
  size(1000, 700);

  gameManager = new GameManager();
}

void draw() {
  background(0);

  gameManager.update();
}
