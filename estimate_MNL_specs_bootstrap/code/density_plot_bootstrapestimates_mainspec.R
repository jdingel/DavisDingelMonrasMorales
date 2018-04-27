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
specification="mainspec"

path_data_bootstrap = paste0("../output/estimates/",specification,"/")
path_data_MLE =  paste0("../input/estimates/",specification,"/")
path_plots = paste0("../output/figures/",specification,"/")

###########################################
# Functions
###########################################

source("density_plots_bootstrapestimates_functions.R")

###############################################################################################################################################################################################################################################################
# FASTEST MODE SPECIFICATION
###############################################################################################################################################################################################################################################################

###############################################################################################################################################################################################################################################################
# Black users
###############################################################################################################################################################################################################################################################

#Load data
raceid ="black"

#Load data
data_bootstrap = read.csv(paste0(path_data_bootstrap,"estimates_",raceid,"_",specification,"_bootstrap_clean.csv"))
data_MLE = read.csv(paste0(path_data_MLE,"estimates_",raceid,"_mainspec.csv"))

#Time covariates
plot_time_car_home_log = plot_density_covariates(data_bootstrap,data_MLE,"time_car_home_log","Log travel time from home by car",path_plots,adjust=5,paste0("density_time_car_home_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_car_path_log = plot_density_covariates(data_bootstrap,data_MLE,"time_car_path_log","Log travel time from commute by car",path_plots,adjust=5,paste0("density_time_car_path_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_car_work_log = plot_density_covariates(data_bootstrap,data_MLE,"time_car_work_log","Log travel time from work by car",path_plots,adjust=5,paste0("density_time_car_work_log_",raceid,"_",specification,".pdf"),export_plot = 0)

plot_time_public_home_log = plot_density_covariates(data_bootstrap,data_MLE,"time_public_home_log","Log travel time from home by public transit",path_plots,adjust=5,paste0("density_time_home_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_public_path_log = plot_density_covariates(data_bootstrap,data_MLE,"time_public_path_log","Log travel time from commute by public transit",path_plots,adjust=5,paste0("density_time_path_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_public_work_log = plot_density_covariates(data_bootstrap,data_MLE,"time_public_work_log","Log travel time from work by public transit",path_plots,adjust=5,paste0("density_time_work_log_",raceid,"_",specification,".pdf"),export_plot = 0)

big_plot_time_covariates = ggarrange(plot_time_car_home_log, plot_time_car_path_log, plot_time_car_work_log, plot_time_public_home_log, plot_time_public_path_log, plot_time_public_work_log,ncol=2,nrow=3)
ggsave(plot=big_plot_time_covariates,path = path_plots,filename = paste0("density_time_covariates_",raceid,"_",specification,".pdf"),device=cairo_pdf,height = 8,width =13,units="in")

#Time covariates with trim
trim_left = 0.05
title = paste0("density_time_car_home_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_car_home_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_car_home_log","Log travel time from home by car",path_plots,adjust=10,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

trim_left = 0.15
title = paste0("density_time_public_home_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_public_home_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_public_home_log","Log travel time from home by public transit",path_plots,adjust=5,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

trim_left = 0.01
title=paste0("density_time_public_path_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_public_path_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_public_path_log","Log travel time from commute by public transit",path_plots,adjust=5,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

trim_left = 0.10
title=paste0("density_time_car_work_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_car_work_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_car_work_log","Log travel time from work by car",path_plots,adjust=12,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

trim_left = 0.03
title=paste0("density_time_public_work_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_public_work_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_public_work_log","Log travel time from work by public transit",path_plots,adjust=7,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

big_plot_time_covariates_trimleft_3by2 = ggarrange(plot_time_car_home_log_trimleft,plot_time_public_home_log_trimleft,plot_time_car_path_log,plot_time_public_path_log_trimleft,plot_time_car_work_log_trimleft,plot_time_public_work_log_trimleft,ncol=2,nrow=3)
ggsave(plot=big_plot_time_covariates_trimleft_3by2,path = path_plots,filename = paste0("density_time_covariates_",raceid,"_",specification,"_zoom_3by2.pdf"),device=cairo_pdf,height = 8,width =13,units="in")

big_plot_time_covariates_trimleft_2by3 = ggarrange(plot_time_car_home_log_trimleft,plot_time_public_home_log_trimleft,plot_time_car_path_log,plot_time_public_path_log_trimleft,plot_time_car_work_log_trimleft,plot_time_public_work_log_trimleft,ncol=3,nrow=2)
ggsave(plot=big_plot_time_covariates_trimleft_2by3,path = path_plots,filename = paste0("density_time_covariates_",raceid,"_",specification,"_zoom_2by3.pdf"),device=cairo_pdf,height = 8,width =13,units="in")

#EDD
plot_EDD = plot_density_covariates(data_bootstrap,data_MLE,"eucl_demo_distance","Euclidean demographic distance",path_plots,adjust=3,paste0("density_EDD_",raceid,"_",specification,".pdf"),export_plot = 0)

#race percent covariates:  "asian_percent","black_percent","hispanic_percent","other_percent"
plot_asian_percent = plot_density_covariates(data_bootstrap,data_MLE,"asian_percent","Asian share of tract population",path_plots,adjust=3,paste0("density_asian_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_black_percent = plot_density_covariates(data_bootstrap,data_MLE,"black_percent","Black share of tract population",path_plots,adjust=3,paste0("density_black_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_hispanic_percent = plot_density_covariates(data_bootstrap,data_MLE,"hispanic_percent","Hispanic share of tract population",path_plots,adjust=4,paste0("density_hispanic_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
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

#Load data
raceid ="asian"

#Load data
data_bootstrap = read.csv(paste0(path_data_bootstrap,"estimates_",raceid,"_",specification,"_bootstrap_clean.csv"))
data_MLE = read.csv(paste0(path_data_MLE,"estimates_",raceid,"_mainspec.csv"))

#Time covariates
plot_time_car_home_log = plot_density_covariates(data_bootstrap,data_MLE,"time_car_home_log","Log travel time from home by car",path_plots,adjust=5,paste0("density_time_car_home_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_car_path_log = plot_density_covariates(data_bootstrap,data_MLE,"time_car_path_log","Log travel time from commute by car",path_plots,adjust=5,paste0("density_time_car_path_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_car_work_log = plot_density_covariates(data_bootstrap,data_MLE,"time_car_work_log","Log travel time from work by car",path_plots,adjust=5,paste0("density_time_car_work_log_",raceid,"_",specification,".pdf"),export_plot = 0)

plot_time_public_home_log = plot_density_covariates(data_bootstrap,data_MLE,"time_public_home_log","Log travel time from home by public transit",path_plots,adjust=5,paste0("density_time_home_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_public_path_log = plot_density_covariates(data_bootstrap,data_MLE,"time_public_path_log","Log travel time from commute by public transit",path_plots,adjust=5,paste0("density_time_path_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_public_work_log = plot_density_covariates(data_bootstrap,data_MLE,"time_public_work_log","Log travel time from work by public transit",path_plots,adjust=5,paste0("density_time_work_log_",raceid,"_",specification,".pdf"),export_plot = 0)

big_plot_time_covariates = ggarrange(plot_time_car_home_log, plot_time_car_path_log, plot_time_car_work_log, plot_time_public_home_log, plot_time_public_path_log, plot_time_public_work_log,ncol=2,nrow=3)
ggsave(plot=big_plot_time_covariates,path = path_plots,filename = paste0("density_time_covariates_",raceid,"_",specification,".pdf"),device=cairo_pdf,height = 8,width =13,units="in")

#Time covariates with trim
trim_left = 0.008
title = paste0("density_time_car_home_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_car_home_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_car_home_log","Log travel time from home by car",path_plots,adjust=8,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

trim_left = 0.08
title = paste0("density_time_public_home_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_public_home_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_public_home_log","Log travel time from home by public transit",path_plots,adjust=5,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

trim_left = 0.012
title=paste0("density_time_car_work_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_car_work_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_car_work_log","Log travel time from work by car",path_plots,adjust=7,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

trim_left = 0.1
title=paste0("density_time_public_work_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_public_work_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_public_work_log","Log travel time from work by public transit",path_plots,adjust=5,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

big_plot_time_covariates_trimleft_3by2 = ggarrange(plot_time_car_home_log_trimleft,plot_time_public_home_log_trimleft,plot_time_car_path_log,plot_time_public_path_log,plot_time_car_work_log_trimleft,plot_time_public_work_log_trimleft,ncol=2,nrow=3)
ggsave(plot=big_plot_time_covariates_trimleft_3by2,path = path_plots,filename = paste0("density_time_covariates_",raceid,"_",specification,"_zoom_3by2.pdf"),device=cairo_pdf,height = 8,width =13,units="in")

big_plot_time_covariates_trimleft_2by3 = ggarrange(plot_time_car_home_log_trimleft,plot_time_public_home_log_trimleft,plot_time_car_path_log,plot_time_public_path_log,plot_time_car_work_log_trimleft,plot_time_public_work_log_trimleft,ncol=3,nrow=2)
ggsave(plot=big_plot_time_covariates_trimleft_2by3,path = path_plots,filename = paste0("density_time_covariates_",raceid,"_",specification,"_zoom_2by3.pdf"),device=cairo_pdf,height = 8,width =13,units="in")

#EDD
plot_EDD = plot_density_covariates(data_bootstrap,data_MLE,"eucl_demo_distance","Euclidean demographic distance",path_plots,adjust=3,paste0("density_EDD_",raceid,"_",specification,".pdf"),export_plot = 0)

#race percent covariates:  "asian_percent","black_percent","hispanic_percent","other_percent"
plot_asian_percent = plot_density_covariates(data_bootstrap,data_MLE,"asian_percent","Asian share of tract population",path_plots,adjust=3,paste0("density_asian_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_black_percent = plot_density_covariates(data_bootstrap,data_MLE,"black_percent","Black share of tract population",path_plots,adjust=4,paste0("density_black_percent_",raceid,"_",specification,".pdf"),export_plot = 0)
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

#Load data
raceid ="whithisp"

#Load data
data_bootstrap = read.csv(paste0(path_data_bootstrap,"estimates_",raceid,"_",specification,"_bootstrap_clean.csv"))
data_MLE = read.csv(paste0(path_data_MLE,"estimates_",raceid,"_mainspec.csv"))

#Time covariates
plot_time_car_home_log = plot_density_covariates(data_bootstrap,data_MLE,"time_car_home_log","Log travel time from home by car",path_plots,adjust=5,paste0("density_time_car_home_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_car_path_log = plot_density_covariates(data_bootstrap,data_MLE,"time_car_path_log","Log travel time from commute by car",path_plots,adjust=5,paste0("density_time_car_path_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_car_work_log = plot_density_covariates(data_bootstrap,data_MLE,"time_car_work_log","Log travel time from work by car",path_plots,adjust=5,paste0("density_time_car_work_log_",raceid,"_",specification,".pdf"),export_plot = 0)

plot_time_public_home_log = plot_density_covariates(data_bootstrap,data_MLE,"time_public_home_log","Log travel time from home by public transit",path_plots,adjust=5,paste0("density_time_home_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_public_path_log = plot_density_covariates(data_bootstrap,data_MLE,"time_public_path_log","Log travel time from commute by public transit",path_plots,adjust=5,paste0("density_time_path_log_",raceid,"_",specification,".pdf"),export_plot = 0)
plot_time_public_work_log = plot_density_covariates(data_bootstrap,data_MLE,"time_public_work_log","Log travel time from work by public transit",path_plots,adjust=5,paste0("density_time_work_log_",raceid,"_",specification,".pdf"),export_plot = 0)

big_plot_time_covariates = ggarrange(plot_time_car_home_log, plot_time_car_path_log, plot_time_car_work_log, plot_time_public_home_log, plot_time_public_path_log, plot_time_public_work_log,ncol=2,nrow=3)
ggsave(plot=big_plot_time_covariates,path = path_plots,filename = paste0("density_time_covariates_",raceid,"_",specification,".pdf"),device=cairo_pdf,height = 8,width =13,units="in")

#Time covariates with trim
trim_left = 0.0075
title = paste0("density_time_car_home_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_car_home_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_car_home_log","Log travel time from home by car",path_plots,adjust=10,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

trim_left = 0.05
title = paste0("density_time_public_home_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_public_home_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_public_home_log","Log travel time from home by public transit",path_plots,adjust=5,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

trim_left = 0.02
title=paste0("density_time_car_work_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_car_work_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_car_work_log","Log travel time from work by car",path_plots,adjust=5,title,export_plot = 1,trimming_left = 1,trim_left=trim_left)

trim_left = 0.15
title=paste0("density_time_public_work_log_",raceid,"_",specification,"_trimleft",100*trim_left,"percent.pdf")
plot_time_public_work_log_trimleft = plot_density_covariates(data_bootstrap,data_MLE,"time_public_work_log","Log travel time from work by public transit",path_plots,adjust=5,title,export_plot = 0,trimming_left = 1,trim_left=trim_left)

big_plot_time_covariates_trimleft_3by2 = ggarrange(plot_time_car_home_log_trimleft,plot_time_public_home_log_trimleft,plot_time_car_path_log,plot_time_public_path_log,plot_time_car_work_log_trimleft,plot_time_public_work_log_trimleft,ncol=2,nrow=3)
ggsave(plot=big_plot_time_covariates_trimleft_3by2,path = path_plots,filename = paste0("density_time_covariates_",raceid,"_",specification,"_zoom_3by2.pdf"),device=cairo_pdf,height = 8,width =13,units="in")

big_plot_time_covariates_trimleft_2by3 = ggarrange(plot_time_car_home_log_trimleft,plot_time_public_home_log_trimleft,plot_time_car_path_log,plot_time_public_path_log,plot_time_car_work_log_trimleft,plot_time_public_work_log_trimleft,ncol=3,nrow=2)
ggsave(plot=big_plot_time_covariates_trimleft_2by3,path = path_plots,filename = paste0("density_time_covariates_",raceid,"_",specification,"_zoom_2by3.pdf"),device=cairo_pdf,height = 8,width =13,units="in")

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
