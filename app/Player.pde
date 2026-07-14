class Player {

  float x;
  float y;
  float speed;
  float size;

  int hp;
  int atk;
  int level;
  int exp;

  ArrayList<Bullet> bullets;

  Player() {
    x = width / 2;
    y = height - 80;

    speed = 6;
    size = 50;

    hp = 100;
    atk = 10;
    level = 1;
    exp = 0;

    bullets = new ArrayList<Bullet>();
  }

  void update() {

    // 左右移動
    if (keyPressed) {

      if (keyCode == LEFT) {
        x -= speed;
      }

      if (keyCode == RIGHT) {
        x += speed;
      }
    }

    // 画面外に出ないようにする
    x = constrain(x, size / 2, width - size / 2);

    // 弾の移動と削除
    for (int i = bullets.size() - 1; i >= 0; i--) {

      Bullet b = bullets.get(i);

      b.update();

      if (b.isOut()) {
        bullets.remove(i);
      }
    }
  }

  void display() {

    // プレイヤーを三角形で表示
    fill(0, 180, 255);
    noStroke();

    triangle(
      x, y - size / 2,
      x - size / 2, y + size / 2,
      x + size / 2, y + size / 2
    );

    // 弾を表示
    for (Bullet b : bullets) {
      b.display();
    }

    // HP表示
    fill(255);
    textSize(20);
    text("HP : " + hp, 20, 30);
  }

  // 弾を発射
  void shoot() {
    bullets.add(new Bullet(x, y - size / 2, atk));
  }

  // ダメージを受ける
  void damage(int damageValue) {
    hp -= damageValue;

    if (hp < 0) {
      hp = 0;
    }
  }

  // 生きているか確認
  boolean isDead() {
    return hp <= 0;
  }
}
