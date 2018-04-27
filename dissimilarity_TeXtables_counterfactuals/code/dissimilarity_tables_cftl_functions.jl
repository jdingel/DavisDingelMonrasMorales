## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

###########################
# Functions
###########################

function format_number(num)

  if 0<num<1 #e.g number is of the form 0.xxx
  num_string =  string(".",split(@sprintf("%.3f",num),".")[2])
  elseif 0>num>-1
    num_string =  string("-",".",split(@sprintf("%.3f",num),".")[2])
  elseif 10>abs(num)>1
    num_string = @sprintf("%9.2f",num)
  elseif abs(num)>10
    num_string = @sprintf("%9.1f",num)
  end

  return strip(num_string)
end

function dissimilarity_tex_table_cftl(list_data_dissimilarity,list_data_dissimilarity_pairwise,insert_colnames,path,saveas)

  #size of one dataframe
  (n1,n2) = size(list_data_dissimilarity[1])
  n3 = length(list_data_dissimilarity)

  colnames = string("&")
  sim_num = string("&")

  for i in 1:n3
    colnames = string(colnames,"&",insert_colnames[i])
    sim_num  = string(sim_num,"&","($i)")
  end

  colnames = string(colnames," \\\\ \\midrule \n")
  sim_num = string(sim_num," \\\\ \\hline \n")

  latex_table = string("\\begin{tabular}{ll","c"^(n3+2),"} \\toprule \n",colnames,sim_num)
  latex_table = string(latex_table,"\\multicolumn{2}{l}{\\textit{Dissimilarity index}}\\\\ \n")

  for (i,i_n) in zip(["Asian","black","Hispanic","white","white or Hispanic"],["asian","black","hispanic","white","whithisp"])

    temp_covariates = string(i,"&&")

    for k in 1:n3
      df_temp = list_data_dissimilarity[k]
      tf = df_temp[(df_temp[:race].==i_n) .& (df_temp[:spec].== "prob_visit_venue_standard"),:dissimilarityindex][1]
      temp_covariates = string(temp_covariates,format_number(tf),"&")
    end

    latex_table = string(latex_table,temp_covariates,"\\\\ \n")
  end

  latex_table= string(latex_table,"\\midrule \n")
  latex_table= string(latex_table,"\\multicolumn{2}{l}{\\textit{Pairwise dissimilarity}}&\\\\ \n")


  for (race1,race2) in zip(["Asian","Asian","Asian","black","black","Hispanic"],["black","Hispanic","white","Hispanic","white","white"])
    temp_covariates = string(race1,"&",race2,"&")

    for k in 1:n3
      df_temp = list_data_dissimilarity_pairwise[k]
      tf = df_temp[(df_temp[:race1].==lowercase(race1)).&(df_temp[:race2].==lowercase(race2)).&(df_temp[:spec].== "prob_visit_venue_standard"),:dissimilarityindex][1]
      temp_covariates = string(temp_covariates,format_number(tf),"&")
    end

    latex_table = string(latex_table,temp_covariates,"\\\\ \n")

  end

  latex_table = string(latex_table,"\\bottomrule \n")
  latex_table = string(latex_table,"\\end{tabular} \n")

  write(string(path,saveas),latex_table)

end
