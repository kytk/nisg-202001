#!/bin/bash

SUBJECTS_DIR=$PWD

freeview -v \
  $SUBJECTS_DIR/OAS2_0013/mri/T1.mgz \
  $SUBJECTS_DIR/OAS2_0013/mri/wm.mgz \
  $SUBJECTS_DIR/OAS2_0013/mri/brainmask.mgz \
  $SUBJECTS_DIR/OAS2_0013/mri/aseg.mgz:colormap=lut:opacity=0.2 \
  -f \
  $SUBJECTS_DIR/OAS2_0013/surf/lh.pial:annot=aparc.annot:name=lh.pial_aparc:visible=0 \
  $SUBJECTS_DIR/OAS2_0013/surf/rh.pial:annot=aparc.annot:name=rh.pial_aparc:visible=0 \
  $SUBJECTS_DIR/OAS2_0013/surf/lh.inflated:overlay=lh.thickness:overlay_threshold=0.1,3::name=lh.inflated_thickness:visible=0 \
  $SUBJECTS_DIR/OAS2_0013/surf/rh.inflated:overlay=rh.thickness:overlay_threshold=0.1,3::name=rh.inflated_thickness:visible=0 \
  $SUBJECTS_DIR/OAS2_0013/surf/lh.inflated:visible=0 \
  $SUBJECTS_DIR/OAS2_0013/surf/rh.inflated:visible=0 \
  $SUBJECTS_DIR/OAS2_0013/surf/lh.white:visible=0 \
  $SUBJECTS_DIR/OAS2_0013/surf/rh.white:visible=0 \
  $SUBJECTS_DIR/OAS2_0013/surf/lh.pial \
  $SUBJECTS_DIR/OAS2_0013/surf/rh.pial \
  --layout 2 --viewport 3d &
