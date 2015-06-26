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

*--- Setting
    
    global graph_cofing "graphregion(color(white))  ylabel(,labsize(vsmall)) legend( region( style(none)) cols(3) size(vsmall) forcesize )"


* ------------------------------------------------------------ *
* --- PLOT SIZE AND HH WITH PLOTS   ---- *
* ------------------------------------------------------------ *
    
    *-- 1. Open and append the data

            use "$path_work/NER/0_CropsSells.dta", clear


            gen n_parcel_Tree_Fruit=(tree_type=="Fruit Tree")
            gen n_parcel_Tree_Agri=(tree_type=="Tree Crops")

            collapse (sum) n_parcel_*, by(grappe)


merge 1:1 grappe using "$path_data/NER/2011-12/NE11GEODTA/NER_EA_Offsets.dta", nogen keepusing(LAT_DD_MOD LON_DD_MOD)

rename LAT_DD_MOD lat
rename LON_DD_MOD lon
rename grappe hh_id


    ** Export for the map
    export delimited using "/Users/jcmunozmora/Box Sync/Trees on Farm/LSMS-ISA/Maps/NER/trees_on_farm_hh.csv", replace


** Export for the map
save "$path_work/NER/map.dta", replace



