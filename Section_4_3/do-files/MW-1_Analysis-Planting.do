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
	
	use "$path_work/MW/1_Plantation_Clas.dta", clear

*--- Collapse the data at Household Level

	foreach i in NA Plant Small_trees Tree Tree_likeplants {
		replace trees_`i'=0 if trees_`i'==.
		gen d_`i'=(trees_`i'>0 )
	}
	gen x=1


	collapse (sum) n_plots=x n_plots_NA=d_NA n_plots_Plant=d_Plant n_plots_Small_trees=d_Small_trees n_Tree=d_Tree n_Tree_likeplants=d_Tree_likeplants area_NA area_Plant area_Small_trees area_Tree area_Tree_likeplants trees_NA trees_Plant trees_Small_trees trees_Tree trees_Tree_likeplants area_farm=plot_size (median) cropp_system_NA cropp_system_Plant cropp_system_Small_trees cropp_system_Tree cropp_system_Tree_likeplants year_plant_NA year_plant_Plant year_plant_Small_trees year_plant_Tree year_plant_Tree_likeplants, by(HHID)

*--- Merge Data

	* HH Data
	merge 1:1 HHID using "$path_work/MW/1_HH_Information.dta", nogenerate 
	replace area_farm=0 if area_farm==.

*--- Declaring Sampling Structure
	
	*For plot level analysis and/or variables that are at the area level (yields, value of output per hectare, fertilize used per hectare, labor input per hectare…) we should multiply the household weights by area.

	gen weight_plot=hh_wgt*area_farm
	rename hh_a01 district
	svyset ea_id [pweight=weight_plot], strata(district) singleunit(centered)


* ------------------------------------------------------------ *
* --- ANALYSIS - CROPPED   ---- *
* ------------------------------------------------------------ *

*--- TABLE 2-3: Share of Households with any trees on farm

	* Trees
	eststo clear
	estpost svy: tabulate n_Tree,  percent subpop(if area_farm>0)

	esttab using "$tables/sec43_MW_table_2.tex", cell("b(fmt(%9.3f)) se(fmt(%9.3f)) lb(fmt(%9.3f)) ub(fmt(%9.3f))") nodepvar  nonum replace noobs nomtitles  fragment collabels(none) posthead("& & & & \\")  

	* Small_trees
	eststo clear
	estpost svy: tabulate n_plots_Small_trees,  percent subpop(if  reside==2)

	esttab using "$tables/sec43_MW_table_3.tex", cell("b(fmt(%9.3f)) se(fmt(%9.3f)) lb(fmt(%9.3f)) ub(fmt(%9.3f))") nodepvar  nonum replace noobs nomtitles  fragment collabels(none) posthead("& & & & \\")  



*--- GRAPH 3: Share of the crops

	rename n_Tree  n_plots_Tree
	rename n_Tree_likeplants n_plots_Tree_likeplants
	foreach i in NA Plant Small_trees Tree Tree_likeplants {
		gen share_plots_`i'=n_plots_`i'/n_plots
	}

	graph pie share_plots_NA share_plots_Plant share_plots_Small_trees share_plots_Tree share_plots_Tree_likeplants  [pweight=weight_plot],  plabel(_all percent, format(%9.2f)) scheme(s4mono) legend (label  (1 NA) label  (2 Plant/Herb/Grass/Roots) label (3 Small trees or shrubs) label (4 Tree) label (5 Tree-like plants))  graphregion(color(white))  legend( region( style(none)) cols(3)  size(small) forcesize )

	graph export "$graphs/sec43_MW_fig_2.png", replace width(4147) height(2250) 


*--- GRAPH 4: Area of the crops

	gen area_cropped=area_NA+area_Plant+area_Small_trees+area_Tree+area_Tree_likeplants

	foreach i in NA Plant Small_trees Tree Tree_likeplants {
		gen share_area_`i'=(area_`i'/area_cropped)*100
	}


	graph bar share_area_NA share_area_Plant share_area_Small_trees share_area_Tree share_area_Tree_likeplants [pweight=weight_plot], blabel(bar, format(%9.2f) color(none)) bar(1,color(gs12)) bar(2,color(gs4)) bar(3,color(gs8)) bar(4,color(black)) bargap(7) scheme(s2mono) legend (label(1 NA) label(2 Plant/Herb/Grass/Roots) label(3 Small trees or shrubs) label(4 Tree) label(5 Tree-like plants) ) ytitle(Percentage (%),size(small))  graphregion(color(white))  legend( size(2)  ) ylabel(,labsize(vsmall)) legend( region( style(none)) cols(3)  size(small) forcesize )

	graph export "$graphs/sec43_MW_fig_3.png", replace width(4147) height(2250) 







 	
 	





