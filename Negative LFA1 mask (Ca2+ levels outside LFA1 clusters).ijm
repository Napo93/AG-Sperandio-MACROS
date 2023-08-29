run("Options...", "iterations=1 count=1 black");

inputImageName = getTitle();
originalImage = inputImageName;
rename(originalImage);

run("Split Channels");
calcium = "C1-"+ originalImage;
Lyz2 = "C2-"+ originalImage;
LFA1 = "C3-"+ originalImage;


//Auto Thresholding//Segmentation of Lyz2 channel for cell mask
selectWindow(Lyz2);
run("Subtract Background...", "rolling=15 stack");
run("Median...", "radius=5 stack");
run("Enhance Contrast...", "saturated=1 normalize process_all");
run("Auto Threshold", "method=Huang white stack");

//LFA-1 mask and LFA-1 nanoclusters by size thresholding
selectWindow(LFA1);
run("Auto Threshold", "method=MaxEntropy white stack");
run("Analyze Particles...", "size=0.15-Infinity show=Masks clear add stack");
close("Results");
close("ROI Manager");

//negative LFA-1 mask subtracting LFA-1 mask from Lyz2 mask
run("Image Calculator...");
imageCalculator("Subtract", Lyz2, "Mask of " + LFA1);

waitForUser

run("Analyze Particles...", "size=0-Infinity show=Outlines display add in_situ stack");
close("Results");

//save excel file measuremnts
selectWindow(calcium);
run("From ROI Manager");
roiManager("Measure");
saveAs("Results", "C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Kellner/Calcium_LFA1/LFA-1 negative mask analysis/S100/20200925/FC6/cell4.csv");

//save mask movie
selectWindow("Result of " + Lyz2) 
run("AVI... ", "compression=JPEG frame=25 save=[C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/MICROSCOPY/Confocal/Kellner/Calcium_LFA1/LFA-1 negative mask analysis/WT/20200915/FC1/cell1.avi]");

close("Results");
close("ROI Manager");
close(calcium);
close(Lyz2)
close(LFA1);
close("Mask of " + LFA1);