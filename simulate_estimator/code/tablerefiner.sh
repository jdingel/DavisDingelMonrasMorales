#!/bin/bash

cat ../output/estimator_simulated.tex > ../output/temp.tex
sed -i.bak 's/tabular}{\([lcr]*\)} \\hline/tabular}{\1} \\toprule/' ../output/temp.tex
sed -i.bak 's/\(VARIABLES [[:alpha:]&[:blank:]]* \\\\\).*\hline/\1 \\midrule/'  ../output/temp.tex
sed -i.bak 's/VARIABLES/Dummy for:/' ../output/temp.tex
sed -i.bak 's/drawn from//' ../output/temp.tex
sed -i.bak 's/Math \&/ \&/' ../output/temp.tex
sed -i.bak 's/Obs \&/ Observations \&/' ../output/temp.tex
sed -i.bak 's/\hline/\bottomrule/' ../output/temp.tex
sed -i.bak 's/\\_\\{it\\}/_{it}/g' ../output/temp.tex
sed -i.bak 's/\\_\\{iT\\_\\{i\\}\\}/_{iT_{i}}/' ../output/temp.tex
sed -i.bak 's/\(([0-1]\.[0-9]*)\)/\\footnotesize{\1}/g' ../output/temp.tex
grep -v 'Standard errors in parentheses' ../output/temp.tex | grep -v 'Outcome &' > ../output/estimator_simulations.tex
rm ../output/temp.tex ../output/temp.tex.bak

