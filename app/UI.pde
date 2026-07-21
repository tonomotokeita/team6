class UI {
  // タイトル画面のスタートボタンの位置とサイズ
  float startBtnX, startBtnY, startBtnW, startBtnH;
  
  // 画像アセット用の変数（後で画像を使う時にここに入れます）
  PImage titleLogo;
  PImage heartIcon;
  
  UI() {
 
    startBtnW = 200;
    startBtnH = 60;
    startBtnX = 400 - (startBtnW / 2); // 画面中央付近（後で動的に調整も可能）
    startBtnY = 400;
    
  }
  
  // 1. タイトル画面の表示
  void displayTitle() {
    // ボタンのX座標を画面中央にリアルタイム更新（画面サイズ変更対策）
    startBtnX = width / 2 - startBtnW / 2;
    
    // 背景（グラデーション風の濃い紺色）
    background(10, 15, 30);
    
    // タイトル文字の描画
    fill(255, 215, 0); // 金色
    textSize(55);
    textAlign(CENTER, CENTER);
    text("SPACE SHOOTER", width / 2, height / 2 - 80);
    
    // サブタイトルや操作説明
    fill(180, 200, 255);
    textSize(18);
    text("スタートボタンを押してください", width / 2, height / 2 - 10);
    
    // スタートボタンの描画
    // マウスがボタンの上にある時は色を明るくする（ホバー効果）
    if (isMouseOverButton()) {
      fill(130, 130, 255); // 明るい青
    } else {
      fill(80, 80, 200);   // 通常の青
    }
    stroke(255); // 白い枠線
    strokeWeight(2);
    rect(startBtnX, startBtnY, startBtnW, startBtnH, 15); // 角丸の四角
    noStroke();
    
    // ボタンの文字
    fill(255);
    textSize(22);
    text("ゲームスタート", startBtnX + startBtnW / 2, startBtnY + startBtnH / 2);
  }
  
  // 🌟ステージ選択画面の描画（上段1〜4、下段5〜8のグリッド配置）
  void displaySelect() {
    background(20, 30, 45); // 選択画面用の背景色
    
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(40);
    text("ステージ選択", width / 2, 100);
    
    textSize(22);
    fill(180, 200, 255);
    text("プレイするステージを選んでください", width / 2, 160);
    
    // ボタンのサイズと配置の計算
    float btnW = 200; // 横並びにするため少しスリムに
    float btnH = 90;  // 押しやすいように少し高さを出す
    float gapX = 30;  // ボタン同士の横の隙間
    
    // 4つのボタンを並べた時の全体の横幅を計算
    float totalW = (btnW * 4) + (gapX * 3); // 200*4 + 25*3 = 875px
    float startX = (width - totalW) / 2;    // 画面中央に収めるための左端の開始位置
    float startY = 320;                     // 1行目のY座標の開始位置
    
    for (int i = 1; i <= 4; i++) {
      int col = (i - 1) ; // 左から何番目か（0、1、2、3）
      
      float x = startX + col * (btnW + gapX);
      float y = startY;
      
      // マウスがこのボタンの上にあるかチェック
      boolean isHover = (mouseX >= x && mouseX <= x + btnW && mouseY >= y && mouseY <= y + btnH);
      
      // ボタンの背景（ホバー時は明るく）
      if (isHover) {
        fill(100, 100, 230); // 明るい青
      } else {
        fill(50, 50, 130);   // 暗い青
      }
      stroke(255, 150);
      strokeWeight(2);
      rect(x, y, btnW, btnH, 10); // 角丸ボタン
      noStroke();
      
      // ボタンの文字
      fill(255);
      textSize(18);
      textAlign(CENTER, CENTER);
      
      // ステージ名（改行を入れて2行にすると綺麗に収まります）
      String stageTitle = "ステージ " + i;
      String stageSub = "";
      switch(i) {
        case 1: stageSub = "（草原）"; break;
        case 2: stageSub = "（夕方）"; break;
        case 3: stageSub = "（洞窟）"; break;
        case 4: stageSub = "（空）"; break;
      }
      
      // ボタンの中心に文字を描画
      text(stageTitle + "\n" + stageSub, x + btnW / 2, y + btnH / 2);
    }
  }

  // 🌟マウスクリック時の当たり判定（描画と同じ計算式を使用）
  int getSelectedStageByMouse() {
    float btnW = 200;
    float btnH = 90;
    float gapX = 30;

    
    float totalW = (btnW * 4) + (gapX * 3);
    float startX = (width - totalW) / 2;
    float startY = 320;
    
    for (int i = 1; i <= 4; i++) {
      int col = (i - 1) % 4;
      
      float x = startX + col * (btnW + gapX);
      float y = startY;
      
      if (mouseX >= x && mouseX <= x + btnW && mouseY >= y && mouseY <= y + btnH) {
        return i; // クリックされたステージ（1〜8）を返す
      }
    }
    return 0; // どこもクリックされていない
  }
  
  // 2. ゲームプレイ中の画面表示（HP、スコア、現在のステージ情報）
  void displayGame(int hp, int score, int stageNum) {
    textAlign(LEFT, TOP);
    textSize(22);
    
    // 黒い半透明の座布団（文字を見やすくするための背景）を上部に敷く
    fill(0, 0, 0, 100);
    rect(0, 0, width, 75);
    
    // ステータス表示
    fill(255, 100, 100); // 赤っぽい色
    text("HP: " + hp, 30, 15);
    
    fill(255, 255, 100); // 黄色っぽい色
    text("スコア: " + score, 200, 15);
    
    fill(100, 255, 255); // 水色っぽい色
    text("ステージ: " + stageNum, width - 170, 15);
  }
  
  // 3. ゲームオーバー画面の表示（必要に応じて使用）
  void displayGameOver(int finalScore) {
    background(30, 0, 0); // 暗い赤
    
    fill(255, 50, 50);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, height / 2 - 50);
    
    fill(255);
    textSize(24);
    text("最終スコア: " + finalScore, width / 2, height / 2 + 30);
    text("Rキーでタイトルへ戻る", width / 2, height / 2 + 80);
  }

  void displayClear(int finalScore) {
    background(10, 30, 55);

    fill(255, 220, 80);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("全ステージクリア！", width / 2, height / 2 - 70);

    fill(255);
    textSize(26);
    text("最終スコア: " + finalScore, width / 2, height / 2 + 20);

    fill(180, 220, 255);
    textSize(20);
    text("Rキーでタイトルへ戻る", width / 2, height / 2 + 90);
  }
  
  // 便利関数：マウスがスタートボタンの上にあるかどうかを判定する
  boolean isMouseOverButton() {
    return (mouseX >= startBtnX && mouseX <= startBtnX + startBtnW &&
            mouseY >= startBtnY && mouseY <= startBtnY + startBtnH);
  }
}
