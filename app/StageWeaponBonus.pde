class StageWeaponBonus {

  // スロットで獲得できる強化の種類
  static final int BULLET_COUNT = 0;
  static final int BULLET_SPEED = 1;
  static final int RAPID_FIRE = 2;
  static final int POWER = 3;

  // 次のステージで発動する予約中の強化
  int pendingType = -1;
  int pendingStrength = 0;

  // 現在のステージで発動している強化
  int activeType = -1;
  int activeStrength = 0;

  int bulletCountBonus = 0;
  float bulletSpeedBonus = 0;
  int fireIntervalReduction = 0;
  int powerBonus = 0;

  // スロットで決まった効果を次ステージ用に予約する
  void reserve(int type, int strength) {
    pendingType = type;
    pendingStrength = strength;
  }

  // 予約した効果を次ステージ開始時に発動する
  void activateForNextStage() {
    clearActive();

    activeType = pendingType;
    activeStrength = pendingStrength;

    if (activeType == BULLET_COUNT) {
      bulletCountBonus = activeStrength;
    } else if (activeType == BULLET_SPEED) {
      bulletSpeedBonus = 2.5 * activeStrength;
    } else if (activeType == RAPID_FIRE) {
      fireIntervalReduction = 3 * activeStrength;
    } else if (activeType == POWER) {
      powerBonus = 5 * activeStrength;
    }

    pendingType = -1;
    pendingStrength = 0;
  }

  // ボス撃破時に現在の一時強化を解除する
  void clearActive() {
    activeType = -1;
    activeStrength = 0;
    bulletCountBonus = 0;
    bulletSpeedBonus = 0;
    fireIntervalReduction = 0;
    powerBonus = 0;
  }

  String getBonusName(int type) {
    if (type == BULLET_COUNT) return "弾数アップ";
    if (type == BULLET_SPEED) return "弾速アップ";
    if (type == RAPID_FIRE) return "連射速度アップ";
    if (type == POWER) return "攻撃力アップ";
    return "なし";
  }

  String getActiveDescription() {
    if (activeType < 0) return "なし";

    String description = getBonusName(activeType);
    if (activeStrength >= 2) description += " 2倍";
    return description;
  }
}
