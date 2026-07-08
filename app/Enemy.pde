class Enemy {

  float x, y;
  int hp;
  float speed;
  int point;
  int attack;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;

    hp = 30;
    speed = 3;
    point = 100;
    attack = 10;
  }

  void move() {
    y += speed;
  }

  void display() {
    fill(255, 0, 0);
    ellipse(x, y, 40, 40);
  }

  void damage(int d) {
    hp -= d;
  }

  boolean isDead() {
    return hp <= 0;
  }

  void attack() {
    // 敵弾を追加する予定
  }
}
