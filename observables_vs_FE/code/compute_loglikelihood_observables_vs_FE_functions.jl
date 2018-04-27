## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

function compute_LL_observables_userlvl(userid,spec_obs,data_estimates_obs,data_estsample_predictarray,data_user_trip)

  df_user_trip = data_user_trip[data_user_trip[:userid_num].==userid,:]
  df_user_trip[:pr_visit]=0.0

  df_predictarray = data_estsample_predictarray[data_estsample_predictarray[:userid_num].==userid,:]
  df_predvisits = compute_prob_visit_venue(norg,df_predictarray,data_estimates_obs,spec_obs)

  adjust = 1.0

  for i in 1:nrow(df_user_trip)
    df_user_trip[i,:pr_visit]=(df_predvisits[df_predvisits[:venue_num].==df_user_trip[i,:venue_num],:prob_visit_venue][1])/adjust
    adjust-=df_user_trip[i,:pr_visit]
  end

  LL_observables = sum(log.(df_user_trip[:pr_visit]))
  return LL_observables
end

function compute_LL_FE_userlvl(userid,spec_FE,data_estimates_FE,data_estsample_predictarray,data_user_trip)

  df_user_trip = data_user_trip[data_user_trip[:userid_num].==userid,:]
  df_user_trip[:pr_visit]=0.0

  df_predictarray = data_estsample_predictarray[data_estsample_predictarray[:userid_num].==userid,:]
  df_predvisits = compute_prob_visit_venue_FE(norg,df_predictarray,data_estimates_FE,spec_FE)

  adjust = 1.0

  for i in 1:nrow(df_user_trip)
    df_user_trip[i,:pr_visit]=(df_predvisits[df_predvisits[:venue_num].==df_user_trip[i,:venue_num],:prob_visit_venue][1])/adjust
    adjust-=df_user_trip[i,:pr_visit]
  end

  LL_FE = sum(log.(df_user_trip[:pr_visit]))
  return LL_FE
end
