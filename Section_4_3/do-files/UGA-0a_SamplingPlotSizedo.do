*---------------------------------------------*
*-------    Trees on Farm   ------------------*
*-------    World Bank      ------------------*
*-------    Section 4.3     ------------------*
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
* We merge owns plot (AGSEC2B.dta) + plot that they have rights (AGSEC2A.dta)
    
    *-- 1. Open and append the data
        use "$path_data/UGA/2010-11/AGSEC2A.dta", clear
        gen land_rights=1
        append using "$path_data/UGA/2010-11/AGSEC2B.dta"
        replace land_rights=0 if land_rights==.
        label def land_rights 1 "Land Holding" 2 "Access To Right"
        label val land_rights land_rights
   
    *-- 2. Fix the Parcel Size 
        gen parcel_size_gps=a2aq4
        replace parcel_size_gps=a2bq4 if parcel_size_gps==.

        gen parcel_size_farmer=a2aq5
        replace parcel_size_farmer=a2bq5 if parcel_size_farmer==.

        replace parcel_size_farmer=parcel_size_gps if parcel_size_farmer==.
 
    *-- 3. Data about the main use

       keep HHID prcid parcel_size_farmer a2aq13a a2aq13b a2bq15a a2bq15b land_rights

       order HHID prcid land_rights parcel_size_farmer

       replace a2aq13a=a2bq15a if land_rights==0
       replace a2aq13b=a2bq15b if land_rights==0

       drop a2bq15a a2bq15b

       rename a2aq13a parcel_use1
       rename a2aq13b parcel_use2

    *-- 4. Reshape for seasons

      reshape long parcel_use, i(HHID prcid) j(season 1 2)

    *-- 5. Merge the data with Crops information
      sort HHID prcid season
      merge 1:1 HHID prcid season using "$path_work/UGA/0_CropsClassification.dta", nogenerate 

      foreach i in n_parcel_Tree_Fruit n_parcel_Tree_Agri n_parcel_Tree_wood n_parcel_NA n_parcel_Plant {
        replace `i'=(`i'>0 & `i'!=.)
      }

    *-- 6. Putting the data at HH level
      
      * Those non-cultivated plots with forest
      replace  n_parcel_Tree_wood=n_parcel_Tree_wood+1 if parcel_use==7

      foreach i in  _Tree_Fruit _Tree_Agri _Tree_wood _NA _Plant {
        gen inter_n`i'=inter_crop*n_parcel`i'
      }

      gen x=1

    collapse (sum)  n_parcel_* inter_n* inter_crop farm_size=parcel_size_farmer n_plots=x, by(HHID season)

    *-- 6. Merge with household data
    
    merge n:1 HHID using "$path_data/UGA/2010-11/GSEC1.dta", keepusing(region urban stratum comm h1aq1 wgt10  hh_status) nogenerate

    foreach i in n_parcel_Tree_Fruit n_parcel_Tree_Agri n_parcel_Tree_wood n_parcel_NA n_parcel_Plant inter_n_Tree_Fruit inter_n_Tree_Agri inter_n_Tree_wood inter_n_NA inter_n_Plant inter_crop farm_size n_plots {
      replace `i'=0 if `i'==.
    }

     save "$path_work/UGA/1_Plot-Crop_Information.dta", replace










