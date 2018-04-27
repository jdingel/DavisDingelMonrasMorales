sed -n 4,6p ../output/isolationindex_estsample.tex | awk -F '&' '{print $1 "&" $3 "&"} ' > temp1.tex
sed -n 4,6p ../output/isoindices_sixom_mainspec.tex | awk -F '&' '{print "[" $5 "," $6 "]"}'| sed 's/\\\\]/] \\\\/' | sed 's/\[ ./\[./' | sed 's/\ \]/\]/'  > temp2.tex
sed -n 4,6p ../output/isoindices_bsavg.tex | awk -F '&' '{print "[" $5 "," $6 "]"}'| sed 's/\\\\]/] \\\\/' | sed 's/\[ ./\[./' | sed 's/\ \]/\]/'  > temp7.tex

echo '\begin{tabular}{lcc} \toprule & Estimation sample & Model predictions \\ \midrule' > ../output/temp100.tex
paste temp1.tex temp2.tex >> ../output/temp100.tex
echo '\bottomrule \end{tabular}' >> ../output/temp100.tex
echo '\begin{minipage}[t]{0.8\textwidth}' >> ../output/temp100.tex
echo '{\footnotesize \textsc{Notes}: ' >> ../output/temp100.tex
echo 'The reported leave-out isolation indices are the value for the estimation sample and the 90\% confidence interval for model-predicted outcomes from 500 generated samples of the same size.' >> ../output/temp100.tex
echo 'Isolation indices as defined in \citet{GentzkowShapiro:2011}.\par}' >> ../output/temp100.tex
echo '\end{minipage}' >> ../output/temp100.tex

echo '\begin{tabular}{lcc} \toprule &  & Bootstrap average \\ & Estimation sample & confidence interval\\ \midrule' > ../output/isoindices_bsavg_ci.tex
paste temp1.tex temp7.tex >> ../output/isoindices_bsavg_ci.tex
echo '\bottomrule \end{tabular}' >> ../output/isoindices_bsavg_ci.tex
echo '\begin{minipage}[t]{0.75\textwidth}' >> ../output/isoindices_bsavg_ci.tex
echo '{\footnotesize \textsc{Notes}: ' >> ../output/isoindices_bsavg_ci.tex
echo 'The reported leave-out isolation indices are the value for the estimation sample and the 90\% confidence interval for predicted outcomes for generated samples of the same size using the average of the bootstrapped distribution of parameters.' >> ../output/isoindices_bsavg_ci.tex
echo 'Isolation indices as defined in \citet{GentzkowShapiro:2011}.\par}' >> ../output/isoindices_bsavg_ci.tex
echo '\end{minipage}' >> ../output/isoindices_bsavg_ci.tex

rm temp2.tex
sed -i 's/isolation index//' temp1.tex
sed -n 4,6p ../output/isoindices_sixom_pooled.tex | awk -F '&' '{print "[" $5 "," $6 "] & "}'| sed 's/\ \\\\]/]/' | sed 's/\[ /\[/' | sed 's/\ ,/,/' > temp2.tex
sed -n 4,6p ../output/isoindices_sixom_mainspec.tex | awk -F '&' '{print "[" $5 "," $6 "] & "}'| sed 's/\ \\\\]/]/' | sed 's/\[ ./\[./' | sed 's/\ ,/,/' > temp3.tex
sed -n 4,6p ../output/isoindices_sixom_nest1.tex  | awk -F '&' '{print "[" $5 "," $6 "] & "}'| sed 's/\ \\\\]/]/' | sed 's/\[ ./\[./' | sed 's/\ ,/,/' > temp4.tex
sed -n 4,6p ../output/isoindices_sixom_nest2.tex  | awk -F '&' '{print "[" $5 "," $6 "] & "}'| sed 's/\ \\\\]/]/' | sed 's/\[ ./\[./' | sed 's/\ ,/,/' > temp5.tex
sed -n 4,6p ../output/isoindices_mintime.tex      | awk -F '&' '{print "[" $5 "," $6 "]\\\\"}'| sed 's/\ \\\\]/]/' | sed 's/\[ ./\[./' | sed 's/\ ,/,/' > temp6.tex
 
 
echo '\begin{tabular}{lcccccc} \toprule' > ../output/isoindices_sixom_robustness_ci.tex
echo '&&\multicolumn{5}{c}{Model predictions} \\ \cline{3-7}' >> ../output/isoindices_sixom_robustness_ci.tex
echo 'Isolation index&Data&Pooled&Race-specific&Nested 1&Nested 2&Minimum time \\ \hline' >> ../output/isoindices_sixom_robustness_ci.tex
paste temp1.tex temp2.tex temp3.tex temp4.tex temp5.tex temp6.tex >> ../output/isoindices_sixom_robustness_ci.tex
echo '\bottomrule \end{tabular}' >> ../output/isoindices_sixom_robustness_ci.tex

rm temp*.tex
