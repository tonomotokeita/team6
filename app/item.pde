class Item {

  float x;
  float y;

  boolean active = true;

  Item(float x, float y) {

    this.x = x;
    this.y = y;
  }

  void display() {

    if (!active) return;

    // HP回復アイテムだと分かりやすいように緑色で表示する
    fill(0, 255, 0);
    ellipse(x, y, 20, 20);
  }

  void applyEffect(Player player) {
    player.hp = min(player.maxHp, player.hp + 20);

    active = false;
  }

  void checkCollision(Player player) {

    if (!active) return;

    if (dist(x, y, player.x, player.y) < 20) {
      applyEffect(player);
    }
  }
}
