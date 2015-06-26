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
	
	use "$path_work/UGA/1_Planting_CropsWithoutCla.dta", clear

*--- Collapse the data at Household Level

	foreach i in plat_tree other_forest_tree natural_forest other_crops {
		replace area_`i'=0 if area_`i'==.
		gen d_`i'=(area_`i'>0 )
	}
	gen x=1

	collapse (sum) n_plots=x n_plots_plat_tree=d_plat_tree n_plots_other_forest_tree=d_other_forest_tree n_plots_natural_forest=d_natural_forest n_other_crops=d_other_crops area_other_crops area_natural_forest area_plat_tree area_other_forest_tree area_farm=parcel_size_farmer (median) cropp_system_other_crops cropp_system_natural_forest cropp_system_plat_tree cropp_system_other_forest_tree, by(HHID season)

*--- Merge Data

	* HH Data
	merge n:1 HHID using  "$path_work/UGA/1_HH_Information.dta", nogenerate 
	replace area_farm=0 if area_farm==.

*--- Declaring Sampling Structure
	
	*For plot level analysis and/or variables that are at the area level (yields, value of output per hectare, fertilize used per hectare, labor input per hectare…) we should multiply the household weights by area.

	gen weight_plot=wgt10*area_farm
	svyset comm [pweight=weight_plot], strata(stratum) singleunit(centered)

* ------------------------------------------------------------ *
* --- ANALYSIS - CROPPED   ---- *
* ------------------------------------------------------------ *

*--- TABLE 1: Share of Households with any trees on farm

	gen sum_plot_forest=n_plots_plat_tree+n_plots_other_forest_tree+n_plots_natural_forest

	* First Crop Season of 2010
	eststo clear
	estpost svy: tabulate sum_plot_forest,  percent subpop(if area_farm>0)

	esttab using "$tables/sec43_UGA_table_1.tex", cell("b(fmt(%9.3f)) se(fmt(%9.3f)) lb(fmt(%9.3f)) ub(fmt(%9.3f))") nodepvar  nonum replace noobs nomtitles  fragment collabels(none) posthead("& & & & \\")  


*--- GRAPH 1: Percentage of the cropped are in the three others trees 

	gen area_cropped=area_other_crops+area_natural_forest+area_plat_tree+area_other_forest_tree

	foreach i in plat_tree other_forest_tree natural_forest other_crops {
		gen share_area_`i'=(area_`i'/area_cropped)*100
	}


	graph bar share_area_plat_tree share_area_other_forest_tree share_area_natural_forest [pweight=weight_plot], blabel(bar, format(%9.3f) color(none)) bar(1,color(gs12)) bar(2,color(gs4)) bar(3,color(gs8)) bar(4,color(black)) bargap(7) scheme(s2mono) over(season, label(labsize(vsmall) ) relabel(1 `""First Crop Season 2010" "(Visit 1)""' 2 `""Second Crop Season 2010" "(Visit 2)""' ))  legend (label(1 Plantation Trees) label(2 Other Forest Trees) label(3 Natural Forest Trees)) ytitle(Percentage (%),size(small))  graphregion(color(white))  legend( size(2)  ) ylabel(,labsize(vsmall)) legend( region( style(none)) cols(3)  size(small) forcesize )

	graph export "$graphs/sec43_UGA_fig_1.png", replace width(4147) height(2250) 
