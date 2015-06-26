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

*----------------------------------------------------- *
* --- PLOT SIZE AND HH WITH PLOTS   ---- *
* ------------------------------------------------------------ *

  *----------------------------
  *  RAINY SEASON- VISIT I 
  *----------------------------

  *-- 1. Open and append the data

    *---- ROSTER PLOT MODULE - AG-MODULE C: PLOT ROSTER
    use "$path_data/MW/2010-11/Agriculture/AG_MOD_C.dta", clear


  *-- 2. Fix the Parcel Size
    
    * Convert everything to accres 
      * Hectares (ag_c04b=2) to Acres
        replace ag_c04a=ag_c04a*2.47 if ag_c04b==2
      * Square Meters (ag_c04b=3) to Acres
      replace ag_c04a=ag_c04a*0.00024711 if ag_c04b==3

      * Parcel Size using the GPS information
    gen plot_size=ag_c04c
    replace plot_size=ag_c04a if plot_size==.

    rename ag_c00 plot_id

  *-- 3. Data about the main use

    *--- Rainy Season - Visit 1

      preserve
      use "$path_data/MW/2010-11/Agriculture/AG_MOD_D.dta", clear
      keep HHID ag_d00 ag_d14
      rename ag_d00 plot_id
      drop if plot_id==""
      rename ag_d14 plot_use_rainy
      *Some only case repeated
      duplicates drop  HHID plot_id, force
      save "$path_work/MW/0_PlotUse_Rainy.dta", replace
      restore 

  *-- 4. Clean and merge the data
    keep HHID plot_id plot_size 
     drop if plot_id==""
    merge 1:1  HHID plot_id using "$path_work/MW/0_PlotUse_Rainy.dta", nogenerate keep(matched)

  *-- 5. Save data

      gen season_rainy=1
      save "$path_work/MW/0_Plot_Rainy.dta", replace

  *----------------------------
  *  DRY SEASON- VISIT II
  *----------------------------

  *-- 1. Open and append the data
    *---- ROSTER PLOT MODULE - AG-MODULE C: PLOT ROSTER
    use "$path_data/MW/2010-11/Agriculture/AG_MOD_J.dta", clear

     rename ag_j00 plot_id
     drop if plot_id==""


  *-- 2. Fix the Parcel Size
    
    * Convert everything to accres 
      * Hectares (ag_c04b=2) to Acres
        replace ag_j05a=ag_j05a*2.47 if ag_j05b==2
      * Square Meters (ag_c04b=3) to Acres
      replace ag_j05a=ag_j05a*0.00024711 if ag_j05b==3

      * Parcel Size using the GPS information
    gen plot_size=ag_j05c
    replace plot_size=ag_j05a if plot_size==.

   
  *-- 3. Data about the main use

    *--- DRY Season - Visit 2

      preserve
      use "$path_data/MW/2010-11/Agriculture/AG_MOD_K.dta", clear
      keep HHID ag_k0a ag_k15
      rename ag_k0a plot_id
      drop if plot_id==""
      rename ag_k15 plot_use_dry
      *Some only case repeated
      duplicates drop  HHID plot_id, force
      save "$path_work/MW/0_PlotUse_Dry.dta", replace
      restore 

  *-- 4. Clean and merge the data
    keep HHID plot_id plot_size 
     drop if plot_id==""
    merge 1:1  HHID plot_id using "$path_work/MW/0_PlotUse_Dry.dta", nogenerate 

    rename plot_size plot_size_dry

  *-- 5. Save data

    gen season_dry=2
    save "$path_work/MW/0_Plot_Dry.dta", replace

  *----------------------------
  *  MERGING DATA FROM THE TWO VISITS
  *----------------------------

  use "$path_work/MW/0_Plot_Rainy.dta", clear
  merge 1:1 HHID plot_id using "$path_work/MW/0_Plot_Dry.dta"

    rename plot_use_rainy plot_use
    * Organize the data f
    replace plot_size=plot_size_dry if _merge==2
    replace plot_use=plot_use_dry if _merge==2

    drop plot_size_dry  plot_use_dry _merge

    drop season_rainy season_dry

    gen x_dry=0
    gen x_rainy=1

    reshape long x_, i(HHID plot_id) j(season "rainy" "dry")
    drop x_

    rename season season1
    gen  season=1 if season1=="rainy"
    replace season=2 if season1=="dry"
    drop season1

    * D - Only appears in the Dry Season
    drop if (plot_id=="D1"|plot_id=="D2"|plot_id=="D3") & season==1

    save "$path_work/MW/1_Plot-Crop_Information.dta", replace

  *----------------------------
  *  MERGE INFORMATION WITH CROPS
  *----------------------------
    merge 1:1 HHID plot_id season using "$path_work/MW/0_CropsClassification.dta"

    drop if plot_id=="10"

  * To clean the data we will delete those plots without information

  drop if (plot_id=="D1"|plot_id=="D2"|plot_id=="R1"|plot_id=="R2"|plot_id=="R3"|plot_id=="R4"|plot_id=="R5"|plot_id=="R6"|plot_id=="R7") & _merge==2

  drop _merge

  save "$path_work/MW/1_Plot-Crop_Information.dta", replace

  * Organing the data

  foreach i in n_parcel_Tree_Fruit n_parcel_Tree_Agri n_parcel_NA n_parcel_Plant {
        replace `i'=(`i'>0 & `i'!=.)
      }

*-- 5. Fixing information For Inter-cropping and 
      
      * Those non-cultivated plots with forest
      gen  n_parcel_Tree_wood=(plot_use==5) 

      foreach i in _Tree_Fruit _Tree_Agri _NA _Plant {
        gen inter_n`i'=inter_crop*n_parcel`i'
      }

  *----------------------------
  *  MERGE DATA FROM HOUSEHOLD
  *----------------------------

  merge n:1 HHID using "$path_data/MW/2010-11/Household/HH_MOD_A_FILT.dta", keepusing(ea_id reside stratum hh_wgt hh_a01 hh_a02 hh_a02b) nogenerate


  save "$path_work/MW/1_Plot-Crop_Information.dta", replace




