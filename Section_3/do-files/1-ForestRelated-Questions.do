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
use "$w_folder/data/Forest-related-LSMS.dta", clear


 encode  forestcategory, gen(forest)

 gen forest_related=(forest!=6 & forest!=5)

**** Graph 1: FOREST RELATED QUESTIONS BY CONTRY
preserve
gen x=1
keep if forest_related==1
collapse (sum) x, by(country year forest)


reshape wide x, i(country year) j(forest)
foreach i in ETH MW NER NGA TZN UGA {
graph hbar x1 x2 x3 x4 if country=="`i'",   over(year, label(labsize(small)))   ytitle("Number of Questions", size(small) )   blabel(bar, position(inside) format(%9.0f) color(white))  $graph_cofing  bar(1,  color(gs4)    lcolor(gs15))   bar(2,  color(gs12)    lcolor(gs9))   legend( label(1 "Assets and access to resources") label(2 " Benefits/payment from forest-related services") label(3 "Firewood and Charcoal")  label(4 "Governance and institutions") size(vsmall) cols(2) ) bargap(-20) 
cd "$graphs"
graph export fig_1_`i'.png, replace width(4147) height(2250)
}
restore


**** Graph 2: In which Modules
 encode  module, gen(lsms_module)
 gen abre=" ("
 gen cierra=")"
 egen country_year=concat(country abre year cierra)
  encode  country_year, gen(country_year1)

 preserve
 gen x=1
 keep if forest_related==1
 replace lsms_module=1 if lsms_module==2|lsms_module==3
	collapse (sum) x, by(country_year1 lsms_module forest )
reshape wide x, i(country_year1 forest) j(lsms_module)


forvalue i=1/4 {
graph hbar x1 x4 x5 if forest==`i',   over(country_year1, label(labsize(small)))   ytitle("Number of Questions", size(small) )   blabel(bar, position(inside) format(%9.0f) color(white) size(vsmall))  $graph_cofing  bar(1,  color(gs4)    lcolor(gs15))   bar(2,  color(gs12)    lcolor(gs9))   legend( label(1 "Agriculture Module") label(2 "Community Module") label(3 "Household Module") size(vsmall) cols(2) ) bargap(-10) 
cd "$graphs"
graph export fig_2_`i'.png, replace width(4147) height(2250)
}
restore

*******************************************************
**** INFORMATION ABOUT PERMANENT CROPS AND 
*******************************************************










