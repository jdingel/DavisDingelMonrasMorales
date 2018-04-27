## Author: Kevin Dano
## Date: April 2018
## Purpose: Fit a multinomial logit using the Newton Raphson optimization routine
## Packages required: StatsFuns, Optim, Calculus
## Julia version: 0.6.2

################################################################################
# Functions
################################################################################

#Computes P_ijl
function choice_probability_mnl_newton(data,theta)
	P = softmax(data*theta)
  return P
end

#Computes P_ij = sum_l P_ijl
function sum_pairs_choice_probability_mnl_newton(J,norg,P_ijl)
  P_sum  = reshape(sum(reshape(P_ijl,norg,J),1),J)
  return P_sum
end

#Loglikelihood at individual-time level
function LL_it_mnl_newton(norg,theta,data,choices)

	(Jnorg,K)=size(data)
	J = div(Jnorg,norg)
	P_ijl = choice_probability_mnl_newton(data,theta)
	P = sum_pairs_choice_probability_mnl_newton(J,norg,P_ijl)
	LL_it = sum(choices.*log.(P))

	return LL_it
end

#Loglikelihood: LL = sum_i sum_t LL_it
function LL_mnl_newton(norg,theta,list_data,list_choices)
		list_LL_it = map((choices,data)-> LL_it_mnl_newton(norg,theta,data,choices),list_choices,list_data)
	return sum(list_LL_it)
end

#Score function at individual-time level
function Score_it_mnl_newton(norg,theta,data,choices)

	(Jnorg,K)=size(data)
	J = div(Jnorg,norg)
	P_ijl = choice_probability_mnl_newton(data,theta)
	P = sum_pairs_choice_probability_mnl_newton(J,norg,P_ijl)

	S_it = squeeze(sum(reshape(data.*P_ijl,norg,J,K),1),1)'*(choices./P-1)

	return S_it
end

#Score function : S = sum_i sum_t S_it
function Score_mnl_newton(norg,theta,list_data,list_choices)
		list_S_it = map((choices,data)->Score_it_mnl_newton(norg,theta,data,choices),list_choices,list_data)
	return sum(list_S_it)
end

#Computes X_ijl .* P_ijl
function product_data_choice_probability_mnl_newton(data,P_ijl)
  temp = data.*P_ijl
  return temp
end

#computes sum_l X_ijl P_ijl
function sum_pairs_product_data_choice_probability_mnl_newton(J,K,norg,prod_X_ijl_choice_proba)
  temp = squeeze(sum(reshape(prod_X_ijl_choice_proba,norg,J,K),1),1)
  return temp
end

#Hessian function at individual-time level
function Hessian_it_mnl_newton(norg,theta,data,choices)

  (Jnorg,K)=size(data)
	J = div(Jnorg,norg)

  P_ijl =  choice_probability_mnl_newton(data,theta)
  P_ij = sum_pairs_choice_probability_mnl_newton(J,norg,P_ijl)
  data_choice_proba = product_data_choice_probability_mnl_newton(data,P_ijl)
  sum_pairs_data_choice_proba = sum_pairs_product_data_choice_probability_mnl_newton(J,K,norg,data_choice_proba)
  sum_data_choice_proba = sum(data_choice_proba,1)

  #Computation of first term
	H_it = -((choices./P_ij.^2).*sum_pairs_data_choice_proba)'*sum_pairs_data_choice_proba

	#Computation of the second term
	for k in 1:norg:J*norg
    j = div((k-1),norg)+1
		H_it +=  (choices[j]/P_ij[j]-1)*(data[k:k+norg-1,:].*P_ijl[k:k+norg-1])'*data[k:k+norg-1,:]
  end

  #Calculation of third term
	H_it += sum_data_choice_proba'*sum_data_choice_proba

  return H_it
end

#Hessian function : H = sum_i sum_t H_it
function Hessian_mnl_newton(norg,theta,list_data,list_choices)
		list_Hessian_it = map((choices,data)->Hessian_it_mnl_newton(norg,theta,data,choices),list_choices,list_data)
	return sum(list_Hessian_it)
end

################################################################################
# Solver: Newton Raphson
################################################################################

#Note:
#-The default optimizer is Newton-Raphson
#-The user can ask for gradient free method (BFGS) by changing the optional parameter gradient gradient
function fit_mnl_newton(theta_init,list_data,list_choices,norg;gradient::Int64=2)

		I = length(list_data)

		#objective function
		function obj_fun(theta)
			return -LL_mnl_newton(norg,theta,list_data,list_choices)
		end

		#gradient
		function d_objfun(storage::Array{Float64,1},theta::Array{Float64,1})
			storage[:] = -Score_mnl_newton(norg,theta,list_data,list_choices)
		end

		#hessian
		function d2_objfun(storage::Array{Float64,2},theta::Array{Float64,1})
			storage[:,:] = -Hessian_mnl_newton(norg,theta,list_data,list_choices)
		end

		if gradient == 1
			df = OnceDifferentiable(obj_fun,d_objfun,theta_init)
			results = optimize(df,theta_init,BFGS(),Optim.Options(iterations=10000,allow_f_increases=true))
		elseif gradient == 2
			df = TwiceDifferentiable(obj_fun,d_objfun,d2_objfun,theta_init)
			results = optimize(df,theta_init,Newton(),Optim.Options(iterations=10000,allow_f_increases=true))
		elseif gradient == 0
			results = optimize(obj_fun,theta_init,BFGS(),Optim.Options(iterations=10000,allow_f_increases=true))
		end

		return results
end

################################################################################
# Standard deviation of the estimates
################################################################################

function std_mnl_newton(theta_est,list_data,list_choices,norg)

	I = length(list_data)
	H = Hessian_mnl_newton(norg,theta_est,list_data,list_choices)
	Fisher = -1*H

	if det(Fisher) == 0
		println("Hessian is degenerate")
		return error()
	else
		Var = inv(Fisher)
		std = sqrt.(diag(Var))
	return std
	end
end

function var_mnl_newton(theta_est,list_data,list_choices,norg)

	I = length(list_data)
	H = Hessian_mnl_newton(norg,theta_est,list_data,list_choices)
	Fisher = -1*H

	if det(Fisher) == 0
		println("Hessian is degenerate")
		return error()
	else
		Var = inv(Fisher)
	return diag(Var)
	end
end
