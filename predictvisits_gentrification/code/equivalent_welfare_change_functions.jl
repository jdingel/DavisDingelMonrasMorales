## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

#####################
# Functions
#####################

function compute_welfare_diff(x,df_predictarray_sub,df_predvisits_gentrification_sub,venues_treated,venues_untreated,keep_cols)

  df_treated = copy(df_predictarray_sub[findin(df_predictarray_sub[:venue_num],venues_treated),:])
  df_untreated = copy(df_predictarray_sub[findin(df_predictarray_sub[:venue_num],venues_untreated),:])

  #Step1: add x to time_public_home_log & time_car_home_log for the treated venues
  df_treated[:time_public_home] = x.*df_treated[:time_public_home]
  df_treated[:time_car_home] = x.*df_treated[:time_car_home]

  df_full = [df_treated;df_untreated]
  df_full[:time_public_path]=max(0,0.5.*(df_full[:time_public_home] + df_full[:time_public_work] - df_full[:time_public_home_work]))
  df_full[:time_car_path] = max(0,0.5.*(df_full[:time_car_home] + df_full[:time_car_work] - df_full[:time_car_home_work]))

  for i in ["time_public_home"; "time_public_work"; "time_public_path"; "time_car_home"; "time_car_work"; "time_car_path"]
    df_full[Symbol(string(i,"_log"))] = log(df_full[Symbol(i)]+1)
  end

  df_full=df_full[:,keep_cols]
  df_full = sort(df_full,cols = [order(:userid_num), order(:venue_num)])

  df_predvisit_standard =  compute_prob_visit_venue(norg,df_full,data_estimates,spec_standard;gentrification=1)
  df_predvisit_standard[:welfare]=log(df_predvisit_standard[:denom_prob_visit_venue])

  diff = abs(df_predvisit_standard[:welfare][1]-df_predvisits_gentrification_sub[:welfare][1])

  return diff
end
