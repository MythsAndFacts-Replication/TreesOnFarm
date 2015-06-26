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
* --- PART I: Only information from SElls   ---- *
* ------------------------------------------------------------ *
* Data was collected only on one visit
 **** Fruits Trees (AG_SEC6A.dta) + Permanent Crops (AG_SEC6B.dta)

  ***** PERMANENT CROPS

   *--- 1 - Open DataSet - All Data Sets Together

      * Post-Planting (Season 1)
      use "$path_data/NER/2011-12/NE1P2AGDTAen/ecvmaas05_p2_en.dta", clear

   *--- 2 - Deleting information 
      * No presence of those tree
      drop if as05q04==2

      * Missing values
        drop if  as05q02==.
        rename as05q02 crop_id

        rename as05q10 value_sold
        rename as05q06a q_harvest
        rename as05q07 q_selfcosumption
        rename as05q08 q_gift
        rename as05q09 q_sold


      keep hid crop_id value_sold q_*
    
   *--- 3 - Include our crop classification
      include "$path_work/do-files/NER-CropClassification.do"



  *-- 4. Fixing value
        foreach i in q_harvest q_selfcosumption q_gift q_sold {
            replace `i'=0 if `i'==.
        }


        gen total=q_selfcosumption+q_gift+q_sold


        gen x=(total>q_harvest)
        drop if x==1
        gen q_other=q_harvest-total



   *--- 5 - Collapsing information
     
      collapse (sum) value_sold q_*, by(hid tree_type)

     save "$path_work/NER/0_Sells-PERMANT.dta", replace

  ***** TRANSITORY CROPS

    *--- 1 - Open DataSet - All Data Sets Together

      * Post-Planting (Season 1)
      use "$path_data/NER/2011-12/NE1P2AGDTAen/ecvmaas2e_p2_en.dta", clear

    *--- 2 - Deleting information

       keep hid  as02eq04 as02eq06  as02eq13
       rename as02eq06 crop_id
       drop if crop_id==.
       replace as02eq13=0 if as02eq13==.

   *--- 3 - Include our crop classification
      include "$path_work/do-files/NER-CropClassification.do"
 
    *--- 4 - Collapsing information
     
      collapse (sum) value_sold=as02eq13, by(hid tree_type)

      append using "$path_work/NER/0_Sells-PERMANT.dta"

      foreach i in q_harvest q_selfcosumption q_gift q_sold {
            replace `i'=0 if `i'==.
        }

        foreach i in _selfcosumption _gift _sold _other {
            gen share_q`i'=q`i'/q_harvest
        }

      collapse (sum) value_sold (mean) share_q*, by(hid tree_type)

       *-- 3. Share

       
      
        *-- 4. Merge 
        merge n:1 hid using "$path_data/NER/2011-12/NE1P1HH3DTAen/ecvmamen_p1_en.dta", keepusing(grappe strate hhweight) keep(matched) nogenerate


      save "$path_work/NER/0_CropsSells.dta", replace
