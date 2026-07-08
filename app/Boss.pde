class Boss extends Enemy {

  int attackPattern;
  int phase;

  Boss(float x, float y) {
    super(x, y);

    hp = 300;
    speed = 1.5;

    attackPattern = 0;
    phase = 1;
  }

  @Override
  void move() {
    x += sin(radians(frameCount)) * 2;
  }

  @Override
  void display() {
    fill(100, 0, 255);
    ellipse(x, y, 100, 100);

    fill(255);
    textAlign(CENTER);
    text("BOSS", x, y);
  }

  @Override
  void attack() {

    switch(attackPattern) {

    case 0:
      // 正面へ撃つ
      break;

    case 1:
      // 扇状に撃つ
      break;

    case 2:
      // 円形に撃つ
      break;
    }

  }

  @Override
  void damage(int d) {
    hp -= d;

    if (hp < 150) {
      phase = 2;
      attackPattern = 1;
    }

    if (hp < 70) {
      phase = 3;
      attackPattern = 2;
    }
  }
}
