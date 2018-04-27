## Author: Kevin Dano
## Date: April 2018
## Package: DataFrame
## Julia version: 0.6.2

#########################
# Functions
########################

function format_number(num)

  if 0<num<1 #e.g number is of the form 0.xxx
  num_string =  string(".",split(@sprintf("%.3f",num),".")[2])
  elseif 0>num>-1
    num_string =  string("-",".",split(@sprintf("%.3f",num),".")[2])
  elseif 10>abs(num)>1
    num_string = @sprintf("%9.2f",num)
  elseif abs(num)>10
    num_string = @sprintf("%9.1f",num)
  end

  return strip(num_string)
end

function gentrification_tex_table(data,path,saveas)

  latex_table = string("\\begin{tabular}{","c"^5,"} \\toprule \n")
  latex_table = string(latex_table,"Transit time increase&Initial & \\multicolumn{3}{c}{Change in value of characteristics \$( \\gamma \\Delta \\bar{X\_{i}},\\Delta \\bar{Z\_{i}})\$} \\\\ \\cline{3-5} \n")
  latex_table = string(latex_table,"equal to welfare loss &visit share& Social frictions & Restaurant traits & Other traits  \\\\ \\hline \n")
  latex_table = string(latex_table,string(convert(Int,round(data[:delta_percent][1])),"\\%"),"&",format_number(data[:initial_visit_share][1]),"&",format_number(data[:social_change][1]),"&",format_number(data[:restaurant_traits_change][1]),"&",format_number(data[:other_traits_change][1]),"\\\\ \n")
  latex_table = string(latex_table,"\\bottomrule \n")
  latex_table = string(latex_table,"\\end{tabular} \n")
  write(string(path,saveas),latex_table)

end
