class Enemy {

  PImage img;
  float x, y;
  float dx, dy;
  float size;
  int hp;
  
  ArrayList<EnemyBullet> bullets;

  Enemy(int stage, float x, float y) {

    img = loadImage("enemy" + stage + ".png");
    
    this.x = x;
    this.y = y;
    size = 60;

    dx = 0;
    dy = 2.0 + stage * 0.5;

    hp = 30;
    
    bullets = new ArrayList<EnemyBullet>();
  }

  void move() {
    x += dx;
    y += dy;
  }

  void display() {

    imageMode(CENTER);

    if (img != null) {
      image(img, x, y, size, size);
    } else {
      fill(255, 0, 0);
      ellipse(x, y, size, size);
    }
  }

  void damage(int d) {
    hp -= d;
  }
  
  void attack() {

  if (frameCount % 120 == 0) {
    bullets.add(new EnemyBullet(x, y));
  }
}

  void updateBullets(Player player) {

  for (int i = bullets.size()-1; i >= 0; i--) {

    EnemyBullet b = bullets.get(i);

    b.move();
    b.display();

    if (dist(b.x, b.y, player.x, player.y)
        < (player.size + b.size)/2) {

      player.damage(b.atk);
      bullets.remove(i);
    }
    else if (b.isOut()) {
      bullets.remove(i);
    }
  }
}

  boolean isDead() {
    return hp <= 0;
  }
}
