## Author: Kevin Dano
## Date: April 2017
## Purpose: MLE with Taddy-Baker specification
## Julia version: 0.6.2
## Packages required: StatsFuns, Optim, Calculus, DataFrames
## Notes: -This version of the solver computes the score of the Taddy likelihood
#         -It is faster and requires less memory than solver_norg_TaddyBaker.jl


################################################################################
# Optimization
################################################################################

#Computes exp(V_ijl)
function compute_exp_Vijl(data,theta)
	temp = exp.(data*theta)
  return temp
end

#Computes sum_l exp(V_ijl)
function compute_exp_Vij(J,norg,exp_Vijl)
  exp_Vijl_sum  = reshape(sum(reshape(exp_Vijl,norg,J),1),J)
  return exp_Vijl_sum
end

function exp_Vij_user_trip(theta,data_it,inset_it,norg)

  (Jnorg,K)=size(data_it)
  J = div(Jnorg,norg)

  exp_V_l = compute_exp_Vijl(data_it,theta)
  exp_V = compute_exp_Vij(J,norg,exp_V_l) #sum_l exp(V_ijl)
  exp_V = exp_V.*inset_it
  return exp_V
end

function LL_Taddy(theta,list_data,list_choices,list_inset,list_totalchoices,norg)

  temp = map((data_it,inset_it)->exp_Vij_user_trip(theta,data_it,inset_it,norg),list_data,list_inset)
  temp_denom = sum(temp)
  ratio = map(x->x./temp_denom,temp)

  list_LL = map((r,d,m)->d.*log.(r)-m.*r ,ratio,list_choices,list_totalchoices)
  LL = sum(sum(list_LL))

  return LL
end

################################################################################
# Solver: BFGS
################################################################################

function fit_Taddy(theta_init,list_data,list_choices,list_inset,list_totalchoices,norg)

  function obj_fun(theta)
    return -LL_Taddy(theta,list_data,list_choices,list_inset,list_totalchoices,norg)
  end

  rez = optimize(obj_fun,theta_init,BFGS(),Optim.Options(iterations=10000,allow_f_increases=true,show_trace=true))
  return rez
end

################################################################################
# Standard deviation of the estimates
################################################################################

#Extract score value
function score_Taddy(theta,list_data,list_choices,list_inset,list_totalchoices,norg)

  function obj_fun(theta)
    return -LL_Taddy(theta,list_data,list_choices,list_inset,list_totalchoices,norg)
  end

  grad = Calculus.gradient(obj_fun,theta)
  return -1.*grad
end

function var_Taddy(theta,list_data,list_choices,list_inset,list_totalchoices,norg)

  function obj_fun(theta)
    return -LL_Taddy(theta,list_data,list_choices,list_inset,list_totalchoices,norg)
  end

  H = -1.*hessian(obj_fun,theta)
  Fisher = -1*H
	if det(Fisher) == 0
		println("Hessian is degenerate")
		return error()
	else
  	Var = inv(Fisher)
  	return diag(Var)
	end
end
