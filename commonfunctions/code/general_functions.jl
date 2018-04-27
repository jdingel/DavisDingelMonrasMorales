## Author: Kevin Dano
## Date: April 2018
## Purpose: Practical functions used in various tasks
## Packages required: DataFrames, CSV, FileIO, StatFiles
## Julia version: 0.6.2

#########################
# DataFrame manipulation
#########################

#Repeat each row n times (faster than Julia's function repeat)
function repeat_inner(A::Array{Float64,2},n::Int)
  (J,I) = size(A)
  Jn = J*n
  B = zeros(Jn,I)
  for j in 1:Jn
    B[j,:]= A[div((j-1),n)+1,:]
  end
  return B
end

#Repeat the rows of a DataFrame n times
function expand_df(df::DataFrame,n::Int)

  names_data = names(df)

  df = convert(Array{Float64},df)
  df = repeat_inner(df,n) #repeat each row norg times

  df = convert(DataFrame,df)
  rename!(df, Dict(Symbol("x$i")=>names_data[i] for i in 1:length(names_data)))

  return df

end

#Combines the elements of a list into a dataframe
function append_list_df(list_df;method=1)

  N = length(list_df)
  df_all = list_df[1]

  if method == 1
    if N>1
      for i in 2:N
        if list_df[i]!=nothing
        append!(df_all,list_df[i])
        end
      end
    end
  elseif method == 0
    if N>1
      for i in 2:N
        if list_df[i]!=nothing
        df_all=[df_all;list_df[i]]
        end
      end
    end
  end
  return df_all
end

#convert a column of type float into a column of type Int64
function convert_float_integer(df,name_cols)

  for i in name_cols
    df[Symbol(i)] = convert(Array{Int64},df[Symbol(i)])
  end

  return df
end

#########################
# String manipulation
########################

#convert a column of type string into a column of type numeric
function convert_string_numeric(data,list_cols)

  for c in list_cols
  data[c] = [parse(Int,data[c][i]) for i in 1:length(data[c])]
  end
  return data
end

function covariates_endingwith(data,word)
  names_string = [string(i) for i in names(data)]
  index = [endswith(i,word) for i in names_string]
  rez = names_string[index]
  return rez
end

#returns a vector of strings that contain the covariates starting by the given prefix
function covariates_startingby(data,prefix)

	names_string = [string(i) for i in names(data)]
	index = [ismatch(Regex(prefix),i) for i in names_string]
	rez = names_string[index]

	return rez
end

################################
# Handling missing values
################################

function remove_missing_type(data)

    names_data=names(data)

    for i in names_data
        data[i]=disallowmissing(data[i])
    end
    return data
end

##################################
# Importing a dta file
##################################

function read_stata(data_name)

    Df=DataFrame(load(data_name))
    Df=remove_missing_type(Df)

    return Df
end
