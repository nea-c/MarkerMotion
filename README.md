# MarkerMotion

Markerを移動速度や重力、バウンド回数などを指定して動かすことができるライブラリデータパック。

## 最新

v3.0

## 動作要件

MinecraftJE 1.19.4

## 過去バージョンについて

過去バージョンのダウンロードは[Releases](https://github.com/nea-c/MarkerMotion/releases)からどうぞ。

## 使用方法

### 絶対事項

* 実行者はMarkerであること。
* `marker_motion:`を実行すること。

### 記述方法

Markerの召喚時や召喚後に以下のようなNBTを設定する。
```mcfunction
## 例
summon marker ~ ~ ~ {Tags:["A"],data:{MarkerMotion:{speed:{amount:1.50,loss:{amount:0.950,type:"*"}},gravity:39.200,bounce:{count:2,e:0.950,g:1b},stopwith:{hit:1b,block:1b}}}}
```

### 設定項目

| 引数名 | 必須 | 型 | 説明 | デフォルト |
| -: | :-: | :-: | :- | :-: |
| speed.amount | o | double | 初期速度<br>小数点2桁まで有効 | - |
| speed.loss.amount | x | double | 毎tickの速度変更量<br>この値の有効数字は以下のspeed.loss.typeによって指定されます<br>"+"：小数点2桁まで有効<br>"\*"：小数点3桁まで有効 | 0 |
| speed.loss.type | x | string | "+"か"\*"のどちらかを入力します<br>"+"：加算で計算します<br>"\*"：乗算で計算します | "+" |
| gravity | x | double | 重力加速度<br>9.8の倍数がおすすめ<br>小数点3桁まで有効 | 0 |
| bounce.count | x | int | 跳ねる回数<br>-1を指定すると無限 | 0 |
| bounce.e | x | double | 跳ねた時の速度変更量<br>乗算で計算されます<br>小数点3桁まで有効 | 1.0 |
| bounce.g | x | boolean | 床、天井に衝突して跳ねる時、重力加速を考慮して跳ねるようにします | false |
| stopwith.hit | x | boolean | ヒットしたエンティティがいた時、ヒット位置で停止するようにします | true |
| stopwith.block | x | boolean | ブロックに衝突した時、衝突位置で停止するようにします | true |

### 補足
* `speed.amount`は`speed.loss`や`bounce.e`での変動時にデータが変更されます

### 返りタグ
* MarkerMotion.on_block
```
ブロックに接触して停止した時 (跳ねた場合は付与されません)
```
* MarkerMotion.on_block.wall , MarkerMotion.on_block.y , MarkerMotion.on_block.[方角]
```
ブロックに接触した停止した方角やカテゴリ (MarkerMotion.on_blockがない場合は付与されません)
```
* MarkerMotion.bounce
```
跳ねた瞬間だけ付与されるタグ
```
* MarkerMotion.speed.0
```
スピードが0以下になった時
```
* MarkerMotion.stopwith.hit
```
"stopwith.hitがfalseでない"かつ、hitタグを付与したエンティティがいた時
```
* MarkerMotion.stop
```
メイン処理が実行されないようになるタグ。
MarkerMotion.on_block, MarkerMotion.speed.0, MarkerMotion.stopwith.hitのタグがあれば必ず付与されています。
```

### markerのNBTに追加返却されるもの
* data.MarkerMotion.Move
```
移動距離と移動角度。
この値を使って綺麗な繋がったパーティクル出したりとかが可能。exampleを参照。
```
* data.MarkerMotion.GravitySum
```
重力の合計。
1秒毎にリセットとかで変な挙動できるかもしれない。
```

### ダメージを与える飛び道具として扱う際の当たり判定に関して

このライブラリを呼ぶ前に判定に入れたいエンティティに対し`MarkerMotion.target`タグを付与します。

distanceとかで範囲指定してあげると軽量化になると思います。

当たり判定はヒットボックスサイズで検知され、`MarkerMotion.hit`タグを返します。

付与された、または付与したタグは必ず削除するようにしてください。


### #marker_motion:tag_remove

このライブラリを実行したMarkerに自動的に付与されるタグを全て剥がすfunction。

`marker_motion_example:bounce_advanced`の挙動で利用しています。


### exampleに関して

上記で少し記述したように挙動の例をいくつか作成しています。参考程度に。

MarkerMotion本体と一緒に導入することで実際に動かして確認できます。

## クレジット

* ブロック接触、エンティティヒット判定参考 ： [MC-Command-Note](https://github.com/RuskEocssar/MC-Command-Note)

## ライセンス

[MIT Licence](https://github.com/nea-c/MarkerMotion/blob/master/LICENSE)に基づく

## 更新履歴

* v3.0
  * 別ディメンションにおいて、x:0,z:0付近から離れると正常に動作しない問題の修正
  * xかzが特定座標を超えたときに正常に動作しない問題の修正
  * ブロックの当たり判定を追加
    * 階段やハーフなど、フルブロックより小さいブロックの隙間など細かい当たり判定で移動させることが可能になりました
  * `#marker_motion:`,`#marker_motion:tag_remove`で利用できるように変更
  * speedの値を以前までの1/100で宣言するように変更
  * gravityの値を以前までの1/10で宣言するように変更
  * speed.loss.typeの指定を`"+"`,`"*"`で指定するように変更
  * Motionを削除
    * 代替としてMoveを追加
  * stopwith.hitのデフォルト値をtrueに変更

* v2.3
  * `data.MarkerMotion.speed.amount`が0になっても`data.MarkerMotion.gravity`が0.01以上であれば停止しないように変更
  * exampleの召喚用functionを#marker_motion_example:...でそれぞれ呼び出せるように変更

* v2.2
  * `stopwith.block`の設定項目を追加

* v2.1
  * speed.lossの値で加速できるように変更
  * 対応バージョンを1.19.2に変更
  * exampleとMarkerMotion本体を分離

* v2.0
  * データパックの名称から`"NeAc"`を削除
  * 動作要件に`MinecraftJE 1.18.2`と記載したにも関わらず`pack_format`が**9**でなかった問題を修正
  * `data.MarkerMotion.speed.loss.type`が`"multiply"`でないときの動作が正常でなかった問題を修正
  * 直接弄ったりしていたデータを一時ストレージに入れてから利用することでの微軽量化試み
  * その他軽微な修正

* v1.1
  * いくつかの問題を修正

* v1.0
  * 初版