
* HBAT - Principal Components Analysis; 

ods graphics on;

options ls=80 ps=50 nodate pageno=1;

* Input HATCO_X1-X7_tabs ; 

data HATCO;
infile '/folders/myfolders/HATCO_X1-X7_tabs.txt' DLM = '09'X TRUNCOVER;
input X1 X2 X3 X4 X5 X6 X7;

data HATCO;
	set HATCO (keep = X1 X2 X3 X4 X5 X6 X7);
	label X1 = 'X1 - Delivery Speed'
		  X2 = 'X2 - Price Level'  
		  X3 = 'X3 - Price Flexibility'
		  X4 = 'X4 - Manufacturer Image'
		  X5 = 'X5 - Service Level'
		  X6 = 'X6 - Salesforce Image'
		  X7 = 'X7 - Product Quality';
		 
proc print data = HATCO;

* Principal Components Analysis - All Variables;

proc princomp data = HATCO plots = all;
	var X1 X2 X3 X4 X5 X6 X7;
	
	
************ All Variables - Method=Principal Rotation: None and Varimax ****************;

* Exploratory Factor Analysis Rotate=NONE All Variables ;

proc factor data = HATCO method=principal rotate=none nfactors=3 simple MSA 
plots = scree mineigen=0 reorder;
	var X1 X2 X3 X4 X5 X6 X7;

* Exploratory Factor Analysis Rotate=Varimax All Variables ;

proc factor data = HATCO method=principal rotate=varimax nfactors=3 print 
score simple MSA plots = scree mineigen=0 reorder;
	var X1 X2 X3 X4 X5 X6 X7;


************ X5 Deleted - Method=Principal Rotation: None and Varimax ****************;

* Exploratory Factor Analysis Rotate=NONE X5 Deleted ;

proc factor data = HATCO method=principal rotate=none nfactors=3 simple MSA 
plots = scree mineigen=0 reorder;
	var X1 X2 X3 X4 X6 X7;

* Exploratory Factor Analysis Rotate=Varimax X5 Deleted ;

proc factor data = HATCO method=principal rotate=varimax nfactors=3 print 
score simple MSA plots = scree mineigen=0 reorder;
	var X1 X2 X3 X4 X6 X7;


************ X5 & X3 Deleted - Method=Principal Rotation: None and Varimax ****************;

* Exploratory Factor Analysis Rotate=NONE X5 & X3 Deleted ;

proc factor data = HATCO method=principal rotate=none nfactors=3 simple MSA 
plots = scree mineigen=0 reorder;
	var X1 X2 X4 X6 X7;

* Exploratory Factor Analysis Rotate=Varimax X5 & X3 Deleted ;

proc factor data = HATCO method=principal rotate=varimax nfactors=3 print 
score simple MSA plots = all mineigen=0 reorder;
	var X1 X2 X4 X6 X7;


************ Compute Factor and Summated Scores****************;

proc factor data = HATCO outstat=factout method=principal rotate=varimax nfactors=3
print score simple MSA plots=all mineigen=0 reorder;
	var X1 X2 X4 X6 X7;
proc score data = HATCO score = FactOut out = FScore;
	var X1 X2 X4 X6 X7;

proc print data = FactOut;

proc print data = FScore;

data FScore;
	set FScore;
	label SumScale1 = 'SumScale1 - Overall Image '
		  SumScale2 = 'SumScale2 - Product Value'
		  SumScale3 = 'SumScale3 - Price Level';
	SumScale1 = (X6 + X4) / 2;
	SumScale2 = (X1 + (5 - X7)) / 2;
	SumScale3 = X2;

proc print data = FScore;

proc means data = FScore;
	var Factor1 Factor2 Factor3 SumScale1 SumScale2 SumScale3;
	
	 
************ Compute Factor and Summated Correlations ****************;
proc corr data = FScore;
	var Factor1 Factor2 Factor3 SumScale1 SumScale2 SumScale3;





