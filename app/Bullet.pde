class Bullet {

  float x;
  float y;
  float dx;
  float dy;
  float speed;
  float size;

  int atk;

  Bullet(float x, float y, int atk) {
    this(x, y, atk, 10, -HALF_PI);
  }

  Bullet(float x, float y, int atk, float speed, float angle) {
    this.x = x;
    this.y = y;
    this.atk = atk;

    this.speed = speed;
    size = 12;

    dx = cos(angle) * speed;
    dy = sin(angle) * speed;
  }

  void update() {
    x += dx;
    y += dy;
  }

  void display() {
    fill(255, 255, 0);
    noStroke();

    ellipse(x, y, size, size * 1.5);
  }

  // 画面外に出たか確認
  boolean isOut() {
    return x < -size ||
           x > width + size ||
           y < -size ||
           y > height + size;
  }
}
