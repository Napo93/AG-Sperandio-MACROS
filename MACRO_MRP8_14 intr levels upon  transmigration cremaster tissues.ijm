

//Macro for intracellular MRP8/14 quantification in extravasated vs intravascular neutrophils in the inflamed cremaster muscle of WT mice

//Start//

run("Options...", "iterations=1 count=1 black");

inputImageName = getTitle();
originalImage = inputImageName;
rename(originalImage);

//Create Z max projection
run("Z Project...", "projection=[Max Intensity]");
run("Split Channels");

pecam_max = "C1-MAX_" + originalImage;
contrast_max = "C2-MAX_" + originalImage;
mrp814_max = "C3-MAX_" + originalImage;
close(contrast);

//Auto thresholding//segmentation of MRP8/14 channel for neutrophil mask
selectWindow(mrp814_max);
run("Subtract Background...", "rolling=20");
run("Median...", "radius=2");
run("Enhance Contrast...", "saturated=1 normalize");
run("Auto Threshold", "method=RenyiEntropy white");
run("Fill Holes");
run("Watershed");
run("Analyze Particles...", "size=25-Infinity circularity=0.50-1.00 show=Outlines clear add");
selectWindow("Drawing of " + mrp814_max);
close();

//Overlay//apply mask to original image to measure MRP8/14 intensities in each plane of the Z-stack
selectWindow(originalImage);
run("Split Channels");
pecam = "C1-" + originalImage;
contrast = "C2-" + originalImage;
mrp814 = "C3-" + originalImage
selectWindow(contrast);
close();
selectWindow(pecam);
close();

selectWindow(pecam_max);
run("From ROI Manager");
run("Flatten");
saveAs("Tiff", "C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/INA transmigration MRP8_14/20150625/MAX_C1-"+ originalImage +".tif");
close();

selectWindow(mrp814);
run("From ROI Manager");
roiManager("Multi Measure");
saveAs("Results", "C:/MATTEO N/LMU/Project 'Role of S100A8-9 in Leukocyte recruitment in vivo'/INA transmigration MRP8_14/20150625/Results"+ originalImage +".csv");
close();

close(pecam_max);
close(mrp814);
close("ROI Manager");
close("Results");