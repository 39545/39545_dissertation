//Subgroup Analysis


**# Covid 19 Risk and Risk perception

**************** Graph Subgroups: Generic ****************
		
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf
global outcomes policyindex econindex health_index_all health_index_you 

// Produce and store estimates
local x = 1	
local  y = 1	
local qc = 111		
foreach  sg in $subgroups {
		foreach  outc in $outcomes {	
			reg `outc' i.informationarm#`sg', vce(robust)
				mat `outc' = r(table)
				local b =`outc'[1,4]
				local ll =`outc'[5,4]
				local ul =`outc'[6,4]				
				local p = `outc'[4,4]
				local outcome =`outc'
				local sgmatrix =`sg'
				if `x' == 1 {
				mat results = [`b',`ll',`ul',`y',`x']
				mat qtemp = [`b',`p',`x',`qc']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				}
				else {
				mat matresultstemp = [`b',`ll',`ul',`y',`x']	
				mat results = nullmat(results) \ matresultstemp	
				mat qtemp = [`b',`p',`x',`qc']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				} 				
				local x = `x' + 1
				local q = `q' + 1
				local y = `y' + 1
			}
			local y = 1
			mat empty = [.,.,.,.,`x']
			mat results = nullmat(results) \ empty
			local x = `x' + 1
		}

// prepare datset for graph	
		mat colnames results = "Effectsize" "lb" "ub" "Outcome" "counter"
		mat list results
		cap drop  Effectsize  
		cap drop  lb 
		cap drop  ub 
		cap drop  Outcome 
		cap drop  counter
		svmat results, names(col)
	
twoway ///
(rcap lb ub counter, vert lc(dknavy)) /// code for 95% CI
(scatter Effectsize counter if Outcome ==1, ms(o) mc(blue) msize(large) ) /// dot for group 1
(scatter Effectsize counter if Outcome ==2, ms(t) mc(lavender ) msize(large)  yline(0 , lc(gs1) lw(vthin) lp(shortdash))) /// dot for group 2
(scatter Effectsize counter if Outcome ==3, mcolor(cranberry) xline(5 10 15 20 25 30 , lc(gs14) ) ) /// dot for group 1
(scatter Effectsize counter if Outcome ==4, ms(d) mcolor(navy)) /// dot for group 2
, legend(row(1) order(2 "Policy Support" 3 "Economic RP" 4 "Health RP" 5 "Health RP (LY)") pos(6)) /// legend at 6 o'clock position
	xlabel(2.5 "High RP" 7.5 "R-Lover" 12.5 "Overest." 17.5 "Underest" 22.5 "At Risk", angle(0) noticks) ///
	title("Generic Info Covid Risk") ///
	xtitle(" ") ///
	//ytitle("Y axis") ///
	
graph export "Generic Info Covid Risk.pdf"



**************** Graph Subgroups:Individualised ****************
		
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf
global outcomes policyindex econindex health_index_all health_index_you 

// Produce and store estimates
local x = 1	
local  y = 1			
foreach  sg in $subgroups {
		foreach  outc in $outcomes {	
			reg `outc' i.informationarm#`sg' , vce(robust)
				mat `outc' = r(table)
				local b =`outc'[1,6]
				local ll =`outc'[5,6]
				local ul =`outc'[6,6]
				local p =`outc'[4,6]
				local outcome =`outc'
				local sgmatrix =`sg'
				if `x' == 1 {
				mat results = [`b',`ll',`ul',`y',`x']
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				}
				else {
				mat matresultstemp = [`b',`ll',`ul',`y',`x']	
				mat results = nullmat(results) \ matresultstemp	
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				} 				
				local x = `x' + 1
				local y = `y' + 1
			} 
			local y = 1
			mat empty = [.,.,.,.,`x']
			mat results = nullmat(results) \ empty
			local x = `x' + 1
		}

// prepare datset for graph	
		mat colnames results = "Effectsize" "lb" "ub" "Outcome" "counter"
		mat list results
		cap drop  Effectsize  
		cap drop  lb 
		cap drop  ub 
		cap drop  Outcome 
		cap drop  counter
		svmat results, names(col)
	
twoway ///
(rcap lb ub counter, vert lc(dknavy)) /// code for 95% CI
(scatter Effectsize counter if Outcome ==1, ms(o) mc(blue) msize(large)) /// dot for group 1
(scatter Effectsize counter if Outcome ==2, ms(t) mc(lavender ) msize(large)  yline(0 , lc(gs1) lw(vthin) lp(shortdash))) ///	) /// dot for group 2
(scatter Effectsize counter if Outcome ==3, mcolor(cranberry) xline(5 10 15 20 25 30 , lc(gs14) ) ) /// dot for group 1
(scatter Effectsize counter if Outcome ==4, ms(d) mcolor(navy)) /// dot for group 2
, legend(row(1) order(2 "Policy Support" 3 "Economic RP" 4 "Health RP" 5 "Health RP (LY)") pos(6)) /// legend at 6 o'clock position
	xlabel(2.5 "High RP" 7.5 "R-Lover" 12.5 "Overest." 17.5 "Underest" 22.5 "At Risk", angle(0) noticks) ///
	title("Individualised Info Covid Risk") ///
	xtitle(" ") ///
	
graph export "Individualised Info Covid Risk.pdf"


**# Health and economic vulnurability

**************** Graph Subgroups: Generic ****************
		
global subgroups healthimpact econimpactdummy proximity
global outcomes policyindex econindex health_index_all health_index_you 

// Produce and store estimates
local x = 1	
local  y = 1			
foreach  sg in $subgroups {
		foreach  outc in $outcomes {	
			reg `outc' i.informationarm#`sg', vce(robust)
				mat `outc' = r(table)
				local b =`outc'[1,4]
				local ll =`outc'[5,4]
				local ul =`outc'[6,4]
				local p =`outc'[4,4]
				local outcome =`outc'
				local sgmatrix =`sg'
				if `x' == 1 {
				mat results = [`b',`ll',`ul',`y',`x']
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				}
				else {
				mat matresultstemp = [`b',`ll',`ul',`y',`x']	
				mat results = nullmat(results) \ matresultstemp	
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				} 				
				local x = `x' + 1
				local y = `y' + 1
			}
			local y = 1
			mat empty = [.,.,.,.,`x']
			mat results = nullmat(results) \ empty
			local x = `x' + 1
		}

// prepare datset for graph	
		mat colnames results = "Effectsize" "lb" "ub" "Outcome" "counter"
		mat list results
		cap drop  Effectsize  
		cap drop  lb 
		cap drop  ub 
		cap drop  Outcome 
		cap drop  counter
		svmat results, names(col)
	
twoway ///
(rcap lb ub counter, vert lc(dknavy)) /// code for 95% CI
(scatter Effectsize counter if Outcome ==1, ms(o) mc(blue) msize(large)) /// dot for group 1
(scatter Effectsize counter if Outcome ==2, ms(t) mc(lavender ) msize(large)  yline(0 , lc(gs1) lw(vthin) lp(shortdash))) /// dot for group 2
(scatter Effectsize counter if Outcome ==3, mcolor(cranberry) xline(5 10 15 20 25 30 , lc(gs14) ) ) /// dot for group 1
(scatter Effectsize counter if Outcome ==4, ms(d) mcolor(navy)) /// dot for group 2
, legend(row(1) order(2 "Policy Support" 3 "Economic RP" 4 "Health RP" 5 "Health RP (LY)") pos(6)) /// legend at 6 o'clock position
	xlabel(2.5 "Health impact" 7.5 "Economic Impact" 12.5 "Covid proximity", angle(0) noticks) ///
	title("Generic Info Pandemic Exposure") ///
	xtitle(" ") ///
	//ytitle("Y axis") ///
	
graph export "Generic Info Pandemic Exposure.pdf"

	
**************** Graph Subgroups:Individualised ****************
		
global subgroups healthimpact econimpactdummy  proximity
global outcomes policyindex econindex health_index_all health_index_you 

// Produce and store estimates
local x = 1	
local  y = 1			
foreach  sg in $subgroups {
		foreach  outc in $outcomes {	
			reg `outc' i.informationarm#`sg', vce(robust)
				mat `outc' = r(table)
				local b =`outc'[1,6]
				local ll =`outc'[5,6]
				local ul =`outc'[6,6]
				local p =`outc'[4,6]
				local outcome =`outc'
				local sgmatrix =`sg'
				if `x' == 1 {
				mat results = [`b',`ll',`ul',`y',`x']
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				}
				else {
				mat matresultstemp = [`b',`ll',`ul',`y',`x']	
				mat results = nullmat(results) \ matresultstemp	
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				} 				
				local x = `x' + 1
				local y = `y' + 1
			}
			local y = 1
			mat empty = [.,.,.,.,`x']
			mat results = nullmat(results) \ empty
			local x = `x' + 1
		}
// prepare datset for graph	
		mat colnames results = "Effectsize" "lb" "ub" "Outcome" "counter"
		mat list results
		cap drop  Effectsize  
		cap drop  lb 
		cap drop  ub 
		cap drop  Outcome 
		cap drop  counter
		svmat results, names(col)
	
twoway ///
(rcap lb ub counter, vert lc(dknavy)) /// code for 95% CI
(scatter Effectsize counter if Outcome ==1, ms(o) mc(blue) msize(large)) /// dot for group 1
(scatter Effectsize counter if Outcome ==2, ms(t) mc(lavender ) msize(large)  yline(0 , lc(gs1) lw(vthin) lp(shortdash))) /// dot for group 2
(scatter Effectsize counter if Outcome ==3, mcolor(cranberry) xline(5 10 15 20 25 30 , lc(gs14) ) ) /// dot for group 1
(scatter Effectsize counter if Outcome ==4, ms(d) mcolor(navy)) /// dot for group 2
, legend(row(1) order(2 "Policy Support" 3 "Economic RP" 4 "Health RP" 5 "Health RP (LY)") pos(6)) /// legend at 6 o'clock position
	xlabel(2.5 "Health impact" 7.5 "Economic Impact" 12.5 "Covid proximity", angle(0) noticks) ///
	title("Individualised Info Pandemic Exposure") ///
	xtitle(" ") ///
	//ytitle("Y axis") ///
	
graph export "Individualised Info Pandemic Exposure.pdf"

	
**# Socioeconomic and Demographic

**************** Graph Subgroups: Generic ****************
		
global subgroups agerf male basiced 
global outcomes policyindex econindex health_index_all health_index_you 

// Produce and store estimates
local x = 1	
local  y = 1			
foreach  sg in $subgroups {
		foreach  outc in $outcomes {	
			reg `outc' i.informationarm#`sg', vce(robust)
				mat `outc' = r(table)
				local b =`outc'[1,4]
				local ll =`outc'[5,4]
				local ul =`outc'[6,4]
				local p =`outc'[4,4]
				local outcome =`outc'
				local sgmatrix =`sg'
				if `x' == 1 {
				mat results = [`b',`ll',`ul',`y',`x']
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				}
				else {
				mat matresultstemp = [`b',`ll',`ul',`y',`x']	
				mat results = nullmat(results) \ matresultstemp	
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				} 				
				local x = `x' + 1
				local y = `y' + 1
			}
			local y = 1
			mat empty = [.,.,.,.,`x']
			mat results = nullmat(results) \ empty
			local x = `x' + 1
		}

		mat colnames results = "Effectsize" "lb" "ub" "Outcome" "counter"
		mat list results
		cap drop  Effectsize  
		cap drop  lb 
		cap drop  ub 
		cap drop  Outcome 
		cap drop  counter
		svmat results, names(col)
	
twoway ///
(rcap lb ub counter, vert lc(dknavy)) /// code for 95% CI
(scatter Effectsize counter if Outcome ==1, ms(o) mc(blue) msize(large)) /// dot for group 1
(scatter Effectsize counter if Outcome ==2, ms(t) mc(lavender ) msize(large)  yline(0 , lc(gs1) lw(vthin) lp(shortdash))) /// dot for group 2
(scatter Effectsize counter if Outcome ==3, mcolor(cranberry) xline(5 10 15 20 25 30 , lc(gs14) ) ) /// dot for group 1
(scatter Effectsize counter if Outcome ==4, ms(d) mcolor(navy)) /// dot for group 2
, legend(row(1) order(2 "Policy Support" 3 "Economic RP" 4 "Health RP" 5 "Health RP (LY)") pos(6)) /// legend at 6 o'clock position
	xlabel(2.5 "Over 60" 7.5 "Male" 12.5 "Completed basic education", angle(0) noticks) ///
	title("Generic Info Demographic and Socioeconomic") ///
	xtitle(" ") ///
	//ytitle("Y axis") ///
	
graph export "Generic Info Demographic and Socioeconomic.pdf"

	
**************** Graph Subgroups:Individualised ****************
		
global subgroups agerf male basiced 
global outcomes policyindex econindex health_index_all health_index_you 

// Produce and store estimates
local x = 1	
local  y = 1			
foreach  sg in $subgroups {
		foreach  outc in $outcomes {	
			reg `outc' i.informationarm#`sg', vce(robust)
				mat `outc' = r(table)
				local b =`outc'[1,4]
				local ll =`outc'[5,6]
				local ul =`outc'[6,6]
				local p =`outc'[4,6]
				local outcome =`outc'
				local sgmatrix =`sg'
				if `x' == 1 {
				mat results = [`b',`ll',`ul',`y',`x']
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				}
				else {
				mat matresultstemp = [`b',`ll',`ul',`y',`x']	
				mat results = nullmat(results) \ matresultstemp	
				mat qtemp = [`b',`p',`x']
				mat qvalues  = nullmat(qvalues)  \ qtemp
				} 				
				local x = `x' + 1
				local y = `y' + 1
			}
			local y = 1
			mat empty = [.,.,.,.,`x']
			mat results = nullmat(results) \ empty
			local x = `x' + 1
		}
// prepare datset for graph	
		mat colnames results = "Effectsize" "lb" "ub" "Outcome" "counter"
		mat list results
		cap drop  Effectsize  
		cap drop  lb 
		cap drop  ub 
		cap drop  Outcome 
		cap drop  counter
		svmat results, names(col)
	
twoway ///
(rcap lb ub counter, vert lc(dknavy)) /// code for 95% CI
(scatter Effectsize counter if Outcome ==1, ms(o) mc(blue) msize(large)) /// dot for group 1
(scatter Effectsize counter if Outcome ==2, ms(t) mc(lavender ) msize(large)  yline(0 , lc(gs1) lw(vthin) lp(shortdash))) /// dot for group 2
(scatter Effectsize counter if Outcome ==3, mcolor(cranberry) xline(5 10 15 20 25 30 , lc(gs14) ) ) /// dot for group 1
(scatter Effectsize counter if Outcome ==4, ms(d) mcolor(navy)) /// dot for group 2
, legend(row(1) order(2 "Policy Support" 3 "Economic RP" 4 "Health RP" 5 "Health RP (LY)") pos(6)) /// legend at 6 o'clock position
	xlabel(2.5 "Over 60" 7.5 "Male" 12.5 "Completed basic education", angle(0) noticks) ///
	title("Individualised Info Demographic and Socioeconomic") ///
	xtitle(" ") ///
	//ytitle("Y axis") ///
	
graph export "Individualised Info Demographic and Socioeconomic.pdf"


// 
svmat qvalues, names(col)

*************************************** SG WTP *********

logit information_demand_covid_fu priceinf i.informationarm
margins, dydx(i.informationarm)
outreg2 using myfile, ctitle(margins) see

global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf healthimpact econimpactdummy proximity 
mat wtpsg = [.,.,.,.,.]

// Produce and store estimates
local x = 1	
local  y = 1			
foreach  sg in $subgroups {
			logit information_demand_covid_fu priceinf i.informationarm#`sg' $controlvlist, vce(robust)
			margins, dydx(i.informationarm)
				mat results = r(table)
				local bg = results[1,2]
				local serg = results[2,2]
				local pg =results[4,2]
				local zg = results[3,2]
				local bi = results[1,3]
				local seri = results[2,3]
				local pi =results[4,3]
				local zi = results[3,3]
				mat wtpsgtemp = [`bg',`zg',`pg',`serg',`x']
				mat wtpsg  = nullmat(wtpsg)  \ wtpsgtemp	
				local x = `x' + 1
				mat wtpsgtemp = [`bi',`zi',`pi',`seri',`x']
				mat wtpsg  = nullmat(wtpsg)  \ wtpsgtemp	
				local x = `x' + 1		
			}

logit information_demand_covid_fu priceinf i.informationarm $controlvlist, vce(robust)
margins, dydx(i.informationarm)
				mat results = r(table)
				global bg = results[1,2]
				global serg = results[2,2]
				global pg =results[4,2]
				global zg = results[3,2]
				global bi = results[1,3]
				global seri = results[2,3]
				global pi =results[4,3]
				global zi = results[3,3]
				mat wtpsgtemp = [`bg',`zg',`pg',`serg',`x']
				mat wtpsg  = nullmat(wtpsg)  \ wtpsgtemp	
				mat wtpsgtemp = [`bi',`zi',`pi',`seri',`x']
				mat wtpsg  = nullmat(wtpsg)  \ wtpsgtemp	


mat colnames wtpsg = "Effectsize" "Z score" "P > z" "SE" "counter"
mat list wtpsg


****************************** Appendix: SG Indices

/* Omitted Controls */

///////// Population Health
clear all
use "/Users/jonas/Dropbox/Salvador - covid information risk/data/DESSAP COVID copy.dta"
do "/Users/jonas/Dropbox/Salvador - covid information risk/dofiles/Covid Risk Manipulation.do"
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf healthimpact econimpactdummy proximity 
foreach sg in $subgroups {
			eststo:reg health_index_all i.informationarm#`sg', vce(robust)
}
esttab using "output/Heterogeneous/population health woc Heterogeneous.csv", se star(* .10 ** .05 *** .01) r2 
clear all
use "/Users/jonas/Dropbox/Salvador - covid information risk/data/DESSAP COVID copy.dta"
do "/Users/jonas/Dropbox/Salvador - covid information risk/dofiles/Covid Risk Manipulation.do"
///////// Personal Health
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf healthimpact econimpactdummy proximity 
foreach sg in $subgroups {
			eststo:reg health_index_you i.informationarm#`sg', vce(robust)
}
esttab using "output/Heterogeneous/personal health woc Heterogeneous.csv", se star(* .10 ** .05 *** .01) r2
clear all
use "/Users/jonas/Dropbox/Salvador - covid information risk/data/DESSAP COVID copy.dta"
do "/Users/jonas/Dropbox/Salvador - covid information risk/dofiles/Covid Risk Manipulation.do"
///////// Econ 
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf healthimpact econimpactdummy proximity 
foreach sg in $subgroups {
			eststo:reg econindex i.informationarm#`sg', vce(robust)
}
esttab using "output/Heterogeneous/econ risk woc Heterogeneous.csv", se star(* .10 ** .05 *** .01) r2 
clear all
use "/Users/jonas/Dropbox/Salvador - covid information risk/data/DESSAP COVID copy.dta"
do "/Users/jonas/Dropbox/Salvador - covid information risk/dofiles/Covid Risk Manipulation.do"
///////// Policy 
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf healthimpact econimpactdummy proximity 
foreach sg in $subgroups {
			eststo:reg policyindex i.informationarm#`sg', vce(robust)
}
esttab using "output/Heterogeneous/policy woc Heterogeneous.csv",se star(* .10 ** .05 *** .01) r2

/* Included Controls */

///////// Population Health
clear all
use "/Users/jonas/Dropbox/Salvador - covid information risk/data/DESSAP COVID copy.dta"
do "/Users/jonas/Dropbox/Salvador - covid information risk/dofiles/Covid Risk Manipulation.do"
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf healthimpact econimpactdummy proximity 
foreach sg in $subgroups {
			eststo:reg health_index_all i.informationarm#`sg' $controlvlist, vce(robust)
}
esttab using "output/Heterogeneous/population health wc Heterogeneous.csv", se star(* .10 ** .05 *** .01) r2 drop($controlvlist)
clear all
use "/Users/jonas/Dropbox/Salvador - covid information risk/data/DESSAP COVID copy.dta"
do "/Users/jonas/Dropbox/Salvador - covid information risk/dofiles/Covid Risk Manipulation.do"
///////// Personal Health
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf healthimpact econimpactdummy proximity 
foreach sg in $subgroups {
			eststo:reg health_index_you i.informationarm#`sg' /*$controlvlist*/, vce(robust)
}
esttab using "output/Heterogeneous/personal health wc Heterogeneous.csv", se star(* .10 ** .05 *** .01) r2 drop($controlvlist)
clear all
use "/Users/jonas/Dropbox/Salvador - covid information risk/data/DESSAP COVID copy.dta"
do "/Users/jonas/Dropbox/Salvador - covid information risk/dofiles/Covid Risk Manipulation.do"
///////// Econ 
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf healthimpact econimpactdummy proximity 
foreach sg in $subgroups {
			eststo:reg econindex i.informationarm#`sg' $controlvlist, vce(robust)
}
esttab using "output/Heterogeneous/econ risk wc Heterogeneous.csv", se star(* .10 ** .05 *** .01) r2 drop($controlvlist)
clear all
use "/Users/jonas/Dropbox/Salvador - covid information risk/data/DESSAP COVID copy.dta"
do "/Users/jonas/Dropbox/Salvador - covid information risk/dofiles/Covid Risk Manipulation.do"
///////// Policy 
global subgroups covid_severidad_covid_fu riskl overestimate underestimate hasrf healthimpact econimpactdummy proximity 
foreach sg in $subgroups {
			eststo:reg policyindex i.informationarm#`sg' $controlvlist, vce(robust) 
}
esttab using "output/Heterogeneous/policy wc Heterogeneous.csv",se star(* .10 ** .05 *** .01) r2 drop($controlvlist)


********* Appendix indices
global outcomes health_index_all health_index_you econindex policyindex

foreach var in $outcomes {
	eststo:reg `var' i.informationarm
}

esttab using "output/appendix indices woc.csv",se star(* .10 ** .05 *** .01) r2












