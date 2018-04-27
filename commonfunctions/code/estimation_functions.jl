## Author: Kevin Dano
## Date: April 2018
## Purpose: Performs the estimation of our models
## Packages required: DataFrames, CSV, JLD
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Imported functions
include("fit_mnl_newton.jl")
include("fit_mnl_hessianfree.jl")
include("fit_nlogit_onelambda_multiperiod.jl")

########################
# Function
########################

function compute_estimates_mnl_newton(norg,path_input,name_input,path_output,name_output;provide_starting_point::Int=0,path_starting_point::String="",name_starting_point::String="")

  @time load_data = load(string(path_input,name_input))
  println("Successful loading")

  list_choices = load_data["list_choices"]
  list_data = load_data["list_data"]
  names_covariates = load_data["names_covariates"]
  num_trips = load_data["num_trips"]
  rank_estarray = load_data["rank_estarray"]

  I = length(list_data)
  K = length(names_covariates)

  #Starting point
  theta_init = zeros(K)

  if provide_starting_point == 1
    df_starting_point = CSV.read(string(path_starting_point,name_starting_point),allowmissing=:none,weakrefstrings=false)

    covariates_of_interest = map(i->string(i),names_covariates)

    theta_starting_point = convert(Array{Float64},df_starting_point[findin(df_starting_point[:names],covariates_of_interest),:estimates])

    theta_init = theta_init + [theta_starting_point;zeros(K-length(theta_starting_point))]
  end

  @time result = fit_mnl_newton(theta_init,list_data,list_choices,norg)
  theta_estimates = Optim.minimizer(result)
  println("Estimates: ",theta_estimates)

  @time var = try
    var_mnl_newton(theta_estimates,list_data,list_choices,norg)
  catch
    "singular matrix"
  end
  println("Variance of estimates: ",var)

  @time std = try
    sqrt.(var)
    catch
    "negative number"
  end
  println("Standard deviation of estimates: ",std)

  export_data = DataFrame(names = names_covariates,estimates = theta_estimates,std = std,var=var)

  LL_theta_estimates = LL_mnl_newton(norg,theta_estimates,list_data,list_choices)
  Score_theta_estimates = Score_mnl_newton(norg,theta_estimates,list_data,list_choices)

  export_data[:log_likelihood_value] = LL_theta_estimates
  export_data[:norm_score] = norm(Score_theta_estimates)

  #Report convergence flags
  export_data[:x_converged] =  Optim.x_converged(result)
  export_data[:f_converged] =  Optim.f_converged(result)
  export_data[:g_converged] =  Optim.g_converged(result)
  export_data[:f_increased] =  Optim.f_increased(result)

  #Report number of iterations
  export_data[:iterations] = Optim.iterations(result)

  #Report number of trips
  export_data[:num_trips] = num_trips

  #Report rank of estimation array
  export_data[:rank_estarray] = rank_estarray

  CSV.write(string(path_output,name_output),export_data)

end

function compute_estimates_mnl_hessianfree(norg,path_input,name_input,path_output,name_output;provide_starting_point::Int=0,path_starting_point::String="",name_starting_point::String="")

  @time load_data = load(string(path_input,name_input))

  println("Successful loading")

  list_choices = load_data["list_choices"]
  list_data = load_data["list_data"]
  names_covariates = load_data["names_covariates"]
  num_trips = load_data["num_trips"]
  rank_estarray = load_data["rank_estarray"]

  I = length(list_data)
  K = length(names_covariates)

  #Starting point
  theta_init = zeros(K)

  if provide_starting_point == 1
    df_starting_point = CSV.read(string(path_starting_point,name_starting_point),allowmissing=:none,weakrefstrings=false)

    covariates_of_interest = map(i->string(i),names_covariates)

    theta_starting_point = convert(Array{Float64},df_starting_point[findin(df_starting_point[:names],covariates_of_interest),:estimates])

    theta_init = theta_init + [theta_starting_point;zeros(K-length(theta_starting_point))]
  end

  @time result = fit_mnl_hessianfree(norg,theta_init,list_data,list_choices)
  theta_estimates = Optim.minimizer(result)
  println("Estimates: ",theta_estimates)

  @time var = try
    var_mnl_hessianfree(norg,K,theta_estimates,list_data,list_choices)
    catch
      "singular matrix"
  end
  println("Variance of estimates: ",var)

  @time std = try
    sqrt.(var)
    catch
    "negative number"
  end
  println("Standard deviation of estimates: ",std)

  export_data = DataFrame(names = names_covariates,estimates = theta_estimates,std = std,var=var)

  LL_theta_estimates = -mnl_obj_hessianfree(norg,I,K,theta_estimates,Array(Float64),list_data,list_choices)
  Score_theta_estimates = score_mnl_hessianfree(norg,theta_estimates,list_data,list_choices)

  export_data[:log_likelihood_value] = LL_theta_estimates
  export_data[:norm_score] = norm(Score_theta_estimates)

  #Report convergence flags
  export_data[:x_converged] =  Optim.x_converged(result)
  export_data[:f_converged] =  Optim.f_converged(result)
  export_data[:g_converged] =  Optim.g_converged(result)
  export_data[:f_increased] =  Optim.f_increased(result)

  #Report number of iterations
  export_data[:iterations] = Optim.iterations(result)

  #Report number of trips
  export_data[:num_trips] = num_trips

  #Report rank of estimation array
  export_data[:rank_estarray] = rank_estarray

  CSV.write(string(path_output,name_output),export_data)

end

function compute_estimates_mnl_FE_hessianfree(norg,path_input,name_input,path_output,name_output;provide_starting_point::Int=0,path_starting_point::String="",name_starting_point::String="")

  @time load_data = load(string(path_input,name_input))

  println("Successful loading")

  list_choices = load_data["list_choices"]
  list_data = load_data["list_data"]
  names_covariates = load_data["names_covariates"]
  num_trips = load_data["num_trips"]
  omitted_dummy = load_data["omitted_dummy"]
  rank_estarray = load_data["rank_estarray"]

  I = length(list_data)
  K = length(names_covariates)

  #Starting point
  theta_init = zeros(K)

  if provide_starting_point == 1
    df_starting_point = CSV.read(string(path_starting_point,name_starting_point),allowmissing=:none,weakrefstrings=false)

    covariates_of_interest = map(i->string(i),names_covariates)
    covariates_of_interest = covariates_of_interest[.![contains(i,"restaurant_") for i in covariates_of_interest]] #drop dummies

    theta_starting_point = convert(Array{Float64},df_starting_point[findin(df_starting_point[:names],covariates_of_interest),:estimates])

    theta_init = theta_init + [theta_starting_point;zeros(K-length(theta_starting_point))]
  end

  @time result = fit_mnl_hessianfree(norg,theta_init,list_data,list_choices)
  theta_estimates = Optim.minimizer(result)
  println("Estimates: ",theta_estimates)

  @time var = try
    var_mnl_hessianfree(norg,K,theta_estimates,list_data,list_choices)
    catch
      "singular matrix"
  end
  println("Variance of estimates: ",var)

  @time std = try
    sqrt.(var)
    catch
    "negative number"
  end
  println("Standard deviation of estimates: ",std)

  export_data = DataFrame(names = names_covariates,estimates = theta_estimates,std = std,var=var)

  LL_theta_estimates = -mnl_obj_hessianfree(norg,I,K,theta_estimates,Array{Float64}(),list_data,list_choices)
  Score_theta_estimates = score_mnl_hessianfree(norg,theta_estimates,list_data,list_choices)

  export_data[:log_likelihood_value] = LL_theta_estimates
  export_data[:norm_score] = norm(Score_theta_estimates)

  #Report convergence flags
  export_data[:x_converged] =  Optim.x_converged(result)
  export_data[:f_converged] =  Optim.f_converged(result)
  export_data[:g_converged] =  Optim.g_converged(result)
  export_data[:f_increased] =  Optim.f_increased(result)

  #Report number of iterations
  export_data[:iterations] = Optim.iterations(result)

  #Report number of trips
  export_data[:num_trips] = num_trips
  export_data[:omitted_dummy] = omitted_dummy

  #Report rank of estimation array
  export_data[:rank_estarray] = rank_estarray

  CSV.write(string(path_output,name_output),export_data)

end

function compute_estimates_nlogit_uniquelambda(norg,path_input,name_input,path_output,name_output;provide_starting_point::Int=0,path_starting_point::String="",name_starting_point::String="")

@time load_data = load(string(path_input,name_input))

println("Successful loading")

list_choices = load_data["list_choices"]
list_data_nests = load_data["list_data_nests"]
list_data_incval = load_data["list_data_incval"]
names_covariates = load_data["names_covariates"]
num_trips = load_data["num_trips"]
rank_estarray = load_data["rank_estarray"]

I = length(list_data_nests)
K = length(names_covariates)

#Starting point
theta_init = zeros(K)

if provide_starting_point == 1
  df_starting_point = CSV.read(string(path_starting_point,name_starting_point),allowmissing=:none,weakrefstrings=false)

  covariates_of_interest = map(i->string(i),names_covariates)

  theta_starting_point = convert(Array{Float64},df_starting_point[findin(df_starting_point[:names],covariates_of_interest),:estimates])

  theta_init = theta_init + [theta_starting_point;zeros(K-length(theta_starting_point))]
end

@time result = fitnlogit_norg_uniquelambda_multiperiod(norg,theta_init,list_data_nests,list_data_incval,list_choices)
theta_estimates = Optim.minimizer(result)
println("Estimates: ",theta_estimates)

@time var = try
  var_fitnlogit_norg_uniquelambda_multiperiod(norg,K,theta_estimates,list_data_nests,list_data_incval,list_choices)
  catch
    "singular matrix"
end
println("Variance of estimates: ",var)

@time std = try
  sqrt.(var)
  catch
  "negative number"
end
println("Standard deviation of estimates: ",std)

export_data = DataFrame(names = [names_covariates;"lambda"],estimates = theta_estimates,std = std,var=var)

LL_theta_estimates = -nlogitobj_norg_uniquelambda_multiperiod(norg,I,theta_estimates,Array(Float64),K,list_data_nests,list_data_incval,list_choices)
Score_theta_estimates = try
  score_nlogitobj_norg_uniquelambda_multiperiod(norg,theta_estimates,K,list_data_nests,list_data_incval,list_choices)
  catch
  "error"
end

export_data[:log_likelihood_value] = LL_theta_estimates
export_data[:norm_score] = try
  norm(Score_theta_estimates)
  catch
  "error"
end

#Report convergence flags
export_data[:x_converged] =  Optim.x_converged(result)
export_data[:f_converged] =  Optim.f_converged(result)
export_data[:g_converged] =  Optim.g_converged(result)
export_data[:f_increased] =  Optim.f_increased(result)

#Report number of iterations
export_data[:iterations] = Optim.iterations(result)

#Report number of trips
export_data[:num_trips] = num_trips

#Report rank of estimation array
export_data[:rank_estarray] = rank_estarray

CSV.write(string(path_output,name_output),export_data)

end
