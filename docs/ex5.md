# FreeSurfer勉強会

## 第2部(1) ROI解析

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


### asegstats2table

```
========================================
cd $SUBJECTS_DIR
asegstats2table \
 --subjects OAS2_0013 OAS2_0048 \
 --delimiter=comma \
 --tablefile aseg.vol.csv
========================================
```

- subject は OAS2_0013 と OAS2_0048, カンマ区切りで 出力ファイル名を aseg.vol.csv としています。

### aseg.vol.csv

```
========================================
asegstats2table \
 --subjects OAS2_0013 OAS2_0048 \
 --delimiter=comma \
 --transpose \
 --tablefile aseg.vol.trans.csv
========================================
```

- --transpose で結果の行列を転置します。


### fs_stats_aseg.sh


```
========================================
fs_stats_aseg.sh OAS2_*MR[12]
open tables
========================================
```

- OAS2_*MR[12] は、OAS2_ ではじまって、途中、任意の文字列が続き、最後にMR1かMR2で終わるということを意味します。
- open tables で、tablesディレクトリをGUIで開くという意味になります。

### fs_stats_aseg_trans.sh

```
========================================
fs_stats_aseg_trans.sh OAS2_*MR[12]
open tables
========================================
```


### aparcstats2table

```
========================================
aparcstats2table --hemi lh \
 --subjects OAS2_0013 OAS2_0048 \
 --delimiter=comma \
 --table lh.aparc.area.csv
========================================
```

- --hemi lh で左半球を意味します。


### aparcstats2table: thicknessの計算

```
========================================
aparcstats2table --hemi lh \
 --subjects OAS2_0013 OAS2_0048 \
 --delimiter=comma \
 --meas thickness \
 --table lh.aparc.thickness.csv
========================================
```


### fs_stats_aparc.sh

```
========================================
fs_stats_aparc.sh OAS2_*MR[12]
open tables
========================================
```


### fs_stats_aparc_trans.sh

```
========================================
fs_stats_aparc_trans.sh OAS2_*MR[12]
open tables
========================================
```


### 海馬subfield容積の確認

```
========================================
cd $SUBJECTS_DIR/ernie/mri
cat lh.hippoSfVolumes-T1.v10.txt
========================================
```

### quantifyHippocampalSubfields.sh

```
========================================
quantifyHippocampalSubfields.sh T1 hipposf.txt
========================================
```


### fs_stats_hipposf.sh

```
========================================
cd $SUBJECTS_DIR
fs_stats_hipposf.sh OAS2_*MR1
open tables
========================================
```


### fs_stats_hipposf_trans.sh

```
========================================
fs_stats_hipposf_trans.sh OAS2_*MR1
open tables
========================================
```


### 脳幹構造の容積の確認

```
========================================
cd $SUBJECTS_DIR/ernie/mri
cat brainstemSsVolumes.v10.txt
========================================
```


### quantifyBrainstemStructures.sh

```
========================================
quantifyBrainstemStructures.sh brainstem.txt
========================================
```

