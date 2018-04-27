## Author: Kevin Dano
## Date: April 2018
## Purpose: nested logit with multiple non overlapping sets, the dissimilarity parameter lambda is the same accross all nests
## Julia version: 0.6.2
## Packages required: StatsFuns, Optim, Calculus

##Notes:
#1) The code assumes that the first column of data_it (e.g S_it) and choice_it indicates the nest number
#2) The input of the individual-time loglikelihood is data_it, choice_it and a dataset that contains "user_id-nest" information (the first column should also indicate the nest number)

################################################################################
# Functions
################################################################################

#Computes the choice probability for a nested logit
function choice_probability_nlogit_uniquelambda_multiperiod(norg,beta,lambda,data,data_nest)

  Jnorg = size(data,1)
  J = div(Jnorg,norg)
  list_nests = convert(Array{Int64},unique(data[:,1]))
  data_temp = hcat(copy(data),zeros(Jnorg)) # add a column for the inclusive values
  cumsum_uij = 0.0

  for k in list_nests
    data_temp[data_temp[:,1].== k,end] = Inclusive_value_uniquelambda_multiperiod(norg,beta,lambda,data_nest,k) #compute the inclusive value
  end

  P_nlogit = zeros(J) #choice probability

  for j in 1:norg:Jnorg
    data_sub_loop = data_temp[j:j+norg-1,:]
    num_nest = convert(Int,data_sub_loop[1,1])
    uij =  sum(exp.(data_sub_loop[:,2:end]*[beta/lambda;1]))
    cumsum_uij += uij
    P_nlogit[div((j-1),norg)+1] = uij
  end

  P_nlogit =P_nlogit./cumsum_uij

  return P_nlogit
end

#Computes the inclusive value for nest k
function Inclusive_value_uniquelambda_multiperiod(norg,beta,lambda,data_nest,num_nest)

  data_nest_sub =  data_nest[data_nest[:,1].== num_nest,2:end] #select covariates

  #Calculate inclusive values for nest k
  inclusive_value = (lambda-1)*logsumexp(data_nest_sub*(beta./lambda))

  return inclusive_value
end

#Computes the derivative of the inclusive value for nest k / See KD's derivations in section 4 of nestedlogit_notes.pdf
function d_Inclusive_value_uniquelambda_multiperiod(norg,beta,lambda,data_nest,num_nest)

  data_nest_sub = data_nest[data_nest[:,1].==num_nest,2:end]

  temp1 = exp.(data_nest_sub*(beta./lambda))
  temp2 = sum(temp1)
  d_I_beta = (1-1/lambda)*vec(sum((data_nest_sub).*temp1,1))./temp2
  d_I_lambda = log.(temp2)+sum(-(data_nest_sub*(beta)).*temp1)*((lambda-1)/lambda^2)./temp2

  return d_I_beta,d_I_lambda
end

#Computes the derivative of the variable u_ij / See KD's derivations in section 4 of nestedlogit_notes.pdf
function compute_d_uij_uniquelambda_multiperiod(norg,data_sub,data_nest,beta,lambda,d_I_beta,d_I_lambda)

  temp0 = exp.(data_sub[2:end]'*[beta/lambda;1])

  d_uij_beta = (data_sub[2:(end-1)]./lambda + d_I_beta).*temp0
  d_uij_lambda = (-beta'*data_sub[2:end-1]./lambda^2 + d_I_lambda).*temp0

  return Float64[d_uij_beta;d_uij_lambda]
end

#Computes variable u_ij / See KD's derivations in section 4 of nestedlogit_notes.pdf
function compute_uij_uniquelambda_multiperiod(norg,data_sub,beta,lambda)

  Jsub = div(size(data_sub,1),norg)
  theta = Float64[beta./lambda;1.0]
  exp_V_ijl = exp.(data_sub*theta)
  sum_l_exp_V_ijl = reshape(sum(reshape(exp_V_ijl,norg,Jsub),1),Jsub) #sum_l exp(V_ijl_Bk)

  return sum_l_exp_V_ijl
end

#Objective function
function nlogitobj_norg_uniquelambda_multiperiod(norg,I,theta,nLLG,num_covariates,list_data,list_data_nest,list_choices)

  beta = theta[1:num_covariates]
  lambda = theta[end]

  K_beta = length(beta)
  K_lambda = 1
  nLL = 0.0

  if (size(nLLG) == ()) | (length(nLLG) == 0)
      dd = 0
  else
      dd = 1
      nLLG[:] = zeros(length(theta))
  end

  if dd == 0
    for i in 1:I
      if size(list_data[i],2) == 1
        for t in 1:length(list_data[i])
          nLL += nlogitobj_norg_it_uniquelambda_multiperiod(norg,K_beta,K_lambda,beta,lambda,list_data[i][t],list_data_nest[i],list_choices[i][t],0)
        end
      else
        nLL += nlogitobj_norg_it_uniquelambda_multiperiod(norg,K_beta,K_lambda,beta,lambda,list_data[i],list_data_nest[i],list_choices[i],0)
      end
    end
  elseif dd == 1
    temp_vec = zeros(K_beta+K_lambda+1)
    n = 0

    for i in 1:I
      if size(list_data[i],2) == 1
        for t in 1:length(list_data[i])
          temp_vec +=  nlogitobj_norg_it_uniquelambda_multiperiod(norg,K_beta,K_lambda,beta,lambda,list_data[i][t],list_data_nest[i],list_choices[i][t],1)
          n+=1
        end
      else
        temp_vec +=  nlogitobj_norg_it_uniquelambda_multiperiod(norg,K_beta,K_lambda,beta,lambda,list_data[i],list_data_nest[i],list_choices[i],1)
        n+=1
      end
    end
    nLL += temp_vec[1]
    nLLG[:] -= temp_vec[2:end]
  end

  return -1*nLL
end

#Objective function individual-time level
function nlogitobj_norg_it_uniquelambda_multiperiod(norg,K_beta,K_lambda,beta,lambda,data,data_nest,choices,dd)

  #Compute the inclusive value for everyone
  Jnorg = size(data,1)
  J = div(Jnorg,norg)
  list_nests = convert(Array{Int64},unique(data[:,1]))
  data_temp = hcat(copy(data),zeros(Jnorg)) # add a column for the inclusive values
  LL_temp = 0.0; cumsum_uij = 0.0

  if dd == 0
    for k in list_nests
      data_temp[data_temp[:,1].== k,end] = Inclusive_value_uniquelambda_multiperiod(norg,beta,lambda,data_nest,k) #compute the inclusive value
      choices_sub = choices[choices[:,1].== k,2]
      uij= compute_uij_uniquelambda_multiperiod(norg,data_temp[data_temp[:,1].== k,2:end],beta,lambda) # range is 2:end because nest number is not a covariate
      cumsum_uij += sum(uij)
      LL_temp += sum(choices_sub.*log.(uij)) #loglikelihood
    end

    LL_temp -= log.(cumsum_uij) #This assumes that only one choice was made in the set S_{it}
    return LL_temp

  elseif dd == 1
    #Preallocate arrays output
    D_I_beta = zeros(0); D_I_lambda = zeros(0)

    for k in list_nests
      D_I_beta = vcat(D_I_beta,k*ones(K_beta))
      D_I_lambda = vcat(D_I_lambda,k*ones(1))
    end

    D_I_beta = hcat(D_I_beta,zeros(size(D_I_beta,1))); D_I_lambda = hcat(D_I_lambda,zeros(size(D_I_lambda,1)))

    for k in list_nests
       data_temp[data_temp[:,1].== k,end] = Inclusive_value_uniquelambda_multiperiod(norg,beta,lambda,data_nest,k)
       D_I_beta[D_I_beta[:,1].==k,end], D_I_lambda[D_I_lambda[:,1].==k,end] = d_Inclusive_value_uniquelambda_multiperiod(norg,beta,lambda,data_nest,k)
    end

    cumsum_d_uij_beta = zeros(K_beta)
    cumsum_d_uij_lambda = 0.0

    Score_beta = zeros(K_beta)
    Score_lambda = 0.0

    for j in 1:norg:Jnorg
      data_sub_loop = data_temp[j:j+norg-1,:]
      num_nest = convert(Int,data_sub_loop[1,1])
      uij =  sum(exp.(data_sub_loop[:,2:end]*[beta/lambda;1]))
      cumsum_uij += uij
      LL_temp += choices[div((j-1),norg)+1,2].*log.(uij)

      d_I_beta = D_I_beta[D_I_beta[:,1].==num_nest,2]
      d_I_lambda = D_I_lambda[D_I_lambda[:,1].==num_nest,2]
      d_uij= compute_d_uij_uniquelambda_multiperiod(norg,data_sub_loop[1,:],data_nest,beta,lambda,d_I_beta,d_I_lambda)

      if norg>1
        for index in 2:norg
          d_uij += compute_d_uij_uniquelambda_multiperiod(norg,data_sub_loop[index,:],data_nest,beta,lambda,d_I_beta,d_I_lambda)
        end
      end

      d_uij_beta = d_uij[1:K_beta]
      d_uij_lambda = d_uij[end]

      cumsum_d_uij_beta += d_uij_beta
      cumsum_d_uij_lambda += sum(d_uij_lambda)
      Score_beta += (choices[div((j-1),norg)+1,2]./uij).*d_uij_beta
      Score_lambda += sum((choices[div((j-1),norg)+1,2]./uij).*d_uij_lambda)
    end

    LL_temp -= log.(cumsum_uij)
    Score_beta -= cumsum_d_uij_beta./cumsum_uij
    Score_lambda -= cumsum_d_uij_lambda./cumsum_uij
    return Float64[LL_temp;Score_beta;Score_lambda]
  end
end

#Extract score value
function score_nlogitobj_norg_uniquelambda_multiperiod(norg,x,num_covariates,list_data,list_data_nest,list_choices)

  I = length(list_data)
  K = length(x)
  gr = zeros(K)
  nlogitobj_norg_uniquelambda_multiperiod(norg,I,x,gr,num_covariates,list_data,list_data_nest,list_choices)
  return -1.*copy(gr)
end

################################################################################
# Solver: BFGS ( Broyden–Fletcher–Goldfarb–Shanno (BFGS))
################################################################################

#Produces nested logit ML
function fitnlogit_norg_uniquelambda_multiperiod(norg,theta_init,list_data,list_data_nest,list_choices)

    I = length(list_data)
    theta_init_nlogit = Float64[theta_init;0.5]
    num_covariates = length(theta_init)

    g!(gr,x) = nlogitobj_norg_uniquelambda_multiperiod(norg,I,x,gr,num_covariates,list_data,list_data_nest,list_choices)
    f(x) = nlogitobj_norg_uniquelambda_multiperiod(norg,I,x,Array(Float64),num_covariates,list_data,list_data_nest,list_choices)

    df = OnceDifferentiable(f, g!, g!,theta_init_nlogit)
    result = optimize(df,theta_init_nlogit,BFGS(),Optim.Options(iterations=10000,allow_f_increases=true))

    return result
end

################################################################################
# Standard deviation of the estimates
################################################################################

#Fast numerical hessian
function var_fitnlogit_norg_uniquelambda_multiperiod(norg,num_covariates,theta_estimate,list_data,list_data_nest,list_choices)

  I = length(list_data)

  g!(x, gr) =  nlogitobj_norg_uniquelambda_multiperiod(norg,I,x,gr,num_covariates,list_data,list_data_nest,list_choices)
  f(x) = nlogitobj_norg_uniquelambda_multiperiod(norg,I,x,Array(Float64),num_covariates,list_data,list_data_nest,list_choices)

  function last_score(x)
    grad = zeros(length(x))
    g!(x, grad)
    return copy(grad)
  end

   H = -hessian(f,last_score,theta_estimate)
   Det_H = det(H)

   if Det_H != 0
     Fisher = -1*H
     Var = inv(Fisher)
     return diag(Var)
   else
     println("Non invertible Hessian")
     error()
   end
end
