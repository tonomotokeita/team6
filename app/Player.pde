class Player {

  float x;
  float y;
  float speed;
  float size;

  int hp;
  int power;
  int level;
  int exp;

  PImage image;

  ArrayList<Bullet> bullets;

  Player(String filename) {
    x = width / 2;
    y = height - 80;

    speed = 6;
    size = 60;

    hp = 100;
    power = 10;
    level = 1;
    exp = 0;

    image = loadImage(filename);

    bullets = new ArrayList<Bullet>();
  }

  void update() {

    if (keyPressed) {
      if (keyCode == LEFT) {
        x -= speed;
      }

      if (keyCode == RIGHT) {
        x += speed;
      }
    }

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
    bullets.add(new Bullet(x, y - size / 2, power));
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
