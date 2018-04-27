sed -n 4,6p ../input/isolationindex_estsample.tex | awk -F '&' '{print $1 "&" $3 "&"} ' > temp1.tex
sed -n 4,6p ../output/isoindices_bsavg.tex | awk -F '&' '{print "[" $5 "," $6 "]"}'| sed 's/\\\\]/] \\\\/' | sed 's/\[ ./\[./' | sed 's/\ \]/\]/'  > temp7.tex

echo '\begin{tabular}{lcc} \toprule &  & Bootstrap average \\ & Estimation sample & confidence interval\\ \midrule' > ../output/isoindices_bsavg_ci.tex
paste temp1.tex temp7.tex >> ../output/isoindices_bsavg_ci.tex
echo '\bottomrule \end{tabular}' >> ../output/isoindices_bsavg_ci.tex
echo '\begin{minipage}[t]{0.75\textwidth}' >> ../output/isoindices_bsavg_ci.tex
echo '{\footnotesize \textsc{Notes}: ' >> ../output/isoindices_bsavg_ci.tex
echo 'The reported leave-out isolation indices are the value for the estimation sample and the 90\% confidence interval for predicted outcomes for generated samples of the same size using the average of the bootstrapped distribution of parameters.' >> ../output/isoindices_bsavg_ci.tex
echo 'Isolation indices as defined in \citet{GentzkowShapiro:2011}.\par}' >> ../output/isoindices_bsavg_ci.tex
echo '\end{minipage}' >> ../output/isoindices_bsavg_ci.tex

rm temp1.tex temp7.tex

