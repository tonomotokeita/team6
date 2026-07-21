class Item {

  float x;
  float y;

  String type;

  boolean active = true;

  Item(float x, float y, String type) {

    this.x = x;
    this.y = y;
    this.type = type;
  }

  void display() {

    if (!active) return;

    fill(255, 255, 0);
    ellipse(x, y, 20, 20);
  }

  void applyEffect(Player player) {

    if (type.equals("HP")) {
      player.hp = min(player.maxHp, player.hp + 20);
    }

    if (type.equals("Speed")) {
      player.speed += 1;
    }

     if (type.equals("Power")) {
      player.power += 5;
    }

    active = false;
  }

  void checkCollision(Player player) {

    if (!active) return;

    if (dist(x, y, player.x, player.y) < 20) {
      applyEffect(player);
    }
  }
}
