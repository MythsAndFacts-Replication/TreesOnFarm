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
* ---  PART I : CROP AND TREE CLASSIFICATION   ---- *
* ------------------------------------------------------------ *
* Information collect in two visit(i.e. rainy and dry seasons)
* Information on permanent crops was collected during the second visit - dry visit

  *-- 0. Open  Data sets and appending data sets

    use "$path_data/MW/2010-11/Agriculture/AG_MOD_P.dta", clear

            rename ag_p0b plot_id 
            rename ag_p0d crop_id

            keep HHID plot_id crop_id 
            gen d_crop=1

      * Transitory Crops Rainy Season 
      append using "$path_data/MW/2010-11/Agriculture/AG_MOD_G.dta", keep(HHID ag_g0b ag_g0d)

      replace plot_id=ag_g0b if plot_id==""
      replace crop_id=ag_g0d if crop_id==.
      replace d_crop=2 if d_crop==.

       keep HHID plot_id crop_id d_crop

      * Transitory Crops Rainy Season 
      append using "$path_data/MW/2010-11/Agriculture/AG_MOD_M.dta", keep(HHID ag_m0b ag_m0d)

      replace plot_id=ag_m0b if plot_id==""
      replace crop_id=ag_m0d if crop_id==.
      replace d_crop=3 if d_crop==.

       keep HHID plot_id crop_id d_crop
        drop if crop_id==.



  *-- 1. Include our Classification         
        
        include "$path_work/do-files/MW-CropClassification.do"

      
  *--  2 - Collapse information
    gen x=1
    collapse (sum) n_parcels=x  ,by( HHID plot_id d_crop tree_type)


 *---  5 - Information per season

      reshape long h, i(HHID plot_id d_crop tree_typ) j(season 1 2)
        drop h
        drop if d_crop==2 & season==2
        drop if d_crop==3 & season==1
        drop d_crop

      collapse (sum) n_parcels, by(HHID plot_id season tree_type)

  *-- 6. We identify whether the Parcel has more than one crop (i.e. Inter-cropped)

            bys HHID plot_id season: gen n_crops_plot=_N
            gen inter_crop=(n_crops_plot>1 & n_crops_plot!=.)
            drop n_crops_plot

  *-- 7. Reshape the data for the new crops system

            encode tree_type, gen(type_crop)
              *1 Fruit Tree
              *2 NA
              *3 Plant
              *4 Tree Crops
            drop tree_type
            order HHID plot_id type_crop 
            reshape wide n_parcels , i(HHID plot_id season) j(type_crop)

  *--- 8. rename Variables 
            global names "Tree_Fruit NA Plant  Tree_Agri"
            local number "1 2 3 4 5"
            
            local i=1
            foreach y of global names {
                local name: word `i' of `number'
                rename n_parcels`name' n_parcel_`y'
                replace n_parcel_`y'=0 if n_parcel_`y'==.
                local i=`i'+1
            }

  *--- 6. Save the data

          order HHID plot_id inter_crop n_parcel_Tree_*  

          save "$path_work/MW/0_CropsClassification.dta", replace



* ------------------------------------------------------------ *
* --- DATA ON PRODUCTION - MODULE V - AGRICULTURAL MODULE  ---- *
* ------------------------------------------------------------ *
* Information collect in two visit(i.e. rainy and dry seasons)
* Information on permanent crops was collected during the second visit - dry visit


  *----------------------------
  *  RAINY SEASON- VISIT I - Transitory Crops (ONLY)
  *----------------------------
    
    *--- 1 - Open DataSet (Transitory Crops - Visit 1) 

      use "$path_data/MW/2010-11/Agriculture/AG_MOD_B.dta", clear
      
      gen season=1
      rename ag_b0c crop_id

      rename ag_b08 value_sold
      rename ag_b04a q_harvest
      rename ag_b07a q_sold

      replace ag_b12a=0 if ag_b12a==.
      replace ag_b13a=0 if ag_b13a==.
      gen q_gift=ag_b12a+ag_b13a
      rename ag_b13a q_animal
      rename ag_b16a q_lost
      gen q_selfcosumption=ag_b20a if ag_b22a==1
      gen q_stored=ag_b20a if ag_b22a!=1

      keep HHID crop_id value_sold q_* season

    *--- 2 - Append the other data (Transitory Crops - Visit 2) 

      append using  "$path_data/MW/2010-11/Agriculture/AG_MOD_O.dta"

      replace season=2 if season==.

      replace crop_id=ag_o0b if season==2
      replace value_sold=ag_o03 if season==2
      replace q_harvest=ag_o02a if season==2
      replace ag_o12a=0 if ag_o12a==.
      replace ag_o21a=0 if ag_o21a==.
      replace q_sold=ag_o12a+ag_o21a if season==2
      replace q_gift=ag_o31a if season==2
      replace q_animal=ag_o33a if season==2
      replace q_lost=ag_o36a if season==2
      replace q_selfcosumption=ag_o40a if season==2 &  ag_o42a==1
      replace q_stored=ag_o40a if season==2 &  ag_o42a!=1
      
       keep HHID crop_id value_sold q_* season
       order HHID crop_id season value_sold q_*

    *--- 3 - Append the Data (Permanent Crops)
     append using  "$path_data/MW/2010-11/Agriculture/AG_MOD_Q.dta"
      replace season=0 if season==.
      replace value_sold=ag_q03 if season==0
      replace crop_id=ag_q0b if season==0
      replace q_harvest=ag_q02a if season==0
      replace ag_q12a=0 if ag_q12a==.
      replace ag_q21a=0 if ag_q21a==.
      replace q_sold=ag_q12a+ag_q21a if season==0
      replace q_gift=ag_q31a if season==0
      replace q_animal=ag_q33a if season==0
      replace q_lost=ag_q35a if season==0
      replace q_selfcosumption=ag_q39a if season==0 &  ag_q41a==1
      replace q_stored=ag_q39a if season==0 &  ag_q41a!=1

      keep HHID crop_id value_sold q_* season
       order HHID crop_id season value_sold q_*


    *--- 4 - Fixing the data
      
       drop if crop_id==.

       foreach i in q_harvest q_sold value_sold q_animal q_lost q_gift q_selfcosumption q_stored {
        replace `i'=0 if `i'==.
       }

       gen total=q_sold+q_animal+q_lost+q_gift+q_selfcosumption+q_stored


        gen x=(total>q_harvest)
        drop if x==1
        gen q_other=q_harvest-total


    *--- 4. Collapsing information

       foreach i in _sold _selfcosumption _gift _lost _other {
            gen share_q`i'=q`i'/q_harvest
        }

    *--- 3. Include our Classification         
        
        include "$path_work/do-files/MW-CropClassification.do"
    

    *--- 4. Collapsing information 

      collapse (sum) value_sold (mean) share_q_* ,by(HHID tree_type)
      order HHID tree_type

     *----------------------------
  *  MERGE DATA FROM HOUSEHOLD
  *----------------------------

  merge n:1 HHID using "$path_data/MW/2010-11/Household/HH_MOD_A_FILT.dta", keepusing(ea_id reside stratum hh_wgt hh_a01 hh_a02 hh_a02b) nogenerate


    *--- 5. Save Data

      save "$path_work/MW/0_CropsSells.dta", replace

