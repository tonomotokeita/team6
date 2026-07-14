class Stage {
  int stageNumber = 1;
  PImage bgImage;
  
  // ステージごとの難易度設定用（GameManagerが読み込む用）
  float enemySpeed;
  int enemySpawnInterval;
  int bossHp;
  
  Stage() {
    // 初期化時はステージ1に設定しておく
    setStage(1);
  }
  
  // ステージ番号を受け取って、背景画像と難易度を切り替えるメソッド
  void setStage(int number) {
    stageNumber = number;
    
    // 1. 4で割った余りで背景画像を切り替える
    int remainder = stageNumber % 4;
    
    if (remainder == 1) {
      bgImage = loadImage("stage1.png"); // 余り1：草原
    } 
    else if (remainder == 2) {
      bgImage = loadImage("stage2.png");     // 余り2：夕方
    } 
    else if (remainder == 3) {
      bgImage = loadImage("stage3.png");       // 余り3：洞窟
    } 
    else if (remainder == 0) {
      bgImage = loadImage("stage4.png");        // 余り0 (4の倍数)：空
    }
    
    // 2. 【オマケ】ステージが進むほど難しくなるように数値を設定
    // 周回（5ステージ目以降）しても、敵はどんどん強くなります！
    enemySpeed = 2.0 + (stageNumber * 0.5);          // ステージが上がるごとに速度+0.5
    enemySpawnInterval = max(30, 120 - (stageNumber * 10)); // 出現間隔を短くする（最低30フレーム）
    bossHp = 50 + (stageNumber * 20);                // ボスのHPを増やす
  }
  
  // 背景を描画するメソッド
  void display() {
    if (bgImage != null) {
      // 画像が存在すれば、画面サイズ（width, height）に引き伸ばして描画
      image(bgImage, 0, 0, width, height);
    } else {
      // 万が一画像が読み込めなかった時のための安全対策（真っ黒にする）
      background(0);
    }
  }
}
