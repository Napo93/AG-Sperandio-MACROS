

//Macro for LFA-1 nanocluster and subcellular Ca2+ analysis: change WT to Mrp14-/- depending on the group being analyzed


//Start//

run("Options...", "iterations=1 count=1 black");

inputImageName = getTitle();
originalImage = inputImageName;
rename(originalImage);

run("Split Channels");

Calcium = "C1-" + originalImage;
LFA1 = "C3-" + originalImage;
Lyz2 = "C2-" + originalImage

close(Lyz2);

selectWindow(LFA1);

//Auto Thresholding//Segmentation of LFA-1 channel for LFA-1 mask

run("Duplicate...", "duplicate");

run("Auto Threshold", "method=MaxEntropy white stack");

//Particle analyzer//define LFA-1 nanoclusters by size thresholding

run("Analyze Particles...", "size=0.15-Infinity show=Outlines display add in_situ stack");

saveAs("Results", "C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Analysis/WT/20200922/FC3/Cell3/ParticleResults.csv"); 
close("Results")

//Overlay//apply mask to LFA-1 and Ca2+ channels and save measurements

selectWindow(LFA1);
run("From ROI Manager");
roiManager("Measure");
saveAs("Results", "C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Analysis/WT/20200922/FC3/Cell3/C3_Results.csv");
close("Results");

selectWindow(Calcium);
run("From ROI Manager");
roiManager("Measure");
saveAs("Results", "C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Analysis/WT/20200922/FC3/Cell3/C1_Results.csv");
close("Results");

//Save movies

selectWindow("C3-MN20200922.lif - FC3_GCAMP5-1");
run("AVI... ", "compression=JPEG frame=25 save=[C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Analysis/WT/20200922/FC3/Cell3/"+ LFA1 +".avi]");

selectWindow("C1-MN20200922.lif - FC3_GCAMP5-1");
run("AVI... ", "compression=JPEG frame=25 save=[C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Analysis/WT/20200922/FC3/Cell3/"+ Calcium +".avi]");
