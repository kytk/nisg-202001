# FreeSurfer勉強会

## 第1部(3) recon-all -autorecon3

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


### lh.sphereの確認

```
========================================
cd $SUBJECTS_DIR/ernie/surf
freeview -f lh.sphere \
-layout 1 -viewport 3d
========================================
```


### lh.sphere.regの確認

```
========================================
freeview -f \
lh.sphere.reg:vertex=1 \
-layout 1 -viewport 3d -zoom 10
========================================
```

- -zoom 10で10倍に拡大します。


### 頂点数が変わっていないことの確認

```
========================================
mris_euler_number lh.smoothwm
mris_euler_number lh.inflated
mris_euler_number lh.sphere
mris_euler_number lh.sphere.reg 
========================================
```


### Jacobian determinantの確認

```
========================================
cd .. # $SUBJECTS_DIR/ernie に移動
freeview -v mri/brain.mgz -f \
surf/lh.smoothwm:overlay=lh.jacobian_white \
-layout 2 -viewport coronal
========================================
```


### 平均的な folding pattern を個人の white surface に表示 

```
========================================
cd surf 
freeview -f lh.smoothwm:overlay=lh.avg_curv \
-layout 1 -viewport 3d
========================================
```


### DK アトラスの確認

```
========================================
freeview -f lh.smoothwm:annot=aparc.annot
freeview -f lh.inflated:annot=aparc.annot
freeview -f lh.sphere:annot=aparc.annot
========================================
```


### pial surface の確認

```
========================================
freeview -f lh.pial
freeview -f \
 lh.pial:overlay=lh.thickness
========================================
```

- 皮質厚などの情報は、overlayで表示します。


### thickness の確認

```
========================================
freeview -f \
 lh.pial:overlay=lh.thickness:overlay_threshold=0.5,4.5
========================================
```


### cortical ribbon の確認

```
========================================
cd ../mri
freeview -v lh.ribbon.mgz \
 rh.ribbon.mgz \
 ribbon.mgz:colormap=lut \
 -layout 2 -viewport sagittal
========================================
```


### Destrieux アトラスの確認

```
========================================
cd ../surf
freeview -f \
 lh.pial:annot=aparc.a2009s.annot \
 -layout 1 -viewport 3d
========================================
```

- :annot でアトラスを表示します。:annotに限っては、lh, rhをつける必要はありません。その前のlh.pialから自動的にlhと判定します。


### DKT アトラスの確認

```
========================================
freeview -f \
 lh.pial:annot=aparc.DKTatlas.annot
========================================
```


### 皮質+aseg.mgzの確認

```
========================================
cd ../mri
freeview -v \
 aparc.DKTatlas+aseg.mgz:colormap=lut \
 aparc.a2009s+aseg.mgz:colormap=lut \
 aparc+aseg.mgz:colormap=lut \
 -layout 2 -viewport sagittal
========================================
```


### aseg.mgz の確認

```
========================================
freeview -v aseg.mgz:colormap=lut
========================================
```


### wmparc.mgz の確認

```
========================================
freeview -v wmparc.mgz:colormap=lut
========================================
```


### ラベルの表示法 (1)

```
========================================
cd ..
freeview -v mri/brain.mgz -l \
 label/lh.BA1_exvivo.label 
========================================
```


### ラベルの表示法 (2)

```
========================================
freeview -f \
 surf/lh.pial:curvature_method=off:label=label/lh.BA1_exvivo.label \
 -layout 1 -viewport 3d
========================================
```

