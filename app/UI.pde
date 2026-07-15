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
    text("- Press START BUTTON to Play -", width / 2, height / 2 - 10);
    
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
    text("START GAME", startBtnX + startBtnW / 2, startBtnY + startBtnH / 2);
  }
  
  // 2. ゲームプレイ中の画面表示（HP、スコア、現在のステージ情報）
  void displayGame(int hp, int score, int stageNum) {
    textAlign(LEFT, TOP);
    textSize(22);
    
    // 黒い半透明の座布団（文字を見やすくするための背景）を上部に敷く
    fill(0, 0, 0, 100);
    rect(0, 0, width, 50);
    
    // ステータス表示
    fill(255, 100, 100); // 赤っぽい色
    text("HP: " + hp, 30, 15);
    
    fill(255, 255, 100); // 黄色っぽい色
    text("SCORE: " + score, 200, 15);
    
    fill(100, 255, 255); // 水色っぽい色
    text("STAGE: " + stageNum, width - 150, 15);
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
    text("FINAL SCORE: " + finalScore, width / 2, height / 2 + 30);
    text("Press 'R' to Return to Title", width / 2, height / 2 + 80);
  }
  
  // 便利関数：マウスがスタートボタンの上にあるかどうかを判定する
  boolean isMouseOverButton() {
    return (mouseX >= startBtnX && mouseX <= startBtnX + startBtnW &&
            mouseY >= startBtnY && mouseY <= startBtnY + startBtnH);
  }
  
void displaySelect() {
  background(20, 25, 45);

  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("STAGE SELECT", width / 2, 100);

  drawStageButton(1, 180, 250);
  drawStageButton(2, 390, 250);
  drawStageButton(3, 600, 250);
  drawStageButton(4, 810, 250);

  fill(200);
  textSize(18);
  text("Select a stage", width / 2, 500);
}


void drawStageButton(int stageNumber, float x, float y) {
  rectMode(CENTER);

  fill(70, 90, 180);
  stroke(255);
  strokeWeight(2);
  rect(x, y, 150, 100, 15);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(24);
  text("STAGE " + stageNumber, x, y);

  noStroke();
  rectMode(CORNER);
}


int getSelectedStageByMouse() {

  if (
    mouseX >= 105 && mouseX <= 255 &&
    mouseY >= 200 && mouseY <= 300
  ) {
    return 1;
  }

  if (
    mouseX >= 315 && mouseX <= 465 &&
    mouseY >= 200 && mouseY <= 300
  ) {
    return 2;
  }

  if (
    mouseX >= 525 && mouseX <= 675 &&
    mouseY >= 200 && mouseY <= 300
  ) {
    return 3;
  }

  if (
    mouseX >= 735 && mouseX <= 885 &&
    mouseY >= 200 && mouseY <= 300
  ) {
    return 4;
  }

  return 0;
}
}
