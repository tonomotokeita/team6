class Slot {

  PImage[] symbols = new PImage[4];
  int[] result = new int[3];

  boolean isSpinning = false;

  Slot() {
    symbols[0] = loadImage("slot1.png");
    symbols[1] = loadImage("slot2.png");
    symbols[2] = loadImage("slot3.png");
    symbols[3] = loadImage("slot4.png");
  
    for (int i = 0; i < 3; i++) {
      result[i] = int(random(symbols.length));
    }
  }

  
  void start() {
    isSpinning = true;
  }

  void update(){
    if (isSpinning && frameCount % 3 == 0){
      for (int i = 0; i < 3; i++){
        result[i] = int(random(symbols.length));
      }
    }
  }
  
  void stop(Player player) {
    isSpinning = false;

    for (int i = 0; i < 3; i++) {
      result[i] = int(random(symbols.length));
    }

    judge(player);
  }

  void display() {

    fill(255);
    textAlign(CENTER);
    textSize(28);
    text("SLOT",width / 2,100);
    textAlign(LEFT);

    int slotSize = 100;
    int gap = 30;
    int totalWidth = slotSize * 3 + gap * 2;
    int startX = (width - totalWidth) / 2;
    int y = 180;
    
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
        text("slot" + (result[i] + 1), x + slotSize / 2, y + slotSize / 2);
        textAlign(LEFT);
      }
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
