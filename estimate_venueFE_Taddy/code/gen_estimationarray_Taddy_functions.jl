## Julia version: 0.6.2

#########################
# Computing ressources
#########################

#Imported functions
include("gen_estimationarray_functions.jl")

#####################
# Functions
#####################

function prepare_data_user_trip_Taddy(norg,total_visits,data_sub,specification;mintravel_time::Int=0)

  m_j = join(data_sub[:,[:userid_num;:venue_num]],total_visits,on=:venue_num,kind=:left)
  m_j = convert(Array{Int},m_j[:total_visits])

  choice_it = convert(Array{Bool},data_sub[:,:chosen])
  inset_it = convert(Array{Bool},data_sub[:,:inset])

  if mintravel_time == 0
    df_temp = diagonalize_time_covariates(data_sub,norg) #standard case
  else
    df_temp = data_sub
  end

  return m_j,choice_it,inset_it,convert(Array{Float64},df_temp[:,specification])

end

function add_previously_chosen_venues(data,num_trips)

  real_tripnum = data[:tripnumber][1]

  if real_tripnum<num_trips
    data_temp = expand_df(data,num_trips-real_tripnum)
    data_temp[:tripnumber] = collect(real_tripnum+1:num_trips)
    data_temp[:,:inset]=0.0
    data_temp[:,:chosen]=0.0
    return data_temp
  end
end

#user-specific
function build_choiceset_Taddy(df)

  num_trips = length(convert(Array{Int},unique(df[:tripnumber]))) #Total number of trips done by this user

  if num_trips > 1
    df_chosen_venues = df[(df[:chosen].==1)&(df[:tripnumber].<num_trips) ,:] #select the venues chosen before the last trip
    list_df_chosen_venues = groupby(df_chosen_venues,:tripnumber)

    list_temp = map(t->add_previously_chosen_venues(list_df_chosen_venues[t][:,1:end],num_trips),collect(1:length(list_df_chosen_venues)))
    temp = append_list_df(list_temp)
  else
    return nothing
  end

  return temp
end

function eliminate_repeated_obs(df,keep_cols)
  df_temp =df[setdiff(collect(1:nrow(df)),find(nonunique(df[:,setdiff(keep_cols,[:inset])]).==true)),:]
  sort!(df_temp,cols = [order(:userid_num),order(:tripnumber),order(:venue_num)])
  return df_temp
end

function gen_estimationarray_Taddy(norg,path_input,name_input,path_output,name_output)

  data = read_stata(string(path_input,name_input))

  data[:inset]=1.0
  data_byuser = groupby(data,:userid_num)
  list_data_missing = map(i->build_choiceset_Taddy(data_byuser[i][:,1:end]),collect(1:length(data_byuser)))
  data_missing=append_list_df(list_data_missing)
  data = [data;data_missing]

  names_data = names(data)
  cols_id = [:userid_num; :tripnumber;:venue_num; :chosen;:inset]
  discard_cols = [:user_weight,:geoid11_home,:geoid11_work,:geoid11_dest,:female,:asian,:black,:whithisp,:gender_nd,:race_nd]
  specification = setdiff(names_data,[cols_id;discard_cols])
  specification = sort_spatialcovariates(norg,specification)
  keep_cols = [cols_id;specification]
  data = data[:,keep_cols]

  data_split = groupby(data,[:userid_num,:tripnumber])
  num_trips = length(data_split) #total number of trips

  #Need to create m_j = total number of individual-time period that chosen alternative j
  total_visits = by(data,:venue_num,df->DataFrame(total_visits = sum(df[:chosen])))

  #That's i-t instances
  list_data = Array[]; list_choices = Array[];list_inset = Array[]; list_totalchoices = Array[]

  for n in 1:length(data_split)
      temp = eliminate_repeated_obs(data_split[n][:,1:end],keep_cols)
      totalchoice_tf,choice_tf,inset_tf,data_tf = prepare_data_user_trip_Taddy(norg,total_visits,temp,specification)
     push!(list_data,data_tf) ; push!(list_choices,choice_tf);push!(list_inset,inset_tf); push!(list_totalchoices,totalchoice_tf)
  end

  #save to JLD format
  save(string(path_output,name_output),"list_choices",list_choices,"list_totalchoices",list_totalchoices,"list_inset",list_inset,"list_data",list_data,"names_covariates",specification,"num_trips",num_trips,compress=true)

end
