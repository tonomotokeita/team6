# 設計ドキュメント

## Player
主担当者名：船戸優冴
属性：
- x, y：プレイヤーの位置
- hp：体力
- speed：移動速度
- level：レベル
- exp：経験値

メソッド：
- move()：キー入力に応じて移動する
- display()：プレイヤーを表示する
- shoot()：弾を発射する
- damage()：ダメージを受ける
- levelUp()：経験値が一定以上になったらレベルアップする

## Bullet
主担当者名：船戸優冴
属性：
- x, y：弾の位置
- speed：弾の速度
- power：攻撃力

メソッド：
- move()：弾を移動する
- display()：弾を表示する
- isHitEnemy()：敵に当たったか判定する

## Enemy
主担当者名：
属性：
- x, y：敵の位置
- hp：敵の体力
- speed：移動速度
- point：倒した時の得点

メソッド：
- move()：敵を移動する
- display()：敵を表示する
- damage()：ダメージを受ける
- isDead()：倒されたか判定する

## Boss
主担当者名：
属性：
- x, y：ボスの位置
- hp：ボスの体力
- attackPattern：攻撃パターン

メソッド：
- move()：ボスを移動する
- display()：ボスを表示する
- attack()：弾を発射する
- damage()：ダメージを受ける

## Slot
主担当者名：
属性：
- symbols：スロットの絵柄
- result：スロットの結果
- isSpinning：回転中かどうか

メソッド：
- start()：スロットを開始する
- stop()：スロットを停止する
- judge()：絵柄が揃ったか判定する
- applyBonus()：ボーナス効果を反映する

## Item
主担当者名：
属性：
- x, y：アイテムの位置
- type：アイテムの種類

メソッド：
- display()：アイテムを表示する
- applyEffect()：効果を発動する

## Shop
主担当者名：
属性：
- coin：所持コイン
- items：購入できる強化一覧

メソッド：
- display()：ショップ画面を表示する
- buy()：強化を購入する

## GameManager
主担当者名：
属性：
- scene：現在の画面
- score：スコア
- stage：現在のステージ

メソッド：
- update()：ゲーム全体を更新する
- changeScene()：画面を切り替える
- gameOver()：ゲームオーバー処理を行う

## UI
主担当者名：
属性：
- score：スコア
- hp：体力
- level：レベル

メソッド：
- displayTitle()：タイトル画面を表示する
- displayGame()：ゲーム画面を表示する
- displayStatus()：HPやスコアを表示する
- displayGameOver()：ゲームオーバー画面を表示する

## Stage
主担当者名：
属性：
- stageNumber：ステージ番号
- background：背景画像

メソッド：
- display()：背景を表示する
- nextStage()：次のステージへ進む