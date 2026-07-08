class Slot {

  String[] symbols = {"7", "★", "🍒"};
  String[] result = new String[3];

  boolean isSpinning = false;

  Slot() {
  }

  void start() {
    isSpinning = true;
  }

  void stop(Player player) {
    isSpinning = false;

    for (int i = 0; i < 3; i++) {
      result[i] = symbols[int(random(symbols.length))];
    }

    judge(player);
  }

  void display() {

    fill(255);
    textSize(40);

    for (int i = 0; i < 3; i++) {
      text(result[i], 200 + i * 80, 200);
    }
  }

  void judge(Player player) {

    if (result[0].equals(result[1]) && result[1].equals(result[2])) {
      applyBonus(player);
    }
  }

  void applyBonus(Player player) {

    int type = int(random(3));

    if (type == 0) {
      player.hp += 20;
    } else if (type == 1) {
      player.speed += 1;
    } else {
      player.power += 5;
    }
  }
}
