class Slot {

  PImage[] symbols = new PImage[4];
  String[] bonusNames = {
    "弾数UP", "弾速UP", "連射UP", "攻撃UP"
  };
  int[] result = new int[3];

  boolean isSpinning = false;
  boolean hasStopped = false;
  String bonusMessage = "";

  Slot() {
    symbols[0] = loadImage("slot1.png");
    symbols[1] = loadImage("slot2.png");
    symbols[2] = loadImage("slot3.png");
    symbols[3] = loadImage("slot4.png");
  
    for (int i = 0; i < 3; i++) {

      result[i] = (int) random(symbols.length);

    }
  }

  
  void start() {
    if (hasStopped) return;
    isSpinning = true;
  }

  // 次のボス撃破後に、新しいスロットとして初期化する
  void reset() {
    isSpinning = false;
    hasStopped = false;
    bonusMessage = "";

    for (int i = 0; i < result.length; i++) {

      result[i] = (int) random(symbols.length);

    }
  }

  void update(){
    if (isSpinning && frameCount % 3 == 0){
      for (int i = 0; i < 3; i++){

        result[i] = (int) random(symbols.length);

      }
    }
  }
  
  void stop(Player player) {
    if (!isSpinning) return;

    isSpinning = false;
    hasStopped = true;

    for (int i = 0; i < 3; i++) {

      result[i] = (int) random(symbols.length);

    }

    judge(player);
  }

  void display() {

    fill(255);
    textAlign(CENTER);
    textSize(28);
    text("スロット",width / 2,100);
    textAlign(LEFT);

    int slotSize = 100;
    int gap = 30;
    int totalWidth = slotSize * 3 + gap * 2;
    int startX = (width - totalWidth) / 2;
    int y = 180;
    imageMode(CORNER);
    
    for (int i = 0; i < 3; i++) {
      int x = startX + i * (slotSize + gap);

      noFill();
      stroke(255);
      rect(x, y, slotSize, slotSize);
      noStroke();

      PImage img = symbols[result[i]];
      if (img != null) {
        image(img, x, y, slotSize, slotSize);
      } else {
        fill(255);
        textAlign(CENTER);
        textSize(20);
        text(bonusNames[result[i]], x + slotSize / 2, y + slotSize / 2);
        textAlign(LEFT);
      }
    }

    if (hasStopped) {
      fill(255, 230, 80);
      textAlign(CENTER);
      textSize(24);
      text(bonusMessage, width / 2, 380);

      fill(220);
      textSize(16);
      text("この強化は次のステージで発動します", width / 2, 420);
    }
  }

  void judge(Player player) {
    boolean jackpot =
      result[0] == result[1] && result[1] == result[2];

    // 通常時は中央リールの効果を獲得する
    int bonusType = result[1];
    int strength = jackpot ? 2 : 1;

    player.weaponBonus.reserve(bonusType, strength);

    bonusMessage = player.weaponBonus.getBonusName(bonusType);
    bonusMessage += jackpot ? " 2倍！ 大当たり！" : "を獲得！";
  }
}
