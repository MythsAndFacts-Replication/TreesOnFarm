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


    *-- 2. Declaring the Survey Design

        svyset ea [pweight=wt_wave1], strata(state) singleunit(centered)

    *-- Cleaning data set
    foreach i in n_parcel_Tree_Fruit n_parcel_Plant n_parcel_Tree_Agri {
      replace `i'=0 if `i'==.
    }

**** ANALYSIS 0: 
  * Gen Total Parcel - Trees
        gen n_trees=n_parcel_Tree_Fruit+n_parcel_Tree_Agri


        replace n_trees=(n_trees>0 & n_trees!=.)

       svy: tabulate n_trees, percent subpop(if farm_size>0 )


    foreach i in n_parcel_Tree_Fruit n_parcel_Tree_Agri {
       gen n_`i'=(`i'>0 & `i'!=.)
       svy: tabulate n_`i', percent subpop(if farm_size>0 )
       }



******* GRAPHS 1: %HH For Different Type of crop (ALL TYPES OF TREES)

     
     foreach i in n_parcel_Tree_Fruit n_parcel_Plant n_parcel_Tree_Agri {
      
      preserve 
      
      
      qui estpost svy: tabulate `i', percent subpop(if farm_size>0 )
        * Getting the data
            mat data=[e(b)',e(lb)',e(ub)']

        matrix colnames data = percent lower upper 

        clear 
        local length=rowsof(data)
        svmat data, names(col)
        drop in `length'
        egen n_plots=seq(), from(0)
      
        *gen the value
       
        graph bar percent, over(n_plots , label(labsize(small)))  ytitle("% HH",size(small))  blabel(bar, position(outside) format(%9.2f) color(black) size(vsmall) justification(left) ) $graph_cofing bar(1,color(gs9)) 

        cd "$graphs/"
        graph export NGA_HH_`i'.png, replace width(4147) height(2250) 
       restore
       }

******* GRAPHS 2: Percentage with plot

        * To estimate the total share of plots with presence of trees


        gen plots=n_parcel_Tree_Fruit+n_parcel_Plant+n_parcel_Tree_Agri

          foreach i in  _Tree_Fruit _Plant _Tree_Agri {
            gen share`i'=(n_parcel`i'/plots)*100
        }

        graph hbar share_Tree_Fruit share_Plant share_Tree_Agri   [pweight=wt_wave1],  ytitle("% of Farms/Plots",size(small))  blabel(bar, position(outside) format(%9.2f) color(black) size(vsmall) justification(left) ) $graph_cofing legend (label  (1 Fruit Trees)   label (2 Plant/Herb/Grass/Roots) label (3 Tree Crop )  ) bar(1,color(cranberry)) bar(2,color(midgreen)) bar(3,color(olive))  
            
            * Colors
            * 1 - Fruit Trees - bar(1,color(cranberry))
            * 2 - Plant/ - bar(2,color(midgreen))
            * 3 - Tree Crop - bar(3,color(olive))

            cd "$graphs/"
          graph export NGA_plot_classification.png, replace width(4147) height(2250) 



******* GRAPHS 3: Type of Crops system

    

         foreach i in  _Tree_Fruit _Plant _Tree_Agri {
            gen share_inter`i'=inter_n`i'/n_parcel`i'
            gen share_nointer`i'=(n_parcel`i'-inter_n`i')/n_parcel`i'
        }

         foreach i in  _Tree_Fruit _Plant _Tree_Agri {


        graph pie share_inter`i' share_nointer`i' [pweight=wt_wave1] ,  plabel(_all percent, format(%9.2f)  )   pie(1, color(ebg) )  pie(1, color(ebblue) )   legend (label  (1 Inter-Cropped) label  (2 Mono-Cropping) )  graphregion(color(white))  legend( region( style(none)) cols(3)  size(small) forcesize ) 

        cd "$graphs/"
        graph export NGA_INTER_`i'.png, replace width(4147) height(2250) 
    }



