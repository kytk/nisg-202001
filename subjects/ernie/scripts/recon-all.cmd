

#---------------------------------
# New invocation of recon-all Mon Dec 30 20:03:28 JST 2019 

 mri_convert /home/brain/freesurfer/subjects/sample-001.mgz /home/brain/freesurfer/subjects/ernie/mri/orig/001.mgz 


 mri_convert /home/brain/freesurfer/subjects/sample-002.mgz /home/brain/freesurfer/subjects/ernie/mri/orig/002.mgz 

#--------------------------------------------
#@# MotionCor Mon Dec 30 20:03:36 JST 2019

 mri_robust_template --mov /home/brain/freesurfer/subjects/ernie/mri/orig/001.mgz /home/brain/freesurfer/subjects/ernie/mri/orig/002.mgz --average 1 --template /home/brain/freesurfer/subjects/ernie/mri/rawavg.mgz --satit --inittp 1 --fixtp --noit --iscale --iscaleout /home/brain/freesurfer/subjects/ernie/mri/orig/001-iscale.txt /home/brain/freesurfer/subjects/ernie/mri/orig/002-iscale.txt --subsample 200 --lta /home/brain/freesurfer/subjects/ernie/mri/orig/001.lta /home/brain/freesurfer/subjects/ernie/mri/orig/002.lta 


 mri_convert /home/brain/freesurfer/subjects/ernie/mri/rawavg.mgz /home/brain/freesurfer/subjects/ernie/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /home/brain/freesurfer/subjects/ernie/mri/transforms/talairach.xfm /home/brain/freesurfer/subjects/ernie/mri/orig.mgz /home/brain/freesurfer/subjects/ernie/mri/orig.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 20:06:17 JST 2019 
#--------------------------------------------
#@# Talairach Mon Dec 30 20:06:17 JST 2019

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 



#---------------------------------
# New invocation of recon-all Mon Dec 30 20:07:56 JST 2019 
#--------------------------------------------
#@# Nu Intensity Correction Mon Dec 30 20:07:57 JST 2019

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 


 mri_add_xform_to_header -c /home/brain/freesurfer/subjects/ernie/mri/transforms/talairach.xfm nu.mgz nu.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 20:09:59 JST 2019 
#--------------------------------------------
#@# Intensity Normalization Mon Dec 30 20:10:00 JST 2019

 mri_normalize -g 1 -mprage nu.mgz T1.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 20:12:13 JST 2019 
#--------------------------------------------
#@# Skull Stripping Mon Dec 30 20:12:14 JST 2019

 mri_em_register -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mri_em_register.skull.dat -skull nu.mgz /usr/local/freesurfer/average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta 


 mri_watershed -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mri_watershed.dat -T1 -brain_atlas /usr/local/freesurfer/average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta T1.mgz brainmask.auto.mgz 


 cp brainmask.auto.mgz brainmask.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 20:32:09 JST 2019 
#-------------------------------------
#@# EM Registration Mon Dec 30 20:32:10 JST 2019

 mri_em_register -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mri_em_register.dat -uns 3 -mask brainmask.mgz nu.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta 



#---------------------------------
# New invocation of recon-all Mon Dec 30 20:50:38 JST 2019 
#--------------------------------------
#@# CA Normalize Mon Dec 30 20:50:38 JST 2019

 mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta norm.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 20:51:47 JST 2019 
#--------------------------------------
#@# CA Reg Mon Dec 30 20:51:47 JST 2019

 mri_ca_register -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mri_ca_register.dat -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.m3z 



#---------------------------------
# New invocation of recon-all Mon Dec 30 22:43:07 JST 2019 
#--------------------------------------
#@# SubCort Seg Mon Dec 30 22:43:07 JST 2019

 mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca aseg.auto_noCCseg.mgz 


 mri_cc -aseg aseg.auto_noCCseg.mgz -o aseg.auto.mgz -lta /home/brain/freesurfer/subjects/ernie/mri/transforms/cc_up.lta ernie 

#--------------------------------------
#@# Merge ASeg Mon Dec 30 23:25:50 JST 2019

 cp aseg.auto.mgz aseg.presurf.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 23:25:50 JST 2019 
#--------------------------------------------
#@# Intensity Normalization2 Mon Dec 30 23:25:50 JST 2019

 mri_normalize -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 23:28:27 JST 2019 
#--------------------------------------------
#@# Mask BFS Mon Dec 30 23:28:27 JST 2019

 mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 23:28:29 JST 2019 
#--------------------------------------------
#@# WM Segmentation Mon Dec 30 23:28:29 JST 2019

 mri_segment -mprage brain.mgz wm.seg.mgz 


 mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz 


 mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 23:30:03 JST 2019 
#--------------------------------------------
#@# Fill Mon Dec 30 23:30:04 JST 2019

 mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.auto_noCCseg.mgz wm.mgz filled.mgz 



#---------------------------------
# New invocation of recon-all Mon Dec 30 23:30:33 JST 2019 
#--------------------------------------------
#@# Tessellate lh Mon Dec 30 23:30:33 JST 2019

 mri_pretess ../mri/filled.mgz 255 ../mri/norm.mgz ../mri/filled-pretess255.mgz 


 mri_tessellate ../mri/filled-pretess255.mgz 255 ../surf/lh.orig.nofix 


 rm -f ../mri/filled-pretess255.mgz 


 mris_extract_main_component ../surf/lh.orig.nofix ../surf/lh.orig.nofix 

#--------------------------------------------
#@# Tessellate rh Mon Dec 30 23:30:39 JST 2019

 mri_pretess ../mri/filled.mgz 127 ../mri/norm.mgz ../mri/filled-pretess127.mgz 


 mri_tessellate ../mri/filled-pretess127.mgz 127 ../surf/rh.orig.nofix 


 rm -f ../mri/filled-pretess127.mgz 


 mris_extract_main_component ../surf/rh.orig.nofix ../surf/rh.orig.nofix 



#---------------------------------
# New invocation of recon-all Mon Dec 30 23:30:43 JST 2019 
#--------------------------------------------
#@# Smooth1 lh Mon Dec 30 23:30:44 JST 2019

 mris_smooth -nw -seed 1234 ../surf/lh.orig.nofix ../surf/lh.smoothwm.nofix 

#--------------------------------------------
#@# Smooth1 rh Mon Dec 30 23:30:48 JST 2019

 mris_smooth -nw -seed 1234 ../surf/rh.orig.nofix ../surf/rh.smoothwm.nofix 



#---------------------------------
# New invocation of recon-all Mon Dec 30 23:30:52 JST 2019 
#--------------------------------------------
#@# Inflation1 lh Mon Dec 30 23:30:53 JST 2019

 mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix 

#--------------------------------------------
#@# Inflation1 rh Mon Dec 30 23:31:25 JST 2019

 mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix 



#---------------------------------
# New invocation of recon-all Mon Dec 30 23:31:58 JST 2019 
#--------------------------------------------
#@# QSphere lh Mon Dec 30 23:31:59 JST 2019

 mris_sphere -q -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix 

#--------------------------------------------
#@# QSphere rh Mon Dec 30 23:35:55 JST 2019

 mris_sphere -q -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix 



#---------------------------------
# New invocation of recon-all Mon Dec 30 23:39:30 JST 2019 
#--------------------------------------------
#@# Fix Topology Copy lh Mon Dec 30 23:39:30 JST 2019

 cp ../surf/lh.orig.nofix ../surf/lh.orig 


 cp ../surf/lh.inflated.nofix ../surf/lh.inflated 

#--------------------------------------------
#@# Fix Topology Copy rh Mon Dec 30 23:39:30 JST 2019

 cp ../surf/rh.orig.nofix ../surf/rh.orig 


 cp ../surf/rh.inflated.nofix ../surf/rh.inflated 

#@# Fix Topology lh Mon Dec 30 23:39:30 JST 2019

 mris_fix_topology -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mris_fix_topology.lh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 ernie lh 

#@# Fix Topology rh Mon Dec 30 23:51:32 JST 2019

 mris_fix_topology -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mris_fix_topology.rh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 ernie rh 


 mris_euler_number ../surf/lh.orig 


 mris_euler_number ../surf/rh.orig 


 mris_remove_intersection ../surf/lh.orig ../surf/lh.orig 


 rm ../surf/lh.inflated 


 mris_remove_intersection ../surf/rh.orig ../surf/rh.orig 


 rm ../surf/rh.inflated 



#---------------------------------
# New invocation of recon-all Tue Dec 31 00:09:12 JST 2019 
#--------------------------------------------
#@# Make White Surf lh Tue Dec 31 00:09:13 JST 2019

 mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -mgz -T1 brain.finalsurfs ernie lh 

#--------------------------------------------
#@# Make White Surf rh Tue Dec 31 00:20:46 JST 2019

 mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -mgz -T1 brain.finalsurfs ernie rh 



#---------------------------------
# New invocation of recon-all Tue Dec 31 00:32:07 JST 2019 
#--------------------------------------------
#@# Smooth2 lh Tue Dec 31 00:32:08 JST 2019

 mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm 

#--------------------------------------------
#@# Smooth2 rh Tue Dec 31 00:32:12 JST 2019

 mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm 



#---------------------------------
# New invocation of recon-all Tue Dec 31 00:32:18 JST 2019 
#--------------------------------------------
#@# Inflation2 lh Tue Dec 31 00:32:19 JST 2019

 mris_inflate -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mris_inflate.lh.dat ../surf/lh.smoothwm ../surf/lh.inflated 

#--------------------------------------------
#@# Inflation2 rh Tue Dec 31 00:32:54 JST 2019

 mris_inflate -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mris_inflate.rh.dat ../surf/rh.smoothwm ../surf/rh.inflated 



#---------------------------------
# New invocation of recon-all Tue Dec 31 00:33:28 JST 2019 
#--------------------------------------------
#@# Curv .H and .K lh Tue Dec 31 00:33:29 JST 2019

 mris_curvature -w lh.white.preaparc 


 mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated 

#--------------------------------------------
#@# Curv .H and .K rh Tue Dec 31 00:34:39 JST 2019

 mris_curvature -w rh.white.preaparc 


 mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated 



#---------------------------------
# New invocation of recon-all Tue Dec 31 00:35:44 JST 2019 

#-----------------------------------------
#@# Curvature Stats lh Tue Dec 31 00:35:44 JST 2019

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm ernie lh curv sulc 


#-----------------------------------------
#@# Curvature Stats rh Tue Dec 31 00:35:47 JST 2019

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm ernie rh curv sulc 



#---------------------------------
# New invocation of recon-all Tue Dec 31 00:35:50 JST 2019 
#--------------------------------------------
#@# Sphere lh Tue Dec 31 00:35:51 JST 2019

 mris_sphere -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mris_sphere.lh.dat -seed 1234 ../surf/lh.inflated ../surf/lh.sphere 

#--------------------------------------------
#@# Sphere rh Tue Dec 31 01:17:25 JST 2019

 mris_sphere -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mris_sphere.rh.dat -seed 1234 ../surf/rh.inflated ../surf/rh.sphere 



#---------------------------------
# New invocation of recon-all Tue Dec 31 02:00:42 JST 2019 
#--------------------------------------------
#@# Surf Reg lh Tue Dec 31 02:00:42 JST 2019

 mris_register -curv -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mris_register.lh.dat ../surf/lh.sphere /usr/local/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/lh.sphere.reg 

#--------------------------------------------
#@# Surf Reg rh Tue Dec 31 02:50:24 JST 2019

 mris_register -curv -rusage /home/brain/freesurfer/subjects/ernie/touch/rusage.mris_register.rh.dat ../surf/rh.sphere /usr/local/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/rh.sphere.reg 



#---------------------------------
# New invocation of recon-all Tue Dec 31 03:41:50 JST 2019 
#--------------------------------------------
#@# Jacobian white lh Tue Dec 31 03:41:50 JST 2019

 mris_jacobian ../surf/lh.white.preaparc ../surf/lh.sphere.reg ../surf/lh.jacobian_white 

#--------------------------------------------
#@# Jacobian white rh Tue Dec 31 03:41:52 JST 2019

 mris_jacobian ../surf/rh.white.preaparc ../surf/rh.sphere.reg ../surf/rh.jacobian_white 



#---------------------------------
# New invocation of recon-all Tue Dec 31 03:41:53 JST 2019 
#--------------------------------------------
#@# AvgCurv lh Tue Dec 31 03:41:54 JST 2019

 mrisp_paint -a 5 /usr/local/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/lh.sphere.reg ../surf/lh.avg_curv 

#--------------------------------------------
#@# AvgCurv rh Tue Dec 31 03:41:55 JST 2019

 mrisp_paint -a 5 /usr/local/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/rh.sphere.reg ../surf/rh.avg_curv 



#---------------------------------
# New invocation of recon-all Tue Dec 31 03:41:57 JST 2019 
#-----------------------------------------
#@# Cortical Parc lh Tue Dec 31 03:41:57 JST 2019

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 ernie lh ../surf/lh.sphere.reg /usr/local/freesurfer/average/lh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.annot 

#-----------------------------------------
#@# Cortical Parc rh Tue Dec 31 03:42:08 JST 2019

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 ernie rh ../surf/rh.sphere.reg /usr/local/freesurfer/average/rh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.annot 



#---------------------------------
# New invocation of recon-all Tue Dec 31 03:42:18 JST 2019 
#--------------------------------------------
#@# Make Pial Surf lh Tue Dec 31 03:42:19 JST 2019

 mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs ernie lh 

#--------------------------------------------
#@# Make Pial Surf rh Tue Dec 31 03:52:48 JST 2019

 mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs ernie rh 

#--------------------------------------------
#@# Surf Volume lh Tue Dec 31 04:03:27 JST 2019
#--------------------------------------------
#@# Surf Volume rh Tue Dec 31 04:03:29 JST 2019


#---------------------------------
# New invocation of recon-all Tue Dec 31 04:03:32 JST 2019 
#--------------------------------------------
#@# Cortical ribbon mask Tue Dec 31 04:03:32 JST 2019

 mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon ernie 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:15:37 JST 2019 
#-----------------------------------------
#@# Parcellation Stats lh Tue Dec 31 04:15:38 JST 2019

 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab ernie lh white 


 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.pial.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab ernie lh pial 

#-----------------------------------------
#@# Parcellation Stats rh Tue Dec 31 04:16:36 JST 2019

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab ernie rh white 


 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.pial.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab ernie rh pial 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:17:33 JST 2019 
#-----------------------------------------
#@# Cortical Parc 2 lh Tue Dec 31 04:17:33 JST 2019

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 ernie lh ../surf/lh.sphere.reg /usr/local/freesurfer/average/lh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.a2009s.annot 

#-----------------------------------------
#@# Cortical Parc 2 rh Tue Dec 31 04:17:47 JST 2019

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 ernie rh ../surf/rh.sphere.reg /usr/local/freesurfer/average/rh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.a2009s.annot 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:18:01 JST 2019 
#-----------------------------------------
#@# Parcellation Stats 2 lh Tue Dec 31 04:18:01 JST 2019

 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.a2009s.stats -b -a ../label/lh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab ernie lh white 

#-----------------------------------------
#@# Parcellation Stats 2 rh Tue Dec 31 04:18:32 JST 2019

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.a2009s.stats -b -a ../label/rh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab ernie rh white 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:19:02 JST 2019 
#-----------------------------------------
#@# Cortical Parc 3 lh Tue Dec 31 04:19:03 JST 2019

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 ernie lh ../surf/lh.sphere.reg /usr/local/freesurfer/average/lh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.DKTatlas.annot 

#-----------------------------------------
#@# Cortical Parc 3 rh Tue Dec 31 04:19:14 JST 2019

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 ernie rh ../surf/rh.sphere.reg /usr/local/freesurfer/average/rh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.DKTatlas.annot 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:19:25 JST 2019 
#-----------------------------------------
#@# Parcellation Stats 3 lh Tue Dec 31 04:19:25 JST 2019

 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.DKTatlas.stats -b -a ../label/lh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab ernie lh white 

#-----------------------------------------
#@# Parcellation Stats 3 rh Tue Dec 31 04:19:54 JST 2019

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.DKTatlas.stats -b -a ../label/rh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab ernie rh white 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:20:22 JST 2019 
#-----------------------------------------
#@# WM/GM Contrast lh Tue Dec 31 04:20:23 JST 2019

 pctsurfcon --s ernie --lh-only 

#-----------------------------------------
#@# WM/GM Contrast rh Tue Dec 31 04:20:27 JST 2019

 pctsurfcon --s ernie --rh-only 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:20:32 JST 2019 
#-----------------------------------------
#@# Relabel Hypointensities Tue Dec 31 04:20:32 JST 2019

 mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:20:48 JST 2019 
#-----------------------------------------
#@# AParc-to-ASeg aparc Tue Dec 31 04:20:49 JST 2019

 mri_aparc2aseg --s ernie --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt 

#-----------------------------------------
#@# AParc-to-ASeg a2009s Tue Dec 31 04:24:45 JST 2019

 mri_aparc2aseg --s ernie --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --a2009s 

#-----------------------------------------
#@# AParc-to-ASeg DKTatlas Tue Dec 31 04:28:50 JST 2019

 mri_aparc2aseg --s ernie --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --annot aparc.DKTatlas --o mri/aparc.DKTatlas+aseg.mgz 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:32:54 JST 2019 
#-----------------------------------------
#@# APas-to-ASeg Tue Dec 31 04:32:55 JST 2019

 apas2aseg --i aparc+aseg.mgz --o aseg.mgz 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:33:01 JST 2019 
#--------------------------------------------
#@# ASeg Stats Tue Dec 31 04:33:02 JST 2019

 mri_segstats --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /usr/local/freesurfer/ASegStatsLUT.txt --subject ernie 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:36:06 JST 2019 
#-----------------------------------------
#@# WMParc Tue Dec 31 04:36:06 JST 2019

 mri_aparc2aseg --s ernie --labelwm --hypo-as-wm --rip-unknown --volmask --o mri/wmparc.mgz --ctxseg aparc+aseg.mgz 


 mri_segstats --seg mri/wmparc.mgz --sum stats/wmparc.stats --pv mri/norm.mgz --excludeid 0 --brainmask mri/brainmask.mgz --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --subject ernie --surf-wm-vol --ctab /usr/local/freesurfer/WMParcStatsLUT.txt --etiv 



#---------------------------------
# New invocation of recon-all Tue Dec 31 04:45:40 JST 2019 
#--------------------------------------------
#@# BA_exvivo Labels lh Tue Dec 31 04:45:41 JST 2019

 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA1_exvivo.label --trgsubject ernie --trglabel ./lh.BA1_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA2_exvivo.label --trgsubject ernie --trglabel ./lh.BA2_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA3a_exvivo.label --trgsubject ernie --trglabel ./lh.BA3a_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA3b_exvivo.label --trgsubject ernie --trglabel ./lh.BA3b_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA4a_exvivo.label --trgsubject ernie --trglabel ./lh.BA4a_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA4p_exvivo.label --trgsubject ernie --trglabel ./lh.BA4p_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA6_exvivo.label --trgsubject ernie --trglabel ./lh.BA6_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA44_exvivo.label --trgsubject ernie --trglabel ./lh.BA44_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA45_exvivo.label --trgsubject ernie --trglabel ./lh.BA45_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.V1_exvivo.label --trgsubject ernie --trglabel ./lh.V1_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.V2_exvivo.label --trgsubject ernie --trglabel ./lh.V2_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.MT_exvivo.label --trgsubject ernie --trglabel ./lh.MT_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.entorhinal_exvivo.label --trgsubject ernie --trglabel ./lh.entorhinal_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.perirhinal_exvivo.label --trgsubject ernie --trglabel ./lh.perirhinal_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA1_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.BA1_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA2_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.BA2_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA3a_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.BA3a_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA3b_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.BA3b_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA4a_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.BA4a_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA4p_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.BA4p_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA6_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.BA6_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA44_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.BA44_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.BA45_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.BA45_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.V1_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.V1_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.V2_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.V2_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.MT_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.MT_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.entorhinal_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.entorhinal_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/lh.perirhinal_exvivo.thresh.label --trgsubject ernie --trglabel ./lh.perirhinal_exvivo.thresh.label --hemi lh --regmethod surface 


 mris_label2annot --s ernie --hemi lh --ctab /usr/local/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.label --l lh.BA2_exvivo.label --l lh.BA3a_exvivo.label --l lh.BA3b_exvivo.label --l lh.BA4a_exvivo.label --l lh.BA4p_exvivo.label --l lh.BA6_exvivo.label --l lh.BA44_exvivo.label --l lh.BA45_exvivo.label --l lh.V1_exvivo.label --l lh.V2_exvivo.label --l lh.MT_exvivo.label --l lh.entorhinal_exvivo.label --l lh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose 


 mris_label2annot --s ernie --hemi lh --ctab /usr/local/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.thresh.label --l lh.BA2_exvivo.thresh.label --l lh.BA3a_exvivo.thresh.label --l lh.BA3b_exvivo.thresh.label --l lh.BA4a_exvivo.thresh.label --l lh.BA4p_exvivo.thresh.label --l lh.BA6_exvivo.thresh.label --l lh.BA44_exvivo.thresh.label --l lh.BA45_exvivo.thresh.label --l lh.V1_exvivo.thresh.label --l lh.V2_exvivo.thresh.label --l lh.MT_exvivo.thresh.label --l lh.entorhinal_exvivo.thresh.label --l lh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose 


 mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.stats -b -a ./lh.BA_exvivo.annot -c ./BA_exvivo.ctab ernie lh white 


 mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.thresh.stats -b -a ./lh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab ernie lh white 

#--------------------------------------------
#@# BA_exvivo Labels rh Tue Dec 31 04:49:30 JST 2019

 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA1_exvivo.label --trgsubject ernie --trglabel ./rh.BA1_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA2_exvivo.label --trgsubject ernie --trglabel ./rh.BA2_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA3a_exvivo.label --trgsubject ernie --trglabel ./rh.BA3a_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA3b_exvivo.label --trgsubject ernie --trglabel ./rh.BA3b_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA4a_exvivo.label --trgsubject ernie --trglabel ./rh.BA4a_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA4p_exvivo.label --trgsubject ernie --trglabel ./rh.BA4p_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA6_exvivo.label --trgsubject ernie --trglabel ./rh.BA6_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA44_exvivo.label --trgsubject ernie --trglabel ./rh.BA44_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA45_exvivo.label --trgsubject ernie --trglabel ./rh.BA45_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.V1_exvivo.label --trgsubject ernie --trglabel ./rh.V1_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.V2_exvivo.label --trgsubject ernie --trglabel ./rh.V2_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.MT_exvivo.label --trgsubject ernie --trglabel ./rh.MT_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.entorhinal_exvivo.label --trgsubject ernie --trglabel ./rh.entorhinal_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.perirhinal_exvivo.label --trgsubject ernie --trglabel ./rh.perirhinal_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA1_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.BA1_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA2_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.BA2_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA3a_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.BA3a_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA3b_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.BA3b_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA4a_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.BA4a_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA4p_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.BA4p_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA6_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.BA6_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA44_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.BA44_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.BA45_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.BA45_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.V1_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.V1_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.V2_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.V2_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.MT_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.MT_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.entorhinal_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.entorhinal_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /home/brain/freesurfer/subjects/fsaverage/label/rh.perirhinal_exvivo.thresh.label --trgsubject ernie --trglabel ./rh.perirhinal_exvivo.thresh.label --hemi rh --regmethod surface 


 mris_label2annot --s ernie --hemi rh --ctab /usr/local/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.label --l rh.BA2_exvivo.label --l rh.BA3a_exvivo.label --l rh.BA3b_exvivo.label --l rh.BA4a_exvivo.label --l rh.BA4p_exvivo.label --l rh.BA6_exvivo.label --l rh.BA44_exvivo.label --l rh.BA45_exvivo.label --l rh.V1_exvivo.label --l rh.V2_exvivo.label --l rh.MT_exvivo.label --l rh.entorhinal_exvivo.label --l rh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose 


 mris_label2annot --s ernie --hemi rh --ctab /usr/local/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.thresh.label --l rh.BA2_exvivo.thresh.label --l rh.BA3a_exvivo.thresh.label --l rh.BA3b_exvivo.thresh.label --l rh.BA4a_exvivo.thresh.label --l rh.BA4p_exvivo.thresh.label --l rh.BA6_exvivo.thresh.label --l rh.BA44_exvivo.thresh.label --l rh.BA45_exvivo.thresh.label --l rh.V1_exvivo.thresh.label --l rh.V2_exvivo.thresh.label --l rh.MT_exvivo.thresh.label --l rh.entorhinal_exvivo.thresh.label --l rh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose 


 mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.stats -b -a ./rh.BA_exvivo.annot -c ./BA_exvivo.ctab ernie rh white 


 mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.thresh.stats -b -a ./rh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab ernie rh white 



#---------------------------------
# New invocation of recon-all Sat Jan  4 13:10:30 JST 2020 
#--------------------------------------------
#@# Hippocampal Subfields processing (T1 only) left Sat Jan  4 13:10:33 JST 2020

 /usr/local/freesurfer/bin/segmentSF_T1.sh /usr/local/freesurfer/MCRv80 /usr/local/freesurfer ernie /media/sf_share/subjects left 

See log file: /media/sf_share/subjects/ernie/scripts/hippocampal-subfields-T1.log
#--------------------------------------------
#@# Hippocampal Subfields processing (T1 only) right Sat Jan  4 13:31:42 JST 2020

 /usr/local/freesurfer/bin/segmentSF_T1.sh /usr/local/freesurfer/MCRv80 /usr/local/freesurfer ernie /media/sf_share/subjects right 

See log file: /media/sf_share/subjects/ernie/scripts/hippocampal-subfields-T1.log


#---------------------------------
# New invocation of recon-all Sat Jan  4 14:08:42 JST 2020 
#--------------------------------------------
#@# Segmentation of brainstem substructures  Sat Jan  4 14:08:45 JST 2020

 /usr/local/freesurfer/bin/segmentBS.sh /usr/local/freesurfer/MCRv80 /usr/local/freesurfer ernie /media/sf_share/subjects 

See log file: /media/sf_share/subjects/ernie/scripts/brainstem-structures.log
