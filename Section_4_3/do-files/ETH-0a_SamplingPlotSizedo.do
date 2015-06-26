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


*-- 1. Open the data

  use "$path_data/ETH/2011-12/sect3_pp_w1.dta", clear

*-- 2. Organizing the data
  rename saq01 region
  rename saq02 zone
  rename saq03 woreda
  rename pp_s3q02_c local_unit


  keep holder_id household_id pp_s3q02_a pp_s3q02_b parcel_id field_id pp_s3q02_d pp_s3q03 local_unit pp_s3q02_d pp_s3q05_a region zone woreda 

*-- 3. Merge Measurement Unit

    * Local Mesuarement
    gen d_local=(local_unit==3|local_unit==4|local_unit==5|local_unit==6)
    
    * First, merge the unit converstion
    merge n:1 region zone woreda local_unit using "$path_data/ETH/2011-12/ET_local_area_unit_conversion.dta", keepusing(conversion) nogenerate keep(master matched)

    * Fix those without land
    bys region zone local_unit: egen mean_conversion_zone=mean(conversion)
    bys region local_unit: egen mean_conversion_region=mean(conversion)
     bys local_unit: egen mean_conversion_country=mean(conversion)

*-- 4. Fix Area Parcel (Mt2) - GPS measure
    gen area_parcel=pp_s3q05_a

      * To estimate the area of plot I use the area measure byt e 

          * (a) Ha to Mts 
          replace area_parcel=pp_s3q02_d/10000 if local_unit==1 & area_parcel==.
          
          * (b) Mts to Mts
          replace area_parcel=pp_s3q02_d if local_unit==2 & area_parcel==.

          * (c) Appling the conversion rate
          replace area_parcel=pp_s3q02_d*conversion if d_local==1 & area_parcel==.
          
          * (d) When no available the Zone 

            * Mean from the zone
           replace area_parcel=pp_s3q02_d*mean_conversion_zone if d_local==1 & area_parcel==.

           * Mean from the region
           replace area_parcel=pp_s3q02_d*mean_conversion_region if d_local==1 & area_parcel==.

            * Mean from the country
           replace area_parcel=pp_s3q02_d*mean_conversion_country if d_local==1 & area_parcel==.

        keep holder_id  household_id parcel_id field_id area_parcel pp_s3q03

*-- 5. Merge the data

  collapse (mean)  area_parcel (median) pp_s3q03, by( household_id parcel_id field_id)

    * Land Use
    replace  pp_s3q03=round(pp_s3q03)
    label val pp_s3q03 PP_S3Q03
    rename pp_s3q03 plot_use

 

  merge 1:1 household_id parcel_id field_id using "$path_work/ETH/0_CropsClassification.dta", nogenerate keep(master matched) 

  foreach i in  n_parcel_Tree_Fruit n_parcel_NA n_parcel_Plant n_parcel_Tree_Agri n_parcel_Tree_wood {
    replace `i'=0 if `i'==.
  }

*-- 6. Collapse the data at Household level

  collapse (sum) n_parcel_Tree_Fruit n_parcel_NA n_parcel_Plant n_parcel_Tree_Agri n_parcel_Tree_wood (median) plot_use inter_crop farm_size=area_parcel, by(household_id)
  
  replace plot_use=round(plot_use)
  replace inter_crop=round(inter_crop)


  * Organing the data

  foreach i in n_parcel_Tree_Fruit n_parcel_NA n_parcel_Plant n_parcel_Tree_Agri n_parcel_Tree_wood {
        replace `i'=(`i'>0 & `i'!=.)
      }

*-- 7. Fixing information For Inter-cropping and 
      
      * Those non-cultivated plots with forest
      replace  n_parcel_Tree_wood=n_parcel_Tree_wood+1 if plot_use==5 

      foreach i in _Tree_Fruit _NA _Plant _Tree_Agri _Tree_wood    {
        gen inter_n`i'=inter_crop*n_parcel`i'
      }

*-- 8. Merge from the HH

  
  merge n:1 household_id using "$path_data/ETH/2011-12/sect_cover_hh_w1.dta", keepusing(ea_id pw saq01) nogenerate


save "$path_work/ETH/1_Plot-Crop_Information.dta", replace