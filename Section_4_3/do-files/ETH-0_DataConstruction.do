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


* ------------------------------------------------------------ *
* --- PART I: Production data   ---- *
* ------------------------------------------------------------ *
* Data was collected only on one visit
 **** Fruits Trees (AG_SEC6A.dta) + Permanent Crops (AG_SEC6B.dta)

  *----------------------------
  *  All Crops together
  *----------------------------

    *--- 1 - Open DataSet - All Data Sets Together
        * Start with Fruit Crops/Permanent Crops

         
         * Post-Planting (Season 1)
        use "$path_data/ETH/2011-12/sect4_pp_w1.dta", clear

    *---  2 - Include our crop classification
      include "$path_work/do-files/ETH-CropClassification.do"
    
  
    *---  4 - Collapse information
        gen x=1
        collapse (sum) n_parcels=x  ,by( household_id parcel_id field_id tree_type)


    *-- 6. We identify whether the Parcel has more than one crop (i.e. Inter-cropped)

            bys household_id parcel_id field_id: gen n_crops_plot=_N
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
            order household_id parcel_id field_id
            reshape wide n_parcels , i(household_id parcel_id field_id) j(type_crop)
  
    *--- 8. Rename Variables 
            global names "Tree_Fruit NA Plant Tree_Agri Tree_wood"
            local number "1 2 3 4 5"
            
            local i=1
            foreach y of global names {
                local name: word `i' of `number'
                rename n_parcels`name' n_parcel_`y'
                replace n_parcel_`y'=0 if n_parcel_`y'==.
                local i=`i'+1
            }
    
    *--- 9. Save the data set


		save "$path_work/ETH/0_CropsClassification.dta", replace
    

* ------------------------------------------------------------ *
* --- PART II: Sells data data   ---- *
* ------------------------------------------------------------ *

    *--- 1 - Open DataSet - Permanent Crops 
       
        use "$path_data/ETH/2011-12/sect11_ph_w1.dta", clear
        gen x=1

        rename ph_s11q04_a value_sold
        rename ph_s11q22_a share_q_selfcosumption
        rename ph_s11q22_b share_q_seed
        rename ph_s11q22_c share_q_sold
        rename ph_s11q22_d share_q_kind
        rename ph_s11q22_e share_q_animal
        rename ph_s11q22_f share_q_other
        

        keep household_id crop_code value_sold share_q_* x

 
    *---3. Append Trees/Roots

      	append using "$path_data/ETH/2011-12/sect12_ph_w1.dta"
        replace value_sold=ph_s12q08 if x==.
        replace share_q_selfcosumption=ph_s12q19_a if x==.
        replace share_q_sold=ph_s12q19_c if x==.
        replace share_q_seed=ph_s12q19_b if x==.

        replace share_q_selfcosumption=ph_s12q19_a if x==.
        replace share_q_seed=ph_s12q19_b if x==.
        replace share_q_sold=ph_s12q19_c if x==.
        replace share_q_kind=ph_s12q19_d if x==.
        replace share_q_animal=ph_s12q19_e if x==.
        replace share_q_other=ph_s12q19_f if x==.


        keep household_id crop_code value_sold share_q_* 



    *-- Cleaning the data set 
     drop if crop_code==.
     replace value_sold=0 if value_sold==.

     foreach i in share_q_selfcosumption share_q_seed share_q_sold share_q_kind share_q_animal share_q_other {
      replace `i'=0 if `i'==. 
      replace `i'=`i'/100
     }
     gen total=share_q_selfcosumption+share_q_sold+share_q_seed 

     gen x=(total>1)
     drop if x==1
    

   *---  4 - Include our crop classification
      include "$path_work/do-files/ETH-CropClassification.do"

        

    *---  6 - Collapse information
    
    collapse (sum) value_sold (mean) share_q_*, by(household_id tree_type)

    *-- 8. Merge from the HH

  
  merge n:1 household_id using "$path_data/ETH/2011-12/sect_cover_hh_w1.dta", keepusing(ea_id pw saq01) nogenerate

    save "$path_work/ETH/0_CropsSells.dta", replace







