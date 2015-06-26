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
* --- DATA ON PLANTING - SECTION 4 - AGRICULTURAL MODULE  ---- *
* ------------------------------------------------------------ *
* Data was collected only on one visit
 **** Fruits Trees (AG_SEC6A.dta) + Permanent Crops (AG_SEC6B.dta)

  *----------------------------
  *  All Crops together
  *----------------------------

    *--- 1 - Open DataSet - All Data Sets Together
        * Start with Fruit Crops
        use "$path_data/TZN/2010-11/AG_SEC6A.dta", clear
        * Append Permanent Crops
        append using "$path_data/TZN/2010-11/AG_SEC6B.dta"
        gen d_crop=1
         * Append Transitory - Long rainy Season 
        append using "$path_data/TZN/2010-11/AG_SEC4A.dta"
        replace d_crop=2 if d_crop==.
          * Append Transitory - Long rainy Season 
        append using "$path_data/TZN/2010-11/AG_SEC4B.dta"
        replace d_crop=3 if d_crop==.

        * Labels for the differnent crops
        label def d_crop 1 "Permanent" 2 "First Season" 3 "Second Season"
        label val d_crop d_crop

    *---  2 - Only the data we are inserted

      keep y2_hhid plotnum zaocode d_crop
      drop if zaocode==.
      rename zaocode crop_id


    *---  3 - Include our crop classification
      include "$path_work/do-files/TZN-CropClassification.do"

        
    *---  4 - Collapse information
        gen x=1
        collapse (sum) n_parcels=x  ,by( y2_hhid plotnum d_crop tree_type)

    *---  5 - Information per season

      reshape long h, i(y2_hhid plotnum d_crop tree_typ) j(season 1 2)
        drop h
        drop if d_crop==2 & season==2
        drop if d_crop==3 & season==1
        drop d_crop

      collapse (sum) n_parcels, by(y2_hhid plotnum season tree_type)

    *-- 6. We identify whether the Parcel has more than one crop (i.e. Inter-cropped)

            bys y2_hhid plotnum season: gen n_crops_plot=_N
            gen inter_crop=(n_crops_plot>1 & n_crops_plot!=.)
            drop n_crops_plot

    *-- 7. Reshape the data for the new crops system

            encode tree_type, gen(type_crop)
                * 1 Fruit Tree
                * 2 NA
                * 3 Plant/Herb/Grass/Roots
                * 4 Tree Crops
                * 5 Trees for timber and fuel-wood

            drop tree_type
            order y2_hhid plotnum season type_crop
            reshape wide n_parcels , i(y2_hhid plotnum season) j(type_crop)
  
    *--- 8. Rename Variables 
            global names "Tree_Fruit NA  Plant  Tree_Agri  Tree_wood "
            local number "1 2 3 4 5 "
            
            local i=1
            foreach y of global names {
                local name: word `i' of `number'
                rename n_parcels`name' n_parcel_`y'
                replace n_parcel_`y'=0 if n_parcel_`y'==.
                local i=`i'+1
            }
    

    save "$path_work/TZN/0_CropsClassification.dta", replace

  
* ------------------------------------------------------------ *
* --- DATA ON PRODUCTION - MODULE V - AGRICULTURAL MODULE  ---- *
* ------------------------------------------------------------ *

* Data was collected only on one visit


    * Sells Crops Short (Long Rainy Season)
      use "$path_data/TZN/2010-11/AG_SEC5A.dta", clear
      keep y2_hhid zaocode ag5a_03
        * Short Rainy Season
      merge 1:1 y2_hhid zaocode using "$path_data/TZN/2010-11/AG_SEC5B.dta", keepusing(ag5b_03) nogenerate
        * Fruits
      merge 1:1 y2_hhid zaocode using "$path_data/TZN/2010-11/AG_SEC7A.dta", keepusing(ag7a_04) nogenerate
        * Permanent crops
          * There are some repeated values in this data set, so I will fix this first
            preserve
            use "$path_data/TZN/2010-11/AG_SEC7B.dta", clear
            replace ag7b_04=0 if ag7b_04==.
            collapse (sum)   ag7b_04, by(y2_hhid zaocode)
            save "$path_work/TZN/0_Fix_Sells.dta", replace
            restore

      merge 1:1 y2_hhid zaocode using "$path_work/TZN/0_Fix_Sells.dta", keepusing(ag7b_04) nogenerate

      * Organizing the variables
      foreach i in  ag5a_03 ag5b_03 ag7a_04 ag7b_04 {
        replace `i'=0 if `i'==.
      }

      gen value_sold=ag5a_03+ag5b_03+ag7a_04+ag7b_04

      *---  3 - Include our crop classification
      rename zaocode crop_id
      include "$path_work/do-files/TZN-CropClassification.do"



      * Collapsing the data

      collapse (sum) value_sold, by(y2_hhid tree_type)

    *Merge information for crops

    merge n:1 y2_hhid using "$path_data/TZN/2010-11/HH_SEC_A.dta", keepusing(y2_weight y2_rural clusterid strataid region district) nogenerate
    
    save "$path_work/TZN/0_CropsSells.dta", replace


