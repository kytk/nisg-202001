# FreeSurfer勉強会

## 第1部(2) recon-all -autorecon2

### SUBJECTS_DIRの設定

- Lin4Neuro

	```
	===================================
	nisg=/media/sf_share/nisg-202001
	===================================
	```

- MacOS

	```
	===================================
	nisg=~/git/nisg-202001
	===================================
	```


```
========================================
SUBJECTS_DIR=$nisg/subjects
cd $SUBJECTS_DIR/ernie
========================================
```

- $SUBJECTS_DIR は、自分で変更できます。これを使うことで、任意の場所にFreeSurferの結果を保存できます。


### talairach.lta の確認

```
========================================
cd mri
cat transforms/talairach.lta
========================================
```


### 皮質下領域の確認

```
========================================
freeview -v T1.mgz \
 aseg.presurf.mgz:colormap=lut
========================================
```

- :colormap でカラーマップを指定できます。
- lut は、FreeSurfer専用のカラーマップです。


### 信号値補正の確認

```
========================================
freeview -v brainmask.mgz brain.mgz
========================================
```


### wm.mgzの確認

```
========================================
freeview -v brain.mgz \
 wm.mgz:opacity=0.8:colormap=heat
========================================
```

- :opacity は不透明度を設定します。0-1の間の値をとります。
- :colormap=heat で、heatカラーマップを指定します。


### filled.mgzの確認

```
========================================
freeview -v wm.mgz filled.mgz
========================================
```


### white surface 画像の確認

```
========================================
cd .. # $SUBJECTS_DIR/ernie に移動
freeview -f surf/lh.orig.nofix \
 -layout 3 -viewport 3d
========================================
```


### 平滑化された white surface 画像の確認

```
========================================
freeview -f surf/lh.smoothwm.nofix \
 -layout 3 -viewport 3d
========================================
```


### どれだけ inflate されるか確認

```
========================================
freeview -f surf/lh.smoothwm.nofix \
 surf/lh.inflated.nofix \
 -layout 1 -viewport 3d
========================================
```


### 頂点数などの確認

```
========================================
mris_euler_number surf/lh.orig.nofix
mris_euler_number surf/lh.orig
========================================
```

- mris_euler_number は、FreeSurferに準備されているコマンドで、脳表に敷き詰めた三角形の頂点の数、辺の数、三角形の数などを確認することができます。


### 平滑化の効果確認

```
========================================
freeview -v mri/brain.mgz -f \
 surf/lh.orig.nofix:edgecolor=yellow \
 surf/lh.smoothwm:edgecolor=blue \
 -layout 1 -viewport axial -zoom 3
========================================
```

- -v でVolume画像を、-f でSurface画像を表示します。
- :edgecolor で、Surface画像の境界線の色を指定できます。
- -zoom 3 で、3倍に拡大して表示します。


### lh.inflated と lh.sulc の確認

```
========================================
freeview -f surf/lh.inflated \
 surf/lh.inflated:overlay=lh.sulc \
 -layout 1 -viewport 3d
========================================
```

- lh.sulc は正確には画像ファイルではなく、信号値の情報をもっているだけのファイルです。このため、これを直接表示しようとするとエラーになり、inflated画像に overlay する形で表示します。


### lh.white.H の確認

```
========================================
freeview -v mri/brain.mgz \
 -f surf/lh.smoothwm:overlay=lh.white.H \
 -layout 2 -viewport sagittal
========================================
```


### lh.curv.stats の確認

```
========================================
less stats/lh.curv.stats
========================================
```

- less は、ファイルを表示するコマンドです。終了を表示するには、"q" をタイプします。



