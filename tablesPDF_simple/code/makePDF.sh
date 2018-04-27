#!/bin/bash

##Build TeX document
module load texlive
cp ../code/texheader.tex ../output/tabsfigs.tex

echo "\input{tabsfigs/table1.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table2.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table3.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/table4.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/table5.tex}" >> ../output/tabsfigs.tex
echo "\addtocounter{table}{2}"     >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table6.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table7.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table8.tex}" >> ../output/tabsfigs.tex

echo "\addtocounter{figure}{4}"     >> ../output/tabsfigs.tex
echo "\input{tabsfigs/figure5.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/figure6.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/figure7.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/figure8.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/figure9.tex}" >> ../output/tabsfigs.tex

echo '\FloatBarrier' >> ../output/tabsfigs.tex
echo '\appendix' >> ../output/tabsfigs.tex
echo '\setcounter{table}{0}' >> ../output/tabsfigs.tex
echo '\renewcommand{\thetable}{\Alph{section}.\arabic{table}}' >> ../output/tabsfigs.tex
echo '\setcounter{figure}{0}' >> ../output/tabsfigs.tex
echo '\renewcommand{\thefigure}{\Alph{section}.\arabic{figure}}' >> ../output/tabsfigs.tex
echo '\section{Appendix Figures and Tables}' >> ../output/tabsfigs.tex
echo '\FloatBarrier' >> ../output/tabsfigs.tex

echo "\input{tabsfigs/figure_A1.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/figure_A2.tex}" >> ../output/tabsfigs.tex

echo "\input{tabsfigs/table_A01.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A02.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A03.tex}" >> ../output/tabsfigs.tex

echo "\clearpage" >> ../output/tabsfigs.tex


echo "\input{tabsfigs/table_A04_a.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A04_b.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A05_a.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A05_b.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A06_a.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A06_b.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A07_a.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A07_b.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A08_a.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A08_b.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A09_a.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A09_b.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A10.tex}" >> ../output/tabsfigs.tex


echo "\input{tabsfigs/table_A11.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A12.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A13.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A14.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/table_A15.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/table_A16.tex}" >> ../output/tabsfigs.tex
echo "\addtocounter{table}{2}"     >> ../output/tabsfigs.tex

echo "\clearpage" >> ../output/tabsfigs.tex

echo "\input{tabsfigs/table_A17.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_A18.tex}" >> ../output/tabsfigs.tex

echo "\addtocounter{section}{1}"     >> ../output/tabsfigs.tex
echo '\section{Econometrics}' >> ../output/tabsfigs.tex
echo '\setcounter{table}{0}' >> ../output/tabsfigs.tex
echo '\setcounter{figure}{0}' >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_C1.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_C2.tex}" >> ../output/tabsfigs.tex

#echo '\section{Model fit}' >> ../output/tabsfigs.tex
#echo '\setcounter{table}{0}' >> ../output/tabsfigs.tex
#echo '\setcounter{figure}{0}' >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/table_D1.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/table_D3.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/figure_D1.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/figure_D2.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/figure_D3.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/figure_D4.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/table_D4.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/figure_D5.tex}" >> ../output/tabsfigs.tex
#echo "\input{tabsfigs/figure_D6.tex}" >> ../output/tabsfigs.tex


echo "\addtocounter{section}{1}"     >> ../output/tabsfigs.tex
echo '\section{Consumption segregation and counterfactuals}' >> ../output/tabsfigs.tex
echo '\setcounter{table}{0}' >> ../output/tabsfigs.tex
echo '\setcounter{figure}{1}' >> ../output/tabsfigs.tex
echo "\input{tabsfigs/figure_E2.tex}" >> ../output/tabsfigs.tex
echo "\input{tabsfigs/table_E1.tex}" >> ../output/tabsfigs.tex

echo "\end{document}" >> ../output/tabsfigs.tex

##Compile PDF
cd ../output
pdflatex ../output/tabsfigs.tex
pdflatex ../output/tabsfigs.tex ##run a second time to compile references
rm ../output/tabsfigs.log ../output/tabsfigs.aux ../output/tabsfigs.out ../output/tabsfigs.tex

module unload texlive