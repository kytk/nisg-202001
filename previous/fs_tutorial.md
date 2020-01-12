# 第2回FreeSurfer勉強会で用いるコマンド

-----

## 変数FSWSの設定

```
FSWS=~/git/fsws
```

-----

## 第1部(1) FreeSurferの概要/構造画像の前処理

### recon-all関連スクリプト

```
### 1.1.1
# Lin4Neuro
gedit $FSWS/fs-scripts/fs_autorecon.sh &

# Mac
open -e $FSWS/fs-scripts/fs_autorecon.sh
```

### チュートリアルディレクトリを$SUBJECTS_DIRに設定

```
### 1.1.2
cd $FSWS/subjects
SUBJECTS_DIR=$PWD
echo $SUBJECTS_DIR
```

### OAS2_0022のrecon-allの進捗状況ログの確認

```
### 1.1.3
cd $SUBJECTS_DIR/OAS2_0022/scripts
less recon-all-status.log
```

### recon-all-status.logを用いてエラーを検出する

```
### 1.1.4
cd $SUBJECTS_DIR
grep ERRORS */scripts/recon-all-status.log
```

## 第1部(2) Freeview/recon-allのQC

### FreeViewでvolumeデータを表示

- volumeデータはsubject名/mriの下に保存されている
- オプション
	- colormap=lut:	カラーマップに lut を利用
	- opacity=0.2: 不透明度を0.2に設定

```
### 1.2.1
cd $SUBJECTS_DIR
freeview -v \
  bert/mri/T1.mgz \
  bert/mri/wm.mgz \
  bert/mri/brainmask.mgz \
  bert/mri/aseg.mgz:colormap=lut:opacity=0.2

```

### FreeViewでsurfaceデータを表示

- surfaceデータはsubject名/surfの下に保存されている
- オプション
	- annot=aparc.annot: label/?h.aparc.annot を読み込む (?にはlかrが入る)
	- name=lh.pial_aparc: FreeViewに表示される名前
	- visible=0: 表示するチェックボックスをoffにする
	- overlay=lh.thickness: lh.thicknessを重ねあわせる
	- overlay_threshold=0.1,3: lh.thicknessの表示範囲
	- edgecolor=blue: 境界を青色で示す
	- --viewport 3d: 3次元表示の画面を左上に持ってくる

```
### 1.2.2
cd $SUBJECTS_DIR
freeview -f \
  bert/surf/lh.pial:annot=aparc.annot:name=lh.pial_aparc:visible=0 \
  bert/surf/lh.inflated:overlay=lh.thickness:overlay_threshold=0.1,3:name=lh.inflated_thickness:visible=0 \
  bert/surf/lh.inflated:visible=0 \
  bert/surf/lh.white:edgecolor=blue \
  bert/surf/lh.pial:edgecolor=red \
  --viewport 3d

```

### 画像のQC

```
### 1.2.3
SUBJECTS_DIR=$FSWS/subjects
cd $SUBJECTS_DIR
ls

fs_qc1_skullstrip.sh OAS2_0013
fs_qc2_aseg.sh OAS2_0013
fs_qc3_wm.sh OAS2_0013
fs_qc4_pial.sh OAS2_0013

```



### Freeviewで海馬のsubfieldを表示: 元画像空間に表示する場合

```
### 1.2.4
cd $FSWS/subjects/OAS2_0013/mri
freeview -v nu.mgz \
         -v lh.hippoSfLabels-T1.v10.mgz:colormap=lut \
         -v rh.hippoSfLabels-T1.v10.mgz:colormap=lut

```

### Freeviewで海馬のsubfieldを表示: FSの空間に表示する場合

```
### 1.2.5
freeview -v brainmask.mgz \
         -v lh.hippoSfLabels-T1.v10.FSvoxelSpace.mgz:colormap=lut \
         -v rh.hippoSfLabels-T1.v10.FSvoxelSpace.mgz:colormap=lut

```

### 海馬subfield解析で得られた海馬のsubfield容積の確認

```
### 1.2.6
echo "Left hippocampus" > hippoSfVolumes.txt
cat lh.hippoSfVolumes-T1.v10.txt >> hippoSfVolumes.txt
echo "" >> hippoSfVolumes.txt
echo "Right hippocampus" >> hippoSfVolumes.txt
cat rh.hippoSfVolumes-T1.v10.txt >> hippoSfVolumes.txt
less hippoSfVolumes.txt

```

## 第1部(3) ROI解析

### アトラスの違い
- Alt+cで表示順番を入れ替えることができる(MacはバグのためGUIで)
- オプション
	- --layout 1: 画面表示をパターン1(1画面だけ)にする

```
### 1.3.1
cd $SUBJECTS_DIR
freeview -f \
  bert/surf/lh.pial:annot=aparc.DKTatlas.annot:name=DKT \
  bert/surf/lh.pial:annot=aparc.a2009s.annot:name=Destrieux \
  bert/surf/lh.pial:annot=aparc.annot:name=Desikan-Killiany \
  --viewport 3d --layout 1

```

### aseg, aparc, LUTの関係 
- 読み込む画像および設定は以下の通り
	- orig.mgz: 元のMRIからボクセルサイズを1x1x1に統一した画像
	- aparc+aseg.mgz: DK atlasによるparcellationと皮質下segmentationの結果を統合した画像
	- lut: FreeSurfer用のLookup table
	- --layout 4: 画面表示をパターン4(左上を大きく、残り3つは右に縦に並べる)にする

```
### 1.3.2
cd $SUBJECTS_DIR
freeview \
-v \
  bert/mri/orig.mgz \
  bert/mri/aparc+aseg.mgz:colormap=lut:opacity=0.4 \
-f \
  bert/surf/lh.white:annot=aparc.annot \
--viewport coronal --layout 4

```

### チュートリアルディレクトリを$SUBJECT_DIRに設定

```
### 1.3.3
FSWS=~/git/fsws
export SUBJECTS_DIR=$FSWS/subjects
```

### asegstats2table

```
### 1.3.4
cd $SUBJECTS_DIR
asegstats2table \
  --subjects OAS2_0013 OAS2_0048 \
  --tablefile aseg.vol.txt

```

### asegstats2table の結果を転置

```
### 1.3.5
cd $SUBJECTS_DIR
asegstats2table \
  --subjects OAS2_0013 OAS2_0048 \
  --transpose \
  --tablefile aseg.vol.trans.txt

```

### aparcstats2table
- デフォルトはarea

```
### 1.3.6
cd $SUBJECTS_DIR
aparcstats2table \
  --hemi lh \
  --subjects OAS2_0013 OAS2_0048 \
  --tablefile lh.aparc.area.txt

```

### aparcstats2tableで、thicknessを求める
- --meas thickness を付け加えればよい

```
### 1.3.7
cd $SUBJECTS_DIR
aparcstats2table \
  --hemi lh \
  --subjects OAS2_0013 OAS2_0048 \
  --meas thickness \
  --tablefile lh.aparc.thickness.txt

```

-----

## 第2部(1,2) FreeSurferトラブルシューティング

**一度ターミナルを閉じて再度起動してください。**

### 変数FSWSの設定

```
FSWS=~/git/fsws
```

### チュートリアルディレクトリを$SUBJECTS_DIRに設定

```
### 2.0
cd $FSWS/subjects
SUBJECTS_DIR=$PWD
echo $SUBJECTS_DIR
```

### 脳抽出のマニュアル修正: 削りすぎ

- 修正前

```
### 2.1
cd $SUBJECTS_DIR
freeview -v skullstrip1_before/mri/T1.mgz \
  skullstrip1_before/mri/brainmask.mgz:colormap=heat:visible=false -f \
  skullstrip1_before/surf/lh.white:edgecolor=yellow \
  skullstrip1_before/surf/lh.pial:edgecolor=red \
  skullstrip1_before/surf/rh.white:edgecolor=yellow \
  skullstrip1_before/surf/rh.pial:edgecolor=red

```

- 修正後のrecon-all
    - brainmask volumeを編集し、軟膜surfaceを再度作りたい場合にこれを使う

```
recon-all -autorecon-pial -subjid skullstrip1_before
```

- 修正後

```
### 2.2
cd $SUBJECTS_DIR
freeview -v skullstrip1_after/mri/T1.mgz \
  skullstrip1_after/mri/brainmask.mgz:colormap=heat:visible=false -f \
  skullstrip1_after/surf/lh.white:edgecolor=yellow \
  skullstrip1_after/surf/lh.pial:edgecolor=red \
  skullstrip1_after/surf/rh.white:edgecolor=yellow \
  skullstrip1_after/surf/rh.pial:edgecolor=red

```

### 脳抽出のマニュアル修正:小脳以外へのはみ出し

- 修正前

```
### 2.3
cd $SUBJECTS_DIR
freeview -v pial_edits_before/mri/T1.mgz \
  pial_edits_before/mri/brainmask.mgz \
  -f pial_edits_before/surf/lh.white:edgecolor=yellow \
  pial_edits_before/surf/lh.pial:edgecolor=red \
  pial_edits_before/surf/rh.white:edgecolor=yellow \
  pial_edits_before/surf/rh.pial:edgecolor=red

```

- 修正後のrecon-all
    - この場合もbrainmask volumeを編集し、軟膜surfaceを再度作りたいので2.1と同じ

```
recon-all -autorecon-pial -subjid pial_edits_before
```

- 修正後

```
### 2.4
cd $SUBJECTS_DIR
freeview -v pial_edits_after/mri/T1.mgz \
  pial_edits_after/mri/brainmask.mgz \
  -f pial_edits_after/surf/lh.white:edgecolor=yellow \
  pial_edits_after/surf/lh.pial:edgecolor=red \
  pial_edits_after/surf/rh.white:edgecolor=yellow \
  pial_edits_after/surf/rh.pial:edgecolor=red

```

### 脳抽出の修正: 小脳へはみ出している場合



```
### 2.5
cd $SUBJECTS_DIR/bert/mri
cp brain.finalsurfs.mgz brain.finalsurfs.manedit.mgz
cd $SUBJECTS_DIR
freeview -v bert/mri/T1.mgz \
  bert/mri/brain.finalsurfs.manedit.mgz \
  -f bert/surf/lh.white:edgecolor=yellow \
  bert/surf/lh.pial:edgecolor=red \
  bert/surf/rh.white:edgecolor=yellow \
  bert/surf/rh.pial:edgecolor=red

```

### 白質の修正: 病変部位などの誤除外

- 修正前

```
### 2.6
cd $SUBJECTS_DIR
freeview -v wm3_edits_before/mri/brainmask.mgz \
  wm3_edits_before/mri/wm.mgz:colormap=heat:opacity=0.4 -f \
  wm3_edits_before/surf/lh.white:edgecolor=yellow \
  wm3_edits_before/surf/lh.pial:edgecolor=red \
  wm3_edits_before/surf/rh.white:edgecolor=yellow \
  wm3_edits_before/surf/rh.pial:edgecolor=red \
  wm3_edits_before/surf/rh.inflated:visible=0 \
  wm3_edits_before/surf/lh.inflated:visible=0

```

- 修正後のrecon-all
    - wmを編集し、final surfaceを再度作成したい場合は、以下を用いる

```
recon-all -autorecon2-wm -autorecon3 -subjid wm3_edits_before
```

- 修正後

```
### 2.7
cd $SUBJECTS_DIR
freeview -v wm3_edits_after/mri/brain.mgz \
  wm3_edits_after/mri/wm.mgz:colormap=heat:opacity=0.4 -f \
  wm3_edits_after/surf/lh.white:edgecolor=yellow \
  wm3_edits_after/surf/lh.pial:edgecolor=red \
  wm3_edits_after/surf/rh.white:edgecolor=yellow \
  wm3_edits_after/surf/rh.pial:edgecolor=red \
  wm3_edits_after/surf/rh.inflated:visible=0 \
  wm3_edits_after/surf/lh.inflated:visible=0

```

### 白質の修正: 信号むらなどによる誤除外-白質ボクセル追加による修正

- 修正前

```
### 2.8
cd $SUBJECTS_DIR
freeview -v topo_defect_before/mri/brainmask.mgz \
  topo_defect_before/mri/wm.mgz:colormap=heat:opacity=0.4:visible=0 -f \
  topo_defect_before/surf/lh.white:edgecolor=yellow \
  topo_defect_before/surf/lh.pial:edgecolor=red \
  topo_defect_before/surf/rh.white:edgecolor=yellow \
  topo_defect_before/surf/rh.pial:edgecolor=red \
  topo_defect_before/surf/lh.smoothwm.nofix:visible=0 

```

- 修正後のrecon-all
	- wmを編集し、final surfaceを再度作成したいので、病変部位などの誤除外と同様

```
recon-all -autorecon2-wm -autorecon3 -subjid topo_defect_before
```

- 修正後

```
### 2.9
cd $SUBJECTS_DIR
freeview -v topo_defect_after/mri/brainmask.mgz \
  topo_defect_after/mri/wm.mgz:colormap=heat:opacity=0.4:visible=0 -f \
  topo_defect_after/surf/lh.white:edgecolor=yellow \
  topo_defect_after/surf/lh.pial:edgecolor=red \
  topo_defect_after/surf/rh.white:edgecolor=yellow \
  topo_defect_after/surf/rh.pial:edgecolor=red \
  topo_defect_after/surf/lh.smoothwm.nofix:visible=0 

```

### 白質の修正:信号むらなどによる誤除外-コントロールポイントによる修正

- 修正前

```
### 2.10
cd $SUBJECTS_DIR
freeview -v cp_before/mri/brainmask.mgz -f \
  cp_before/surf/lh.white:edgecolor=yellow \
  cp_before/surf/lh.pial:edgecolor=red \
  cp_before/surf/rh.white:edgecolor=yellow \
  cp_before/surf/rh.pial:edgecolor=red

```

- 修正後のrecon-all
    - control pointを決めた後にfinal surfaceを再度作成したい場合は以下
    - 先ほどのautorecon2-wmとautorecon2-cpの違いに注意

```
recon-all -autorecon2-cp -autorecon3 -subjid cp_before
```

- 修正後

```
### 2.11
cd $SUBJECTS_DIR
freeview -v cp_after/mri/brainmask.mgz -f \
  cp_after/surf/lh.white:edgecolor=yellow \
  cp_after/surf/lh.pial:edgecolor=red \
  cp_after/surf/rh.white:edgecolor=yellow \
  cp_after/surf/rh.pial:edgecolor=red

```

-----


## 第3部(1) Qdecを用いたグループ解析

### チュートリアルディレクトリを$SUBJECT_DIRに設定

```
### 3.1.1
FSWS=~/git/fsws
export SUBJECTS_DIR=$FSWS/subjects
```


### qdec.table.dat の内容を確認

```
### 3.1.2
cd $SUBJECTS_DIR/qdec
cat qdec.table.dat

```

### qdecの起動

```
### 3.1.3
cd $SUBJECTS_DIR
qdec &
```

## 第3部(2) コマンドラインを用いたグループ解析

### チュートリアルディレクトリを$SUBJECT_DIRに設定

```
### 3.2.1
FSWS=~/git/fsws
export SUBJECTS_DIR=$FSWS/subjects
```

### recon-all -qcache の生成物の確認

```
### 3.2.2
cd $SUBJECTS_DIR
cd OAS2_0013/surf
ls lh*.log

```

```
### 3.2.3
ls lh.thickness.fwhm*

```

### g1v1モデルにおけるFSGDファイル

```
### 3.2.4
cd $SUBJECTS_DIR/glm
cat g1v1.fsgd

```

### g1v1モデルにおけるmris_preproc

```
### 3.2.5
mris_preproc \
 --fsgd g1v1.fsgd \
 --cache-in thickness.fwhm10.fsaverage \
 --target fsaverage \
 --hemi lh \
 --out lh.age.thickness.10.mgh
```

### g1v1モデルにおけるmri_glmfit

```
### 3.2.6
mri_glmfit --y lh.age.thickness.10.mgh \
 --fsgd g1v1.fsgd dods \
 --C g1v1_v.mtx \
 --surf fsaverage lh \
 --cortex \
 --glmdir lh.age.glmdir
```

### 統計結果をFreeviewで確認

```
### 3.2.7
cd $SUBJECTS_DIR
freeview -f \
$SUBJECTS_DIR/fsaverage/surf/lh.inflated:overlay=$SUBJECTS_DIR/glm/lh.age.glmdir/g1v1_v/sig.mgh:overlay_threshold=2,5 -viewport 3d
```


### g2v0モデルにおけるFSGDファイル

```
### 3.2.8
cd $SUBJECTS_DIR/glm
cat g2v0.fsgd

```

### g2v0モデルにおけるmris_preproc

```
### 3.2.9
mris_preproc \
 --fsgd g2v0.fsgd \
 --cache-in thickness.fwhm10.fsaverage \
 --target fsaverage \
 --hemi lh \
 --out lh.dx.thickness.10.mgh
```

### g2v0.mtxファイルの修正
g2v0.mtxに空行が入ってしまっているため、このままだとエラーが出ます。
この問題を修復します。

```
### 3.2.10.0
sed -i '/^$/d' g2v0.mtx
```

### g2v0モデルにおけるmri_glmfit

```
### 3.2.10
mri_glmfit --y lh.dx.thickness.10.mgh \
 --fsgd g2v0.fsgd dods \
 --C g2v0.mtx \
 --surf fsaverage lh \
 --cortex \
 --glmdir lh.dx.glmdir
```

### 統計結果をFreeviewで確認

```
### 3.2.11
cd $SUBJECTS_DIR
freeview -f \
$SUBJECTS_DIR/fsaverage/surf/lh.inflated:overlay=$SUBJECTS_DIR/glm/lh.dx.glmdir/g2v0/sig.mgh:overlay_threshold=2,5 -viewport 3d
```


### g2v1モデルにおけるFSGDファイル

```
### 3.2.12
cd $SUBJECTS_DIR/glm
cat g2v1.fsgd

```

### g2v1モデルにおけるmris_preproc

```
### 3.2.13
mris_preproc \
 --fsgd g2v1.fsgd \
 --cache-in thickness.fwhm10.fsaverage \
 --target fsaverage \
 --hemi lh \
 --out lh.age_dx.thickness.10.mgh
```

### g2v1モデルにおけるmri_glmfit

```
### 3.2.14
mri_glmfit --y lh.age_dx.thickness.10.mgh \
 --fsgd g2v1.fsgd dods \
 --C g2v1_g.mtx \
 --C g2v1_gxv.mtx \
 --C g2v1_main_g.mtx \
 --C g2v1_main_v.mtx \
 --surf fsaverage lh \
 --cortex \
 --glmdir lh.age_dx.glmdir
```

### 統計結果をFreeviewで確認

```
### 3.2.15
cd $SUBJECTS_DIR
freeview -f \
$SUBJECTS_DIR/fsaverage/surf/lh.inflated:overlay=$SUBJECTS_DIR/glm/lh.age_dx.glmdir/g2v1_gxv/sig.mgh:overlay_threshold=2,5 -viewport 3d
```

