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


* ------------------------------------------------------------ *
* --- PLOT SIZE AND HH WITH PLOTS   ---- *
* ------------------------------------------------------------ *

  *-- Open data on area

    use "$path_data/NGA/2010-11/Post_Planting_Wave_1/Agriculture/sect11a1_plantingw1.dta", clear

  *-- Fix area (mt2)
    gen plot_size=s11aq4d
    replace plot_size=s11aq4d/10000 if s11aq4b==6 & plot_size==.
    replace plot_size=s11aq4d if s11aq4b==7 & plot_size==.

  *-- Keep data
  keep hhid plotid plot_size

  *-- Merge Data
  merge 1:1 hhid plotid  using "$path_work/NGA/0_CropsClassification.dta",keep(master matched)
  drop if plot_size==. & _merge==1
  drop _merge

* Ficing data 
 foreach i in n_parcel_Tree_Fruit n_parcel_Plant n_parcel_Tree_Agri {
        replace `i'=(`i'>0 & `i'!=.)
      }

  *-- 5. Fixing information For Inter-cropping and 

      foreach i in  _Tree_Fruit _Plant _Tree_Agri {
        gen inter_n`i'=inter_crop*n_parcel`i'
      }


  *-- 6. Adding HH information

    gen x=1
    collapse (sum)  n_parcel_* inter_n* inter_crop farm_size=plot_size n_plots=x, by(hhid)




  *-- Merge with HH data
  merge 1:1 hhid using "$path_data/NGA/2010-11/Post_Harvest_Wave_1/Household/secta_harvestw1.dta", nogenerate keepusing(zone state lga sector ea ric wt_wave1) keep(using matched) 

  save "$path_work/NGA/1_Plot-Crop_Information.dta", replace

