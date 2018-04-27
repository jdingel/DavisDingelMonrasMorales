## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2
## Packages required: DataFrames CSV LaTeXStrings Distributions

######################
# Computing resources
######################

#Imported functions
include("tables_formatting.jl")

################################################################################
# Generate Tex table
################################################################################

function convert_dataframe_to_tex(list_data,names_covariates,insert_colnames,path,saveas;add_stats::Int64 = 0,report_norg::Int64=1,show_colnames::Int64=1)

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

  if show_colnames == 1
    temp_tex = string("\\begin{tabular}{l","c"^(n3),"} \\toprule \n",sim_num,"\n",colnames," \\midrule \n")
  elseif  show_colnames == 0
    temp_tex = string("\\begin{tabular}{l","c"^(n3),"} \\toprule \n",sim_num," \\midrule \n")
  end

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
    temp_num_trips = "Number of trips"

    for k in 1:n3
      temp_norg = string(temp_norg,"&",list_data[k][:norg][1])
      temp_num_trips = string(temp_num_trips,"&",list_data[k][:num_trips][1])
    end

    temp_norg = string(temp_norg," \\\\ ")
    temp_num_trips = string(temp_num_trips," \\\\ ")
    if report_norg == 1
      temp_tex = string(temp_tex,"\n",temp_norg,"\n",temp_num_trips)
    elseif  report_norg == 0
      temp_tex = string(temp_tex,"\n",temp_num_trips)
    end
  end

  latex_table = string(temp_tex,"\n \\bottomrule","\n","\\end{tabular}")

  write(string(path,saveas),latex_table)

end

function convert_dataframe_to_tex_format_ABW_ABW(list_data,title1,title2,names_covariates,insert_colnames,path,saveas;add_stats::Int64 = 0,multicol_titles::Int64=1,report_norg::Int64=1)

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
if multicol_titles == 1
  temp_tex = string(temp_tex,string("&\\multicolumn{3}{c}{",title1,"}"),string("&\\multicolumn{3}{c}{",title2,"} \\\\ \n"))
end
temp_tex=string(temp_tex,sim_num,"\n",colnames," \\midrule \n")

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
  temp_num_trips = "Number of trips"

  for k in 1:n3
    temp_norg = string(temp_norg,"&",list_data[k][:norg][1])
    temp_num_trips = string(temp_num_trips,"&",list_data[k][:num_trips][1])
  end

  temp_norg = string(temp_norg," \\\\ ")
  temp_num_trips = string(temp_num_trips," \\\\ ")

  if report_norg == 1
    temp_tex = string(temp_tex,"\n",temp_norg,"\n",temp_num_trips)
  elseif  report_norg == 0
    temp_tex = string(temp_tex,"\n",temp_num_trips)
  end

end

latex_table = string(temp_tex,"\n \\bottomrule","\n","\\end{tabular}")

write(string(path,saveas),latex_table)

end

function convert_dataframe_to_tex_format_ABW_ABW_ABW(list_data,title1,title2,title3,names_covariates,insert_colnames,path,saveas;add_stats::Int64 = 0,multicol_titles::Int64=1)

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
if multicol_titles == 1
  temp_tex = string(temp_tex,string("&\\multicolumn{3}{c}{",title1,"}"),string("&\\multicolumn{3}{c}{",title2,"}"),string("&\\multicolumn{3}{c}{",title3,"} \\\\ \n"))
end
temp_tex=string(temp_tex,sim_num,"\n",colnames," \\midrule \n")

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
  temp_num_trips = "Number of trips"

  for k in 1:n3
    temp_norg = string(temp_norg,"&",list_data[k][:norg][1])
    temp_num_trips = string(temp_num_trips,"&",list_data[k][:num_trips][1])
  end

  temp_norg = string(temp_norg," \\\\ ")
  temp_num_trips = string(temp_num_trips," \\\\ ")

  temp_tex = string(temp_tex,"\n",temp_norg,"\n",temp_num_trips)
end

latex_table = string(temp_tex,"\n \\bottomrule","\n","\\end{tabular}")

write(string(path,saveas),latex_table)

end

################################################################################
# Generate tables in the paper
################################################################################

function gen_standard_tab(path_input,path_output,tab_spec,tab_name_input,tab_name_output,norg;interaction="",interaction_label="",report_norg::Int=1)

  data_black = basic_cleaning(path_input,string("estimates_black_",tab_name_input,".csv"),norg)
  data_asian = basic_cleaning(path_input,string("estimates_asian_",tab_name_input,".csv"),norg)
  data_whithisp = basic_cleaning(path_input,string("estimates_whithisp_",tab_name_input,".csv"),norg)

  #Reorder covariates
  data_black = reorder_covariates(data_black,tab_spec)
  data_asian = reorder_covariates(data_asian,tab_spec)
  data_whithisp = reorder_covariates(data_whithisp,tab_spec)

  #label data
  data_black = label_data(data_black;interaction=interaction,interaction_label=interaction_label)
  data_asian = label_data(data_asian;interaction=interaction,interaction_label=interaction_label)
  data_whithisp = label_data(data_whithisp;interaction=interaction,interaction_label=interaction_label)

  #Convert DataFrame to Tex
  list_data = push!([],data_asian,data_black,data_whithisp)
  names_covariates = list_data[1][:names]

  insert_colnames  = repeat(String["Asian";"black"; "white/Hisp"])

  convert_dataframe_to_tex(list_data,names_covariates,insert_colnames,path_output,string(tab_name_output,".tex");add_stats = 1,report_norg=report_norg)

end

function gen_tab_spatialfrictionsinteracted(path_input,path_output,tab_spec,tab_name_output;report_norg::Int64=1)

  data_black_spatialage = basic_cleaning(path_input,"estimates_black_spatialage.csv",6)
  data_black_spatialincome = basic_cleaning(path_input,"estimates_black_spatialincome.csv",6)
  data_black_spatialgender = basic_cleaning(path_input,"estimates_black_spatialgender.csv",6)

  data_asian_spatialage = basic_cleaning(path_input,"estimates_asian_spatialage.csv",6)
  data_asian_spatialincome = basic_cleaning(path_input,"estimates_asian_spatialincome.csv",6)
  data_asian_spatialgender = basic_cleaning(path_input,"estimates_asian_spatialgender.csv",6)

  data_whithisp_spatialage = basic_cleaning(path_input,"estimates_whithisp_spatialage.csv",6)
  data_whithisp_spatialincome = basic_cleaning(path_input,"estimates_whithisp_spatialincome.csv",6)
  data_whithisp_spatialgender = basic_cleaning(path_input,"estimates_whithisp_spatialgender.csv",6)

  data_black_spatialage = add_missing_covariates(data_black_spatialage,tab_spec)
  data_black_spatialincome = add_missing_covariates(data_black_spatialincome,tab_spec)
  data_black_spatialgender = add_missing_covariates(data_black_spatialgender,tab_spec)

  data_asian_spatialage = add_missing_covariates(data_asian_spatialage,tab_spec)
  data_asian_spatialincome = add_missing_covariates(data_asian_spatialincome,tab_spec)
  data_asian_spatialgender = add_missing_covariates(data_asian_spatialgender,tab_spec)

  data_whithisp_spatialage = add_missing_covariates(data_whithisp_spatialage,tab_spec)
  data_whithisp_spatialincome = add_missing_covariates(data_whithisp_spatialincome,tab_spec)
  data_whithisp_spatialgender = add_missing_covariates(data_whithisp_spatialgender,tab_spec)

  #label data
  for (i,j) in zip(["21to39";"income";"female"],["age 21-39";"income";"female"])
    data_black_spatialage = label_data(data_black_spatialage;interaction=i,interaction_label=j)
    data_black_spatialincome = label_data(data_black_spatialincome;interaction=i,interaction_label=j)
    data_black_spatialgender = label_data(data_black_spatialgender;interaction=i,interaction_label=j)

    data_asian_spatialage = label_data(data_asian_spatialage;interaction=i,interaction_label=j)
    data_asian_spatialincome = label_data(data_asian_spatialincome;interaction=i,interaction_label=j)
    data_asian_spatialgender = label_data(data_asian_spatialgender;interaction=i,interaction_label=j)

    data_whithisp_spatialage = label_data(data_whithisp_spatialage;interaction=i,interaction_label=j)
    data_whithisp_spatialincome = label_data(data_whithisp_spatialincome;interaction=i,interaction_label=j)
    data_whithisp_spatialgender = label_data(data_whithisp_spatialgender;interaction=i,interaction_label=j)
  end

  #Convert DataFrame to Tex
  list_data = push!([],data_asian_spatialage,data_black_spatialage,data_whithisp_spatialage,data_asian_spatialincome,data_black_spatialincome,data_whithisp_spatialincome,data_asian_spatialgender,data_black_spatialgender,data_whithisp_spatialgender)
  names_covariates = list_data[1][:names]

  insert_colnames  = repeat(String["Asian";"black"; "white/Hisp"],outer=3)

  convert_dataframe_to_tex(list_data,names_covariates,insert_colnames,path_output,string(tab_name_output,".tex");add_stats = 1,report_norg=report_norg)

end

function gen_tab_ABW_ABW(path_input1,path_input2,path_output,tab1_name,tab2_name,title1,title2,tab_spec,tab_name_output;norg1=6,norg2=6,add_missing_cov::Int64=0,multicol_titles::Int64=1,report_norg::Int64=1,label="standard")

  data_black_tab1= basic_cleaning(path_input1,string("estimates_black_",tab1_name,".csv"),norg1)
  data_black_tab2 = basic_cleaning(path_input2,string("estimates_black_",tab2_name,".csv"),norg2)

  data_asian_tab1= basic_cleaning(path_input1,string("estimates_asian_",tab1_name,".csv"),norg1)
  data_asian_tab2 = basic_cleaning(path_input2,string("estimates_asian_",tab2_name,".csv"),norg2)

  data_whithisp_tab1= basic_cleaning(path_input1,string("estimates_whithisp_",tab1_name,".csv"),norg1)
  data_whithisp_tab2 = basic_cleaning(path_input2,string("estimates_whithisp_",tab2_name,".csv"),norg2)

  if add_missing_cov == 1
    data_black_tab1 = add_missing_covariates(data_black_tab1,tab_spec)
    data_black_tab2 = add_missing_covariates(data_black_tab2,tab_spec)

    data_asian_tab1 = add_missing_covariates(data_asian_tab1,tab_spec)
    data_asian_tab2 = add_missing_covariates(data_asian_tab2,tab_spec)

    data_whithisp_tab1 = add_missing_covariates(data_whithisp_tab1,tab_spec)
    data_whithisp_tab2 = add_missing_covariates(data_whithisp_tab2,tab_spec)
  end

  #Reorder covariates
  data_black_tab1 = reorder_covariates(data_black_tab1,tab_spec)
  data_black_tab2 = reorder_covariates(data_black_tab2,tab_spec)

  data_asian_tab1 = reorder_covariates(data_asian_tab1,tab_spec)
  data_asian_tab2 = reorder_covariates(data_asian_tab2,tab_spec)

  data_whithisp_tab1 = reorder_covariates(data_whithisp_tab1,tab_spec)
  data_whithisp_tab2 = reorder_covariates(data_whithisp_tab2,tab_spec)

  #label data
  data_black_tab1 = label_data(data_black_tab1;label=label)
  data_black_tab2 = label_data(data_black_tab2;label=label)

  data_asian_tab1 = label_data(data_asian_tab1;label=label)
  data_asian_tab2 = label_data(data_asian_tab2;label=label)

  data_whithisp_tab1 = label_data(data_whithisp_tab1;label=label)
  data_whithisp_tab2 = label_data(data_whithisp_tab2;label=label)

  #Convert DataFrame to Tex
  list_data = push!([],data_asian_tab1,data_black_tab1,data_whithisp_tab1,data_asian_tab2,data_black_tab2,data_whithisp_tab2)
  names_covariates = list_data[1][:names]

  insert_colnames  = repeat(String["Asian";"black"; "white/Hisp"],outer=2)

  convert_dataframe_to_tex_format_ABW_ABW(list_data,title1,title2,names_covariates,insert_colnames,path_output,string(tab_name_output,".tex");add_stats = 1,multicol_titles=multicol_titles,report_norg=report_norg)

end

function gen_tab_racespecific_robustnesschecks(path_input,path_output,race,list_specs,list_colnames,list_norg,tab_spec,tab_name_output;report_norg::Int64=1)

  list_data =  map(i->
  begin
    df = basic_cleaning(path_input,string("estimates_",race,"_",list_specs[i],".csv"),list_norg[i])
    df = add_missing_covariates(df,tab_spec)
    df = reorder_covariates(df,tab_spec)
    df = label_data(df)
  end, collect(1:length(list_specs)))

  names_covariates = list_data[1][:names]

  convert_dataframe_to_tex(list_data,names_covariates,list_colnames,path_output,string(tab_name_output,".tex");add_stats = 1,report_norg=report_norg)

end

function gen_tab_raceblind(path_input,path_output,name_input,tab_spec,tab_name,norg;report_norg::Int=1)

  df = basic_cleaning(path_input,name_input,norg)
  df = reorder_covariates(df,tab_spec)
  df = label_data(df)

  list_data = push!([],df)
  names_covariates = list_data[1][:names]

  convert_dataframe_to_tex(list_data,names_covariates,[""],path_output_sixom,string(tab_name,".tex");add_stats = 1,report_norg=report_norg,show_colnames = 0)

end

function gen_tab_ABW_ABW_ABW(path_input,path_output,list_tab_names,list_titles,list_norg,tab_spec,tab_name_output;add_missing_cov::Int64=0,multicol_titles::Int64=0)

  list_data =  map((race,tab_name,norg)->
  begin
    df = basic_cleaning(path_input,string("estimates_",race,"_",tab_name,".csv"),norg)
    if add_missing_cov == 1
      df = add_missing_covariates(df,tab_spec)
    end
    df = reorder_covariates(df,tab_spec)
    df = label_data(df)
  end,repeat(String["asian";"black"; "whithisp"],outer=3),repeat(list_tab_names,inner=3),repeat(list_norg,inner=3))

  #Convert DataFrame to Tex
  names_covariates = list_data[1][:names]

  insert_colnames  = repeat(String["Asian";"black"; "white/Hisp"],outer=3)

  convert_dataframe_to_tex_format_ABW_ABW_ABW(list_data,list_titles[1],list_titles[2],list_titles[3],names_covariates,insert_colnames,path_output,string(tab_name_output,".tex");add_stats = 1,multicol_titles=multicol_titles)

end
