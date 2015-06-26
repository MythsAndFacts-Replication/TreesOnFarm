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

*-- Working Directxories
	global mysintaxis "/Users/jcmunozmora/Documents/data/mysintaxis"
	global path_work "/Users/jcmunozmora/Box Sync/Trees on Farm/DataAnalysis/Report/Section_4_3"
	global path_data "/Users/jcmunozmora/Box Sync/Trees on Farm/LSMS-ISA/DataSets"
	global tables "/Users/jcmunozmora/Box Sync/Trees on Farm/Reports/Final_Report/Section_4/tables"
	global graphs "/Users/jcmunozmora/Box Sync/Trees on Farm/Reports/Final_Report/Section_4/figures"

* ------------------------------------------------------------ *
* --- OPEN DE DATA ON CROP CLASSIFICATION  ---- *
* ------------------------------------------------------------ *

*--- Open file for working

		use "$path_data/CropClassification/CropClassification-Jun2015.dta", clear

		tostring eth_id, replace

		rename scientificname crop_clas
		replace eth_id="" if eth_id=="."



*--- Create son farm
 
	foreach i in uga tzn ner nga mw eth {
		replace `i'_id=rtrim(`i'_id)
		replace `i'_id=ltrim(`i'_id)
		replace `i'_id=itrim(`i'_id)
		gen d_`i'=(`i'_id!="")
	}

	gen n_countries=d_uga+d_tzn+d_ner+d_nga+d_mw+d_eth

	replace crop_clas=type_tree if crop_clas=="Tree"

*--- Graph 0: Type of Questions by country
	drop crop_clas
	rename final_classication crop_clas
	
	preserve
	keep d_* crop_clas
	collapse (sum) d_*, by(crop_clas)
	reshape long d_, i(crop_clas) j(con "uga" "tzn" "ner" "nga" "mw" "eth")

	bys con: egen total_1=sum(d_)
	bys con: gen prop=(d_/total_1)*100

	encode con, gen(cont)
	encode crop_clas, gen(type_crop)

	

	levelsof con, local(country)

	foreach l of local country {
		qui tabstat d_ if con=="`l'", stat(sum) save
		mat total = r(StatTotal) 
		local `l'= total[1,1]
	}

	keep con type_crop prop

	   **1 Fruit Tree 
     **2 NA
     **3 Plant/Herb/Grass/Roots
     **4  Tree Crops
     **5 Trees for timber and fuelwood

	reshape wide prop, i(con) j(type_crop)
	replace con=upper(con)

	graph hbar prop1 prop2 prop3 prop4 prop5 , over(con, label(labsize(small)) relabel(1 `""ETH" "(n=`eth')""' 2  `""MW" "(n=`mw')""'  3  `""NER" "(n=`ner')""' 4  `""NGA" "(n=`nga')""' 5  `""TZN" "(n=`tzn')""' 6  `""UGA" "(n=`uga')""' ) )  ytitle("% of listed crops" , size(small))  blabel(bar, position(inside) format(%9.0f) color(white) size(vsmall))  $graph_cofing  bar(1,  color(gs4)    lcolor(gs15))   bar(2,  color(gs12)    lcolor(gs9))   legend( label(1  `"Fruit Trees""') label(2 "NA") label(3 "Plant/Herb/Grass/Roots") label(4 "Tree Crops") label(5 "Trees for timber and fuelwood")) bargap(-20)  legend( region( style(none)) cols(3)  size(small) forcesize ) graphregion(color(white)) legend( region( style(none)) cols(3) size(vsmall) forcesize )

 
	graph export "$graphs/sec4_Crops_bycountries.png", replace width(4147) height(2250) 


	restore 


*--- Graph 1: Initial Crop Classification
	preserve
	keep n_countries crop_clas
	drop if crop_clas=="NA"|crop_clas=="Plant/Herb/Grass/Roots"

	gen x=1
	collapse (sum) x, by(n_countries crop_clas )
	encode crop_clas, gen(id_cla)
	   		   *- 1 Fruit Tree
           *- 2 Tree Crops
           *- 3 Trees for timber and fuelwood

	drop crop_clas
	reshape wide x, i(id_cla) j(n_countries)


	graph hbar x1 x2 x3 x4 x5 x6, over(id_cla, label(labsize(small)) relabel(1 "Fruit Tree" 2 "Tree Crops" 3 `""Trees for timber" "and fuelwood""' )) ytitle("# of listed crops")  blabel(bar, size(vsmall) position(inside) format(%9.0f) color(white))  $graph_cofing  bar(1,  color(gs4)    lcolor(gs15))   note("Observations= 71")  legend( region( style(none)) cols(3)  size(small) forcesize ) graphregion(color(white)) legend(label(1 "One Country") label(2 "Two Countries") label(3 "Three Countries") label(4 "Four Countries") label(5 "Five Countries") label(6 "Six Countries" )) legend( region( style(none)) cols(3)  size(small) forcesize ) graphregion(color(white))
	
	graph export "$graphs/sec4_Crops_countries.png", replace width(4147) height(2250) 


	restore 