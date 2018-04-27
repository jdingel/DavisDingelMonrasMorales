sed -n 4,6p ../output/isolationindex_estsample.tex | awk -F '&' '{print $1 "&" $3 "&"} ' > temp1.tex
sed -n 4,6p ../output/isoindices_sixom_mainspec.tex | awk -F '&' '{print "[" $5 "," $6 "]"}'| sed 's/\\\\]/] \\\\/' | sed 's/\[ ./\[./' | sed 's/\ \]/\]/'  > temp2.tex

echo '\begin{tabular}{lcc} \toprule & Estimation sample & Model predictions \\ \midrule' > ../output/isoindices_sixom_mainspec_ci.tex
paste temp1.tex temp2.tex >> ../output/isoindices_sixom_mainspec_ci.tex
echo '\bottomrule \end{tabular}' >> ../output/isoindices_sixom_mainspec_ci.tex
echo '\begin{minipage}[t]{0.8\textwidth}' >> ../output/isoindices_sixom_mainspec_ci.tex
echo '{\footnotesize \textsc{Notes}: ' >> ../output/isoindices_sixom_mainspec_ci.tex
echo 'The reported leave-out isolation indices are the value for the estimation sample and the 90\% confidence interval for model-predicted outcomes from 500 generated samples of the same size.' >> ../output/isoindices_sixom_mainspec_ci.tex
echo 'Isolation indices as defined in \citet{GentzkowShapiro:2011}.\par}' >> ../output/isoindices_sixom_mainspec_ci.tex
echo '\end{minipage}' >> ../output/isoindices_sixom_mainspec_ci.tex

rm temp*.tex