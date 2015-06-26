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

* We merge owns plot (AGSEC2B.dta) + plot that they have rights (AGSEC2A.dta)
    
    *-- 1. Open and append the data

            use "$path_work/MW/1_Plot-Crop_Information.dta", clear

    *-- 2. Declaring the Survey Design

         svyset ea_id [pweight=hh_wgt], strata(hh_a01) singleunit(centered)

*** Make sure is zero 

    foreach i in n_parcel_Tree_Fruit n_parcel_Tree_Agri n_parcel_NA n_parcel_Plant n_parcel_Tree_wood {
    replace `i'=0 if `i'==.
    }

**** ANALYSIS 0: 

  * Gen Total Parcel - Trees
        gen n_trees=n_parcel_Tree_Fruit+n_parcel_Tree_Agri+n_parcel_Tree_wood

        replace n_trees=(n_trees>0 & n_trees!=.)

       svy: tabulate n_trees, percent subpop(if plot_size>0 )


    foreach i in n_parcel_Tree_Fruit n_parcel_Tree_Agri  n_parcel_Tree_wood {
       gen n_`i'=(`i'>0 & `i'!=.)
       svy: tabulate n_`i', percent subpop(if plot_size>0 )
       }


******* GRAPHS 1: %HH For Different Type of crop (ALL TYPES OF TREES)
     
     foreach i in n_parcel_Tree_Fruit n_parcel_Tree_Agri n_parcel_NA n_parcel_Plant n_parcel_Tree_wood {
      
      preserve 
      
      foreach s in 1 2 {
      qui estpost svy: tabulate `i', percent subpop(if plot_size>0 & season==`s')
        * Getting the data
            mat data`s'=[e(b)',e(lb)',e(ub)']
        }
        mat data=[data1,data2]

        matrix colnames data = percent1 lower1 upper1 percent2 lower2 upper2
        clear 
        local length=rowsof(data)
        svmat data, names(col)
        drop in `length'
        egen n_plots=seq(), from(0)
        reshape long percent lower upper, i(n_plots) j(season 1 2)

        *gen the value
       
        graph bar percent, over(n_plots , label(labsize(small))) over(season, label(labsize(small)) relabel(1 "Rainy Season" 2 "Dry Season" )) ytitle("% HH",size(small))  blabel(bar, position(outside) format(%9.2f) color(black) size(vsmall) justification(left) ) $graph_cofing bar(1,color(gs9)) 

        cd "$graphs/"
        graph export MW_HH_`i'.png, replace width(4147) height(2250) 
       restore
       }


******* GRAPHS 2: Percentage with plot

        * To estimate the total share of plots with presence of trees


        gen plots= n_parcel_Tree_Fruit+n_parcel_Tree_Agri+n_parcel_NA+n_parcel_Plant+n_parcel_Tree_wood

          foreach i in  _Tree_Fruit _Tree_Agri _NA _Plant _Tree_wood {
            gen share`i'=(n_parcel`i'/plots)*100
        }


        graph hbar share_Tree_Fruit share_Plant share_Tree_Agri share_Tree_wood share_NA [pweight=hh_wgt],  ytitle("% of Farms/Plots",size(small))  blabel(bar, position(outside) format(%9.2f) color(black) size(vsmall) justification(left) ) $graph_cofing legend (label  (1 Fruit Trees) label   label (2 Plant/Herb/Grass/Roots) label (3 Tree Crop ) label (4 Trees for timber and fuel-wood) (5 NA) ) bar(1,color(cranberry)) bar(2,color(midgreen)) bar(3,color(olive)) bar(4,color(forest green)) bar(5,color(maroon))
            
            * Colors
            * 1 - Fruit Trees - bar(1,color(cranberry))
            * 2 - Plant/ - bar(2,color(midgreen))
            * 3 - Tree Crop - bar(3,color(olive))
            * 4 - Tree Timber - bar(4,color(forest green)) 
            * 5 - NA - bar(1,color(maroon))

            cd "$graphs/"
          graph export MW_plot_classification.png, replace width(4147) height(2250) 



******* GRAPHS 3: Type of Crops system

        label def season 1 "Rainy Season" 2 "Dry Season"
        label val season season

        foreach i in  _Tree_Fruit _Tree_Agri {
            gen share_inter`i'=inter_n`i'/n_parcel`i'
            gen share_nointer`i'=(n_parcel`i'-inter_n`i')/n_parcel`i'
        }

        *Fixing Forest
        gen share_inter_Tree_wood=0
        gen share_nointer_Tree_wood=1

         foreach i in   _Tree_wood  _Tree_Fruit _Tree_Agri  {


        graph pie share_inter`i' share_nointer`i' [pweight=hh_wgt] ,  plabel(_all percent, format(%9.2f)  )   pie(1, color(ebg) )  pie(1, color(ebblue) )   legend (label  (1 Inter-Cropped) label  (2 Mono-Cropping) )    legend( region( style(none)) cols(3)  size(small) forcesize ) by(season, note("") graphregion(color(white))) 

        graph export MW_INTER_`i'.png, replace width(4147) height(2250) 
            }




