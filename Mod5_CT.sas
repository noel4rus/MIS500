/*****************************************************************/
/* Source File: Motor_Vehicle_Collisions_-_Vehicles.csv          */
/* Source Path: /folders/myfolders/MIS500                        */
/* Author: John Noel                                             */
/* Date: 05/17/2020                                              */
/* Description: Module 5: Critical Thinking Option 1             */
/*						  Hypotheses Testing Using SAS Program   */
/* Source of data: Motor_Vehicle_Collisions_-_Vehicles.csv       */
/*                  retrieved from data.gov                      */
/*****************************************************************/

%web_drop_table(WORK.IMPORT);

/* Set libname MIS500 to store data */
libname MIS500 '/folders/myfolders/MIS500';

/*Define variable for location of initial data */
FILENAME REFFILE '/folders/myfolders/MIS500/Motor_Vehicle_Collisions_-_Vehicles.csv';

/*Import CSV data and save as SAS dataset work.import */
PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

/*Start to massage data into MIS500.module5 dataset by only saving columns driver_sez
  and crash_time and only keeping observations that have driver_seq defined as F or M */
DATA MIS500.module5;
SET WORK.IMPORT;
keep driver_sex crash_time;
if driver_sex eq 'F' or driver_sex eq 'M';
run;

/* Massage data further by defining timeGroup into 
   EM - Early Morning
   MR - Morning rush hour
   LT - Lunch time
   PL - Post lunch
   ER - Evening rush
   EH - Evening hours
   timeGroup2 as
   RH - Rush hour
   NR - Non-rush hour
   timeGroup3 as
   1 - Rush Hour
   0 - Non-rush hour
   accident as 1
*/   
DATA MIS500.module5;
SET MIS500.module5;
crash_hour=hour(crash_time);
if (crash_hour le 5) then timeGroup='EM';
else if (crash_hour gt 5 and crash_hour lt 11) then timeGroup='MR';
else if (crash_hour ge 11 and crash_hour le 13) then timeGroup='LT';
else if (crash_hour gt 13 and crash_hour lt 15) then timeGroup='PL';
else if (crash_hour ge 15 and crash_hour le 19) then timeGroup='ER';
else
	timeGroup = 'EH';
if (timeGroup = "ER" or timeGroup = "MR") then timeGroup2='RH';
else timeGroup2='NR';
if (timeGroup = "ER" or timeGroup = "MR") then timeGroup3=1;
else timeGroup3=0;
accident=1;
run;

/*Turn on graphics and perform chi square tests 
  1st test shows driver_seq by timeGroup
  2nd test shows driver_sex by timeGroup2
  3rd test shows driver_seq by timeGroup3 */
ods graphics on;
proc freq DATA=MIS500.module5;
tables driver_sex*timeGroup/ chisq
    plots=(freqplot(twoway=grouphorizontal scale=percent));
run;
proc freq DATA=MIS500.module5;
tables driver_sex*timeGroup2/ chisq
    plots=(freqplot(twoway=grouphorizontal scale=percent));
run;
proc freq DATA=MIS500.module5;
tables driver_sex*timeGroup3/ chisq
    plots=(freqplot(twoway=grouphorizontal scale=percent));
run;
ods graphics off;


%web_open_table(WORK.IMPORT);