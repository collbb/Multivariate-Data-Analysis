
********** 3-Group Analysis **********;


ods graphics on;

* MANOVA Model 1: X9 X10 = X14  ;

options ls=80 ps=50 nodate pageno=1;


* Input HATCO;

DATA HATCO;

INFILE '/folders/myfolders/HATCO_X1-X14_tabs.txt' DLM = '09'X TRUNCOVER;
INPUT X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14;

DATA HATCO;
	SET HATCO (KEEP= X9 X10 X13 X14);
	LABEL X9 = 'X9 - Usage Level'
	      X10 = 'X10 - Satisfaction Level'
	      X13 = 'X13 - Industry Type'
	      X14 = 'X14 - Buying Situation Type';

PROC PRINT DATA = HATCO;


* Exploratory Data Analysis - Means;

PROC MEANS DATA = HATCO;

PROC SORT DATA = HATCO;
	BY X14;
	
PROC MEANS DATA = HATCO;
	VAR X9 X10;
		BY X14;
		ID X14;
		
* Exploratory Data Analysis - Univariate;	

PROC UNIVARIATE DATA = HATCO NORMAL PLOT;
	VAR X9 X10;
	
PROC SORT DATA = HATCO;
	BY X14;
	
PROC UNIVARIATE DATA = HATCO NORMAL PLOT;
	VAR X9 X10;
		BY X14;
		ID X14;
		
		
* GLM MANOVA Analysis;

PROC GLM DATA = HATCO;
	CLASS X14;
		MODEL X9 X10 = X14;
		MEANS X14 / SCHEFFE TUKEY LSD SNK DUNCAN;
		MEANS X14 / HOVTEST=LEVENE HOVTEST=BF HOVTEST=BARTLETT;
		MEANS X14;
		MANOVA H = X14 / MSTAT = EXACT;
		


********** Factorial Design - MANOVA Model 2: X9 X10 = X14 X13 X14*X13  **********;

PROC GLM DATA = HATCO;
	CLASS X14 X13;
		MODEL X9 X10 = X14 X13 X14*X13;
		MEANS X14 X13 X14*X13;
		MANOVA H = X14 X13 X14*X13 / MSTAT = EXACT;
		
		
RUN;
QUIT;

		
		
		
		
		
		
		


	
