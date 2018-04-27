## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Imported functions
include("tables_formatting.jl")

################################################################################
# Generate Tex table
################################################################################

function convert_dataframe_to_tex_FE(list_data,names_covariates,insert_colnames,path,saveas;add_stats::Int64 = 0,report_norg::Int64=1,show_colnames::Int64=1)

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
    temp_num_FE = "Number of fixed effects"

    for k in 1:n3
      temp_norg = string(temp_norg,"&",list_data[k][:norg][1])
      temp_num_trips = string(temp_num_trips,"&",list_data[k][:num_trips][1])
      temp_num_FE = string(temp_num_FE,"&",list_data[k][:num_FE][1])
    end

    temp_norg = string(temp_norg," \\\\ ")
    temp_num_trips = string(temp_num_trips," \\\\ ")
    temp_num_FE = string(temp_num_FE," \\\\ ")

    if report_norg == 1
      temp_tex = string(temp_tex,"\n",temp_norg,"\n",temp_num_trips,"\n",temp_num_FE)
    elseif  report_norg == 0
      temp_tex = string(temp_tex,"\n",temp_num_trips,"\n",temp_num_FE)
    end
  end

  latex_table = string(temp_tex,"\n \\bottomrule","\n","\\end{tabular}")

  write(string(path,saveas),latex_table)

end

################################################################################
# Generate tables in the paper
################################################################################

function gen_standard_tab_FE(norg,path_input,path_output,spec,tab_spec,tab_name_output;report_norg::Int64=1)

  list_data =  map(race->
  begin
    df = basic_cleaning(path_input,string("estimates_venueFE_",race,"_",spec,".csv"),norg)
    num_FE = sum([contains(k,"restaurant_") for k in df[:names]])
    df = reorder_covariates(df,tab_spec)
    df = label_data(df)
    df[:num_FE] = num_FE
    return df
  end, ["asian","black","whithisp"])

  names_covariates = list_data[1][:names]
  insert_colnames  = String["Asian";"black"; "white/Hisp";repeat(["A";"B";"WH"],outer=2)]

  convert_dataframe_to_tex_FE(list_data,names_covariates,insert_colnames,path_output,string(tab_name_output,".tex");add_stats = 1,report_norg=report_norg)

end
