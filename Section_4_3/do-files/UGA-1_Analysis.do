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
	
	use "$path_work/UGA/1_Planting_Clas.dta", clear

*--- Collapse the data at Household Level

	foreach i in NA Plant Small_trees Tree Tree_likeplants {
		replace area_`i'=0 if area_`i'==.
		gen d_`i'=(area_`i'>0 )
	}
	gen x=1

	collapse (sum) n_plots=x n_plots_NA=d_NA n_plots_Plant=d_Plant n_plots_Small_trees=d_Small_trees n_Tree=d_Tree n_Tree_likeplants=d_Tree_likeplants area_NA area_Plant area_Small_trees area_Tree area_Tree_likeplants area_farm=parcel_size_farmer (median) cropp_system_NA cropp_system_Plant cropp_system_Small_trees cropp_system_Tree cropp_system_Tree_likeplants, by(HHID season)

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

*--- TABLE 2-3: Share of Households with any trees on farm

	* Trees
	eststo clear
	estpost svy: tabulate n_Tree,  percent subpop(if area_farm>0)

	esttab using "$tables/sec43_UGA_table_2.tex", cell("b(fmt(%9.3f)) se(fmt(%9.3f)) lb(fmt(%9.3f)) ub(fmt(%9.3f))") nodepvar  nonum replace noobs nomtitles  fragment collabels(none) posthead("& & & & \\")  

	* Small_trees
	eststo clear
	estpost svy: tabulate n_plots_Small_trees,  percent subpop(if area_farm>0)

	esttab using "$tables/sec43_UGA_table_3.tex", cell("b(fmt(%9.3f)) se(fmt(%9.3f)) lb(fmt(%9.3f)) ub(fmt(%9.3f))") nodepvar  nonum replace noobs nomtitles  fragment collabels(none) posthead("& & & & \\")  


*--- GRAPH 3: Share of the crops

	foreach i in n_plots_NA n_plots_Plant n_plots_Small_trees n_Tree n_Tree_likeplants {
		gen share_plot_
	}

	graph pie 


  [pweight=wtmec2yr] if age18p==1, plabel(_all percent, ///
  format(%9.1f)) scheme(s2mono) ///
  legend (label /// (1 “Normal”) label /// (2 “Pre-Hypertensive”)
  /// label ///(3 “Stage 1 Hypertensive”) label (4 “Stage 2 ///
  Hypertensive”))


*--- GRAPH 2: Percentage of the cropped are in the three others trees 

	gen area_cropped=area_NA+area_Plant+area_Small_trees+area_Tree area_Tree_likeplants

	foreach i in plat_tree other_forest_tree natural_forest other_crops {
		gen share_area_`i'=(area_`i'/area_cropped)*100
	}


	graph bar share_area_plat_tree share_area_other_forest_tree share_area_natural_forest [pweight=weight_plot], blabel(bar, format(%9.3f) color(none)) bar(1,color(gs12)) bar(2,color(gs4)) bar(3,color(gs8)) bar(4,color(black)) bargap(7) scheme(s2mono) over(season, label(labsize(vsmall) ) relabel(1 `""First Crop Season 2010" "(Visit 1)""' 2 `""Second Crop Season 2010" "(Visit 2)""' ))  legend (label(1 Plantation Trees) label(2 Other Forest Trees) label(3 Natural Forest Trees)) ytitle(Percentage (%),size(small))  graphregion(color(white))  legend( size(2)  ) ylabel(,labsize(vsmall)) legend( region( style(none)) cols(3)  size(small) forcesize )

	graph export "$graphs/sec43_UGA_fig_1.png", replace width(4147) height(2250) 


