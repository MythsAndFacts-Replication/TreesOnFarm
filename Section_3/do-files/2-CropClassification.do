*******************************************************
************ Trees on Farm 	***************************
*************    March 2013    ************************
*******************************************************

cap log close
cap restore
clear all
cap set mem 1g
set mem 3g
set more off
set logtype smcl
set matsize 10000

pause on

***** Working directory****
	global mysintaxis "/Users/jcmunozmora/Documents/data/mysintaxis"
	
	global w_folder "/Users/jcmunozmora/Box Sync/Trees on Farm/DataAnalysis/Report/Section_3"

	global results  "/Users/jcmunozmora/Box Sync/Trees on Farm/DataAnalysis/Report/Final_Report/Section_3/tables"
	global graphs "/Users/jcmunozmora/Box Sync/Trees on Farm/Reports/Final_Report/Section_3/figures"

** Default Setting
global graph_cofing "graphregion(color(white))  ylabel(,labsize(vsmall)) legend( region( style(none)) cols(3)  size(small) forcesize )"
global tables_setup "cells(b(star fmt(3)) se(par([ ]) fmt(3)))  starlevels(* 0.10 ** 0.05 *** 0.01) label  eqlabels(none)  mlabels(none) collabels(none)  "



** data
use "$w_folder/data/Crop-Classification.dta", clear

encode  type, gen(type_crop)
gen x=1


collapse (sum) x, by(country type_crop)
bys country: egen total_1=sum(x)
bys country: gen prop=(x/total_1)*100

encode  country, gen(con)

keep con type_crop prop

reshape wide prop, i(con) j(type_crop)

graph hbar prop1 prop2 prop3 prop4 prop5, over(con, label(labsize(small)) )  ytitle("%" , size(small))  blabel(bar, position(inside) format(%9.0f) color(white) size(vsmall))  $graph_cofing  bar(1,  color(gs4)    lcolor(gs15))   bar(2,  color(gs12)    lcolor(gs9))   legend( label(1 "NA") label(2 "Plant/Herb/Grass/Roots") label(3 "Small trees or shrubs") label(4 "Tree") label(5 "Tree-like plants") size(vsmall) cols(3) ) bargap(-20) 
cd "$graphs"
graph export fig_3.png, replace width(4147) height(2250)



