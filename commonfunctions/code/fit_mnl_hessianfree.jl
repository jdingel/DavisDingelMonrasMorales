## Author: Kevin Dano
## Date: April 2018
## Purpose: Fit a multinomial logit using Hessian free optimization routine
## Packages required: StatsFuns, Optim, Calculus
## Julia version: 0.6.2

################################################################################
# Functions
################################################################################

#Computes P_ijl
function choice_probability_mnl_hessianfree(data,theta)
	P = softmax(data*theta)
  return P
end

#Computes P_ij = sum_l P_ijl
function sum_pairs_choice_probability_mnl_hessianfree(J,norg,P_ijl)
  P_sum  = reshape(sum(reshape(P_ijl,norg,J),1),J)
  return P_sum
end

#Objective function
function mnl_obj_hessianfree(norg,I,K,theta,nLLG,list_data,list_choices)

  nLL = 0.0

  if (size(nLLG) == ()) | (length(nLLG) == 0)
      dd = 0
  else
      dd = 1
      nLLG[:] = zeros(K)
  end

  if dd == 0
    for i in 1:I
      nLL +=  mnl_obj_it_hessianfree(norg,theta,list_data[i],list_choices[i],dd)
    end
  elseif dd == 1

    temp_vec = zeros(K+1)

    for i in 1:I
      temp_vec +=  mnl_obj_it_hessianfree(norg,theta,list_data[i],list_choices[i],dd)
    end

    nLL += temp_vec[1]
    nLLG[:] -= temp_vec[2:end]
  end

  return -1*nLL
end

function mnl_obj_it_hessianfree(norg,theta,data,choices,dd)

  (Jnorg,K)=size(data)
  J = div(Jnorg,norg)
  P_ijl = choice_probability_mnl_hessianfree(data,theta)
  P = sum_pairs_choice_probability_mnl_hessianfree(J,norg,P_ijl)
  nLL_it = sum(choices.*log.(P))

  if dd == 0
    return nLL_it
  elseif dd == 1
    S_it = squeeze(sum(reshape(data.*P_ijl,norg,J,K),1),1)'*(choices./P-1)
    return Float64[nLL_it;S_it]
  end
end

#Extract score value
function score_mnl_hessianfree(norg,x,list_data,list_choices)

  I = length(list_data)
  K = length(x)
  gr = zeros(K)
  mnl_obj_hessianfree(norg,I,K,x,gr,list_data,list_choices)
  return -1.*copy(gr)
end

################################################################################
# Hessian Free solver
################################################################################

#Choose between BFGS or LBFGS
function fit_mnl_hessianfree(norg,theta_init,list_data,list_choices;optimization_routine::String="BFGS")

    I = length(list_data)
    K = size(list_data[1],2)

    #objective functions
    g!(gr,x) = mnl_obj_hessianfree(norg,I,K,x,gr,list_data,list_choices)
    f(x) = mnl_obj_hessianfree(norg,I,K,x,Array(Float64),list_data,list_choices)

    df = OnceDifferentiable(f, g!, g!,theta_init)

		if optimization_routine == "BFGS"
    	result = Optim.optimize(df,theta_init,BFGS(),Optim.Options(iterations=10000,allow_f_increases=true))
		elseif optimization_routine == "LBFGS"
			result = Optim.optimize(df,theta_init,LBFGS(),Optim.Options(iterations=10000,allow_f_increases=true))
		end

    return result
end

################################################################################
# Standard deviation of the estimates
################################################################################

function Hessian_mnl_hessianfree(norg,K,theta,list_data,list_choices)

  I = length(list_data)

  H = zeros(K,K)

  for i in 1:I
        H +=  Hessian_mnl_hessianfree_it(norg,theta,list_data[i],list_choices[i])
  end

  return H
end

#Computes X_ijl .* P_ijl
function product_data_choice_probability_mnl_hessianfree(data,P_ijl)
  temp = data.*P_ijl
  return temp
end

#computes sum_l X_ijl P_ijl
function sum_pairs_product_data_choice_probability_mnl_hessianfree(J,K,norg,prod_X_ijl_choice_proba)
  temp = squeeze(sum(reshape(prod_X_ijl_choice_proba,norg,J,K),1),1)
  return temp
end

#Hessian function at individual-time level
function  Hessian_mnl_hessianfree_it(norg,theta,data,choices)

  (Jnorg,K)=size(data)
	J = div(Jnorg,norg)

  P_ijl =  choice_probability_mnl_hessianfree(data,theta)
  P_ij = sum_pairs_choice_probability_mnl_hessianfree(J,norg,P_ijl)
  data_choice_proba = product_data_choice_probability_mnl_hessianfree(data,P_ijl)
  sum_pairs_data_choice_proba = sum_pairs_product_data_choice_probability_mnl_hessianfree(J,K,norg,data_choice_proba)
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

function var_mnl_hessianfree(norg,K,theta,list_data,list_choices)

  H = Hessian_mnl_hessianfree(norg,K,theta,list_data,list_choices)
  Fisher = -1*H
	if det(Fisher) == 0
		println("Hessian is degenerate")
		return error()
	else
  	Var = inv(Fisher)
  	return diag(Var)
	end
end

function std_mnl_hessianfree(norg,K,theta,list_data,list_choices)

  H = Hessian_mnl_hessianfree(norg,K,theta,list_data,list_choices)
  Fisher = -1*H

	if det(Fisher) == 0
		println("Hessian is degenerate")
		return error()
	else
	  Var = inv(Fisher)
	  std= sqrt.(diag(Var))
  	return std
	end
end
