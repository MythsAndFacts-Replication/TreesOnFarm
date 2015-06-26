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
    global presentation "/Users/jcmunozmora/Box Sync/Trees on Farm/Presentations/DC-June15/figures/Income"

*--- Setting
    
    global graph_cofing "graphregion(color(white))  ylabel(,labsize(vsmall)) legend( region( style(none)) cols(5) rows(3)  size(vsmall) forcesize )"


* ------------------------------------------------------------ *
* --- PLOT SIZE AND HH WITH PLOTS   ---- *
* ------------------------------------------------------------ *
* We merge owns plot (AGSEC2B.dta) + plot that they have rights (AGSEC2A.dta)
    
    *-- 1. Open and append the data

        use "$path_work/MW/0_CropsSells.dta", clear

    *-- 2. Declaring the Survey Design

         svyset ea_id [pweight=hh_wgt], strata(hh_a01) singleunit(centered)


*** GRAPH 1: COMPOSITION OF THE THREE PRODUCTION
    preserve
    drop if tree_type=="NA"|tree_type=="Plant/Herb/Grass/Roots"

    graph hbar (sum) share_q_sold share_q_selfcosumption share_q_gift share_q_lost share_q_other [pw=hh_wgt],  over(tree_type,  label(labsize(vsmall)))  stack legend(size(vsmall)) per  blabel(bar, position(center) format(%9.2f) color(white) size(vsmall) justification(left) )  legend(label(1 "Sold") label(2 "Self-Consumption") label(3 "Giving") label(4 "Lost") label(5 "Other Uses")) ylabel(,labsize(vsmall)) legend( region( style(none)) cols(5)  size(small) forcesize ) ytitle("% of Quantitative Harvest ",size(vsmall)) graphregion(color(white))  legend( size(2)  )

    cd "$graphs/"
    graph export MW_Quantity_Share.png, replace width(4147) height(2250) 

    restore 

*** GRAPH 2: TOTAL INCOME GENERATED


    gen log_value=log(value_sold)


    graph box log_value [pw=hh_wgt], over(tree_type, label(labsize(vsmall) angle(forty_five)))  marker(2, msymbol(x) mcolor(gs5))   ytitle("Log. Monetary value of product sold",size(small)) ylabel(,labsize(vsmall)) bar(1,   color(gs5))  bar(2,   color(gs10) )   graphregion(color(white)) 

    cd "$graphs/"
    graph export MW_Sold_Quantity.png, replace width(4147) height(2250) 


*** GRAPH 3: UnContribution -- All farmers

    
    graph bar (sum) value_sold [pw=hh_wgt],    over(tree_type,  label(labsize(vsmall)) relabel(1 "Fruit Trees" )) asyvars  stack legend(size(vsmall)) per  blabel(bar, position(center) format(%9.2f) color(white) size(vsmall) )   ylabel(,labsize(vsmall)) legend( region( style(none)) cols(5)  size(small) forcesize ) ytitle("% ", size(vsmall)) graphregion(color(white))  legend( size(2)  )


    cd "$graphs/"
    
    graph export MW_SELL_COMPOSITION.png, replace width(4147) height(2250) 




*** GRAPH MAP 1 - Contribution 

    preserve
    drop if tree_type=="NA"|tree_type=="Plant/Herb/Grass/Roots"|tree_type=="Tree-like plants"


       gen share_other=1-share_q_selfcosumption-share_q_sold

     graph bar (sum) share_q_sold share_q_selfcosumption share_q_other [pw=hh_wgt],  over(tree_type,  label(labsize(large))) stack legend(size(vhuge)) per  blabel(bar, position(center) format(%9.0f) color(white) size(vhuge) justification(left) ) legend(label(1 "Sold") label(2 "Self-Consumption") label(3 "Other Uses") ) ylabel(,labsize(medium)) legend( region( style(none)) cols(6)  size(medium) forcesize )   graphregion(color(white))

            cd "$presentation"
    
    graph export MW_USES.png, replace width(4147) height(2250) 

     restore


*** GRAPH MAP 2 : UnContidional -- All farmers
    preserve


    gen order=1 if tree_type=="Fruit Tree"
    replace order=2 if tree_type=="Tree Crops"
    replace order=3 if tree_type=="Plant/Herb/Grass/Roots"
    replace order=4 if tree_type=="NA"


      graph pie  value_sold [pw=hh_wgt],  over(tree_type) plabel(3 percent,  format(%9.0f) color(white) size(huge)  ) plabel(2 percent,  format(%9.0f) color(white) size(huge)  )  pie(1, color(eltgreen))  pie(2, color(ebblue)) pie(3, color(erose))  pie(4, color(emidblue))     plotregion(lstyle(none))   graphregion(color(white)) sort(order) 
   
         * Colors
        * 1 - "Fruit Tree"  -  color(eltgreen)   
        * 2 - "Tree Crops" -  color(ebblue)
        * 3 - "Plant/Herb/Grass/Roots" - color(erose)
        * 4 - "NA" - color(emidblue)
        * 5 - "Trees for timber and fuel-wood" - color(ebg)

    cd "$presentation"
    
    graph export MW_IN_UNCODITIONAL.png, replace width(4147) height(2250) 

     svy: tabulate tree_type, percent tab(value_sold)
    

    restore


*** GRAPH MAP 2 : Conditional -- All farmers
    preserve
    bys HHID: gen select=1 if  (tree_type=="Fruit Tree" & value_sold>0)|(tree_type=="Other trees or shrubs" & value_sold>0)|(tree_type=="Tree Crops" & value_sold>0)|(tree_type=="Trees for timber and fuel-wood" & value_sold>0) 
    sort HHID select
    bys HHID: replace select=select[_n-1] if select==.

    keep if select==1
    
    gen order=1 if tree_type=="Fruit Tree"
    replace order=2 if tree_type=="Tree Crops"
    replace order=3 if tree_type=="Plant/Herb/Grass/Roots"
    replace order=4 if tree_type=="NA"
    
            
         graph pie  value_sold [pw=hh_wgt],  over(tree_type) plabel(_all percent,  format(%9.0f) color(white) size(huge)  )   pie(1, color(eltgreen))  pie(2, color(ebblue)) pie(3, color(erose))       plotregion(lstyle(none))   graphregion(color(white)) sort(order) 
   
         * Colors
        * 1 - "Fruit Tree"  -  color(eltgreen)   
        * 2 - "Tree Crops" -  color(ebblue)
        * 3 - "Plant/Herb/Grass/Roots" - color(erose)
        * 4 - "NA" - color(emidblue)
        * 5 - "Trees for timber and fuel-wood" - color(ebg)

   
      cd "$presentation"
    
    graph export MW_IN_CODITIONAL.png, replace width(4147) height(2250) 


     svy: tabulate tree_type, percent tab(value_sold)
    

   restore

