class BossBullet {

  float x;
  float y;

  float dx;
  float dy;

  float size;
  int atk;


  // プレイヤーの座標を指定するタイプ
  BossBullet(
    float x,
    float y,
    float targetX,
    float targetY,
    float speed
  ) {

    this.x = x;
    this.y = y;

    size = 16;
    atk = 10;

    float angle =
      atan2(targetY - y, targetX - x);

    dx = cos(angle) * speed;
    dy = sin(angle) * speed;
  }


  // 方向ベクトルを直接指定するタイプ
  BossBullet(
    float x,
    float y,
    float directionX,
    float directionY,
    float speed,
    boolean useDirection
  ) {

    this.x = x;
    this.y = y;

    size = 16;
    atk = 10;

    dx = directionX * speed;
    dy = directionY * speed;
  }


  void move() {
    x += dx;
    y += dy;
  }


  void display() {
    fill(255, 50, 50);
    noStroke();

    ellipse(x, y, size, size);
  }


  boolean isOut() {
    return
      x < -size ||
      x > width + size ||
      y < -size ||
      y > height + size;
  }
}
