* HATCO_X1-X14_tabs - Multiple Regression Analysis;


ods graphics on;

options ls=80 ps=50 nodate pageno=1;


*********** Input HATCO_X1-X14_tabs **********;

data HATCO2;
infile '/folders/myfolders/HATCO_X1-X14_tabs.txt' DLM = '09'X TRUNCOVER;
input X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14;

data HATCO2;
	set HATCO2 (keep=X1 X2 X3 X4 X5 X6 X7 X8 X9);
	label X1 = 'X1 - Delivery Speed'
		  X2 = 'X2 - Price Level'  
		  X3 = 'X3 - Price Flexibility'
		  X4 = 'X4 - Manufacturer Image'
		  X5 = 'X5 - Service Level'
		  X6 = 'X6 - Salesforce Image'
		  X7 = 'X7 - Product Quality'
		  X8 = 'X8 - Firm Size'
		  X9 = 'X9 - Usage Level';
		  
proc print data = HATCO2;


********** Correlation Matrix - All Variables ***********;

proc corr data = HATCO2;
	var X1 X2 X3 X4 X5 X6 X7 X9;
	

********** Regression Analysis - X9 = X5 **********;

proc reg data = HATCO2 plots(unpack);
	model X9 = X5 / stb influence p r vif tol;
	plot NQQ.*R. NPP.*R.;
	
	
********** Stepwise Regression Analysis **********;
	
proc reg data = HATCO2 corr simple plots(unpack);
	model X9 = X1 X2 X3 X4 X5 X6 X7 / 
	selection=stepwise slentry=0.05 stb influence p r vif tol;
	plot NQQ.*R. NPP.*R.;
	
proc reg data = HATCO2 corr simple plots(unpack);
	model X9 = X3 X5 X6 / stb influence p r vif tol;
	plot NQQ.*R. NPP.*R.;

	
********** Confirmatory Regression Analysis - Full Model **********;

proc reg data = HATCO2 corr simple plots(unpack);
	model X9 = X1 X2 X3 X4 X5 X6 X7 / stb influence p r vif tol;
	plot NQQ.*R. NPP.*R.;


********** Adding X8 to the Model **********;

proc reg data = HATCO2 corr simple plots(unpack);
	model X9 = X3 X5 X6 X8 / stb influence p r vif tol;
	plot NQQ.*R. NPP.*R.;


ods graphics off;

run;
quit;




	
	
	
	
	
	
	
	
	
	
	
	
	















