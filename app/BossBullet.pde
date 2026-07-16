class BossBullet {

  float x, y;
  float dx, dy;
  float size = 15;
  int atk = 10;

  BossBullet(float x, float y, float targetX, float targetY) {

    this.x = x;
    this.y = y;

    float angle = atan2(targetY - y, targetX - x);

    dx = cos(angle) * 5;
    dy = sin(angle) * 5;
  }

  void move() {
    x += dx;
    y += dy;
  }

  void display() {
    fill(255, 0, 0);
    noStroke();
    ellipse(x, y, size, size);
  }

  boolean isOut() {
    return x < -20 || x > width + 20 ||
           y < -20 || y > height + 20;
  }
}
