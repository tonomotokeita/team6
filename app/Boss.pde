class Boss extends Enemy {

  float moveX;
  float moveY;

  int stageNo;
  int directionChangeInterval;

  int attackInterval;
  float bulletSpeed;

  ArrayList<BossBullet> bullets;


  Boss(int stage, float x, float y) {
    super(stage, x, y);

    stageNo = stage;

    int bossNo = ((stage - 1) % 4) + 1;
    img = loadImage("boss" + bossNo + ".png");

    size = 150;

    // ステージが上がるほどHP増加
    hp = 200 + stage * 100;

    // 移動方向の変更頻度
    directionChangeInterval = max(20, 70 - stage * 10);

    // ステージが上がるほど発射間隔短縮
    attackInterval = max(20, 90 - stage * 15);

    // ステージが上がるほど弾速上昇
    bulletSpeed = 3.0 + stage * 0.8;

    moveX = random(-2.5, 2.5);
    moveY = random(-2.0, 2.0);

    bullets = new ArrayList<BossBullet>();
  }


  @Override
  void move() {

    if (frameCount % directionChangeInterval == 0) {
      float movePower = 2.0 + stageNo * 0.4;

      moveX = random(-movePower, movePower);
      moveY = random(-movePower, movePower);
    }

    x += moveX;
    y += moveY;

    float half = size / 2;

    if (x < half) {
      x = half;
      moveX *= -1;
    }

    if (x > width - half) {
      x = width - half;
      moveX *= -1;
    }

    if (y < half) {
      y = half;
      moveY *= -1;
    }

    if (y > height / 2) {
      y = height / 2;
      moveY *= -1;
    }
  }


  void attack(Player player) {

    if (frameCount % attackInterval != 0) {
      return;
    }

    int pattern = ((stageNo - 1) % 4) + 1;

    if (pattern == 1) {
      attackSingle(player);
    }
    else if (pattern == 2) {
      attackThreeWay(player);
    }
    else if (pattern == 3) {
      attackFiveWay(player);
    }
    else if (pattern == 4) {
      attackCircle();
    }
  }


  // Stage 1：プレイヤー狙い単発
  void attackSingle(Player player) {

    bullets.add(
      new BossBullet(
        x,
        y,
        player.x,
        player.y,
        bulletSpeed
      )
    );
  }


  // Stage 2：3方向ショット
  void attackThreeWay(Player player) {

    float baseAngle =
      atan2(player.y - y, player.x - x);

    float spread = radians(18);

    for (int i = -1; i <= 1; i++) {

      float angle = baseAngle + spread * i;

      bullets.add(
        new BossBullet(
          x,
          y,
          cos(angle),
          sin(angle),
          bulletSpeed,
          true
        )
      );
    }
  }


  // Stage 3：5方向ショット
  void attackFiveWay(Player player) {

    float baseAngle =
      atan2(player.y - y, player.x - x);

    float spread = radians(14);

    for (int i = -2; i <= 2; i++) {

      float angle = baseAngle + spread * i;

      bullets.add(
        new BossBullet(
          x,
          y,
          cos(angle),
          sin(angle),
          bulletSpeed,
          true
        )
      );
    }
  }


  // Stage 4：円形弾幕
  void attackCircle() {

    int bulletCount = 16;

    for (int i = 0; i < bulletCount; i++) {

      float angle =
        TWO_PI * i / bulletCount;

      bullets.add(
        new BossBullet(
          x,
          y,
          cos(angle),
          sin(angle),
          bulletSpeed,
          true
        )
      );
    }
  }


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
