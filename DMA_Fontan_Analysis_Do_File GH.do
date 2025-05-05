use "/Users/DustinAnderson/Desktop/fontan stata dataset.dta"


*=====VO2 Analysis=====


//Meta-analysis for VO2m %Pred
meta esize N_LEFT_CONTROL VO2M_LEFT_PRED VO2M_LEFT_SD_PRED N_RIGHT_INTERV VO2M_RIGHT_PRED VO2M_RIGHT_SD_PRED, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Favors Left Ventricle)) xlabel(-30(10)30) title("Peak VO2 (%Predicted)") xtitle("Effect Size")
meta funnelplot, title("Peak VO2 (%Pred)")
meta bias, egger
*Meta regression
meta regress TIME_FONTAN_TO_CPET, random(dlaird)
estat bubbleplot, title("Peak VO2 (%Pred)") ytitle("Effect size (SMD)")

*VO2 %Predicted Sensitivity Analyses:
**Excluding smallest 25%ile
meta esize N_LEFT_CONTROL VO2M_LEFT_PRED VO2M_LEFT_SD_PRED N_RIGHT_INTERV VO2M_RIGHT_PRED VO2M_RIGHT_SD_PRED if STUDIES25ILE == 1 , esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(#5) title("Peak VO2 (%Pred) excluding smallest 25% of studies") xtitle("Effect Size")
**Excluding abstracts/unpublished data
meta esize N_LEFT_CONTROL VO2M_LEFT_PRED VO2M_LEFT_SD_PRED N_RIGHT_INTERV VO2M_RIGHT_PRED VO2M_RIGHT_SD_PRED if ABS_OR_UNPUB == 0 , esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(#5) title("Peak VO2 (%Pred) excluding abstracts and unpublished data") xtitle("Effect Size")
**Excluding LV/Mixed combined
meta esize N_LEFT_CONTROL VO2M_LEFT_PRED VO2M_LEFT_SD_PRED N_RIGHT_INTERV VO2M_RIGHT_PRED VO2M_RIGHT_SD_PRED if LV_MIXED_COMBINED == 0 , esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(#5) title("Peak VO2 (%Pred) excluding combined LV/Mixed") xtitle("Effect Size")


//Meta-analysis for VO2m mL/min
meta esize N_LEFT_CONTROL VO2M_LEFT_MLMIN VO2M_LEFT_SD_MLMIN N_RIGHT_INTERV VO2M_RIGHT_MLMIN VO2M_RIGHT_SD_MLMIN, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Favors Left Ventricle)) xlabel(#5) title("Peak VO2 (ml/min)") xtitle("Effect Size")
meta funnel, title("Peak VO2 (mL/min)")
meta bias, egger


//Meta-analysis for VO2m mL/kg/min
meta esize N_LEFT_CONTROL VO2M_LEFT_MLMINKG VO2M_LEFT_SD_MLMINKG N_RIGHT_INTERV VO2M_RIGHT_MLMINKG VO2M_RIGHT_SD_MLMINKG, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Favors Left Ventricle)) xlabel(-30(10)30) title("Peak VO2 (mL/kg/min)") xtitle("Effect Size")
meta funnel, title("Peak VO2 (mL/kg/min)")
meta bias, egger

//Full Analysis for VO2m SMD 
*Meta-analysis generation:
meta esize N_LEFT_CONTROL VO2M_LEFT_ALL VO2M_LEFT_SD_ALL N_RIGHT_INTERV VO2M_RIGHT_ALL VO2M_RIGHT_SD_ALL , esize(hedgesg) studylabel(STUDY_LABEL) eslabel(St. Mean Diff.) random(dlaird)
*Forest plot separated by type of VO2m 
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) subgroup (VO2M_TYPE) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("Peak VO2 (All)") xtitle("Effect Size")
*Meta regression Time to CPET
meta regress TIME_FONTAN_TO_CPET, random(dlaird)
estat bubbleplot, title("Peak VO2 (All) and Time from Fontan to CPET")
*Meta regression Percent Atriopulm connection
meta regress PERCENT_ATRIOPULM, random(dlaird)
estat bubbleplot, title("Peak VO2 (All) and % Atriopulmonary Connection")
*Meta regression Percent TCPC
meta regress  PERCENT_TCPC, random(dlaird)
estat bubbleplot
*Meta regression Percent Lateral Tunnel
meta regress PERCENT_LATTUN, random(dlaird)
estat bubbleplot
*Bias assessment
meta funnel, title("Peak VO2 (All)")
meta funnelplot, contours (1 5 10) title("Peak VO2 (All)")
meta trimfill if !missing(VO2M_LEFT_ALL), estimator(run) funnel (contours ( 1 5 10))
meta bias, egger

*SMD Sensitivity Analyses:
**Excluding smallest 25%ile
***summ N_TOTAL, detail
***gen STUDIES25ILE = N_TOTAL >= r(p25)
meta esize N_LEFT_CONTROL VO2M_LEFT_ALL VO2M_LEFT_SD_ALL N_RIGHT_INTERV VO2M_RIGHT_ALL VO2M_RIGHT_SD_ALL if STUDIES25ILE == 1 , esize(hedgesg) random(dlaird) studylabel(STUDY_LABEL) eslabel(SMD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) subgroup (VO2M_TYPE) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title(" Peak VO2 (All) Excluding Smallest 25% of studies") xtitle("Effect Size")
estat bubbleplot, title("Peak VO2 (All) Excluding Smallest 25% of studies") ytitle("Effect size (SMD)")

**Excluding abstracts/unpublished data
meta esize N_LEFT_CONTROL VO2M_LEFT_ALL VO2M_LEFT_SD_ALL N_RIGHT_INTERV VO2M_RIGHT_ALL VO2M_RIGHT_SD_ALL if ABS_OR_UNPUB == 0 , esize(hedgesg) random(dlaird) studylabel(STUDY_LABEL) eslabel(SMD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) subgroup (VO2M_TYPE) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("Peak VO2 (All) excluding abstracts and unpublished data") xtitle("Effect Size")
meta bias, egger

**Excluding LV/Mixed combined
meta esize N_LEFT_CONTROL VO2M_LEFT_ALL VO2M_LEFT_SD_ALL N_RIGHT_INTERV VO2M_RIGHT_ALL VO2M_RIGHT_SD_ALL if LV_MIXED_COMBINED == 0 , esize(hedgesg) random(dlaird) studylabel(STUDY_LABEL) eslabel(SMD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) subgroup (VO2M_TYPE) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("Peak VO2 excluding combined LV/Mixed") xtitle("Effect Size")
meta bias, egger

*Subgroup Analysis CPET Method
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) subgroup (CPETMETHOD) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("Peak VO2 by CPET type") xtitle("Effect Size")


*=====O2 pulse Analysis=====


//Meta-analysis for O2 Pulse %Pred
meta esize N_LEFT_CONTROL O2_PULSE_LEFT_PRED O2P_LEFT_SD_PRED N_RIGHT_INTERV O2_PULSE_RIGHT_PRED O2P_RIGHT_SD_PR, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Favors Left Ventricle)) xlabel(-10(5)30) title("O2 Pulse (%Predicted)") xtitle("Effect Size")
meta funnel, title("O2 pulse (% Predicted)")
meta bias, egger

//Meta-analysis for O2 Pulse mL/beat
meta esize N_LEFT_CONTROL O2_PULSE_LEFT_MLMIN O2P_LEFT_SD_MLMIN N_RIGHT_INTERV O2_PULSE_RIGHT_MLMIN O2P_RIGHT_SD_MLMIN, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Favors Left Ventricle)) xlabel(-10(5)10) title("O2 Pulse (mL/Beat)") xtitle("Effect Size")
meta funnel, title("O2 pulse (mL/Beat)")
meta bias, egger

//O2 Pulse SMD
*Meta-analysis generation:
meta esize N_LEFT_CONTROL O2_Pulse_All_Left O2_Pulse_All_Left_SD N_RIGHT_INTERV O2_Pulse_All_Right O2_Pulse_All_Right_SD, esize(hedgesg) studylabel(STUDY_LABEL) eslabel(St. Mean Diff.) random(dlaird)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Favors Left Ventricle)) xlabel(-3(1)3) title("O2 Pulse (All)") xtitle("Effect Size")
*Meta-bias
meta funnel, title("O2 pulse (All)")
meta bias, egger

*O2Pulse All Sensitivity Analyses:
**Excluding smallest 25%ile
meta esize N_LEFT_CONTROL O2_Pulse_All_Left O2_Pulse_All_Left_SD N_RIGHT_INTERV O2_Pulse_All_Right O2_Pulse_All_Right_SD if STUDIES25ILE == 1, esize(hedgesg) studylabel(STUDY_LABEL) eslabel(St. Mean Diff.) random(dlaird)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("O2 Pulse (All) excluding smallest 25% of studies") xtitle("Effect Size")
**Excluding abstracts/unpublished data
meta esize N_LEFT_CONTROL O2_Pulse_All_Left O2_Pulse_All_Left_SD N_RIGHT_INTERV O2_Pulse_All_Right O2_Pulse_All_Right_SD if ABS_OR_UNPUB == 0, esize(hedgesg) studylabel(STUDY_LABEL) eslabel(St. Mean Diff.) random(dlaird)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("O2 Pulse (All) excluding abstracts and unpublished data") xtitle("Effect Size")
**Excluding LV/Mixed combined
meta esize N_LEFT_CONTROL O2_Pulse_All_Left O2_Pulse_All_Left_SD N_RIGHT_INTERV O2_Pulse_All_Right O2_Pulse_All_Right_SD if LV_MIXED_COMBINED == 0, esize(hedgesg) studylabel(STUDY_LABEL) eslabel(St. Mean Diff.) random(dlaird)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("O2 Pulse (All) excluding combined LV/Mixed") xtitle("Effect Size")


*=====VE/VCO2 Analysis=====


//Meta-analysis for VE/VCO2
meta esize N_LEFT_CONTROL VEVCO2_LEFT VEVCO2_LEFT_SD N_RIGHT_INTERV VEVCO2_RIGHT VEVCO2_RIGHT_SD, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-30(10)30) title("VE/VCO2") xtitle("Effect Size")
meta funnel, title("VE/VCO2")
meta bias, egger
meta funnelplot, contours ( 1 5 10) title("VE/VCO2")
meta trimfill if !missing(VEVCO2_LEFT), estimator(run) funnel (contours ( 1 5 10))

*VE/VCO2 Sensitivity Analyses:
**Excluding smallest 25%ile
meta esize N_LEFT_CONTROL VEVCO2_LEFT VEVCO2_LEFT_SD N_RIGHT_INTERV VEVCO2_RIGHT VEVCO2_RIGHT_SD if STUDIES25ILE == 1, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(#5) title("VE/VCO2 Excluding Smallest 25% of studies") xtitle("Effect Size")
**Excluding abstracts/unpublished data
meta esize N_LEFT_CONTROL VEVCO2_LEFT VEVCO2_LEFT_SD N_RIGHT_INTERV VEVCO2_RIGHT VEVCO2_RIGHT_SD if ABS_OR_UNPUB == 0, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(#5) title("VE/VCO2 excluding abstracts and unpublished data") xtitle("Effect Size")
**Excluding LV/Mixed combined
meta esize N_LEFT_CONTROL VEVCO2_LEFT VEVCO2_LEFT_SD N_RIGHT_INTERV VEVCO2_RIGHT VEVCO2_RIGHT_SD if LV_MIXED_COMBINED == 0, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(#5) title("VE/VCO2 excluding combined LV/Mixed") xtitle("Effect Size")


*=====VAT Analysis=====


//Meta-analysis for VAT L/min
meta esize N_LEFT_CONTROL VAT_LEFT_LMIN VAT_LEFT_LMIN_SD N_RIGHT_INTERV VAT_RIGHT_LMIN VAT_RIGHT_LMIN_SD, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Favors Left Ventricle)) xlabel(#5) title("VAT (L/min)") xtitle("Effect Size")
meta funnel, title("VAT (L/min)")
meta bias, egger

//Meta-analysis for VAT mL/kg/min
meta esize N_LEFT_CONTROL VAT_LEFT_MLMINKG VAT_LEFT_SD_MLMINKG N_RIGHT_INTERV VAT_RIGHT_MLMINKG VAT__RIGHT_SD_MLMINKG, esize(mdiff) random(dlaird) studylabel(AUTHOR) eslabel(MD)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Favors Left Ventricle)) xlabel(-9(3)9) title("VAT (mL/kg/min)") xtitle("Effect Size")
meta funnel, title("VAT (mL/kg/min)")
meta bias, egger

//VAT SMD
*Meta-analysis generation:
meta esize N_LEFT_CONTROL VAT_LEFT_ALL VAT_LEFT_ALL_SD N_RIGHT_INTERV VAT_RIGHT_ALL VAT_RIGHT_ALL_SD, esize(hedgesg) studylabel(STUDY_LABEL) eslabel(St. Mean Diff.) random(dlaird)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Favors Left Ventricle)) xlabel(-3(1)3) title("VAT (All)") xtitle("Effect Size")
*Meta-bias
meta funnel, title("VAT (All)")
meta bias, egger

*VAT All Sensitivity Analyses:
**Excluding smallest 25%ile
meta esize N_LEFT_CONTROL VAT_LEFT_ALL VAT_LEFT_ALL_SD N_RIGHT_INTERV VAT_RIGHT_ALL VAT_RIGHT_ALL_SD if STUDIES25ILE == 1, esize(hedgesg) studylabel(STUDY_LABEL) eslabel(St. Mean Diff.) random(dlaird)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("VAT (All) excluding smallest 25% of studies") xtitle("Effect Size")
**Excluding abstracts/unpublished data
meta esize N_LEFT_CONTROL VAT_LEFT_ALL VAT_LEFT_ALL_SD N_RIGHT_INTERV VAT_RIGHT_ALL VAT_RIGHT_ALL_SD if ABS_OR_UNPUB == 0, esize(hedgesg) studylabel(STUDY_LABEL) eslabel(St. Mean Diff.) random(dlaird)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("VAT (All) excluding abstracts and unpublished data") xtitle("Effect Size")
**Excluding LV/Mixed combined
meta esize N_LEFT_CONTROL VAT_LEFT_ALL VAT_LEFT_ALL_SD N_RIGHT_INTERV VAT_RIGHT_ALL VAT_RIGHT_ALL_SD if LV_MIXED_COMBINED == 0, esize(hedgesg) studylabel(STUDY_LABEL) eslabel(St. Mean Diff.) random(dlaird)
meta forestplot, columnopts(_data1, supertitle(Left Ventricle)) columnopts(_data2, supertitle(Right Ventricle)) nullrefline(favorsright(Left Ventricle) favorsleft(Right Ventricle)) xlabel(-2(1)3) title("VAT (All) excluding combined LV/Mixed") xtitle("Effect Size")
