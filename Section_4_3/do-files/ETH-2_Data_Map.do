
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

*--- Open the Data
  
  use "$path_work/ETH/1_Plot-Crop_Information.dta", clear


  collapse (mean) n_parcel_*, by(household_id)

*--- Coordinates
  merge 1:1 household_id using "$path_data/ETH/2011-12/Pub_ETH_HouseholdGeovariables_Y1.dta", nogen keepusing(LAT_DD_MOD LON_DD_MOD )


rename LAT_DD_MOD lat
rename LON_DD_MOD lon
rename household_id hh_id

** Export for the map
export delimited using "/Users/jcmunozmora/Box Sync/Trees on Farm/LSMS-ISA/Maps/ETH/trees_on_farm_hh.csv", replace

save "$path_work/ETH/map.dta", replace
