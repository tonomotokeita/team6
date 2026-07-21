class Player {

  float x;
  float y;
  float speed;
  float size;

  int hp;
  int maxHp;
  int power;
  int level;
  int exp;

  int baseShotInterval;
  int lastShotFrame;
  float baseBulletSpeed;

  PImage image;

  ArrayList<Bullet> bullets;
  StageWeaponBonus weaponBonus;

  Player(String filename) {
    x = width / 2;
    y = height - 80;

    speed = 6;
    size = 60;

    maxHp = 100;
    hp = maxHp;
    power = 10;
    level = 1;
    exp = 0;

    baseShotInterval = 12;
    lastShotFrame = -1000;
    baseBulletSpeed = 10;

    image = loadImage(filename);

    bullets = new ArrayList<Bullet>();
    weaponBonus = new StageWeaponBonus();
  }

  void update() {

    boolean moveLeft = keyPressed && keyCode == LEFT;
    boolean moveRight = keyPressed && keyCode == RIGHT;
    update(moveLeft, moveRight);
  }

  void update(boolean moveLeft, boolean moveRight) {

    if (moveLeft) x -= speed;
    if (moveRight) x += speed;

    x = constrain(x, size / 2, width - size / 2);

    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.update();

      if (b.isOut()) {
        bullets.remove(i);
      }
    }
  }

  void display() {

    imageMode(CENTER);

    if (image != null) {
      image(image, x, y, size, size);
    } else {
      fill(0, 180, 255);
      triangle(
        x, y - size / 2,
        x - size / 2, y + size / 2,
        x + size / 2, y + size / 2
      );
    }

    for (Bullet b : bullets) {
      b.display();
    }
  }

  void shoot() {
    int shotInterval = max(
      3,
      baseShotInterval - weaponBonus.fireIntervalReduction
    );

    if (frameCount - lastShotFrame < shotInterval) {
      return;
    }

    lastShotFrame = frameCount;

    int shotCount =
      getBaseShotCount() + weaponBonus.bulletCountBonus;

    float bulletSpeed =
      baseBulletSpeed + weaponBonus.bulletSpeedBonus;

    int bulletPower =
      power + weaponBonus.powerBonus;

    float spread = radians(10);

    for (int i = 0; i < shotCount; i++) {
      float offset = i - (shotCount - 1) / 2.0;
      float angle = -HALF_PI + offset * spread;

      bullets.add(
        new Bullet(
          x,
          y - size / 2,
          bulletPower,
          bulletSpeed,
          angle
        )
      );
    }
  }

  // レベルごとの基本弾数
  int getBaseShotCount() {
    if (level <= 1) return 1;
    if (level == 2) return 2;
    if (level == 3) return 3;
    return 5;
  }

  // 敵を倒したときに経験値を加算する
  void gainExp(int amount) {
    if (level >= 4) return;

    exp += amount;
    int requiredExp = level * 50;

    if (exp >= requiredExp) {
      exp -= requiredExp;
      level++;
    }
  }

  // 次ステージ開始時に初期位置へ戻す
  void resetPosition() {
    x = width / 2;
    y = height - 80;
    bullets.clear();
  }

  void damage(int damageValue) {
    hp -= damageValue;

    if (hp < 0) {
      hp = 0;
    }
  }

  boolean isDead() {
    return hp <= 0;
  }
}
