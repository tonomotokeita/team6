class Enemy {

  PImage img;
  float x, y;
  float dx, dy;
  float size;
  int hp;

  Enemy(int stage, float x, float y) {

    img = loadImage("enemy" + stage + ".png");
    
    this.x = x;
    this.y = y;
    size = 60;

    dx = 0;
    dy = 3;

    hp = 30;
  }

  void move() {
    x += dx;
    y += dy;
  }

  void display() {

    imageMode(CENTER);

    if (img != null) {
      image(img, x, y, size, size);
    } else {
      fill(255, 0, 0);
      ellipse(x, y, size, size);
    }
  }

  void damage(int d) {
    hp -= d;
  }

  boolean isDead() {
    return hp <= 0;
  }
}
