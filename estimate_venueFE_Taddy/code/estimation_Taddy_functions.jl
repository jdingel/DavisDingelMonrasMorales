## Author: Kevin Dano
## Date: April 2018
## Purpose: Performs the estimation of our models
## Julia version: 0.6.2
## Packages required: DataFrames, JLD

######################
# Computing resources
#####################

#Imported functions
include("fit_Taddy.jl")

########################
# Function
########################

function compute_estimates_Taddy(norg,path_input,name_input,path_output,name_output)

  @time load_data = load(string(path_input,name_input))
  println("Successful loading")

  list_choices = load_data["list_choices"]
  list_totalchoices = load_data["list_totalchoices"]
  list_inset = load_data["list_inset"]
  list_data = load_data["list_data"]
  names_covariates = load_data["names_covariates"]
  num_trips = load_data["num_trips"]

  I = length(list_data)
  K = length(names_covariates)

  #Starting point
  theta_init = zeros(K)

  @time result = fit_Taddy(theta_init,list_data,list_choices,list_inset,list_totalchoices,norg)
  theta_estimates = Optim.minimizer(result)
  println("Estimates: ",theta_estimates)

  @time var = try
    var_Taddy(theta_estimates,list_data,list_choices,list_inset,list_totalchoices,norg)
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

  LL_theta_estimates = LL_Taddy(theta_estimates,list_data,list_choices,list_inset,list_totalchoices,norg)
  @time Score_theta_estimates = score_Taddy(theta_estimates,list_data,list_choices,list_inset,list_totalchoices,norg)

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

  CSV.write(string(path_output,name_output),export_data)

end
