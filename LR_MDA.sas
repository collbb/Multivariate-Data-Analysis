********** HATCO_Split60 - Logistic Regression Analysis **********;

ods graphics on;

options ls=80 ps=50 nodate pageno=1;

title 'Logistic Regression';

* Input HATCO_Split60;

data HATCO;
infile '/folders/myfolders/HATCO_Split60_tabs.txt' DLM = '09'X TRUNCOVER;
input ID Split60 X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14;

data HATCO;
	set HATCO(keep = ID Split60 X1 X2 X3 X4 X5 X6 X7 X11);
	label ID = 'ID - Identification Number'
		  Split60 = 'Split60'
	 	  X1 = 'X1 - Delivery Speed'
		  X2 = 'X2 - Price Level'  
		  X3 = 'X3 - Price Flexibility'
		  X4 = 'X4 - Manufacturer Image'
		  X5 = 'X5 - Service Level'
		  X6 = 'X6 - Salesforce Image'
		  X7 = 'X7 - Product Quality'
		  X11 = 'X11 - Specification Buying';
		 
		 
* Create HATCO Split 60 (Original/Initial) and Split 40 (Validation/Holdout) Datasets ;

data HATCO60;
	set HATCO;
	if Split60 = 1;
	
data HATCO40;
	set HATCO;
	if Split60 = 0;
	
	
proc print data = HATCO60;

proc print data = HATCO40;




* Stepwise Logistic Regression Analysis - X11 = X1 X2 X3 X4 X5 X6 X7 *;

proc logistic data = HATCO60;
	model X11(event = '0') = X1 X2 X3 X4 X5 X6 X7 / 
	selection=stepwise slentry=0.05 slstay=0.05 details lackfit rsquare ctable pprob=(0 to 1 by .10);
	

* Final resultant model and output model;

proc logistic data = HATCO60 outmodel = Logistic60;
model X11(event='0') = X7 X1
						/ lackfit rsquare ctable pprob =(0.40 to 0.60 by .01);


* Original Split60 Logistic Model Fitted to Split40 validation Data;

proc logistic inmodel=Logistic60;
	score data = HATCO60 (keep = X11 X7 X1) out=HATCO60Score;
	

* Proc Freq Crosstabulations Original and Holdout Validation Datasets;

proc print data = HATCO60Score;
proc freq data = HATCO60Score;
	table F_X11 * I_X11;
	

proc logistic inmodel=Logistic60;
	score data = HATCO40 (keep = X11 X7 X1) out=HATCO40Score;
	
proc print data = HATCO40Score;
proc freq data = HATCO40Score;
	table F_X11 * I_X11;
	




********** HATCO_Split60 - Two-group Discriminant Analysis **********;


title '2-Group Discriminant Analysis';

* 2-Group Discriminant ANOVA;

proc discrim data = HATCO60 anova;
	class X11;
	var X1 X2 X3 X4 X5 X6 X7;
	priors equal;
	

* Stepwise 2-Group Discriminant Analysis - X11 = X1 X2 X3 X4 X5 X6 X7;

proc stepdisc data = HATCO60 slentry=0.05 slstay=0.05;
	class X11;
	var X1 X2 X3 X4 X5 X6 X7;


*Final Resultant Model and Output Model;

proc discrim data = HATCO60 outstat=DiscFunc crossvalidate crosslist;
	class X11;
	var X3 X7 X1;
	priors equal;
	
	
proc discrim data = DiscFunc testdata=HATCO40 testlist;
	class X11;



ods graphics off;

run;
quit;













