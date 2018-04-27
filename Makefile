###########################################
# Step 0: Distribute functions
###########################################

TASK_0=commonfunctions/code

###########################################
# Step 1: Install packages
###########################################

TASK_1=install_packages/code

###########################################
# Step 2: Generate dta files
###########################################

# Initial data
TASK_2=initialdata/code

# Generates choicesets and estimation arrays for standard specifications
TASK_3=estarrays_DTAs/code

# Estimation arrays for nested logit
TASK_4=estarrays_nestedlogit_DTAs/code

# Estimation arrays for standard venue FE
TASK_5=estarrays_venueFE_DTAs/code

# Estimation arrays for Taddy venue FE
TASK_6=estarrays_venueFE_Taddy_DTAs/code

############################################
# Step 3: Summary stats
############################################

TASK_7=venues_YelpvsDOHMH/code

TASK_8=summarystats/code

TASK_9=schelling_checks/code

############################################
# Step 4: Estimation
############################################

# Standard estimates
TASK_10=estimate_MNL_specs/code

# Nested logit estimates
TASK_11=estimate_nestedlogit/code

# venue FE estimates
TASK_12=estimate_venueFE/code
TASK_13=observables_vs_FE/code

# Taddy venue FE estimates
TASK_14=estimate_venueFE_Taddy/code

#############################################
# Step 5: Generate predicted visits array
#############################################

# In sample arrays
TASK_15=predictvisits_estsmp_arrays/code

# OOS arrays
TASK_16=predictvisits_array/code

# Counterfactual arrays
TASK_17=counterfactuals_DTAs/code
TASK_18=predictvisits_counterfactuals_arrays/code

# Gentrification data
TASK_19=gentrify_DTAs/code

#############################################
# Step 6: Compute predicted visits
#############################################

# In sample P_ij
TASK_20=predictvisits_estsmp/code

# OOS P_ij
TASK_21=predictvisits/code

# Counterfactual P_ij
TASK_22=predictvisits_counterfactuals/code

# Gentrification P_ij
TASK_23=predictvisits_gentrification/code

# In sample P_ij for nested logit specification
TASK_24=predictvisits_estsmp_nested/code

#############################################
# Step 7: Compute dissimilarity
#############################################

# dissimilarity
TASK_25=dissimilarity_computations/code

# dissimilarity counterfactual
TASK_26=dissimilarity_computations_counterfactuals/code

#############################################
# Step 8: Dissimilarity tables
#############################################

# dissimilarity tables
TASK_27=dissimilarity_TeXtables/code

# dissimilarity tables for counterfactual
TASK_28=dissimilarity_TeXtables_counterfactuals/code

#############################################
# Step 9: Bootstrap estimation array
#############################################

#22) simulated trips for bootstrap exercise
TASK_29=isoindex_specs/code

#23) generate bootstrap estimation arrays
TASK_30=bootstrap_estarrays/code

#############################################
# Step 10: Bootstrap estimation
#############################################

#24) estimation using bootrap estimation arrays
TASK_31=estimate_MNL_specs_bootstrap/code

#############################################
# Step 11: Bootstrap predicted visits
#############################################

# OOS Predicted visits using bootstrap estimates
TASK_32=predictvisits_bootstrap/code

# In sample predicted visits using bootstrap estimates
TASK_33=predictvisits_estsmp_bootstrap/code

# Predicted visits using bootstrap average
TASK_34=predictvisits_estsmp_betabsavg/code

#############################################
# Step 12: Bootstrap dissimilarity
#############################################

# dissimilarity using bootstrap predicted visits
TASK_35=dissimilarity_computations_bootstrap/code

#############################################
# Step 13: Bootstrap dissmilarity stderr
#############################################

TASK_36=dissimilarity_stderr/code

#############################################
# Step 14: Plot bootstrap dissmilarities
#############################################

TASK_37=dissimilarity_bootstrap_plot/code

#############################################
# Step 15: Bootstrap isolation index
#############################################

TASK_38=isoindex_bootstrap/code

TASK_39=isoindex_specs_bsavg/code

#############################################
# Step 16: dot maps
#############################################

TASK_40=dot_maps/code

#####################################################
# Step 17: Simulation of model with permanent shocks
#####################################################

TASK_41=simulation_permanent_shocks/code

#################################################################
# Step 18: Testing choice sets and consistency in simulated data
#################################################################

TASK_42=simulate_estimator/code

##################################################################
# Step 19: Insert figures in PDF
##################################################################

TASK_43=tablesPDF/code

#Quickly computed results
TASK_44=tablesPDF_simple/code

#####################
# Work section
#####################

full_version:
	$(MAKE) -C $(TASK_0)
	$(MAKE) -C $(TASK_1)
	$(MAKE) -C $(TASK_2)
	$(MAKE) -C $(TASK_3)
	$(MAKE) -C $(TASK_4)
	$(MAKE) -C $(TASK_5)
	$(MAKE) -C $(TASK_6)
	$(MAKE) -C $(TASK_7)
	$(MAKE) -C $(TASK_8)
	$(MAKE) -C $(TASK_9)
	$(MAKE) -C $(TASK_10)
	$(MAKE) -C $(TASK_11)
	$(MAKE) -C $(TASK_12)
	$(MAKE) -C $(TASK_13)
	$(MAKE) -C $(TASK_14)
	$(MAKE) -C $(TASK_15)
	$(MAKE) -C $(TASK_16)
	$(MAKE) -C $(TASK_17)
	$(MAKE) -C $(TASK_18)
	$(MAKE) -C $(TASK_19)
	$(MAKE) -C $(TASK_20)
	$(MAKE) -C $(TASK_21)
	$(MAKE) -C $(TASK_22)
	$(MAKE) -C $(TASK_23)
	$(MAKE) -C $(TASK_24)
	$(MAKE) -C $(TASK_25)
	$(MAKE) -C $(TASK_26)
	$(MAKE) -C $(TASK_27)
	$(MAKE) -C $(TASK_28)
	$(MAKE) -C $(TASK_29)
	$(MAKE) -C $(TASK_30)
	$(MAKE) -C $(TASK_31)
	$(MAKE) -C $(TASK_32) import_bootstrap_estimates
	$(MAKE) -C $(TASK_32) all
	$(MAKE) -C $(TASK_33) import_bootstrap_estimates
	$(MAKE) -C $(TASK_33) all
	$(MAKE) -C $(TASK_34)
	$(MAKE) -C $(TASK_35) import_bootstrap_estimates
	$(MAKE) -C $(TASK_35) all 
	$(MAKE) -C $(TASK_36)
	$(MAKE) -C $(TASK_37)
	$(MAKE) -C $(TASK_38)
	$(MAKE) -C $(TASK_39)
	$(MAKE) -C $(TASK_40)
	$(MAKE) -C $(TASK_41)
	$(MAKE) -C $(TASK_42)
	$(MAKE) -C $(TASK_43)

quick_version:
	$(MAKE) -C $(TASK_0)
	$(MAKE) -C $(TASK_1)
	$(MAKE) -C $(TASK_2)
	$(MAKE) -C $(TASK_3)
	$(MAKE) -C $(TASK_4)
	$(MAKE) -C $(TASK_7)
	$(MAKE) -C $(TASK_8)
	$(MAKE) -C $(TASK_9)
	$(MAKE) -C $(TASK_10)
	$(MAKE) -C $(TASK_15)
	$(MAKE) -C $(TASK_16)
	$(MAKE) -C $(TASK_17)
	$(MAKE) -C $(TASK_18)
	$(MAKE) -C $(TASK_19)
	$(MAKE) -C $(TASK_20)
	$(MAKE) -C $(TASK_21) all_quick_version
	$(MAKE) -C $(TASK_22)
	$(MAKE) -C $(TASK_23)
	$(MAKE) -C $(TASK_25) all_quick_version
	$(MAKE) -C $(TASK_26)
	$(MAKE) -C $(TASK_27) all_quick_version
	$(MAKE) -C $(TASK_28)
	$(MAKE) -C $(TASK_29) all_quick_version
	$(MAKE) -C $(TASK_40)
	$(MAKE) -C $(TASK_41)
	$(MAKE) -C $(TASK_42)
	$(MAKE) -C $(TASK_44)