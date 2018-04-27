## Author: Kevin Dano
## Date: April 2018
## Packages required: DataFrames CSV LaTeXStrings Distributions
## Julia version: 0.6.2

################################
# General cleaning
################################

#Retain relevant columns
function keep_cols(data,col_names)
  keep_cols = [Symbol(i) for i in col_names]
  data = data[:,keep_cols]

  return data
end

#The 28 area dummies are unreported controls
function drop_area_dummies(data)

  location = [contains(i,"d_area_") for i in data[:names]]
  data = data[.!location,:]

  return data
end

function add_missing_covariates(data,specification)

  missing_var = setdiff(specification,convert(Array{String},data[:names]))
  data_temp = DataFrame(names = missing_var)

  for i in names(data)[2:end]
    if i == :num_trips
    data_temp[i] = 0
    elseif i == :stat_significance
    data_temp[i] = ""
    elseif i == :norg
    data_temp[i] = 0
    else
      data_temp[i]=NaN
    end
  end

  data_temp = [data;data_temp]
  data_temp = reorder_covariates(data_temp,specification)

  return data_temp
end

#Order covariates in a specific order
function reorder_covariates(data,order_covariates)

  data_temp = data[data[:names].==order_covariates[1],:]

  for i in 2:length(order_covariates)
    data_temp = [data_temp;data[data[:names].==order_covariates[i],:]]
  end
  return data_temp
end

function basic_cleaning(path_input,name_input,norg)
  data = CSV.read(string(path_input,name_input),allowmissing=:none,weakrefstrings=false)

  #drop irrelevant info
  cols = ["names","estimates","std","num_trips"]
  data = keep_cols(data,cols)

  #drop area dummies
  data = drop_area_dummies(data)

  #statistical significance
  data = compute_statistical_significance(data)

  data[:norg] = norg

  return data
end

function format_number(num)
  if 0<num<1 #e.g number is of the form 0.xxx
    temp = @sprintf("%.3f",abs(num))
    if temp == "1.000"
      num_string=".999"
    else
      num_string =  string(".",split(temp,".")[2])
    end
  elseif 0>num>-1
    temp = @sprintf("%.3f",abs(num))
    if temp == "1.000"
      num_string="-.999"
    else
      num_string =  string("-",".",split(@sprintf("%.3f",num),".")[2])
    end
  elseif 10>abs(num)>1
    num_string = @sprintf("%9.2f",num)
  elseif abs(num)>10
    num_string = @sprintf("%9.1f",num)
  end

  return strip(num_string)
end


###################################
# Compute Statistical significance
###################################

function compute_statistical_significance(data)

  data[:z_stat] = (data[:estimates]./data[:std]).^2
  #Significance at the 1% level
  data[:a_signif] = (data[:z_stat] .> quantile(Chisq(1),0.99))
  #Significance at the 5% level
  data[:b_signif] = (data[:z_stat] .> quantile(Chisq(1),0.95))
  #Significance at the 10% level
  data[:c_signif] = (data[:z_stat] .> quantile(Chisq(1),0.90))

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

  delete!(data,[:a_signif,:b_signif,:c_signif,:z_stat])
  data[:stat_significance] = temp_string

  return data
end

###############################
# Attach labels to covariates
###############################

function label_data(data;interaction = "",interaction_label="",label="standard")

    for i in 1:nrow(data)
      if endswith(data[:names][i],string("_",interaction))
        temp = data[:names][i][1:searchindex(data[:names][i],string("_",interaction))-1]
        data[:names][i] = string(attach_label(temp)," \$\\times\$ ",interaction_label)
      else
        if label == "standard"
          data[:names][i] = attach_label(data[:names][i])
        elseif label =="alt"
          data[:names][i] = attach_label_alt(data[:names][i])
        end
      end
    end

    return data
end

function attach_label(x)
    if x == "time_public_home_log"
      x="Log travel time from home by public transit"
    elseif x == "time_car_home_log"
      x="Log travel time from home by car"
    elseif x == "time_public_work_log"
      x="Log travel time from work by public transit"
    elseif x == "time_car_work_log"
      x="Log travel time from work by car"
    elseif x == "time_public_path_log"
      x="Log travel time from commute by public transit"
    elseif x == "time_car_path_log"
      x="Log travel time from commute by car"
    elseif x == "eucl_demo_distance"
    	x = string("Euclidean demographic distance between"," \$ h_i\$"," and ","\$ k_j\$")
    elseif x == "eucl_demo_distance_ssi"
    	x = string("EDD ",L"\times"," SSI")
    elseif x == "med_income_perc_diff_signed"
    	x = string("Percent difference in median incomes "," \$(k_j - h_i)\$")
    elseif x == "median_income_percent_difference"
    	x = string("Percent absolute difference in median incomes "," \$(h_i - k_j)\$")
    elseif x == "avgrating_income"
      x = string("Yelp rating ","\$\\times\$"," home tract median income")
    elseif x == "d_price_2_income"
      x = string("2-dollar bin ","\$\\times\$"," home tract median income")
    elseif x == "d_price_3_income"
      x = string("3-dollar bin ","\$\\times\$"," home tract median income")
    elseif x == "d_price_4_income"
      x = string("4-dollar bin ","\$\\times\$"," home tract median income")
    elseif x == "d_price_2"
      x = "Dummy for 2-dollar bin"
    elseif  x == "d_price_3"
      x = "Dummy for 3-dollar bin"
    elseif  x == "d_price_4"
      x = "Dummy for 4-dollar bin"
    elseif x == "avgrating"
      x = "Yelp rating of restaurant"
    elseif x == "median_income_log"
      x = string("Log median household income in ","\$ k_j\$")
    elseif x == "asian_percent"
      x = string("Share of tract population that is Asian")
    elseif x == "black_percent"
      x = string("Share of tract population that is black")
    elseif x == "hispanic_percent"
      x = string("Share of tract population that is Hispanic")
    elseif x == "other_percent"
      x = string("Share of tract population that is other")
    elseif x == "lambda"
      x = string("\$\\lambda\$")
    elseif x=="d_cuisine_1"
      x = "African cuisine category"
    elseif x=="d_cuisine_2"
      x = "American cuisine category"
    elseif x=="d_cuisine_3"
      x = "Asian cuisine category"
    elseif x=="d_cuisine_4"
      x = "European cuisine category"
    elseif x=="d_cuisine_5"
      x = "Indian cuisine category"
    elseif x=="d_cuisine_6"
      x = "Latin American cuisine category"
    elseif x=="d_cuisine_7"
      x = "Middle Eastern cuisine category"
    elseif x=="d_cuisine_9"
      x = "Vegetarian/vegan cuisine category"
    elseif x=="robberies_0711_perres"
      x = string("Average annual robberies per resident in ","\$ k_j\$")
    elseif x=="spectralsegregationindex"
      x = string("Spectral segregation index of ","\$k_j\$")
    elseif  x == "reviews"
      x = "Number of Yelp reviews"
    elseif x == "reviews_log"
      x = "Log number of Yelp reviews"
    elseif  x == "time_minimum_log"
      x = "Log minimum travel time"
    elseif  x == "intercept_public_home"
      x = "Intercept for home by public transit"
    elseif  x == "intercept_car_home"
      x = "Intercept for home by car"
    elseif  x =="intercept_public_work"
      x = "Intercept for work by public transit"
    elseif  x =="intercept_car_work"
      x = "Intercept for work by car"
    elseif  x =="intercept_public_path"
      x = "Intercept for commute by public transit"
    elseif  x =="intercept_car_path"
      x = "Intercept for commute by car"
    elseif  x =="time_home_log"
      x="Log travel time from home"
    elseif  x =="time_work_log"
      x="Log travel time from work"
    elseif  x =="time_path_log"
      x="Log travel time from commute"
    elseif  x =="chain"
      x="Establishment belongs to chain" #New studd starts here
    elseif x == "vehicle_avail_hhshare_diff"
      x="Difference in tracts' private vehicle ownership" #New studd starts here
    end
  return x
end

function attach_label_alt(x)
    if x == "time_public_home_log"
      x="Log travel time from home by public transit"
    elseif x == "time_car_home_log"
      x="Log travel time from home by car"
    elseif x == "time_public_work_log"
      x="Log travel time from work by public transit"
    elseif x == "time_car_work_log"
      x="Log travel time from work by car"
    elseif x == "time_public_path_log"
      x="Log travel time from commute by public transit"
    elseif x == "time_car_path_log"
      x="Log travel time from commute by car"
    elseif x == "eucl_demo_distance"
    	x = "Euclidean demographic distance (EDD)"
    elseif x == "eucl_demo_distance_ssi"
    	x = string("EDD ",L"\times"," SSI")
    elseif x == "med_income_perc_diff_signed"
    	x = string("Percent difference in median incomes "," \$(k_j - h_i)\$")
    elseif x == "median_income_percent_difference"
    	x = string("Percent absolute difference in median incomes ")
    elseif x == "avgrating_income"
      x = string("Yelp rating ","\$\\times\$"," home tract median income")
    elseif x == "d_price_2_income"
      x = string("2-dollar bin ","\$\\times\$"," home tract median income")
    elseif x == "d_price_3_income"
      x = string("3-dollar bin ","\$\\times\$"," home tract median income")
    elseif x == "d_price_4_income"
      x = string("4-dollar bin ","\$\\times\$"," home tract median income")
    elseif x == "d_price_2"
      x = "Dummy for 2-dollar bin"
    elseif  x == "d_price_3"
      x = "Dummy for 3-dollar bin"
    elseif  x == "d_price_4"
      x = "Dummy for 4-dollar bin"
    elseif x == "avgrating"
      x = "Yelp rating of restaurant"
    elseif x == "median_income_log"
      x = string("Log median household income in ","\$ k_j\$")
    elseif x == "asian_percent"
      x = string("Share of tract population that is Asian")
    elseif x == "black_percent"
      x = string("Share of tract population that is black")
    elseif x == "hispanic_percent"
      x = string("Share of tract population that is Hispanic")
    elseif x == "other_percent"
      x = string("Share of tract population that is other")
    elseif x == "lambda"
      x = string("\$\\lambda\$")
    elseif x=="d_cuisine_1"
      x = "African cuisine category"
    elseif x=="d_cuisine_2"
      x = "American cuisine category"
    elseif x=="d_cuisine_3"
      x = "Asian cuisine category"
    elseif x=="d_cuisine_4"
      x = "European cuisine category"
    elseif x=="d_cuisine_5"
      x = "Indian cuisine category"
    elseif x=="d_cuisine_6"
      x = "Latin American cuisine category"
    elseif x=="d_cuisine_7"
      x = "Middle Eastern cuisine category"
    elseif x=="d_cuisine_9"
      x = "Vegetarian/vegan cuisine category"
    elseif x=="robberies_0711_perres"
      x = string("Average annual robberies per resident in ","\$ k_j\$")
    elseif x=="spectralsegregationindex"
      x = string("Spectral segregation index (SSI) of ","\$k_j\$")
    elseif  x == "reviews"
      x = "Number of Yelp reviews"
    elseif x == "reviews_log"
      x = "Log number of Yelp reviews"
    elseif  x == "time_minimum_log"
      x = "Log minimum travel time"
    elseif  x == "intercept_public_home"
      x = "Intercept for home by public transit"
    elseif  x == "intercept_car_home"
      x = "Intercept for home by car"
    elseif  x =="intercept_public_work"
      x = "Intercept for work by public transit"
    elseif  x =="intercept_car_work"
      x = "Intercept for work by car"
    elseif  x =="intercept_public_path"
      x = "Intercept for commute by public transit"
    elseif  x =="intercept_car_path"
      x = "Intercept for commute by car"
    elseif  x =="time_home_log"
      x="Log travel time from home"
    elseif  x =="time_work_log"
      x="Log travel time from work"
    elseif  x =="time_path_log"
      x="Log travel time from commute"
    elseif  x =="chain"
      x="Establishment belongs to chain" #New studd starts here
    elseif x == "vehicle_avail_hhshare_diff"
      x="Difference in tracts' private vehicle ownership" #New studd starts here
    end
  return x
end
