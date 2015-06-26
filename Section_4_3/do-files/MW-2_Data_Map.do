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
	
	use "$path_work/MW/1_Plot-Crop_Information.dta", clear


	collapse (mean) n_parcel_*, by(HHID)


*--- Coordinates
	merge 1:1 HHID using "$path_data/MW/2010-11/Geovariables/HouseholdGeovariables_IHS3_Rerelease.dta", nogen keepusing(lat_modified lon_modified )


rename lat_modified lat
rename lon_modified lon
rename HHID hh_id

** Export for the map
export delimited using "/Users/jcmunozmora/Box Sync/Trees on Farm/LSMS-ISA/Maps/MW/trees_on_farm_hh.csv", replace


** Export for the map
save "$path_work/MW/map.dta", replace


