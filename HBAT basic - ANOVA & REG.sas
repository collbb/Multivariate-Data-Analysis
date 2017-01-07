ods graphics on;

options ls=80 ps=50 nodate pageno=1;

Data HBAT;
Infile '/folders/myfolders/HBAT_tabs.txt' DLM = '09'X TRUNCOVER;
Input ID X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22 X23;

Data HBAT;
Set HBAT (Keep = ID X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22 X23);
Label ID = 'ID - Identification Number' 
	X1 = 'X1 - Customer Type' 
	X2 = 'X2 - Industry Type' 
	X3 = 'X3 - Firm Size' 
	X4 = 'X4 - Region' 
	X5 = 'X5 -Distribution System' 
	X6 = 'X6 - Product Quality' 
	X7 = 'X7 - E-Commerce' 
	X8 = 'X8 - Technical Support' 
	X9 = 'X9 - Complaint Resolution' 
	X10 = 'X10 - Advertizing' 
	X11 = 'X11 - Product Line' 
	X12 = 'X12 - Salesforce Image' 
	X13 = 'X13 - Competitive Pricing' 
	X14 = 'X14 - Warranty & Claims' 
	X15 = 'X15 - New Products' 
	X16 = 'X16 - Order & Billing' 
	X17 = 'X17 - Price Flexibility' 
	X18 = 'X18 - Delivery Speed' 
	X19 = 'X19 - Satisfaction' 
	X20 = 'X20 - Likelihood of Recommendation' 
	X21 = 'X21 - Likelihood of Future Purchase' 
	X22 = 'X22 - Current Purchase/Usage Level' 
	X23 = 'X23 - Consider Strategic Alliance/Partnership in Future';

Data HBAT; 
	Set HBAT;

proc print data = HBAT;

proc univariate data = HBAT;
	var X8 X9;

proc ttest data = HBAT;
	class X2;
	var X8 X9;

proc anova data = HBAT;
	class X2;
	model X8 = X2;
	
proc anova data = HBAT;
	class X2;
	model X9 = X2;
	
proc reg data = HBAT;
	model X8 = X2;

proc reg data = HBAT;
	model X9 = X2;

Run;
Quit;

	