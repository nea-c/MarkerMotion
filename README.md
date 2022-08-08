# MarkerMotion

Markerを移動速度や重力、バウンド回数などを指定して動かすことができるライブラリデータパック。 

## 最新

v2.1

## 動作要件
MinecraftJE 1.18.2 ~

## 使用方法

### 絶対事項

* 実行者はMarkerであること。
* `marker_motion:`を実行すること。

### 記述方法

Markerの召喚時や召喚後に以下のようなNBTを設定する。
```mcfunction
## 例
summon marker ~ ~ ~ {Tags:["A"],data:{MarkerMotion:{speed:{amount:150,loss:{amount:0.950,type:"multiply"}},gravity:392.00,bounce:{count:2,e:0.950,g:1b},stopwith:{hit:1b}}}}
```

### 設定項目
<table><thead>
</thead><tbody>
<tr><th rowspan="4" align="center">speed</th><th align="center">amount</th><td colspan="8">初期速度</td>
<tr><th rowspan="3" align="center">loss</th><th rowspan="3">tick毎の減少量</th><td colspan="2" align="center">amount</td><td colspan="8">量。typeパラメータによって効果が異なる。</td></tr>
<tr><td rowspan="2" align="center">type</td><td rowspan="2">amountの計算方法を変更する。</td><td align="center">"constant"</td><td>減算で計算します [整数値,Default]</td></tr>
<tr><td align="center">"multiply"</td><td>倍率で計算します [小数値,1/1000] 0.9なら10%損失</td></tr>
<tr><td align="center">gravity</td><td align="center">重力の強さ</td><td colspan="7">98の倍数が比較的決めやすくておすすめ [小数値,1/100]</td></tr>
<tr><td rowspan="3" align="center">bounce</td><td align="center">count</td><td colspan="8">跳ねる回数。-1で無限。 [整数値]</td></tr>
<tr><td align="center">e</td><td colspan="8">跳ねたときに減少するスピードの量。倍率で計算します。 [小数値,1/1000] 0.9なら10%損失</td></tr>
<tr><td align="center">g</td><td colspan="8">床や天井にぶつかって跳ねる際、重力での加速を考慮して跳ねます。true,falseで入力も可。 [真偽値]</td></tr>
<tr><td rowspan="1" align="center">stopwith</td><td>途中で停止する条件</td><td align="center">hit</td><td colspan="8">ヒットしたエンティティがいた時。true,falseで入力も可。 [真偽値]</td></tr>
</tbody></table>

### 補足
* `speed.amount`のみで動作します。
* 小数値は`gravity以外は`第3位まで、`gravityは`第2位まで設定できます。
* また、この説明は`marker_motion:main`にも記述してあります。

### 返りタグ
* MarkerMotion.on_block
```
ブロックに接触した時 (跳ねた場合は付与されません)
```
* MarkerMotion.on_block.wall , MarkerMotion.on_block.y , MarkerMotion.on_block.[方角]
```
ブロックに接触した方角やカテゴリ (MarkerMotion.on_blockがない場合は付与されません)
```
* MarkerMotion.speed.0
```
スピードが0以下になった時
```
* MarkerMotion.stopwith.hit
```
stopwith.hitがtrueかつ、hitタグを付与したエンティティがいた時
```
* MarkerMotion.stop
```
移動処理(main.function)が実行されないようになるタグ。
MarkerMotion.on_block, MarkerMotion.speed.0, MarkerMotion.stopwith.hitのタグがあれば必ず付与されています。
```

### 返りNBT
* data.MarkerMotion.Motion
```
移動量。
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


### tag_remove.mcfunction

このライブラリを実行したMarkerに自動的に付与されるタグを全て剥がすfunction。

`marker_motion:example/bounce_advanced`の挙動で利用しています。


### exampleに関して

上記で少し記述したように挙動の例をいくつか同梱しています。参考程度に。

利用する際は必要ないため削除して構いませんが、

削除する場合はこれらのファイル/フォルダを削除してください。

`minecraft/tag/functions/tick.json`

`marker_motion/functions/example`

`marker_motion/tags/entity_types`


## クレジット

* 移動ベクトル取得部分引用 ： [SmartMotion](https://github.com/Irohamaru/SmartMotion)
* サポート ： [C.fuaim様](https://github.com/Cfuaim)　超感謝。

## ライセンス

[MIT Licence](https://github.com/nea-c/MarkerMotion/blob/master/LICENSE)に基づく

## 更新履歴

* v2.1
  * speed.lossの値で加速できるように変更

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