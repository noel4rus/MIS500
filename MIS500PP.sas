libname MIS500 '/folders/myfolders/MIS500';

proc xcopy in=IN1 out=MIS500 import;
run;

proc export data=MIS500.h131
outfile='/folders/myfolders/MIS500/h131.csv'
dbms=csv
replace;
run;
