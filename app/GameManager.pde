class GameManager {
  String scene = "TITLE";
  
  UI ui;
  Stage stage;
  Player player;
  Shop shop;
  Slot slot;
  
  ArrayList<Enemy> enemies;
  Boss boss; 
  boolean isBossBattle = false; 
  
  // ➔ アイテムを複数管理するためのリストを追加
  ArrayList<Item> items;
  
  int score = 0;
  
  GameManager() {
    ui = new UI();
    stage = new Stage();
    player = new Player("player.png");
    shop = new Shop(0); 
    slot = new Slot();
    
    enemies = new ArrayList<Enemy>();
    boss = null; 
    isBossBattle = false;
    
    // アイテムリストの初期化
    items = new ArrayList<Item>();
    
    stage.setStage(1);
  }
  
  void update() {
    if (scene.equals("TITLE")) {
      handleTitleScene();
    } else if(scene.equals("SELECT")){
      handleSelectScene();
    }
    else if (scene.equals("PLAY")) {
      handlePlayScene();
    } 
    else if (scene.equals("SLOT")) {
      handleSlotScene();
    }
    else if (scene.equals("SHOP")) {
      handleShopScene();
    }
    else if (scene.equals("GAMEOVER")) {
      handleGameOverScene();
    }
  }
  
  void handleTitleScene() {
    ui.displayTitle();
    if (mousePressed && ui.isMouseOverButton()) {
      scene = "SELECT";
      
      delay(200);
    }
  }
  
  void handleSelectScene(){
    ui.displaySelect();
    
    if(mousePressed){
      int selectedStage = ui.getSelectedStageByMouse();
      
      if(selectedStage > 0){
        scene = "PLAY";
        score = 0;
        stage.setStage(selectedStage); // クリックしたステージ番号を反映
        player = new Player("player.png");
        shop = new Shop(20); 
        enemies.clear(); 
        items.clear();
        boss = null;
        isBossBattle = false;
        
        delay(200);
      }
    }
  }
    
  
  void handlePlayScene() {
    stage.display();

  player.update();

  if (keyPressed && key == ' ') {
    player.shoot();
  }

  player.display();
   
    player.update(); 
    if (keyPressed && key == ' ') {
      player.shoot();
    }
    player.display(); 
    
    // --- 敵の出現・更新ロジック ---
    if (!isBossBattle) {
      if (frameCount % stage.enemySpawnInterval == 0) {
        enemies.add(new Enemy(stage.stageNumber, random(50, width - 50), -50));
      }
      
      if (score >= 100) {
        isBossBattle = true;
        boss = new Boss(stage.stageNumber, width / 2 - 75, -150); 
      }
    } else {
      if (boss != null) {
        boss.move();
        boss.display();
        boss.attack(player);
        boss.updateBullets(player);
        
        for (int j = player.bullets.size() - 1; j >= 0; j--) {
          Bullet b = player.bullets.get(j);
          if (b.x >= boss.x - boss.size/2 && b.x <= boss.x + boss.size/2 &&
          b.y >= boss.y && b.y <= boss.y + boss.size/2) {
            boss.damage(b.atk);
            player.bullets.remove(j);
          }
        }
        
        // ボス撃破時の処理
        if (boss.isDead()) {
          // ➔ ボスが死んだら確定で強力な「Power（攻撃力UP）」アイテムを落とす
          items.add(new Item(boss.x, boss.y, "Power"));
          
          boss = null;
          isBossBattle = false;
          score = 0; 
          
          scene = "SLOT";
          enemies.clear(); 
        }
      }
    }
    
    // ザコ敵の更新と当たり判定
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy e = enemies.get(i);
      e.move();
      e.display();
      e.attack();
      e.updateBullets(player);
      
      if (dist(player.x, player.y, e.x, e.y)
    < (player.size + e.size)/2) {

  player.damage(20);

  enemies.remove(i);
  }
      
      for (int j = player.bullets.size() - 1; j >= 0; j--) {
        Bullet b = player.bullets.get(j);
        if (b.x >= e.x - e.size/2 && b.x <= e.x + e.size/2 &&
        b.y >= e.y - e.size/2 && b.y <= e.y + e.size/2) {
          e.damage(b.atk);
          player.bullets.remove(j);
        }
      }
      
      if (e.isDead()) {
        // ➔ 【アイテムドロップ】ザコ敵が死んだら30%の確率でアイテムを落とす
        if (random(1) < 0.3) {
          String[] types = {"HP", "Speed", "Power"};
          String randomType = types[int(random(types.length))]; // ランダムで効果を選択
          items.add(new Item(e.x, e.y, randomType));
        }
        
        enemies.remove(i);
        if (!isBossBattle) score += 10; 
      }
      else if (e.y > height) {
        enemies.remove(i);
      }
    }
    
    // ➔ 【新設】アイテムの更新・描画・回収処理
    for (int i = items.size() - 1; i >= 0; i--) {
      Item it = items.get(i);
      
      // アイテムをそのまま浮遊させると自機が取りにいけない場合があるので、
      // 画面下に向かってゆっくり自動で落ちてくるように処理を加えます
      it.y += 1.5; 
      
      it.display();
      it.checkCollision(player); // プレイヤーとの接触判定（当たれば効果発動）
      
      // 拾われた、もしくは画面外（下）に消えたらリストから削除
      if (!it.active || it.y > height) {
        items.remove(i);
      }
    }
    
    if (player.isDead()) {
      scene = "GAMEOVER";
    }
    
    ui.displayGame(player.hp, this.score, stage.stageNumber);
  }
  
  void handleSlotScene() {
    background(30, 20, 40); 
    slot.update();  
    slot.display(); 
    
    fill(255);
    textSize(18);
    textAlign(CENTER);
    if (!slot.isSpinning) {
      text("Press 'S' to SPIN!", width / 2, height - 100);
      text("Press 'ENTER' to Shop", width / 2, height - 50);
    } else {
      text("Press 'T' to STOP!", width / 2, height - 100);
    }
    
    if (keyPressed) {
      if ((key == 's' || key == 'S') && !slot.isSpinning) {
        slot.start(); 
      }
      if ((key == 't' || key == 'T') && slot.isSpinning) {
        slot.stop(player); 
      }
      if (key == ENTER && !slot.isSpinning) {
        scene = "SHOP"; 
      }
    }
  }
  
  void handleShopScene() {
    shop.display(); 
    
    fill(255, 255, 100);
    textSize(18);
    textAlign(CENTER);
    text("Press 'SPACE' to Return to Stage Select " + stage.stageNumber, width / 2, height - 50);
    
    if (keyPressed) {
      if (key == '1') shop.buy(player, 1);
      if (key == '2') shop.buy(player, 2);
      if (key == '3') shop.buy(player, 3);
      
      if (key == ' ') {
        shop.hpBought = false;
        shop.speedBought = false;
        shop.atkBought = false;
        scene = "SELECT";
      }
    }
  }
  
  void handleGameOverScene() {
    ui.displayGameOver(score);
    if (keyPressed && (key == 'r' || key == 'R')) {
      scene = "TITLE";
    }
  }
}
