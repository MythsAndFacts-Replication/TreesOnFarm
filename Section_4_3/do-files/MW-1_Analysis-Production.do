*---------------------------------------------*
*-------   	Trees on Farm   ------------------*
*------- 	World Bank  	------------------*
*-------	Section 4.3 	------------------*
*-------  April 21 - 2015 --------------------*
*---------------------------------------------*

*-- Preliminars 

	cap restore
	clear all
	cap log close
	set more off
	set logtype smcl
	set matsize 11000
	set maxvar 30000

*-- Working Directories
	global mysintaxis "/Users/jcmunozmora/Documents/data/mysintaxis"
	global path_work "/Users/jcmunozmora/Box Sync/Trees on Farm/DataAnalysis/Report/Section_4_3"
	global path_data "/Users/jcmunozmora/Box Sync/Trees on Farm/LSMS-ISA/DataSets"
	global tables "/Users/jcmunozmora/Box Sync/Trees on Farm/Reports/Final_Report/Section_4/tables"
	global graphs "/Users/jcmunozmora/Box Sync/Trees on Farm/Reports/Final_Report/Section_4/figures"

*--- Open the Data
	
	use "$path_work/MW/1_Production_Clas.dta", clear

*--- Merge Data

	* HH Data
	merge n:1 HHID using  "$path_work/MW/1_HH_Information.dta", nogenerate 

*--- Declaring Sampling Structure
	
	*For plot level analysis and/or variables that are at the area level (yields, value of output per hectare, fertilize used per hectare, labor input per hectare…) we should multiply the household weights by area.

	gen weight_plot=hh_wgt
	rename hh_a01 district
	svyset ea_id [pweight=weight_plot], strata(district) singleunit(centered)


* ------------------------------------------------------------ *
* --- ANALYSIS - CROPPED   ---- *
* ------------------------------------------------------------ *

*** Total Income
gen log_value=log(value_sold)


graph box log_value [pweight=weight_plot], over(crop_type, label(labsize(vsmall) angle(forty_five)))  marker(2, msymbol(x) mcolor(gs5))   ytitle("Log. Monetary value of product sold",size(small)) ylabel(,labsize(vsmall)) bar(1,   color(gs5))  bar(2,   color(gs10) )   graphregion(color(white)) 

graph export "$graphs/sec43_MW_fig_4.png", replace width(4147) height(2250) 

*** Contribution 

graph bar (sum) value_sold ,  over(crop_type, label(labsize(small))) asyvars stack legend(size(vsmall)) per  blabel(bar, position(center) format(%3.1f)) ytitle("% Money Received for selling") graphregion(color(white))  ylabel(,labsize(vsmall)) legend( region( style(none)) cols(3)  size(small) forcesize )

graph export "$graphs/sec43_MW_fig_5.png", replace width(4147) height(2250)



