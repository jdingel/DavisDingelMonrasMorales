## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using DataFrames
using CSV

#Imported functions
include("process_bootstrap_estimates_functions.jl")
include("general_functions.jl")

#Arguments
race = ARGS[1]
specification = ARGS[2]

#Path
path_input = string("../output/estimates/",specification,"/")
path_output = string("../output/estimates/",specification,"/")

##################################
# Calls
##################################

list_instances = collect(1:500)
keep_cols = [:names,:estimates,:std,:rank_estarray]

#1)Append all bootstrap results
list_df_bootstrap = map(i->begin

  #Our preferred estimate will be the one leading to the largest value of the log likelihood function
  df0 = CSV.read(string(path_input,string("estimates_",race,"_",specification,"_",i,".csv")),allowmissing=:none,weakrefstrings=false,types=Dict("rank_estarray"=>String))
  df1 = CSV.read(string(path_input,string("estimates_",race,"_",specification,"_",i,"_hessianfree.csv")),allowmissing=:none,weakrefstrings=false,types=Dict("rank_estarray"=>String))

  if df0[:log_likelihood_value][1]>df1[:log_likelihood_value][1]
    df = copy(df0)[:,keep_cols]
  else
    df = copy(df1)[:,keep_cols]
  end

  if typeof(df[:std]).==CategoricalArrays.CategoricalArray{String,1,UInt32,String,CategoricalArrays.CategoricalString{UInt32},Union{}}
      df[:std]=convert(Array{String},df[:std])
  end

  df[:instance] = i
  df[:order_temp] =collect(1:nrow(df))
return df
end,list_instances
)

df_bootstrap = append_list_df(list_df_bootstrap;method=0)
df_bootstrap = sort(df_bootstrap,cols=[order(:order_temp),order(:instance)])
preserve_order = unique(df_bootstrap[:names])
CSV.write(string(path_input,string("estimates_",race,"_",specification,"_bootstrap_all.csv")),df_bootstrap)

#Remove problematic estimates
df_bootstrap_clean = df_bootstrap[df_bootstrap[:rank_estarray].=="full rank",:] #abandon estimates which estimation array was rank deficient
df_bootstrap_clean = df_bootstrap_clean[(df_bootstrap_clean[:std].!="negative number"),:] #abandon estimates that produced negative variance
CSV.write(string(path_input,string("estimates_",race,"_",specification,"_bootstrap_clean.csv")),df_bootstrap_clean)

df_bootstrap_clean[:std][typeof.(df_bootstrap_clean[:std]).!=Float64]=parse.(Float64,df_bootstrap_clean[:std][typeof.(df_bootstrap_clean[:std]).!=Float64])
df_bootstrap_clean[:std]=convert(Array{Float64},df_bootstrap_clean[:std])

#2) Compute average of bootstrap estimates
df_bootstrap_stats = compute_average_bootstrap_estimates(df_bootstrap_clean)
df_bootstrap_stats = reorder_estimates(df_bootstrap_stats,preserve_order)
CSV.write(string(path_input,string("estimates_",race,"_",specification,"_bootstrap_avg.csv")),df_bootstrap_stats)
