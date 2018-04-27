## Author: Kevin Dano
## Julia version: 0.6.2
##Package required : DataFrame

#########################
# Functions
########################

#Compute confidence interval
function compute_bootstrap_CI_percentilemethod(data_bootstrap,bootstrap_CI_lower_bound,bootstrap_CI_upper_bound;keep_full_rank_only::Int=1)

  if keep_full_rank_only == 1
    data_bootstrap = data_bootstrap[data_bootstrap[:rank_estarray].=="full rank",:]
  end

  data_bootstrap_stats = by(data_bootstrap,:names,Df->DataFrame(estimates_mean=mean(df[:estimates]),std_mean=mean(df[:std]),estimates_median=median(df[:estimates]),std_median = median(df[:std]),x1=quantile(df[:estimates],bootstrap_CI_lower_bound),x2=quantile(df[:estimates],bootstrap_CI_upper_bound)))
  rename!(data_bootstrap_stats,[:x1;:x2],[Symbol(string("bootstrap_CI_bound_",@sprintf("%.1f%%",100*bootstrap_CI_lower_bound))),Symbol(string("bootstrap_CI_bound_",@sprintf("%.1f%%",100*bootstrap_CI_upper_bound)))])

  return data_bootstrap_stats
end

#Compute mean of bootstrap estimates
function compute_average_bootstrap_estimates(data_bootstrap;keep_full_rank_only::Int=1)

  if keep_full_rank_only == 1
    data_bootstrap = data_bootstrap[data_bootstrap[:rank_estarray].=="full rank",:]
  end

  data_bootstrap_mean = by(data_bootstrap,:names,df->DataFrame(estimates=mean(df[:estimates]),std=mean(df[:std])))
  return data_bootstrap_mean
end

function reorder_estimates(df,new_order)
  df_temp = df[df[:names].==new_order[1],:]

  for i in 2:length(new_order)
    df_temp = append!(df_temp,df[df[:names].==new_order[i],:])
  end
  return df_temp
end
