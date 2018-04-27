
sed -i.bak 's/multicolumn{1}{c}{N}/multicolumn{1}{c}{Number of restaurants}/' ../output/gentrify_covars_Harlem_preprocess.tex && rm  ../output/gentrify_covars_Harlem_preprocess.tex.bak
sed -i.bak 's/hline\\end{tabular}/bottomrule\\end{tabular}/' ../output/gentrify_covars_Harlem_preprocess.tex && rm ../output/gentrify_covars_Harlem_preprocess.tex.bak

echo '\begin{tabular}{lcc}\toprule' > ../output/gentrify_covars_Harlem.tex
echo 'Change in & Mean & Std. Dev. \\ \midrule' >> ../output/gentrify_covars_Harlem.tex
grep -v '{table}\|begin{tabular}\|textbf' ../output/gentrify_covars_Harlem_preprocess.tex  >> ../output/gentrify_covars_Harlem.tex

sed -i.bak 's/multicolumn{1}{c}{N}/multicolumn{1}{c}{Number of restaurants}/' ../output/gentrify_covars_Bedstuy_preprocess.tex && rm ../output/gentrify_covars_Bedstuy_preprocess.tex.bak
sed -i.bak 's/hline\\end{tabular}/bottomrule\\end{tabular}/' ../output/gentrify_covars_Bedstuy_preprocess.tex && rm ../output/gentrify_covars_Bedstuy_preprocess.tex.bak

echo '\begin{tabular}{lcc}\toprule' > ../output/gentrify_covars_Bedstuy.tex
echo 'Change in & Mean & Std. Dev. \\ \midrule' >> ../output/gentrify_covars_Bedstuy.tex
grep -v '{table}\|begin{tabular}\|textbf' ../output/gentrify_covars_Bedstuy_preprocess.tex  >> ../output/gentrify_covars_Bedstuy.tex



