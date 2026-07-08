class Shop {

  int coin;

  boolean hpBought = false;
  boolean speedBought = false;
  boolean powerBought = false;

  Shop(int coin) {
    this.coin = coin;
  }

  void display() {

    background(50);

    fill(255);

    textSize(25);

    text("SHOP", 300, 60);

    text("Coin : " + coin, 50, 100);

    text("1 : HP +20 (10 Coin)", 50, 180);
    text("2 : Speed +1 (10 Coin)", 50, 230);
    text("3 : Power +5 (10 Coin)", 50, 280);
  }

  void buy(Player player, int item) {

    if (coin < 10) return;

    if (item == 1 && !hpBought) {

      player.hp += 20;
      coin -= 10;
      hpBought = true;
    }

    if (item == 2 && !speedBought) {

      player.speed += 1;
      coin -= 10;
      speedBought = true;
    }

    if (item == 3 && !powerBought) {

      player.power += 5;
      coin -= 10;
      powerBought = true;
    }
  }
}
