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

function dissimilarity_tex_table(data_dissimilarity_residential,data_dissimilarity_pairwise_residential,data_dissimilarity,data_dissimilarity_pairwise,path,saveas)

  latex_table = string("\\begin{tabular}{llcccccc} \\toprule \n")
  latex_table = string(latex_table,"&& Residential & \\multicolumn{4}{c}{Consumption dissimilarity} \\\\ \\cline{4-7} \n")
  latex_table = string(latex_table,"&& dissimilarity & Estimated & No spatial & No social & Neither friction  \\\\ \\hline \n")
  latex_table = string(latex_table,"&&(1)&(2)&(3)&(4)&(5)\\\\ \\midrule \n")
  latex_table = string(latex_table,"\\multicolumn{2}{l}{\\textit{Dissimilarity index}}\\\\ \n")


  #for i in ["Asian","Hispanic","black","white"]
  for (i,i_n) in zip(["Asian","black","Hispanic","white","white or Hispanic"],["asian","black","hispanic","white","whithisp"])

    temp_covariates = string(i,"&&")
    tf0 = data_dissimilarity_residential[data_dissimilarity_residential[:race].==i_n,:dissimilarityindex][1]
    temp_covariates = string(temp_covariates,format_number(tf0),"&")

    for k in retain_spec
      tf = data_dissimilarity[(data_dissimilarity[:race].==i_n) .& (data_dissimilarity[:spec].== k),:dissimilarityindex][1]
      temp_covariates = string(temp_covariates,format_number(tf),"&")
    end

    latex_table = string(latex_table,temp_covariates,"\\\\ \n")
  end

  latex_table= string(latex_table,"\\midrule \n")
  latex_table= string(latex_table,"\\multicolumn{2}{l}{\\textit{Pairwise dissimilarity}}&\\\\ \n")


  for (race1,race2) in zip(["Asian","Asian","Asian","black","black","Hispanic"],["black","Hispanic","white","Hispanic","white","white"])

    temp_covariates = string(race1,"&",race2,"&")
    tf0 = data_dissimilarity_pairwise_residential[(data_dissimilarity_pairwise_residential[:race1].==lowercase(race1)).&(data_dissimilarity_pairwise_residential[:race2].==lowercase(race2)),:dissimilarityindex][1]
    temp_covariates = string(temp_covariates,format_number(tf0),"&")

    for k in retain_spec
      tf = data_dissimilarity_pairwise[(data_dissimilarity_pairwise[:race1].==lowercase(race1)).&(data_dissimilarity_pairwise[:race2].==lowercase(race2)).&(data_dissimilarity_pairwise[:spec].== k),:dissimilarityindex][1]
      temp_covariates = string(temp_covariates,format_number(tf),"&")
    end

    latex_table = string(latex_table,temp_covariates,"\\\\ \n")

  end

  latex_table = string(latex_table,"\\bottomrule \n")
  latex_table = string(latex_table,"\\end{tabular} \n")

  write(string(path,saveas),latex_table)

end

function dissimilarity_tex_table_originmodeintercept(retain_spec,data_dissimilarity_residential,data_dissimilarity_pairwise_residential,data_dissimilarity,data_dissimilarity_pairwise,path,saveas)

  latex_table = string("\\begin{tabular}{llcccccccc} \\toprule \n")
  latex_table = string(latex_table,"& & & \\multicolumn{6}{c}{Consumption dissimilarity} \\\\ \\cline{4-9} \n")

  latex_table = string(latex_table,"&& Residential & Est & & & No soc & & Neither  \\\\  \n")
  latex_table = string(latex_table,"&& dissimilarity & (bias) & Est & No spatial & (bias) & No soc & friction  \\\\ \\hline \n")

  latex_table = string(latex_table,"&&(1)&(2)&(3)&(4)&(5)&(6)&(7)\\\\ \\midrule \n")
  latex_table = string(latex_table,"\\multicolumn{2}{l}{\\textit{Dissimilarity index}}\\\\ \n")


  for i in ["Asian","Hispanic","black","white"]

    temp_covariates = string(i,"&&")
    tf0 = data_dissimilarity_residential[data_dissimilarity_residential[:race].==lowercase(i),:dissimilarityindex][1]
    temp_covariates = string(temp_covariates,format_number(tf0),"&")

    for k in retain_spec
      tf = data_dissimilarity[(data_dissimilarity[:race].==lowercase(i)) .& (data_dissimilarity[:spec].== k),:dissimilarityindex][1]
      temp_covariates = string(temp_covariates,format_number(tf),"&")
    end

    latex_table = string(latex_table,temp_covariates,"\\\\ \n")
  end

  latex_table= string(latex_table,"\\midrule \n")
  latex_table= string(latex_table,"\\multicolumn{2}{l}{\\textit{Pairwise dissimilarity}}&\\\\ \n")


  for (race1,race2) in zip(["Asian","Asian","Asian","Hispanic","black","black"],["Hispanic","black","white","white","Hispanic","white"])

    temp_covariates = string(race1,"&",race2,"&")
    tf0 = data_dissimilarity_pairwise_residential[(data_dissimilarity_pairwise_residential[:race1].==lowercase(race1)).&(data_dissimilarity_pairwise_residential[:race2].==lowercase(race2)),:dissimilarityindex][1]
    temp_covariates = string(temp_covariates,format_number(tf0),"&")

    for k in retain_spec
      tf = data_dissimilarity_pairwise[(data_dissimilarity_pairwise[:race1].==lowercase(race1)).&(data_dissimilarity_pairwise[:race2].==lowercase(race2)).&(data_dissimilarity_pairwise[:spec].== k),:dissimilarityindex][1]
      temp_covariates = string(temp_covariates,format_number(tf),"&")
    end

    latex_table = string(latex_table,temp_covariates,"\\\\ \n")

  end

  latex_table = string(latex_table,"\\bottomrule \n")
  latex_table = string(latex_table,"\\end{tabular} \n")

  write(string(path,saveas),latex_table)

end


################################################################################
# robustness checks
################################################################################

#presentation = 1 (default value) = comparison within-race
#presentation = 0  = comparison across races
function dissimilarity_robustnesschecks_tex_table(list_data_dissimilarity,insert_colnames,path,saveas;presentation::Int=1,title::Int=0)

  if presentation == 1
    dissimilarity_robustnesschecks_tex_table_comp_within_race(list_data_dissimilarity,insert_colnames,path,saveas;title=title)
  elseif presentation == 0
    dissimilarity_robustnesschecks_tex_table_comp_across_race(list_data_dissimilarity,insert_colnames,path,saveas;title=title)
  end

end

function dissimilarity_robustnesschecks_tex_table_comp_within_race(list_data_dissimilarity,insert_colnames,path,saveas;title::Int=0)

  #size of one dataframe
  (n1,n2) = size(list_data_dissimilarity[1])
  n3 = length(list_data_dissimilarity)

  colnames = string("&")
  sim_num = string("&")

  for i in 1:n3
    colnames = string(colnames,"&",insert_colnames[i])
    sim_num  = string(sim_num,"&","($i)")
  end

  colnames = string(colnames," \\\\")
  sim_num = string(sim_num," \\\\")

  if title == 1
    temp_tex = string("\\begin{tabular}{l","c"^(n3+1),"} \\toprule \n",sim_num,"\n",colnames," \\midrule \n")
  elseif title == 0
    temp_tex = string("\\begin{tabular}{l","c"^(n3+1),"} \\toprule \n",sim_num," \\midrule \n")
  end

  for (race1,race2) in zip(["asian","hispanic","black","white","whithisp"],["Asian","Hispanic","black","white","white or Hispanic"])

    temp_sub = string("\\multirow{4}{*}{",race2,"}") #e.g we present dissimilarities for asian, black, hispanic, white

    for (i1,i2) in zip(["Estimated","No spatial","No social","Neither friction"],["standard","nospatial","nosocial","neither"])
      temp_sub = string(temp_sub,"&",i1)
      for k in 1:n3
        df_temp = list_data_dissimilarity[k]
        dissimilarity_sub = format_number(df_temp[(df_temp[:race].==race1) .& (df_temp[:spec].==string("prob_visit_venue_",i2)),:dissimilarityindex][1])
        temp_sub = string(temp_sub,"&",dissimilarity_sub)
      end
        temp_sub = string(temp_sub,"\\\\ \n")
      end
      if race1 != "whithisp"
        temp_tex = string(temp_tex,"\n",temp_sub,"\n\\midrule")
      else
         temp_tex = string(temp_tex,"\n",temp_sub,"\n\\bottomrule")
      end
  end

  latex_table = string(temp_tex,"\n","\\end{tabular}")
  write(string(path,saveas,".tex"),latex_table)

end

function dissimilarity_robustnesschecks_tex_table_comp_across_race(list_data_dissimilarity,insert_colnames,path,saveas;title::Int=0)

  #size of one dataframe
  (n1,n2) = size(list_data_dissimilarity[1])
  n3 = length(list_data_dissimilarity)

  colnames = string("&")
  sim_num = string("&")

  for i in 1:n3
    colnames = string(colnames,"&",insert_colnames[i])
    sim_num  = string(sim_num,"&","($i)")
  end

  colnames = string(colnames," \\\\")
  sim_num = string(sim_num," \\\\")

  if title == 1
    temp_tex = string("\\begin{tabular}{l","c"^(n3+1),"} \\toprule \n",sim_num,"\n",colnames," \\midrule \n")
  elseif title == 0
    temp_tex = string("\\begin{tabular}{l","c"^(n3+1),"} \\toprule \n",sim_num," \\midrule \n")
  end


  for (i1,i2) in zip(["Estimated","No spatial","No social","Neither"],["standard","nospatial","nosocial","neither"])

    if i1 == "Estimated"
      temp_sub = string("\\multirow{5}{*}{",i1,"}") #e.g we present dissimilarities for asian, black, hispanic, white
    else
      temp_sub = string("\\multirow{5}{*}{\\shortstack[l]{",i1,"\\\\","friction","}}")
    end

    for (race1,race2) in zip(["asian","black","hispanic","white","whithisp"],["Asian","black","Hispanic","white","white or Hispanic"])

      temp_sub = string(temp_sub,"&",race2)
        for k in 1:n3
          df_temp = list_data_dissimilarity[k]
          dissimilarity_sub = format_number(df_temp[(df_temp[:race].==race1) .& (df_temp[:spec].==string("prob_visit_venue_",i2)),:dissimilarityindex][1])
          temp_sub = string(temp_sub,"&",dissimilarity_sub)
        end
          temp_sub = string(temp_sub,"\\\\ \n")
    end

    if i1 != "Neither friction"
      temp_tex = string(temp_tex,"\n",temp_sub,"\n\\midrule")
    else
       temp_tex = string(temp_tex,"\n",temp_sub,"\n\\bottomrule")
    end
  end

  latex_table = string(temp_tex,"\n","\\end{tabular}")

  write(string(path,saveas,".tex"),latex_table)
end
