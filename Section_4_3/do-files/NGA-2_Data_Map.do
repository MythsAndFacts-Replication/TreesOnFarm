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

            use "$path_work/NGA/1_Plot-Crop_Information.dta", clear



    collapse (mean) n_parcel_*, by(hhid)


merge 1:1 hhid using "$path_data/NGA/2010-11/Geodata/NGA_HouseholdGeovariables_Y1.dta", nogen keepusing(lat_dd_mod lon_dd_mod)

rename lat_dd_mod lat
rename lon_dd_mod lon
rename hhid hh_id



    ** Export for the map
    export delimited using "/Users/jcmunozmora/Box Sync/Trees on Farm/LSMS-ISA/Maps/NGA/trees_on_farm_hh.csv", replace


** Export for the map
save "$path_work/NGA/map.dta", replace


