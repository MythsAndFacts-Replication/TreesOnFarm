*---------------------------------------------*
*-------    Trees on Farm   ------------------*
*-------  World Bank    ------------------*
*-------  Section 4.3   ------------------*
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

*** Running the individual maps

include "$path_work/do-files/ETH-2_Data_Map.do"
include "$path_work/do-files/MW-2_Data_Map.do"
include "$path_work/do-files/NER-2_Data_Map.do"
include "$path_work/do-files/NGA-2_Data_Map.do"
include "$path_work/do-files/TZN-2_Data_Map.do"
include "$path_work/do-files/UGA-2_Data_Map.do"

*** Appending the data-set


use "$path_work/UGA/map.dta", clear

append using "$path_work/TZN/map.dta", keep(n_parcel_* lat lon )
append using "$path_work/NGA/map.dta", keep(n_parcel_* lat lon )
append using "$path_work/NER/map.dta", keep(n_parcel_* lat lon )
append using "$path_work/MW/map.dta", keep(n_parcel_* lat lon )
append using "$path_work/ETH/map.dta", keep(n_parcel_* lat lon )

drop if lat==.|lon==.

foreach i in Tree_Fruit Tree_Agri Tree_wood NA Plant {
rename n_parcel_`i' `i'
}


** Export for the map
export delimited using "/Users/jcmunozmora/Box Sync/Trees on Farm/LSMS-ISA/Maps/trees_on_farm_hh(all).csv", replace

