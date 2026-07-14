class Bullet {

  float x;
  float y;
  float speed;
  float size;

  int atk;

  Bullet(float x, float y, int atk) {
    this.x = x;
    this.y = y;
    this.atk = atk;

    speed = 10;
    size = 12;
  }

  void update() {
    y -= speed;
  }

  void display() {
    fill(255, 255, 0);
    noStroke();

    ellipse(x, y, size, size * 1.5);
  }

  // 画面外に出たか確認
  boolean isOut() {
    return y < -size;
  }
}
