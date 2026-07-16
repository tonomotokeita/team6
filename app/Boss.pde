class Boss extends Enemy {

  float moveX;
  float moveY;
  int directionChangeInterval = 60;

  ArrayList<BossBullet> bullets;

  Boss(int stage, float x, float y) {
    super(stage, x, y);

    int bossNo = ((stage - 1) % 4) + 1;
    img = loadImage("boss" + bossNo + ".png");

    size = 150;
    hp = 300;

    moveX = random(-3, 3);
    moveY = random(-2, 2);

    bullets = new ArrayList<BossBullet>();
  }

  @Override
  void move() {

    // 一定時間ごとに移動方向を変更
    if (frameCount % directionChangeInterval == 0) {
      moveX = random(-3, 3);
      moveY = random(-2, 2);
    }

    x += moveX;
    y += moveY;

    float half = size / 2;

    // 左右の画面外防止
    if (x < half) {
      x = half;
      moveX *= -1;
    }

    if (x > width - half) {
      x = width - half;
      moveX *= -1;
    }

    // 上下の画面外防止
    if (y < half) {
      y = half;
      moveY *= -1;
    }

    if (y > height / 2) {
      y = height / 2;
      moveY *= -1;
    }
  }

  // ボスが弾を撃つ
  void attack(Player player) {

    if (frameCount % 60 == 0) {
      bullets.add(
        new BossBullet(
          x,
          y,
          player.x,
          player.y
        )
      );
    }
  }

  // ボス弾の更新・描画・当たり判定
  void updateBullets(Player player) {

    for (int i = bullets.size() - 1; i >= 0; i--) {

      BossBullet b = bullets.get(i);

      b.move();
      b.display();

      if (
        dist(b.x, b.y, player.x, player.y)
        < (b.size + player.size) / 2
      ) {

        player.damage(b.atk);
        bullets.remove(i);
      }
      else if (b.isOut()) {
        bullets.remove(i);
      }
    }
  }
}
