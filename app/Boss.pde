class Boss extends Enemy {

  Boss(String filename, float x, float y) {
    super(filename, x, y);

    w = 150;
    h = 150;
    hp = 300;
    dy = 1;
  }

  @Override
  void move() {
    x += sin(radians(frameCount)) * 2;
  }
}
