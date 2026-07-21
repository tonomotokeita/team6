class Shop {

  int coin;

  boolean hpBought = false;
  boolean speedBought = false;
  boolean atkBought = false;

  Shop(int coin) {
    this.coin = coin;
  }

  void display() {

    background(50);

    fill(255);

    textSize(25);

    // 前の画面の文字揃えを引き継がないよう、ここで明示する
    textAlign(CENTER, TOP);
    text("ショップ", width / 2, 50);

    textAlign(LEFT, TOP);

    text("コイン : " + coin, 50, 100);

    text("1 : 最大HP +20（10コイン）", 50, 180);
    text("2 : 移動速度 +1（10コイン）", 50, 230);
    text("3 : 攻撃力 +5（10コイン）", 50, 280);
  }

  void buy(Player player, int item) {

    if (coin < 10) return;

    if (item == 1 && !hpBought) {

      player.maxHp += 20;
      player.hp += 20;
      coin -= 10;
      hpBought = true;
    }

    if (item == 2 && !speedBought) {

      player.speed += 1;
      coin -= 10;
      speedBought = true;
    }

    if (item == 3 && !atkBought) {

      player.power += 5;
      coin -= 10;
      atkBought = true;
    }
  }
}
