filename=getTitle();
selectWindow(filename);
//selectWindow(filename+"-1");
setSlice(1)
//lowerThr = 76;
lowerThr = 60;

run("Set Scale...", "distance=0 known=0 unit=pixel");
run("Duplicate...", "duplicate");
setMinAndMax(0, 20)
for (i = 0; i < nSlices; i++)
{sliceN = getSliceNumber();
//print(sliceN);
//run("Convoluted Background Subtraction", "convolution=Gaussian radius=10 slice");
run("Convoluted Background Subtraction", "convolution=Mean radius=3 slice");
setThreshold(lowerThr, 255, "raw");
run("Convert to Mask", "background=Dark only");
run("Analyze Particles...", "size=2-250 circularity=0.4-1 show=Overlay summarize");
run("Next Slice [>]");
}

selectWindow("Summary of "+filename+"-1");
//selectWindow("Summary of "+filename+"-2");
			nslices=Table.size("Summary of "+filename+"-1");
			//nslices=Table.size("Summary of "+filename+"-2");
			//print(nslices);
						//Sum particle analysis values across all slices
						// (Need to use parseFloat command to convert table string to a number for adding...)
						for (i = 0; i < nSlices; i++) {
							countsum += parseFloat(Table.get("Count", i));
							areasum += parseFloat(Table.get("Total Area", i));
							sizesum += parseFloat(Table.get("Average Size", i));
							percentareasum += parseFloat(Table.get("%Area", i));

current=getValue("results.count")-1;}
Table.create("Data summed across slices");
						
if (current==0) { // If this is the first line of the Results table...
						//selectWindow("Summary of "+filename);
						Table.create("Data summed across slices");
						Table.setLocationAndSize(1500, 800, 1000, 500);
						header1="Image";
						Table.set(header1, 0, filename);
						Table.set("Count", 0, countsum);
						Table.set("Total Area", 0, areasum);
						Table.set("Average Size", 0, sizesum);
						//Insert tissue area 3x in table to facilate later normalization in Excel
						//Table.set("Tissue area", 0, tissue_area);
						//Table.set("Tissue area1", 0, tissue_area);
						//Table.set("Tissue area2", 0, tissue_area);
						//Table.set("%Area", 0, percentareasum);
					}
					else {
						currentS=Table.size("Data summed across slices");
						selectWindow("Data summed across slices");
						Table.set("Image", currentS, filename);
						Table.set("Count", currentS, countsum);
						Table.set("Total Area", currentS, areasum);
						Table.set("Average Size", currentS, sizesum);			
						//Table.set("%Area", currentS, percentareasumN);
						//Table.set("Tissue area", currentS, tissue_area);
						//Table.set("Tissue area1", currentS, tissue_area);
						//Table.set("Tissue area2", currentS, tissue_area);
					}
//run("Merge Channels...", "c1=filename c2=[filename + "-1"] create keep")
//run("Convoluted Background Subtraction", "convolution=Gaussian radius=10 slice");
//run("Convoluted Background Subtraction", "convolution=Gaussian radius=10 slice");
//run("Convoluted Background Subtraction", "convolution=Gaussian radius=10 slice");
//run("Next Slice [>]");
//run("Next Slice [>]");
//run("Next Slice [>]");


//run("Show Info...");
