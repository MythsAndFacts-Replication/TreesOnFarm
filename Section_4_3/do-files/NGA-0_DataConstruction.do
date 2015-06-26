*---------------------------------------------*
*-------    Trees on Farm   ------------------*
*-------  World Bank    ------------------*
*-------  Section 4.3   ------------------*
*-------  April 21 - 2015 --------------------*
*---------------------------------------------*

*-- Preliminary 

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
* --- PART I: Planting data   ---- *
* ------------------------------------------------------------ *

    *--- 1 - Open DataSet - All Data Sets Together

      * Post-Planting (Season 1)
      use "$path_data/NGA/2010-11/Post_Planting_Wave_1/Agriculture/sect11g_plantingw1.dta", clear

      append using "$path_data/NGA/2010-11/Post_Planting_Wave_1/Agriculture/sect11f_plantingw1.dta"

    *--- 2 - Only the data we need

      keep hhid plotid cropcode 
      drop if cropcode==.

    *---  3 - Include our crop classification
      
      include "$path_work/do-files/NGA-CropClassification.do"
  
    *---  4 - Collapse information
        gen x=1
        collapse (sum) n_parcels=x  ,by( hhid plotid tree_type)

    *-- 5. We identify whether the Parcel has more than one crop (i.e. Inter-cropped)

            bys hhid plotid: gen n_crops_plot=_N
            gen inter_crop=(n_crops_plot>1 & n_crops_plot!=.)
            drop n_crops_plot

    *-- 7. Reshape the data for the new crops system

            encode tree_type, gen(type_crop)
            *1 Fruit Tree
            *2 Plant/Herb/Grass/Roots
            *3 Tree Crops   
            drop tree_type
            order hhid plotid type_crop
            reshape wide n_parcels , i(hhid plotid) j(type_crop)

    *--- 8. Rename Variables 
            global names "Tree_Fruit Plant Tree_Agri"
            local number "1 2 3"
            
            local i=1
            foreach y of global names {
                local name: word `i' of `number'
                rename n_parcels`name' n_parcel_`y'
                replace n_parcel_`y'=0 if n_parcel_`y'==.
                local i=`i'+1
            }

     save "$path_work/NGA/0_CropsClassification.dta", replace

* ------------------------------------------------------------ *
* --- PART II: Production data   ---- *
* ------------------------------------------------------------ *

    *--- 1 - Open DataSet - All Data Sets Together

      * Post-Planting (Season 1)
      use "$path_data/NGA/2010-11/Post_Harvest_Wave_1/Agriculture/secta3_harvestw1.dta", clear

    *--- 2 - Only the data we need
      rename sa3q2 cropcode 
      rename sa3q18 value_sold
      rename sa3q6a q_harvest
      rename sa3q20a q_stored
      rename sa3q21a q_paymentlabor
      rename sa3q22a q_Gift

      replace sa3q16a=0 if sa3q16a==.
      replace sa3q11a=0 if sa3q11a==.
      gen q_sold=sa3q16a+sa3q11a


      keep hhid plotid cropcode value_sold q_*
      drop if cropcode==.

      replace value_sold=0 if value_sold==.

    *---  3 - Include our crop classification
      include "$path_work/do-files/NGA-CropClassification.do"
     

    *-- 4. Fixing value
        foreach i in  q_stored q_paymentlabor q_Gift q_sold {
            replace `i'=0 if `i'==.
        }


        gen total=q_stored+q_paymentlabor+q_Gift+q_sold


        gen x=(total>q_harvest)

        drop if x==1
        gen q_other=q_harvest-total


    * Collapsing the data

      foreach i in _stored _paymentlabor _Gift _other _sold {
            gen share_q`i'=q`i'/q_harvest
        }

      collapse (sum) value_sold (mean) share_q_*, by(hhid tree_type)
    

     *-- 3. Share

      
        *-- Merge with HH data
  merge n:1 hhid using "$path_data/NGA/2010-11/Post_Harvest_Wave_1/Household/secta_harvestw1.dta", nogenerate keepusing(zone state lga sector ea ric wt_wave1) keep(using matched) 

  save "$path_work/NGA/0_CropsSells.dta", replace






