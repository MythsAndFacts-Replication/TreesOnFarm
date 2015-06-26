*---------------------------------------------*
*-------    Trees on Farm   ------------------*
*-------    World Bank      ------------------*
*-------    Section 4.3     ------------------*
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

  *----------------------------
  *  FIRST SEASON - VISIT I
  *----------------------------

    *-- 0. Open and keeping only information we need

            use "$path_data/UGA/2010-11/AGSEC4A.dta", clear
            gen season=1

            keep HHID prcid pltid cropID a4aq7 a4aq8 a4aq9 season

            append using "$path_data/UGA/2010-11/AGSEC4B.dta", keep(HHID prcid pltid cropID a4bq7 a4bq8 a4bq9 )
            replace season=2 if season==.

            
           
    *-- 1. Include our Classification         
        
        include "$path_work/do-files/UGA-CropClassification.do"


    *-- 2. Collapsing the information
       
        gen x=1
        collapse (sum) n_parcels=x  ,by(HHID  prcid tree_type season)

    *-- 3. We identify whether the Parcel has more than one crop (i.e. Inter-cropped)

            bys HHID  prcid season: gen n_crops_plot=_N
            gen inter_crop=(n_crops_plot>1 & n_crops_plot!=.)
            drop n_crops_plot

    *-- 4. Reshape the data for the new crops system

            encode tree_type, gen(type_crop)
                *1 Fruit Tree
                *2 NA
                *3 Plant/Herb/Grass/Roots
                *4 Agricultural Tree (Cash Crops)
                *5 Trees for timber and fuel-wood
            drop tree_type
            order HHID prcid type_crop 
            reshape wide n_parcels , i(HHID prcid season) j(type_crop)

    *--- 5. rename Variables 
            global names " Tree_Fruit NA  Plant Tree_Agri Tree_wood "
            local number "1 2 3 4 5 "
            
            local i=1
            foreach y of global names {
                local name: word `i' of `number'
                rename n_parcels`name' n_parcel_`y'
                replace n_parcel_`y'=0 if n_parcel_`y'==.
                local i=`i'+1
            }
    
    *--- 6. Save the data

          order HHID prcid season inter_crop n_parcel_Tree_*
          
            
            save "$path_work/UGA/0_CropsClassification.dta", replace

       

* ------------------------------------------------------------ *
* ---  PART II : Income Generated   ---- *
* ------------------------------------------------------------ *

  *----------------------------
  *  FIRST SEASON - VISIT I
  *----------------------------

    *-- 0. Open and keeping only information we need

            use "$path_data/UGA/2010-11/AGSEC5A.dta", clear

            rename a5aq8 value_sold
            rename a5aq6a q_harvest
            rename a5aq7a q_sold
            rename a5aq13 q_selfcosumption
            rename a5aq12 q_gift
            rename a5aq15 q_lost

            keep HHID prcid pltid cropID value_sold q_*
           
    *-- 1. Include our Classification         
        
        include "$path_work/do-files/UGA-CropClassification.do"
        
        
    *-- 4. Fixing value
        foreach i in q_harvest q_sold q_selfcosumption q_gift q_lost {
            replace `i'=0 if `i'==.
        }


        gen total=q_sold+q_selfcosumption+q_gift+q_lost


        gen x=(total>q_harvest)
        drop if x==1
        gen q_other=q_harvest-total


    *-- 2. Collapsing the information 

        foreach i in _sold _selfcosumption _gift _lost _other {
            gen share_q`i'=q`i'/q_harvest
        }

      collapse (sum) value_sold (mean) share_q_* ,by(HHID tree_type)


    *-- 4. Merge HH information 
          merge n:1 HHID using "$path_data/UGA/2010-11/GSEC1.dta", keepusing(region urban stratum comm h1aq1 wgt10  hh_status) nogenerate

    *-- 3. Save the data set

      save "$path_work/UGA/1_CropsSells.dta", replace



