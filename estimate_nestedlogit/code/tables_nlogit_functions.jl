## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
######################

#Imported functions
include("tables_formatting.jl")

########################
# Functions
########################

function compute_LR_test_nlogit_uniquelambda(df_H0,df_H1)

  #H0 : lambda = 1 (multinomial logit)
  #H1 : lambda != 1 (nested logit)

  LL_H0 = unique(df_H0[:log_likelihood_value])[1]
  LL_H1 = unique(df_H1[:log_likelihood_value])[1]

  LR_stat = -2*(LL_H0-LL_H1)

  df_H1[:pvalue_LR] = ccdf(Chisq(1),LR_stat) #chi2(1): 1 degree of freedom = lambda

  return df_H1

end

################################################################################
# Generate Tex table
################################################################################

function convert_dataframe_to_tex_format_ABW_ABW_nlogit(list_data,title1,title2,names_covariates,insert_colnames,path,saveas;add_stats::Int64 = 0,multicol_titles::Int64=1,report_norg::Int64=1)

#size of one dataframe
(n1,n2) = size(list_data[1])
n3 = length(list_data)

colnames = string("")
sim_num = string("")

for i in 1:n3
  colnames = string(colnames,"&",insert_colnames[i])
  sim_num  = string(sim_num,"&","($i)")
end

colnames = string(colnames," \\\\")
sim_num = string(sim_num," \\\\")

temp_tex = string("\\begin{tabular}{l","c"^(n3),"} \\toprule \n")
temp_tex= string(temp_tex,sim_num,"\n")
if multicol_titles == 1
  temp_tex = string(temp_tex,string("&\\multicolumn{3}{c}{",title1,"}"),string("&\\multicolumn{3}{c}{",title2,"} \\\\  \\cmidrule{2-4} \\cmidrule{5-7}  \n"))
end
temp_tex=string(temp_tex,colnames," \\midrule \n")

for i in 1:n1
  temp_covariates = ""
  std_covariates = ""

  for k in 1:n3
    if isnan(list_data[k][:estimates][i]) == true
      temp_covariates = string(temp_covariates,"&","")
      std_covariates = string(std_covariates,"& ")
    else
      if list_data[k][:stat_significance][i] != ""
        temp_covariates = string(temp_covariates,"&",format_number(list_data[k][:estimates][i]),"\$^{",list_data[k][:stat_significance][i],"}\$")
      else
        temp_covariates = string(temp_covariates,"&",format_number(list_data[k][:estimates][i]))
      end
      std_covariates = string(std_covariates,"& \\footnotesize{("format_number(list_data[k][:std][i])")}")
    end
  end

    temp_covariates = string(names_covariates[i],temp_covariates," \\tabularnewline[-4pt]")
    std_covariates = string(std_covariates," \\\\ ")
    temp_tex = string(temp_tex,"\n",temp_covariates,"\n",std_covariates)
end

if add_stats == 1
  temp_tex = string(temp_tex,"\n \\midrule")

  temp_norg = "Number of origin-mode points"
  temp_pvalue_LR = "\$\\chi^{2}\$ test p-value"
  temp_num_trips = "Number of trips"

  for k in 1:n3
    temp_norg = string(temp_norg,"&",list_data[k][:norg][1])
    temp_pvalue_LR = string(temp_pvalue_LR,"&",format_number(list_data[k][:pvalue_LR][1]))
    temp_num_trips = string(temp_num_trips,"&",list_data[k][:num_trips][1])
  end

  temp_norg = string(temp_norg," \\\\ ")
  temp_pvalue_LR = string(temp_pvalue_LR," \\\\ ")
  temp_num_trips = string(temp_num_trips," \\\\ ")

  if report_norg == 1
    temp_tex = string(temp_tex,"\n",temp_norg,"\n",temp_pvalue_LR,"\n",temp_num_trips)
  elseif  report_norg == 0
    temp_tex = string(temp_tex,"\n",temp_pvalue_LR,"\n",temp_num_trips)
  end

end

latex_table = string(temp_tex,"\n \\bottomrule","\n","\\end{tabular}")

write(string(path,saveas),latex_table)

end

################################################################################
# Generate tables in the paper
################################################################################

function gen_tab_ABW_ABW_nlogit(path_input,path_input_H0,path_output,tab1_name,tab2_name,tab_H0_name,title1,title2,tab_spec,tab_name_output;norg1=6,norg2=6,add_missing_cov::Int64=0,multicol_titles::Int64=1,report_norg::Int64=1)

  list_data = []

  for (tab_name,norg) in zip([tab1_name,tab2_name],[norg1;norg2])
    for race in ["asian","black","whithisp"]

      df = basic_cleaning(path_input,string("estimates_",race,"_",tab_name,".csv"),norg)
      df_H0 = CSV.read(string(path_input_H0,"estimates_",race,"_",tab_H0_name,".csv"))
      df = compute_LR_test_nlogit_uniquelambda(df_H0,df)

      if add_missing_cov == 1
        df = add_missing_covariates(df,tab_spec)
      end
      #Reorder covariates
      df = reorder_covariates(df,tab_spec)

      #label data
      df = label_data(df)

      push!(list_data,df)
    end
  end

  names_covariates = list_data[1][:names]
  insert_colnames  = repeat(String["Asian";"black"; "white/Hisp"],outer=2)

  convert_dataframe_to_tex_format_ABW_ABW_nlogit(list_data,title1,title2,names_covariates,insert_colnames,path_output,string(tab_name_output,".tex");add_stats = 1,multicol_titles=multicol_titles,report_norg=report_norg)

end
