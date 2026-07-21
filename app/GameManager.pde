class GameManager {
  String scene = "TITLE";

  UI ui;
  Stage stage;
  Player player;
  Shop shop;
  Slot slot;

  ArrayList<Enemy> enemies;
  ArrayList<Item> items;
  Boss boss;
  boolean isBossBattle = false;

  boolean leftHeld = false;
  boolean rightHeld = false;
  boolean fireHeld = false;

  // scoreはゲーム全体、stageScoreはボス出現判定に使う
  int score = 0;
  int stageScore = 0;

  GameManager() {
    ui = new UI();
    stage = new Stage();
    player = new Player("player.png");
    shop = new Shop(0);
    slot = new Slot();
    enemies = new ArrayList<Enemy>();
    items = new ArrayList<Item>();
  }

  void update() {
    if (scene.equals("TITLE")) handleTitleScene();
    else if (scene.equals("SELECT")) handleSelectScene();
    else if (scene.equals("PLAY")) handlePlayScene();
    else if (scene.equals("SLOT")) handleSlotScene();
    else if (scene.equals("SHOP")) handleShopScene();
    else if (scene.equals("GAMEOVER")) handleGameOverScene();
    else if (scene.equals("CLEAR")) handleClearScene();
  }

  void handleTitleScene() {
    ui.displayTitle();
  }

  void handleSelectScene() {
    ui.displaySelect();
  }

  // ステージ選択時だけ新しいゲームとしてPlayerを作り直す
  void startNewCampaign(int selectedStage) {
    player = new Player("player.png");
    shop = new Shop(20);
    score = 0;
    stage.setStage(selectedStage);
    prepareBattleObjects();
    scene = "PLAY";
  }

  void prepareBattleObjects() {
    stageScore = 0;
    enemies.clear();
    items.clear();
    boss = null;
    isBossBattle = false;
    player.resetPosition();
    leftHeld = false;
    rightHeld = false;
    fireHeld = false;
  }

  void handlePlayScene() {
    stage.display();

    // Playerの更新・射撃・表示は1フレームに1回だけ行う
    player.update(leftHeld, rightHeld);
    if (fireHeld) player.shoot();
    player.display();

    if (!isBossBattle) {
      if (frameCount % stage.enemySpawnInterval == 0) {
        enemies.add(
          new Enemy(
            stage.stageNumber,
            random(50, width - 50),
            -50
          )
        );
      }

      if (stageScore >= 100) {
        isBossBattle = true;
        enemies.clear();
        boss = new Boss(
          stage.stageNumber,
          width / 2 - 75,
          -150
        );
      }
    } else if (boss != null) {
      updateBossBattle();
      if (!scene.equals("PLAY")) return;
    }

    updateEnemies();
    updateItems();

    if (player.isDead()) scene = "GAMEOVER";

    ui.displayGame(player.hp, score, stage.stageNumber);
    displayExtraStatus();
  }

  void updateBossBattle() {
    boss.move();
    boss.display();
    boss.attack(player);
    boss.updateBullets(player);

    for (int i = player.bullets.size() - 1; i >= 0; i--) {
      Bullet bullet = player.bullets.get(i);

      if (bullet.x >= boss.x - boss.size / 2 &&
          bullet.x <= boss.x + boss.size / 2 &&
          bullet.y >= boss.y - boss.size / 2 &&
          bullet.y <= boss.y + boss.size / 2) {
        boss.damage(bullet.atk);
        player.bullets.remove(i);
      }
    }

    if (boss.isDead()) finishBossBattle();
  }

  void finishBossBattle() {
    score += 100 * stage.stageNumber;
    shop.coin += 10;

    // このステージで使ったスロット強化を解除する
    player.weaponBonus.clearActive();

    boss = null;
    isBossBattle = false;
    enemies.clear();
    items.clear();
    player.bullets.clear();

    if (stage.stageNumber >= 4) {
      scene = "CLEAR";
    } else {
      slot.reset();
      scene = "SLOT";
    }
  }

  void updateEnemies() {
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy enemy = enemies.get(i);
      enemy.move();
      enemy.display();
      enemy.attack();
      enemy.updateBullets(player);

      if (dist(player.x, player.y, enemy.x, enemy.y)
          < (player.size + enemy.size) / 2) {
        player.damage(20);
        enemies.remove(i);
        continue;
      }

      for (int j = player.bullets.size() - 1; j >= 0; j--) {
        Bullet bullet = player.bullets.get(j);

        if (bullet.x >= enemy.x - enemy.size / 2 &&
            bullet.x <= enemy.x + enemy.size / 2 &&
            bullet.y >= enemy.y - enemy.size / 2 &&
            bullet.y <= enemy.y + enemy.size / 2) {
          enemy.damage(bullet.atk);
          player.bullets.remove(j);
        }
      }

      if (enemy.isDead()) {
        if (random(1) < 0.3) {
          String[] types = {"HP", "Speed", "Power"};
          String itemType = types[int(random(types.length))];
          items.add(new Item(enemy.x, enemy.y, itemType));
        }

        enemies.remove(i);
        stageScore += 10;
        score += 10;
        shop.coin += 1;
        player.gainExp(10);
      } else if (enemy.y > height) {
        enemies.remove(i);
      }
    }
  }

  void updateItems() {
    for (int i = items.size() - 1; i >= 0; i--) {
      Item item = items.get(i);
      item.y += 1.5;
      item.display();
      item.checkCollision(player);

      if (!item.active || item.y > height) {
        items.remove(i);
      }
    }
  }

  void displayExtraStatus() {
    fill(255);
    textAlign(LEFT, TOP);
    textSize(15);
    text("Lv: " + player.level + "  経験値: " + player.exp, 340, 17);
    text("コイン: " + shop.coin, 535, 17);
    text(
      "スロット強化: " + player.weaponBonus.getActiveDescription(),
      340,
      48
    );
  }

  void handleSlotScene() {
    background(30, 20, 40);
    slot.update();
    slot.display();

    fill(255);
    textSize(18);
    textAlign(CENTER);

    if (!slot.isSpinning && !slot.hasStopped) {
      text("Sキーでスロット開始", width / 2, height - 100);
    } else if (slot.isSpinning) {
      text("Tキーでストップ！", width / 2, height - 100);
    } else {
      text("ENTERキーでショップへ", width / 2, height - 50);
    }
  }

  void handleShopScene() {
    shop.display();

    fill(255, 255, 100);
    textSize(18);
    textAlign(CENTER);
    text(
      "SPACEキーでステージ " + (stage.stageNumber + 1) + " へ進む",
      width / 2,
      height - 50
    );
  }

  // Playerを作り直さず、ショップとスロットの強化を引き継ぐ
  void startNextStage() {
    int nextStage = stage.stageNumber + 1;
    stage.setStage(nextStage);
    player.weaponBonus.activateForNextStage();
    prepareBattleObjects();

    shop.hpBought = false;
    shop.speedBought = false;
    shop.atkBought = false;
    scene = "PLAY";
  }

  void handleGameOverScene() {
    ui.displayGameOver(score);
  }

  void handleClearScene() {
    ui.displayClear(score);
  }

  void handleKeyPressed(char pressedKey, int pressedCode) {
    if (pressedCode == LEFT || pressedKey == 'a' || pressedKey == 'A') {
      leftHeld = true;
    }
    if (pressedCode == RIGHT || pressedKey == 'd' || pressedKey == 'D') {
      rightHeld = true;
    }
    if (pressedKey == ' ') fireHeld = true;

    if (scene.equals("SLOT")) {
      if ((pressedKey == 's' || pressedKey == 'S') &&
          !slot.isSpinning && !slot.hasStopped) {
        slot.start();
      } else if ((pressedKey == 't' || pressedKey == 'T') &&
                 slot.isSpinning) {
        slot.stop(player);
      } else if ((pressedCode == ENTER || pressedCode == RETURN) &&
                 slot.hasStopped) {
        scene = "SHOP";
      }
    } else if (scene.equals("SHOP")) {
      if (pressedKey == '1') shop.buy(player, 1);
      else if (pressedKey == '2') shop.buy(player, 2);
      else if (pressedKey == '3') shop.buy(player, 3);
      else if (pressedKey == ' ') startNextStage();
    } else if ((scene.equals("GAMEOVER") || scene.equals("CLEAR")) &&
               (pressedKey == 'r' || pressedKey == 'R')) {
      scene = "TITLE";
    }
  }

  void handleKeyReleased(char releasedKey, int releasedCode) {
    if (releasedCode == LEFT || releasedKey == 'a' || releasedKey == 'A') {
      leftHeld = false;
    }
    if (releasedCode == RIGHT || releasedKey == 'd' || releasedKey == 'D') {
      rightHeld = false;
    }
    if (releasedKey == ' ') fireHeld = false;
  }

  void handleMousePressed(int mx, int my) {
    if (scene.equals("TITLE") && ui.isMouseOverButton()) {
      scene = "SELECT";
    } else if (scene.equals("SELECT")) {
      int selectedStage = ui.getSelectedStageByMouse();
      if (selectedStage > 0) startNewCampaign(selectedStage);
    }
  }
}
