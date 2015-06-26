*---------------------------------------------*
*-------    Trees on Farm   ------------------*
*-------  World Bank    ------------------*
*-------  Section 4.3   ------------------*
*-------  April 21 - 2015 --------------------*
*---------------------------------------------*

*-- Initials 

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

  *-- 1. Open and append the data
  
    use "$path_data/TZN/2010-11/AG_SEC2A.dta", clear
    append using "$path_data/TZN/2010-11/AG_SEC2B.dta"

    gen area_farm=ag2a_09
    replace area_farm=ag2b_20 if area_farm==.
    replace area_farm=ag2a_04 if area_farm==.
    replace area_farm=ag2b_15 if area_farm==.

  *-- 2. Append information from the two seasons
    drop if area_farm==.
    keep y2_hhid plotnum area_farm 

    * Information for Long Rainy (Season 1)
    merge 1:1 y2_hhid plotnum using "$path_data/TZN/2010-11/AG_SEC3A.dta", keepusing(ag3a_03) nogenerate

    * Information for Short Rainy (Season 2)
    merge 1:1 y2_hhid plotnum using "$path_data/TZN/2010-11/AG_SEC3B.dta", keepusing(ag3b_03) nogenerate

  *-- 3. Plot Use
    rename ag3a_03 plot_use1
    rename ag3b_03 plot_use2
    replace plot_use2=plot_use1 if plot_use2==.

    reshape long plot_use, i(y2_hhid plotnum) j(season 1 2)

    drop if (plotnum=="V1"|plotnum=="V2") & season==1


  *-- 4. Merge information for crops

    merge 1:1 y2_hhid plotnum season using "$path_work/TZN/0_CropsClassification.dta", nogenerate keep(master matched)


     foreach i in n_parcel_Tree_Fruit n_parcel_NA n_parcel_Plant n_parcel_Tree_Agri n_parcel_Tree_wood {
        replace `i'=(`i'>0 & `i'!=.)
      }

  *-- 5. Fixing information For Inter-cropping and 
      
      * Those non-cultivated plots with forest
      replace  n_parcel_Tree_wood=n_parcel_Tree_wood+1 if plot_use==5

      foreach i in  _Tree_Fruit _NA _Plant _Tree_Agri _Tree_wood {
        gen inter_n`i'=inter_crop*n_parcel`i'
      }

      

  *-- 6. Adding HH information

    gen x=1
    collapse (sum)  n_parcel_* inter_n* inter_crop farm_size=area_farm n_plots=x, by(y2_hhid season)

    *Merge information for crops

    merge n:1 y2_hhid using "$path_data/TZN/2010-11/HH_SEC_A.dta", keepusing(y2_weight y2_rural clusterid strataid region district) 

    save "$path_work/TZN/1_Plot-Crop_Information.dta", replace




