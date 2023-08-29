

//Macro for F-actin and overall Ca2+ analysis: change WT to Mrp14-/- depending on the group being analyzed


//Start//

run("Options...", "iterations=1 count=1 black");

inputImageName = getTitle();
originalImage = inputImageName;
rename(originalImage);//Start//

run("Split Channels");

Calcium = "C1-" + originalImage;
Factin = "C3-" + originalImage;
Lyz2 = "C2-" + originalImage


//Auto Thresholding//Segmentation of Lyz2 channel for cell mask

selectWindow(Lyz2);
run("Duplicate...", "duplicate");
run("Enhance Contrast...", "saturated=0.3 normalize process_all");
run("Gaussian Blur...", "sigma=2 stack");
run("Auto Threshold", "method=Minimum white stack");

//Particle analyzer//define cells 

run("Analyze Particles...", "size=5-Infinity show=Outlines display add in_situ stack");

saveAs("Results", "C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Actin2.5fps/WT/20210304/FC5/Cell5/particles_Results.csv");
close("Results")

//Overlay//apply mask to F-actin and Ca2+ channel and save measurements 

selectWindow(Calcium);
run("From ROI Manager");
roiManager("Measure");
saveAs("Results", "C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Actin2.5fps/WT/20210304/FC5/Cell5/C1_Results.csv");
close("Results");

selectWindow(Factin);
run("From ROI Manager");
roiManager("Measure");
saveAs("Results", "C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Actin2.5fps/WT/20210304/FC5/Cell5/C3_Results.csv");
close("Results");

//Save movie

selectWindow(Lyz2);
run("AVI... ", "compression=JPEG frame=25 save=[C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Actin2.5fps/WT/20210304/FC5/Cell5/"+ Lyz2 +".avi]");
