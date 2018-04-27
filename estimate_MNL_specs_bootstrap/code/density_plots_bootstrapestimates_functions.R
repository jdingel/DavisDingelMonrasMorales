############################################################################################################
# Author: Kevin Dano
# Date: April 2018
# Objective: Function for density plot of bootstrap estimates
############################################################################################################

plot_density_covariates<-function(data_bootstrap,data_MLE,cov_of_interest,new_name,path_data_bootstrap,name_plot,export_plot=0,adjust=0,trimming_left=0,trim_left=0){


  #1) Filter variable of interest for the bootstrap data
  data_sub = filter(data_bootstrap,names == cov_of_interest)
  data_sub$instance = NULL

  #2) MLE asymptotic distribution
  data_MLE_sub = filter(data_MLE,names == cov_of_interest)
  mu = data_MLE_sub$estimates[1] #mean of the gaussian
  sigma = data_MLE_sub$std[1] #standard deviation of the gaussian

  if (trimming_left == 0){

    p = ggplot(data_sub,aes(x=estimates))+geom_line(stat="density",color="red",linetype=1)+
      labs(x = paste0("Estimates ") , y = "") +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black")) +
      guides(linetype=FALSE)+theme(axis.line.x = element_line(color="black", size = 0.5),axis.line.y = element_line(color="black", size = 0.5)) + ggtitle(new_name)+
      theme(plot.title = element_text(size = 14,hjust = 0.5,face="plain"),axis.title=element_text(size=14),axis.text.x=element_text(size=12,color="black"),axis.text.y=element_text(size=12,color="black"))

    #adds MLE asymptotic distribution to the plot
    lim_left = min(min(data_sub$estimates),mu-adjust*sigma)
    p = p + coord_cartesian(xlim=c(lim_left,mu+adjust*sigma),expand=FALSE)

    p = p + stat_function(data=data.frame(estimates=c(lim_left,mu+10*sigma)),n=100000,fun = dnorm, args=list(mean=mu, sd=sigma),color="blue",linetype=2) #100000 interpolation points

  }else if (trimming_left == 1){

    p = ggplot(data_sub,aes(x=estimates))+geom_line(stat="density",color="red",linetype=1)+
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black")) +
      guides(linetype=FALSE)+theme(axis.line.x = element_line(color="black", size = 0.5),axis.line.y = element_line(color="black", size = 0.5)) + ggtitle(new_name)

    p = p + labs(x = paste0("Estimates ","(trimming ",sprintf("%.1f%%",100*trim_left)," of the left tail)") , y = "")

    p = p + theme(plot.title = element_text(size = 14,hjust = 0.5,face="plain"),axis.title=element_text(size=14),axis.text.x=element_text(size=12,color="black"),axis.text.y=element_text(size=12,color="black"))

    lim_left = quantile(data_sub$estimates,trim_left)

    #trim x-axis
    p = p + coord_cartesian(xlim=c(lim_left,mu+adjust*sigma),expand=FALSE)
    #adds MLE asymptotic distribution to the plot
    p = p + stat_function(data=data.frame(estimates=c(lim_left,mu+10*sigma)),n=100000,fun = dnorm, args=list(mean=mu, sd=sigma),color="blue",linetype=2) #100000 interpolation points

  }

  if (export_plot == 1){
    #ggsave(plot=p,path = path_data_bootstrap,filename = name_plot,device=cairo_pdf)
    ggsave(plot=p,path = path_data_bootstrap,filename = name_plot,device=pdf,width=7,heigh=7,units="in")

  }

  return(p)
}
