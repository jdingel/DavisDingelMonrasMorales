## Author: Kevin Dano
## Date: April 2018
## Purpose: Compute dissimilarity indices
## Packages required: DataFrames
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Imported functions
include("general_functions.jl")

#################################
# Functions
#################################

#####################
# Probabilities
#####################

#Generate simultaneously:
#1) Pr(h|r): The distribution of a race's population across NYC tracts
#2) Pr(r): The fraction of NYC residents who are race r
function compute_prob_home_cond_race_and_prob_race(data;add_nonrace::Int=0)

  #Keep variables of interest: race_percent
  data = data[:,[:geoid11;:population;map(i->Symbol(i),covariates_startingby(data,".+_percent\$"))]]

  #Drop census tracts wih zero visits
  data = data[setdiff(collect(1:nrow(data)),findin(data[:geoid11],[36061009400;36061029700])),:]

  #Merge with tract_2010_characteristics
  data[:other_percent] = 1 - data[:asian_percent] -data[:black_percent] -data[:hispanic_percent] -data[:white_percent]
  data[:whithisp_percent] = data[:hispanic_percent] + data[:white_percent]

  #Rename geoid11 to geoid11home
  rename!(data,:geoid11=>:geoid11_home)

  #Pr(h|r): The distribution of a race's population across NYC tracts
  for i in ["asian","black","hispanic","white","other","whithisp"]
    data = compute_prob_home_cond_race(data,i;add_nonrace=add_nonrace)
  end

  data_prob_home_cond_race = data[:,[:geoid11_home;map(i->Symbol(i),covariates_startingby(data,"^prob_h_.+"))]] #Keep variables of interest

  #Pr(r): The fraction of NYC residents who are race r
  data_prob_race = compute_prob_race(data)

  return data_prob_home_cond_race,data_prob_race

end

#Compute Pr(h|r) = the distribution of a race's population across NYC tracts
function compute_prob_home_cond_race(data,race;add_nonrace::Int=0)

  data[Symbol(string(race,"_pop"))] = data[Symbol(string(race,"_percent"))].*data[:population]
  data[Symbol(string("prob_h_",race))] = data[Symbol(string(race,"_pop"))] ./sum(data[Symbol(string(race,"_pop"))])

  if add_nonrace == 1
    data[Symbol(string("non"race,"_pop"))] = (1-data[Symbol(string(race,"_percent"))]).*data[:population]
    data[Symbol(string("prob_h_non",race))] = data[Symbol(string("non"race,"_pop"))] ./sum(data[Symbol(string("non"race,"_pop"))])
  end

  return data
end

#Compute Pr(r)= the fraction of NYC residents who are race r
function compute_prob_race(data)

  data_prob_race = data[:,[:population;map(i->Symbol(i),covariates_startingby(data,".+_pop\$"))]] #Keep variables of interest

  data_prob_race[:temp] = 1
  data_prob_race = by(data_prob_race,:temp,df->DataFrame(population=sum(df[:population]),black_pop=sum(df[:black_pop]),asian_pop=sum(df[:asian_pop]),white_pop=sum(df[:white_pop]),hispanic_pop=sum(df[:hispanic_pop]),other_pop=sum(df[:other_pop])))
  data_prob_race[:whithisp_pop] = data_prob_race[:white_pop]+ data_prob_race[:hispanic_pop]

  for race in ["asian","black","hispanic","white","other","whithisp"]
    data_prob_race[Symbol(string("prob_",race))] = data_prob_race[Symbol(string(race,"_pop"))]./ data_prob_race[:population]
  end

  data_prob_race = data_prob_race[:,map(i->Symbol(i),covariates_startingby(data_prob_race,"^prob_.+"))]

  return data_prob_race

end

#Compute Pr(j|r) = proba of visit conditional
#data inputs:
#1) Pr(j|r,h) = proba of visit conditional on race and home origin
#2) Pr(h|r) = the distribution of a race's population across NYC tracts
#3) Pr(r)= the fraction of NYC residents who are race r
function compute_prob_venue_cond_race(race,data_prob_venue_cond_race_home,data_prob_home_race,data_prob_race,specification;geographic_level::String="venue_level")

  #Merge with Pr(h|r) (Problem with geoid11_home = 36047080800)
  data_proba_venue = join(data_prob_venue_cond_race_home,data_prob_home_race[:,[:geoid11_home;Symbol(string("prob_h_",race))]],on=:geoid11_home,kind=:inner)

  #Calculate Pr(j|r,g) = \sum_h Pr(j|h,r,g) * Pr(h|r,g)
  data_proba_venue[:pr_dest_race] = data_proba_venue[Symbol(string("prob_h_",race))].*data_proba_venue[Symbol(specification)]

  if geographic_level == "venue_level"
    data_proba_venue = by(data_proba_venue,[:geoid11_dest,:venue_num],df->DataFrame(pr_dest_race=sum(df[:pr_dest_race])))
  elseif geographic_level == "tract_level"
    data_proba_venue = by(data_proba_venue,[:geoid11_dest],df->DataFrame(pr_dest_race=sum(df[:pr_dest_race])))
  end

  data_proba_venue[:share] = data_prob_race[Symbol(string("prob_",race))][1]
  data_proba_venue[:race] = race

  return data_proba_venue
end

##########################
# Dissimilarity functions
##########################

#Produce dissimilarity measures for race in terms of not-race for the five races
function dissimilarity_index(data,r1)

    prob_race = data[data[:race].==r1,:pr_dest_race]

    temp = unique(data[:,[:race,:share]])

    other_races = setdiff(temp[:race],[r1])

    prob_other_races = 0.0

    weight_other_races = sum(temp[temp[:race].!=r1,:share])

    for r2 in  other_races
      prob_other_races+= data[data[:race].==r2,:pr_dest_race].*temp[temp[:race].==r2,:share]./weight_other_races
    end

    dissimilarityindex = 0.5*sum(abs.(prob_race-prob_other_races))

    df = DataFrame(race=r1,dissimilarityindex=dissimilarityindex)

    return df
end

#Produce dissimilarity measures for race1-by-race2 matrix
function dissimilarity_index_pairwise(data,race1,race2)

  dissim_pairwise = 0.5*sum(abs.(data[data[:race].== race1,:pr_dest_race]-data[data[:race].== race2,:pr_dest_race]))

  df = DataFrame(race1=race1,race2=race2,dissimilarityindex=dissim_pairwise)
  return df
end

#Produce dissimilarity measures for race in terms of not-race for the five races
function dissimilarity_index_residential(data,race::String)

  prob_race = data[Symbol("prob_h_",race)]
  prob_nonrace = data[Symbol("prob_h_non",race)]

  dissimilarityindex = 0.5*sum(abs.(prob_race-prob_nonrace))

  df = DataFrame(race=race,dissimilarityindex=dissimilarityindex)

  return df
end

#Produce dissimilarity measures for race1-by-race2 matrix
function dissimilarity_index_pairwise_residential(data,race1,race2)

  prob_race1 = data[Symbol("prob_h_",race1)]
  prob_race2 = data[Symbol("prob_h_",race2)]

  dissim_pairwise = 0.5*sum(abs.(prob_race1-prob_race2))

  df = DataFrame(race1=race1,race2=race2,dissimilarityindex=dissim_pairwise)

  return df
end

# Stores dissimilarity measures in a dataframe
function compute_dissimilarity(data_prob_venue_cond_black_home,data_prob_venue_cond_asian_home,data_prob_venue_cond_whithisp_home,data_prob_home_cond_race,data_prob_race,list_race,spec;geographic_level::String="venue_level")

  data_prob_venue_black = compute_prob_venue_cond_race("black",data_prob_venue_cond_black_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)
  data_prob_venue_asian = compute_prob_venue_cond_race("asian",data_prob_venue_cond_asian_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)
  data_prob_venue_white = compute_prob_venue_cond_race("white",data_prob_venue_cond_whithisp_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)
  data_prob_venue_hispanic = compute_prob_venue_cond_race("hispanic",data_prob_venue_cond_whithisp_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)
  data_prob_venue_other = compute_prob_venue_cond_race("other",data_prob_venue_cond_whithisp_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)
  data_prob_venue_whithisp = compute_prob_venue_cond_race("whithisp",data_prob_venue_cond_whithisp_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)

  data_prob_venue = [data_prob_venue_black;data_prob_venue_asian;data_prob_venue_white;data_prob_venue_hispanic;data_prob_venue_other]

  data_dissimilarity_index = append_list_df(map(race->dissimilarity_index(data_prob_venue,race),list_race))
  data_dissimilarity_index_pairwise = append_list_df(map((r1,r2)->dissimilarity_index_pairwise(data_prob_venue,r1,r2),["asian";"asian";"asian";"hispanic";"black";"black"],["hispanic";"black";"white";"white";"hispanic";"white"]))

  #Add dissimilarity for whithisp
  data_prob_venue_addwhithisp = [data_prob_venue_black;data_prob_venue_asian;data_prob_venue_whithisp;data_prob_venue_other]
  append!(data_dissimilarity_index,dissimilarity_index(data_prob_venue_addwhithisp,"whithisp"))

  data_dissimilarity_index[:spec] = spec
  data_dissimilarity_index_pairwise[:spec] = spec

  return data_dissimilarity_index, data_dissimilarity_index_pairwise
end
