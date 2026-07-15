class Boss extends Enemy {

  Boss(int stage, float x, float y) {
    super(stage, x, y);

    int bossNo = ((stage - 1) % 4) + 1;
    img = loadImage("boss" + bossNo + ".png");

    hp = 300;
    dy = 1;
  }

  @Override
  void move() {
    x += sin(radians(frameCount)) * 2;
  }
}
