class Enemy {

  PImage img;
  float x, y;
  float dx, dy;
  int w, h;
  int hp;

  Enemy(String filename, float x, float y) {
    img = loadImage(filename);

    this.x = x;
    this.y = y;

    w = 60;
    h = 60;

    dx = 0;
    dy = 3;

    hp = 30;
  }

  void move() {
    x += dx;
    y += dy;
  }

  void display() {
    image(img, x, y, w, h);
  }

  void damage(int d) {
    hp -= d;
  }

  boolean isDead() {
    return hp <= 0;
  }
}
