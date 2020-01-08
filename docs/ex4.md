# FreeSurfer勉強会

## 第1部(4) recon-allの実際 / freeview

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
========================================
```

- $SUBJECTS_DIR は、自分で変更できます。これを使うことで、任意の場所にFreeSurferの結果を保存できます。


### recon-all 関連スクリプト

- Lin4Neuro

	```
	========================================
	gedit ~/git/fs-scripts/fs_autorecon.sh
	========================================
	```

- macOS

	```
	========================================
	open ~/git/fs-scripts/fs_autorecon.sh
	========================================
	```

- open は macOS において、いろいろなファイルをあけることができるコマンドです。Linuxでは、`xdg-open` がそれに該当するのですが、`open` の方が mac でも Linux でも同じように扱うことができるので、Lin4Neuro では、xdg-open のエイリアスを open として設定しています。

### recon-all のログの確認

```
========================================
cd $SUBJECTS_DIR/ernie/scripts
less recon-all-status.log
========================================
```

- `less` コマンドは `q` で終了します。


### matlabランタイムインストール

- 勉強会の場では実行しないでください。時間がかかります。

```
========================================
cd ~/git/fs-scripts
./fs_download_matlabruntime.sh
========================================
```


### freeview の理解

```
========================================
cd $SUBJECTS_DIR/ernie/mri
freeview -v T1.mgz wm.mgz brainmask.mgz \
 aseg.mgz:colormap=lut:opacity=0.2 \
 -layout 2 -viewport sagittal
========================================
```


### Surface画像の表示

```
========================================
cd $SUBJECTS_DIR/ernie/surf
freeview -f \
 lh.pial:annot=aparc.annot:name=lh.pial_aparc:visible=0 \
 lh.inflated:overlay=lh.thickness:overlay_threshold=0.1,3:name=lh.inflated_thickness:visible=0 \
 lh.inflated:visible=0 \
 lh.white:edgecolor=blue:visible=0 \
 lh.pial:edgecolor=red \
 -viewport 3d
========================================
```


### 海馬のsubfield解析: 高解像度

```
========================================
cd $SUBJECTS_DIR/ernie/mri
freeview -v nu.mgz \
 lh.hippoSfLabels-T1.v10.mgz:colormap=lut \
 rh.hippoSfLabels-T1.v10.mgz:colormap=lut \
 -layout 1 -viewport coronal -zoom 5
========================================
```


### 海馬のsubfield解析: 低解像度

```
========================================
freeview -v brainmask.mgz \
 lh.hippoSfLabels-T1.v10.FSvoxelSpace.mgz:colormap=lut \
 rh.hippoSfLabels-T1.v10.FSvoxelSpace.mgz:colormap=lut \
 -layout 1 -viewport coronal -zoom 5
========================================
```


### 脳幹の構造解析:高解像度

```
========================================
freeview -v nu.mgz \
 brainstemSsLabels.v10.mgz:colormap=lut \
 -layout 2 -viewport sagittal -zoom 3
========================================
```


### 脳幹の構造解析:低解像度

```
========================================
freeview -v brain.mgz \
 brainstemSsLabels.v10.FSvoxelSpacei.mgz:colormap=lut \
 -zoom 3
========================================
```

