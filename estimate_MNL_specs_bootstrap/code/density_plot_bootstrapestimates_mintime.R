############################################################################################################
# Author: Kevin Dano
# Date: April 2018
# Objective: Produce density plots of the bootstrap estimates for the fastestmode specification
############################################################################################################

#######################
# Computing Ressources
#######################

#Clean directory
rm(list=ls())

# Load libraries
packages = c("dplyr","tidyr","purrr","data.table","stringr","ggplot2","latex2exp","tikzDevice","scales","Cairo","ggpubr","cowplot")
lapply(packages,require,character.only=TRUE)

#Specify path data
specification="mintime"

path_data_bootstrap = paste0("../output/estimates/",specification,"/")
path_data_MLE =  paste0("../input/estimates/",specification,"/")
path_plots = paste0("../output/figures/",specification,"/")

###########################################
# Functions
###########################################

source("density_plots_bootstrapestimates_functions.R")

###############################################################################################################################################################################################################################################################
# MINTIME SPECIFICATION
###############################################################################################################################################################################################################################################################

###############################################################################################################################################################################################################################################################
# Black users
###############################################################################################################################################################################################################################################################

raceid ="black"

#Load data
data_bootstrap = read.csv(paste0(path_data_bootstrap,"estimates_",raceid,"_",specification,"_bootstrap_clean.csv"))
data_MLE = read.csv(paste0(path_data_MLE,"estimates_",raceid,"_mainspec.csv"))

#Time covariates
plot_time_minimum_log_black = plot_density_covariates(data_bootstrap,data_MLE,"time_minimum_log","Minimum of log travel time",path_plots,adjust=5,paste0("density_time_home_log_",raceid,"_",specification,".pdf"),export_plot = 1)

#EDD
plot_EDD = plot_density_covariates(data_bootstrap,data_MLE,"eucl_demo_distance","Euclidean demographic distance",path_plots,adjust=3,paste0("density_EDD_",raceid,"_",specification,".pdf"),export_plot = 0)

#race percent covariates:  "asian_percent","black_percent","hispanic_percent","other_percent"
plot_asian_percent = plot_density_covariates(data_bootstrap,data_MLE,"asian_percent","Asian share of tract population",path_plots,adjust=4,paste0("density_asian_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_black_percent = plot_density_covariates(data_bootstrap,data_MLE,"black_percent","Black share of tract population",path_plots,adjust=3,paste0("density_black_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_hispanic_percent = plot_density_covariates(data_bootstrap,data_MLE,"hispanic_percent","Hispanic share of tract population",path_plots,adjust=3,paste0("density_hispanic_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_other_percent = plot_density_covariates(data_bootstrap,data_MLE,"other_percent","Other share of tract population",path_plots,adjust=3,paste0("density_other_percent_",raceid,"_",specification,".pdf"),export_plot = 0)

#average rating
plot_avgrating = plot_density_covariates(data_bootstrap,data_MLE,"avgrating","Yelp rating of restaurant",path_plots,adjust=3,paste0("density_avgrating_",raceid,"_",specification,".pdf"),export_plot = 0)

#d_price_2
plot_d_price_2 = plot_density_covariates(data_bootstrap,data_MLE,"d_price_2","Dummy for 2-dollar bin",path_plots,adjust=3,paste0("density_d_price_2_",raceid,"_",specification,".pdf"),export_plot = 0)

big_plot_social_frictions_3by2 = ggarrange(plot_asian_percent,plot_black_percent,plot_hispanic_percent,plot_EDD,plot_d_price_2,plot_avgrating,ncol=2,nrow=3)
ggsave(plot=big_plot_social_frictions_3by2,path = path_plots,filename = paste0("density_social_frictions_",raceid,"_",specification,"_3by2.pdf"),device=cairo_pdf,height = 8,width =13,units="in")

big_plot_social_frictions_2by3 = ggarrange(plot_asian_percent,plot_black_percent,plot_hispanic_percent,plot_EDD,plot_d_price_2,plot_avgrating,ncol=3,nrow=2)
ggsave(plot=big_plot_social_frictions_2by3,path = path_plots,filename = paste0("density_social_frictions_",raceid,"_",specification,"_2by3.pdf"),device=cairo_pdf,height = 8,width =15,units="in")

###############################################################################################################################################################################################################################################################
# Asian users
###############################################################################################################################################################################################################################################################

raceid ="asian"

#Load data
data_bootstrap = read.csv(paste0(path_data_bootstrap,"estimates_",raceid,"_",specification,"_bootstrap_clean.csv"))
data_MLE = read.csv(paste0(path_data_MLE,"estimates_",raceid,"_mainspec.csv"))

#Time covariates
plot_time_minimum_log_asian = plot_density_covariates(data_bootstrap,data_MLE,"time_minimum_log","Minimum of log travel time",path_plots,adjust=5,paste0("density_time_home_log_",raceid,"_",specification,".pdf"),export_plot = 1)

#EDD
plot_EDD = plot_density_covariates(data_bootstrap,data_MLE,"eucl_demo_distance","Euclidean demographic distance",path_plots,adjust=3,paste0("density_EDD_",raceid,"_",specification,".pdf"),export_plot = 0)

#race percent covariates:  "asian_percent","black_percent","hispanic_percent","other_percent"
plot_asian_percent = plot_density_covariates(data_bootstrap,data_MLE,"asian_percent","Asian share of tract population",path_plots,adjust=3,paste0("density_asian_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_black_percent = plot_density_covariates(data_bootstrap,data_MLE,"black_percent","Black share of tract population",path_plots,adjust=3,paste0("density_black_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_hispanic_percent = plot_density_covariates(data_bootstrap,data_MLE,"hispanic_percent","Hispanic share of tract population",path_plots,adjust=3,paste0("density_hispanic_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_other_percent = plot_density_covariates(data_bootstrap,data_MLE,"other_percent","Other share of tract population",path_plots,adjust=3,paste0("density_other_percent_",raceid,"_",specification,".pdf"),export_plot = 0)

#average rating
plot_avgrating = plot_density_covariates(data_bootstrap,data_MLE,"avgrating","Yelp rating of restaurant",path_plots,adjust=3,paste0("density_avgrating_",raceid,"_",specification,".pdf"),export_plot = 0)

#d_price_2
plot_d_price_2 = plot_density_covariates(data_bootstrap,data_MLE,"d_price_2","Dummy for 2-dollar bin",path_plots,adjust=3,paste0("density_d_price_2_",raceid,"_",specification,".pdf"),export_plot = 0)

big_plot_social_frictions_3by2 = ggarrange(plot_asian_percent,plot_black_percent,plot_hispanic_percent,plot_EDD,plot_d_price_2,plot_avgrating,ncol=2,nrow=3)
ggsave(plot=big_plot_social_frictions_3by2,path = path_plots,filename = paste0("density_social_frictions_",raceid,"_",specification,"_3by2.pdf"),device=cairo_pdf,height = 8,width =13,units="in")

big_plot_social_frictions_2by3 = ggarrange(plot_asian_percent,plot_black_percent,plot_hispanic_percent,plot_EDD,plot_d_price_2,plot_avgrating,ncol=3,nrow=2)
ggsave(plot=big_plot_social_frictions_2by3,path = path_plots,filename = paste0("density_social_frictions_",raceid,"_",specification,"_2by3.pdf"),device=cairo_pdf,height = 8,width =15,units="in")

###############################################################################################################################################################################################################################################################
# White/Hispanic users
###############################################################################################################################################################################################################################################################

raceid ="whithisp"

#Load data
data_bootstrap = read.csv(paste0(path_data_bootstrap,"estimates_",raceid,"_",specification,"_bootstrap_clean.csv"))
data_MLE = read.csv(paste0(path_data_MLE,"estimates_",raceid,"_mainspec.csv"))

#Time covariates
plot_time_minimum_log_whithisp = plot_density_covariates(data_bootstrap,data_MLE,"time_minimum_log","Minimum of log travel time",path_plots,adjust=5,paste0("density_time_home_log_",raceid,"_",specification,".pdf"),export_plot = 1)

#EDD
plot_EDD = plot_density_covariates(data_bootstrap,data_MLE,"eucl_demo_distance","Euclidean demographic distance",path_plots,adjust=3,paste0("density_EDD_",raceid,"_",specification,".pdf"),export_plot = 0)

#race percent covariates:  "asian_percent","black_percent","hispanic_percent","other_percent"
plot_asian_percent = plot_density_covariates(data_bootstrap,data_MLE,"asian_percent","Asian share of tract population",path_plots,adjust=3,paste0("density_asian_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_black_percent = plot_density_covariates(data_bootstrap,data_MLE,"black_percent","Black share of tract population",path_plots,adjust=3,paste0("density_black_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_hispanic_percent = plot_density_covariates(data_bootstrap,data_MLE,"hispanic_percent","Hispanic share of tract population",path_plots,adjust=3,paste0("density_hispanic_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_other_percent = plot_density_covariates(data_bootstrap,data_MLE,"other_percent","Other share of tract population",path_plots,adjust=3,paste0("density_other_percent_",raceid,"_",specification,".pdf"),export_plot = 0)

#average rating
plot_avgrating = plot_density_covariates(data_bootstrap,data_MLE,"avgrating","Yelp rating of restaurant",path_plots,adjust=3,paste0("density_avgrating_",raceid,"_",specification,".pdf"),export_plot = 0)

#d_price_2
plot_d_price_2 = plot_density_covariates(data_bootstrap,data_MLE,"d_price_2","Dummy for 2-dollar bin",path_plots,adjust=3,paste0("density_d_price_2_",raceid,"_",specification,".pdf"),export_plot = 0)

big_plot_social_frictions_3by2 = ggarrange(plot_asian_percent,plot_black_percent,plot_hispanic_percent,plot_EDD,plot_d_price_2,plot_avgrating,ncol=2,nrow=3)
ggsave(plot=big_plot_social_frictions_3by2,path = path_plots,filename = paste0("density_social_frictions_",raceid,"_",specification,"_3by2.pdf"),device=cairo_pdf,height = 8,width =13,units="in")

big_plot_social_frictions_2by3 = ggarrange(plot_asian_percent,plot_black_percent,plot_hispanic_percent,plot_EDD,plot_d_price_2,plot_avgrating,ncol=3,nrow=2)
ggsave(plot=big_plot_social_frictions_2by3,path = path_plots,filename = paste0("density_social_frictions_",raceid,"_",specification,"_2by3.pdf"),device=cairo_pdf,height = 8,width =15,units="in")

###############################################################################################################################################################################################################################################################
# Plot min travel time for Black, Asian and White/Hispanic users
###############################################################################################################################################################################################################################################################

big_plot_spatial_frictions_1by3 = ggarrange(plot_time_minimum_log_asian,plot_time_minimum_log_black,plot_time_minimum_log_whithisp,ncol=3,nrow=1)
ggsave(plot=big_plot_spatial_frictions_1by3,path = path_plots,filename = paste0("density_spatial_frictions_",raceid,"_",specification,"_1by3.pdf"),device=cairo_pdf,height = 4,width =15,units="in")
