class EnemyBullet {

  float x, y;
  float speed = 5;
  float size = 12;
  int atk = 10;

  EnemyBullet(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void move() {
    y += speed;
  }

  void display() {
    fill(255, 0, 0);
    noStroke();
    ellipse(x, y, size, size);
  }

  boolean isOut() {
    return y > height + size;
  }
}
