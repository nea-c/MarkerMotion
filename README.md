# NeAcMarkerMotion

Markerを移動速度や重力、バウンド回数などを指定して動かすことができるライブラリ。 
## 使用方法
* 実行者はMarkerであること。
* `neac_marker_motion:`を実行すること。

### 記述方法

Markerの召喚時や召喚後に以下のようなNBTを設定する。
```mcfunction
## 例
summon marker ~ ~ ~ {Tags:["A"],data:{NeAcMarkerMotion:{speed:{amount:150,loss:{amount:0.950,type:"multiply"}},gravity:392.00,bounce:{count:2,e:0.950,g:1b},stopwith:{hit:1b}}}}
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
* speed.amountのみで動作します。
* 小数値はgravity以外は第3位まで、gravityは第2位まで設定できます。
* また、この説明は`neac_marker_motion:main`にも記述してあります。

### 返りタグ
* NeAcMarkerMotion.on_block : ブロックに接触した時 (跳ねた場合は付与されません)
* NeAcMarkerMotion.on_block.wall , NeAcMarkerMotion.on_block.y , NeAcMarkerMotion.on_block.[方角] : ブロックに接触した方角やカテゴリ (NeAcMarkerMotion.on_blockがない場合は付与されません)
* NeAcMarkerMotion.speed.0 : スピードが0以下になった時
* NeAcMarkerMotion.stopwith.hit : stopwith.hitがtrueかつ、hitタグを付与したエンティティがいた時
* NeAcMarkerMotion.stop : 移動処理(main.function)が実行されないようになるタグ。
　NeAcMarkerMotion.on_block,NeAcMarkerMotion.speed.0,NeAcMarkerMotion.stopwith.hitのタグがあれば必ず付与されています。

### 返りNBT
* Motion : 移動量 (この値を使って綺麗な繋がったパーティクル出したりとかが可能)
* GravitySum : 重力の合計 (1秒毎にリセットとかで変な挙動できるかもしれない)

### ダメージを与える飛び道具として扱う際の当たり判定に関して
このライブラリを呼ぶ前に判定に入れたいエンティティに対し`NeAcMarkerMotion.target`タグを付与します。

distanceとかで範囲指定してあげると軽量化になると思います。

当たり判定はヒットボックスサイズで検知され、`NeAcMarkerMotion.hit`タグを返します。

付与された、または付与したタグは必ず削除するようにしてください。


### tag_remove.mcfunction
このライブラリで自動的に付与されるタグを全て剥がすfunctionです。

実行者はそれらのタグがついたMarkerに必ず変更してください。


### クレジット / Credit