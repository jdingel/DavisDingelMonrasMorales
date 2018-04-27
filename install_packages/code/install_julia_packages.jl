## Author:  Kevin Dano
## Julia version: 0.6.2
## Purpose: install packages used throughout the project

for package in ["DataFrames","CSV","JLD","FileIO","StatFiles","StatsFuns","Optim","Calculus","LaTeXStrings","Distributions"]

  if Pkg.installed(package)==nothing
    Pkg.add(package)
  end

end

#Pin packages to version used in the paper
if Pkg.installed("DataFrames")!=v"0.11.5"
  Pkg.pin("DataFrames",v"0.11.5")
end

if Pkg.installed("CSV")!=v"0.2.4"
  Pkg.pin("CSV",v"0.2.4")
end

if Pkg.installed("JLD")!=v"0.8.3"
  Pkg.pin("JLD",v"0.8.3")
end

if  Pkg.installed("FileIO")!=v"0.7.0"
  Pkg.pin("FileIO",v"0.7.0")
end

if Pkg.installed("StatFiles")!=v"0.3.0"
  Pkg.pin("StatFiles",v"0.3.0")
end

if Pkg.installed("StatsFuns")!=v"0.5.0"
  Pkg.pin("StatsFuns",v"0.5.0")
end

if Pkg.installed("Optim")!=v"0.14.1"
  Pkg.pin("Optim",v"0.14.1")
end

if Pkg.installed("Calculus")!=v"0.2.2"
  Pkg.pin("Calculus",v"0.2.2")
end

if Pkg.installed("LaTeXStrings")!=v"0.3.0"
  Pkg.pin("LaTeXStrings",v"0.3.0")
end

if Pkg.installed("Distributions")!=v"0.15.0"
  Pkg.pin("Distributions",v"0.15.0")
end


#Compile packages
using DataFrames
using CSV
using JLD
using FileIO
using StatFiles
using StatsFuns
using Optim
using Calculus
using LaTeXStrings
using Distributions
