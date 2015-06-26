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

        use "$path_work/NGA/0_CropsSells.dta", clear

    *-- 2. Declaring the Survey Design

        svyset ea [pweight=wt_wave1], strata(state) singleunit(centered)

*** GRAPH 1: COMPOSITION OF THE THREE PRODUCTION
    preserve
    drop if tree_type=="NA"|tree_type=="Plant/Herb/Grass/Roots"

    graph hbar (sum) share_q_stored share_q_paymentlabor share_q_Gift share_q_sold share_q_other [pw=wt_wave1],  over(tree_type,  label(labsize(vsmall)) relabel(1 "Tree Crops" ))  stack legend(size(vsmall)) per  blabel(bar, position(center) format(%9.2f) color(white) size(vsmall) justification(left) )  legend(label(1 "Stored") label(2 "Payment of labor") label(3 "Giving") label(4 "Sold") label(5 "Other Uses")) ylabel(,labsize(vsmall)) legend( region( style(none)) cols(5)  size(small) forcesize ) ytitle("% of Quantitative Harvest ",size(vsmall)) graphregion(color(white))  legend( size(2)  )

    cd "$graphs/"
    graph export NGA_Quantity_Share.png, replace width(4147) height(2250) 

    restore 



*** GRAPH 2: TOTAL INCOME GENERATED


    gen log_value=log(value_sold)


    graph box log_value [pw=wt_wave1], over(tree_type, label(labsize(vsmall) angle(forty_five)))  marker(2, msymbol(x) mcolor(gs5))   ytitle("Log. Monetary value of product sold",size(small)) ylabel(,labsize(vsmall)) bar(1,   color(gs5))  bar(2,   color(gs10) )   graphregion(color(white)) 

    cd "$graphs/"
    graph export NGA_Sold_Quantity.png, replace width(4147) height(2250) 


*** GRAPH 2:  INCOME COMPOSITION

    graph bar (sum) value_sold [pw=wt_wave1],    over(tree_type,  label(labsize(vsmall)) ) asyvars  stack legend(size(vsmall)) per  blabel(bar, position(center) format(%9.2f) color(white) size(vsmall) )   ylabel(,labsize(vsmall)) legend( region( style(none)) cols(5)  size(small) forcesize ) ytitle("% ", size(vsmall)) graphregion(color(white))  legend( size(2)  )


    cd "$graphs/"
    graph export NGA_SELL_COMPOSITION.png, replace width(4147) height(2250) 


*** GRAPH MAP 2 : UnContidional -- All farmers
    preserve

     gen order=1 if tree_type=="Fruit Tree"
    replace order=2 if tree_type=="Tree Crops"
    replace order=3 if tree_type=="Plant/Herb/Grass/Roots"
    
     graph pie  value_sold [pw=wt_wave1],  over(tree_type)  plabel(2 percent,  format(%9.0f) color(white) size(huge)  ) plabel(3 percent,  format(%9.0f) color(white) size(huge)  )  plabel(5 percent,  format(%9.0f) color(white) size(huge)  ) pie(1, color(eltgreen))  pie(2, color(ebblue)) pie(3, color(erose))  pie(4, color(edkblue))    plotregion(lstyle(none))   graphregion(color(white)) sort(order) 
        
        * Colors
        * 1 - "Fruit Tree"  -  color(eltgreen)   
        * 2 - "Other trees or shrubs" -  color(ebblue)
        * 3 - "Plant/Herb/Grass/Roots" - color(erose)
        * 4 - "NA" - color(emidblue)
        * 5 - "Agricultural Tree (Cash Crops)" - color(edkblue)
        * 6 - "Trees for timber and fuel-wood" - color(ebg)

    svy: tabulate tree_type, percent tab(value_sold)
    

    cd "$presentation"
    
    graph export NGA_IN_UNCODITIONAL.png, replace width(4147) height(2250) 

    restore


*** GRAPH MAP 2 : Conditional -- All farmers
    preserve
    bys  hhid: gen select=1 if (tree_type=="Fruit Tree" & value_sold>0)|(tree_type=="Other trees or shrubs" & value_sold>0)|(tree_type=="Tree Crops" & value_sold>0)|(tree_type=="Trees for timber and fuel-wood" & value_sold>0) 
    sort  hhid select
    bys  hhid: replace select=select[_n-1] if select==.

    keep if select==1
    
        gen order=1 if tree_type=="Fruit Tree"
    replace order=2 if tree_type=="Tree Crops"
    replace order=3 if tree_type=="Plant/Herb/Grass/Roots"
    
     graph pie  value_sold [pw=wt_wave1],  over(tree_type)  plabel(1 percent,  format(%9.0f) color(white) size(huge)  ) plabel(2 percent,  format(%9.0f) color(white) size(huge)  ) plabel(3 percent,  format(%9.0f) color(white) size(huge)  )  plabel(5 percent,  format(%9.0f) color(white) size(huge)  ) pie(1, color(eltgreen))  pie(2, color(ebblue)) pie(3, color(erose))  pie(4, color(edkblue))    plotregion(lstyle(none))   graphregion(color(white)) sort(order)
   
      cd "$presentation"
    
    graph export NGA_IN_CODITIONAL.png, replace width(4147) height(2250) 

     svy: tabulate tree_type, percent tab(value_sold)
    

   restore


