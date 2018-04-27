## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

#################################
# Functions
#################################

function gather_prob_venue_cond_race(spec,name,data_tract_2010_characteristics_est,data_prob_home_cond_race,data_prob_race,data_prob_venue_cond_black_home,data_prob_venue_cond_asian_home,data_prob_venue_cond_whithisp_home;geographic_level::String="tract_level")

  data_prob_venue_black = compute_prob_venue_cond_race("black",data_prob_venue_cond_black_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)
  black_pop_total = sum(data_tract_2010_characteristics_est[:population].*data_tract_2010_characteristics_est[:black_percent])
  data_prob_venue_black[:pr_dest_race]=data_prob_venue_black[:pr_dest_race].*black_pop_total
  data_prob_venue_black[:pr_dest_race]=convert(Array{Int},round.(data_prob_venue_black[:pr_dest_race]))

  data_prob_venue_asian = compute_prob_venue_cond_race("asian",data_prob_venue_cond_asian_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)
  asian_pop_total = sum(data_tract_2010_characteristics_est[:population].*data_tract_2010_characteristics_est[:asian_percent])
  data_prob_venue_asian[:pr_dest_race]=data_prob_venue_asian[:pr_dest_race].*asian_pop_total
  data_prob_venue_asian[:pr_dest_race]=convert(Array{Int},round.(data_prob_venue_asian[:pr_dest_race]))

  data_prob_venue_white = compute_prob_venue_cond_race("white",data_prob_venue_cond_whithisp_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)
  white_pop_total = sum(data_tract_2010_characteristics_est[:population].*data_tract_2010_characteristics_est[:white_percent])
  data_prob_venue_white[:pr_dest_race]=data_prob_venue_white[:pr_dest_race].*white_pop_total
  data_prob_venue_white[:pr_dest_race]=convert(Array{Int},round.(data_prob_venue_white[:pr_dest_race]))

  data_prob_venue_hispanic = compute_prob_venue_cond_race("hispanic",data_prob_venue_cond_whithisp_home,data_prob_home_cond_race,data_prob_race,spec;geographic_level=geographic_level)
  hispanic_pop_total = sum(data_tract_2010_characteristics_est[:population].*data_tract_2010_characteristics_est[:hispanic_percent])
  data_prob_venue_hispanic[:pr_dest_race]=data_prob_venue_hispanic[:pr_dest_race].*hispanic_pop_total
  data_prob_venue_hispanic[:pr_dest_race]=convert(Array{Int},round.(data_prob_venue_hispanic[:pr_dest_race]))

  data_prob_venue = [data_prob_venue_black;data_prob_venue_asian;data_prob_venue_white;data_prob_venue_hispanic]
  delete!(data_prob_venue,:share)
  rename!(data_prob_venue,:pr_dest_race,:visits)
  data_prob_venue[:specification]=name

  return data_prob_venue
end
