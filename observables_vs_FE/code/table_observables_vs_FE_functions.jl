## Author: Kevin Dano
## Date: April 2018
## Packages: DataFrame, Distributions
## Julia version: 0.6.2

######################
# Functions
######################

function compute_LR_test_observables_vs_FE(raceid,data,df_chisq)

  LL_obs = data[data[:race].==raceid,:LL_observables]
  LL_FE = data[data[:race].==raceid,:LL_FE]

  LR_stat = -2*(LL_obs-LL_FE)

  df = DataFrame(race=raceid,LL_obs = LL_obs, LL_FE = LL_FE, LR_stat=LR_stat)
  df[:threshold_1_percent_LR] = quantile(Chisq(df_chisq),0.99)
  df[:threshold_5_percent_LR] = quantile(Chisq(df_chisq),0.95)
  df[:threshold_10_percent_LR] = quantile(Chisq(df_chisq),0.9)
  df[:pvalue] = ccdf.(Chisq(df_chisq),LR_stat)

  return df
end

function adds_statistical_significance_LR(data)

  #Significance at the 1% level
  data[:a_signif] = (data[:LR_stat] .> data[:threshold_1_percent_LR])
  #Significance at the 5% level
  data[:b_signif] = (data[:LR_stat] .> data[:threshold_5_percent_LR])
  #Significance at the 10% level
  data[:c_signif] = (data[:LR_stat] .> data[:threshold_10_percent_LR])

  temp_string = String[]

  for i in 1:nrow(data)
    if data[:a_signif][i] == true
      push!(temp_string,"a")
    elseif (data[:a_signif][i] == false) & (data[:b_signif][i] == true)
      push!(temp_string,"b")
    elseif (data[:a_signif][i] == false) & (data[:b_signif][i] == false) & (data[:c_signif][i]== true)
      push!(temp_string,"c")
    else
      push!(temp_string,"")
    end
  end

  delete!(data,[:a_signif,:b_signif,:c_signif])
  delete!(data,[:threshold_1_percent_LR,:threshold_5_percent_LR,:threshold_10_percent_LR])
  data[:stat_significance] = temp_string

  return data
end

function table_observables_vs_FE(df,path,saveas)

  latex_table = string("\\begin{tabular}{","c"^5,"} \\toprule \n")
  latex_table = string(latex_table,"&\\multicolumn{2}{c}{Log likelihood values}&  \\\\ \\cline{2-3} \n")
  latex_table = string(latex_table,"Sample & Observables & Restaurant fixed effects & \$\\chi^{2}\$ test statistic & p-value \\\\ \\hline \n")

  for (i,name) in zip(["asian","black","whithisp"],["Asian reviewers","Black reviewers","White/Hispanic reviewers"])
    df_temp = df[df[:race].==i,:]
    temp = string(name,"&",@sprintf("%9.2f",df_temp[:LL_obs][1]),"&",@sprintf("%9.2f",df_temp[:LL_FE][1]),"&",@sprintf("%9.2f",df_temp[:LR_stat][1]),"\\textsuperscript{\\textit{",df_temp[:stat_significance][1],"}}","&",@sprintf("%9.2f",df_temp[:pvalue][1]))

    if i !="whithisp"
    latex_table = string(latex_table,temp,"\\\\ \n")
    else
      latex_table =string(latex_table,temp,"\\\\ \\bottomrule \n")
    end
  end
  latex_table = string(latex_table,"\\end{tabular}")
  write(string(path,saveas),latex_table)

end
