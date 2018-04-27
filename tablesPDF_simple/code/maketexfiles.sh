#!/bin/bash

##Make TeX files intended to be used as \input{} material in LyX file

##Table 1
echo '\begin{table} \caption{Estimation sample and NYC summary statistics} \label{tab:summ_users_stats}' > ../output/tabsfigs/table1.tex 
echo '\begin{center} \vspace{-4mm} ' >> ../output/tabsfigs/table1.tex 
cat  ../input/sumstats_table1.tex >> ../output/tabsfigs/table1.tex 
echo '\begin{minipage}[t]{.85\textwidth} {\footnotesize \textsc{Notes}: ' >> ../output/tabsfigs/table1.tex 
echo 'This table summarizes characteristics of the 440 Yelp reviewers in our estimation sample and all census tracts in Manhattan and New York City.' >> ../output/tabsfigs/table1.tex 
echo 'Reviewer demographics are inferred from Yelp profile photos.' >> ../output/tabsfigs/table1.tex 
echo 'Tract demographics from 2010 Census of Population and tract incomes from 2007-2011 American Community Survey.' >> ../output/tabsfigs/table1.tex 
echo 'Tracts are weighted by residential population.'  >> ../output/tabsfigs/table1.tex 
echo 'Isolation indices as defined in \cite{MasseyDenton:1988}.\par}' >> ../output/tabsfigs/table1.tex 
echo '\end{minipage}' >> ../output/tabsfigs/table1.tex 
echo '\end{center} \end{table}' >> ../output/tabsfigs/table1.tex 

##Figure 5
echo '\begin{figure}\caption{Travel times, demographic differences, and consumer choice} \label{fig:Reducedform} \begin{center}'  > ../output/tabsfigs/figure5.tex
echo '\includegraphics[width=0.32\textwidth]{../input/rdfm_timehome_density.pdf} \includegraphics[width=0.32\textwidth]{../input/rdfm_timework_density.pdf} \includegraphics[width=0.32\textwidth]{../input/rdfm_eucl_density.pdf}' >> ../output/tabsfigs/figure5.tex
echo '\begin{minipage}[t]{0.95\textwidth}' >> ../output/tabsfigs/figure5.tex
echo '{\footnotesize \textsc{Notes}: These plots are kernel densities for three distributions of reviewer-venue pairs: those venues chosen by reviewers in our estimation sample and a random sample of venues not chosen by these reviewers. The left panel plots the densities of travel time from home by public transit; the center panel shows travel time from work by public transit; the right panel shows Euclidean demographic distances. Epanechnikov kernels with bandwidths of 3, 3 and 0.1, respectively. \par}' >> ../output/tabsfigs/figure5.tex
echo '\end{minipage} \end{center} \end{figure}' >> ../output/tabsfigs/figure5.tex

##Table 2
echo '\begin{table} \caption{Spatial and social frictions estimates} \label{tab:mainestimates}' > ../output/tabsfigs/table2.tex 
echo '\begin{center} \vspace{-4mm} \resizebox{!}{.47\textheight}{' >> ../output/tabsfigs/table2.tex 
cat  ../input/tab_nosocial_and_mainspec.tex >> ../output/tabsfigs/table2.tex 
echo '}' >> ../output/tabsfigs/table2.tex 
echo '\begin{minipage}[t]{0.8\textwidth}' >> ../output/tabsfigs/table2.tex 
echo '{\footnotesize \textsc{Notes}{: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table2.tex 
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table2.tex 
echo 'Unreported controls are 28 area dummies.\par}}' >> ../output/tabsfigs/table2.tex 
echo '\end{minipage}' >> ../output/tabsfigs/table2.tex 
echo '\end{center} \end{table}' >> ../output/tabsfigs/table2.tex 

##Table 3
echo '\begin{table} \caption{Model fit: Isolation indices} \label{tab:Model-fit:Isolation-indices}'  > ../output/tabsfigs/table3.tex
echo '\begin{center}'  >> ../output/tabsfigs/table3.tex
cat  ../input/isoindices_sixom_mainspec_ci.tex  >> ../output/tabsfigs/table3.tex
echo '\end{center}'  >> ../output/tabsfigs/table3.tex
echo '\end{table}'  >> ../output/tabsfigs/table3.tex

##Figure 6
echo '\begin{figure} \caption{Racial gap between pairs of observationally equivalent restaurants} \label{fig:Racial-gap}'  > ../output/tabsfigs/figure6.tex
echo '\begin{center}\includegraphics[width=.6\textwidth]{../input/racegapvsnull.pdf}'  >> ../output/tabsfigs/figure6.tex
echo '\begin{minipage}[t]{0.9\textwidth}' >> ../output/tabsfigs/figure6.tex
echo "{\footnotesize \textsc{Notes}: These kernel densities depict the distribution of the Euclidean distance between two restaurants' shares of patrons belonging to three racial categories for 125 pairs of restaurants that are identical in terms of their cuisine category, price category, Yelp rating, and census tract. The null hypothesis, in line with our model, is that individuals are randomly assigned to one of the two restaurants within each pair.\par}" >> ../output/tabsfigs/figure6.tex
echo '\end{minipage}' >> ../output/tabsfigs/figure6.tex
echo '\end{center}\end{figure}'  >> ../output/tabsfigs/figure6.tex

cp ../input/racegapvsnull.pdf ../output/tabsfigs/racegapvsnull.pdf


##Figure D.1
echo '\begin{figure} \caption{Isolation-index elements for each race in data and under null} \label{fig:schelling_isoindexelements}'  > ../output/tabsfigs/figure_D1.tex
echo '\begin{center}\includegraphics{../input/schelling_isoindexelements.pdf}' >> ../output/tabsfigs/figure_D1.tex
echo '\begin{minipage}[t]{0.9\textwidth}' >> ../output/tabsfigs/figure_D1.tex
echo "{\footnotesize \textsc{Notes}: These kernel densities depict the distribution of differences in pairs of restaurants' contributions to the \citet{GentzkowShapiro:2011} isolation index using leave-out means and 125 pairs of restaurants that are identical in terms of their cuisine category, price category, Yelp rating, and census tract. See appendix \ref{subsec:appendix:schelling} for details. The null hypothesis, in line with our model, is that individuals are randomly assigned to one of the two restaurants within each pair.\par}" >> ../output/tabsfigs/figure_D1.tex
echo '\end{minipage}' >> ../output/tabsfigs/figure_D1.tex
echo '\end{center}\end{figure}'  >> ../output/tabsfigs/figure_D1.tex

cp ../input/schelling_isoindexelements.pdf ../output/tabsfigs/schelling_isoindexelements.pdf
cp ../input/schelling_ttest_appendix_sentence.tex ../output/tabsfigs/schelling_ttest_appendix_sentence.tex
cp ../input/schelling_ttest_sentence.tex ../output/tabsfigs/schelling_ttest_sentence.tex


##Table 6
echo '\begin{table}\caption{Residential and consumption segregation [without standard errors]} \label{tab:dissimilarity:bootstrap}' > ../output/tabsfigs/table6.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.92\textwidth}{!}{\input{../input/dissimilarity_venues_mainspec.tex}}' >> ../output/tabsfigs/table6.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table6.tex

##Figure 7
echo '\begin{figure}[h] \caption{Residential and consumption segregation in three Manhattan communities} \label{fig:Manhattan-segregation-example}' > ../output/tabsfigs/figure7.tex
echo '\begin{minipage}[t]{0.19\columnwidth} \begin{center} ' >> ../output/tabsfigs/figure7.tex
echo '\includegraphics[width=1\textwidth]{../input/dotmap_res_zoom1_edited} \\ A: Residential' >> ../output/tabsfigs/figure7.tex
echo '\end{center} \end{minipage}' >> ../output/tabsfigs/figure7.tex
echo '\begin{minipage}[t]{0.19\columnwidth} \begin{center} ' >> ../output/tabsfigs/figure7.tex
echo '\includegraphics[width=1\textwidth]{../input/dotmap_est_zoom1_edited} \\ B: Estimated' >> ../output/tabsfigs/figure7.tex
echo '\end{center} \end{minipage}' >> ../output/tabsfigs/figure7.tex
echo '\begin{minipage}[t]{0.19\columnwidth} \begin{center} ' >> ../output/tabsfigs/figure7.tex
echo '\includegraphics[width=1\textwidth]{../input/dotmap_nospat_zoom1_edited} \\ C: No spatial' >> ../output/tabsfigs/figure7.tex
echo '\end{center} \end{minipage}' >> ../output/tabsfigs/figure7.tex
echo '\begin{minipage}[t]{0.19\columnwidth} \begin{center} ' >> ../output/tabsfigs/figure7.tex
echo '\includegraphics[width=1\textwidth]{../input/dotmap_nosoc_zoom1_edited} \\ D: No social' >> ../output/tabsfigs/figure7.tex
echo '\end{center} \end{minipage}' >> ../output/tabsfigs/figure7.tex
echo '\begin{minipage}[t]{0.19\columnwidth} \begin{center} ' >> ../output/tabsfigs/figure7.tex
echo '\includegraphics[width=1\textwidth]{../input/dotmap_neither_zoom1_edited} \\ E: Neither' >> ../output/tabsfigs/figure7.tex
echo '\end{center} \end{minipage}' >> ../output/tabsfigs/figure7.tex
echo '\begin{minipage}[t]{0.95\textwidth}' >> ../output/tabsfigs/figure7.tex
echo '{\footnotesize \textsc{Notes}: ' >> ../output/tabsfigs/figure7.tex
echo 'These maps depict community districts 8 (Upper East Side), 10 (Central Harlem), and 11 (East Harlem)' >> ../output/tabsfigs/figure7.tex
echo 'in Manhattan.' >> ../output/tabsfigs/figure7.tex
echo 'The five maps correspond to the five scenarios reported in Table \ref{tab:dissimilarity:bootstrap}. ' >> ../output/tabsfigs/figure7.tex
echo "Each dot represents five percent of the tract's residential population or predicted restaurant visitors." >> ../output/tabsfigs/figure7.tex
echo 'Asian residents or consumers are represented by red dots, black by blue dots, Hispanic by orange dots, and white by green dots.' >> ../output/tabsfigs/figure7.tex
echo 'In different tracts, dots represent a different number of people, so the maps depict variation in shares, not levels.\par}' >> ../output/tabsfigs/figure7.tex
echo '\end{minipage}' >> ../output/tabsfigs/figure7.tex
echo '\end{figure}' >> ../output/tabsfigs/figure7.tex

##Figure 8
echo '\begin{figure}[h] \caption{Residential and consumption segregation in lower Manhattan and west Brooklyn} \label{fig:Williamsburg-dotmap}' > ../output/tabsfigs/figure8.tex
echo '\begin{center}' >> ../output/tabsfigs/figure8.tex
echo '\begin{minipage}[t]{0.32\columnwidth}\begin{center} \includegraphics[width=1\textwidth]{../input/dotmap_res_zoom3and4_edited.pdf} \\' >> ../output/tabsfigs/figure8.tex
echo 'A: Residential \par\end{center}\end{minipage}' >> ../output/tabsfigs/figure8.tex
echo '\begin{minipage}[t]{0.32\columnwidth}\begin{center} \includegraphics[width=1\textwidth]{../input/dotmap_est_zoom3and4_edited.pdf} \\' >> ../output/tabsfigs/figure8.tex
echo 'B: Estimated \par\end{center}\end{minipage}' >> ../output/tabsfigs/figure8.tex
echo '\end{center} ' >> ../output/tabsfigs/figure8.tex
echo '\begin{minipage}[t]{0.32\columnwidth}\begin{center} \includegraphics[width=1\textwidth]{../input/dotmap_nospat_zoom3and4_edited.pdf} \\' >> ../output/tabsfigs/figure8.tex
echo 'C: No spatial \par\end{center}\end{minipage}' >> ../output/tabsfigs/figure8.tex
echo '\begin{minipage}[t]{0.32\columnwidth}\begin{center} \includegraphics[width=1\textwidth]{../input/dotmap_nosoc_zoom3and4_edited.pdf} \\' >> ../output/tabsfigs/figure8.tex
echo 'D: No social \par\end{center}\end{minipage}' >> ../output/tabsfigs/figure8.tex
echo '\begin{minipage}[t]{0.32\columnwidth}\begin{center} \includegraphics[width=1\textwidth]{../input/dotmap_neither_zoom3and4_edited.pdf} \\' >> ../output/tabsfigs/figure8.tex
echo 'E: Neither \par\end{center}\end{minipage} \\' >> ../output/tabsfigs/figure8.tex
echo '\begin{minipage}[t]{0.98\textwidth}' >> ../output/tabsfigs/figure8.tex
echo '{ \footnotesize \textsc{Notes}: ' >> ../output/tabsfigs/figure8.tex
echo 'These maps depict community district 3 in Manhattan and 1, 2, 3, and 4 in Brooklyn.  ' >> ../output/tabsfigs/figure8.tex
echo 'See notes to Figure \ref{fig:Manhattan-segregation-example}.\par} \end{minipage}' >> ../output/tabsfigs/figure8.tex
echo '\end{figure}' >> ../output/tabsfigs/figure8.tex


##Table 7
echo '\begin{table}[htb] \caption{Counterfactual consumption dissimilarity} \label{tab:dissimilarity_cftl}' > ../output/tabsfigs/table7.tex
echo '\begin{center} \input{../input/dissimilarity_cftl_venue_level.tex}' >> ../output/tabsfigs/table7.tex
echo '\begin{minipage}{.9\textwidth}' >> ../output/tabsfigs/table7.tex
echo '{\footnotesize \textsc{Notes}:' >> ../output/tabsfigs/table7.tex
echo 'This table reports venue-level dissimilarity indices based on the coefficient estimates in columns four to six of Table \ref{tab:mainestimates}. Column 1 uses the estimated coefficients.' >> ../output/tabsfigs/table7.tex
echo 'Column 2 introduces the decrease in public-transit times due to the Second Avenue Subway. Column 3 increases all travel times by 20\%. Column 4 reduces the (absolute value of the) coefficients on all social friction covariates by 20\%.\par}' >> ../output/tabsfigs/table7.tex
echo '\end{minipage}' >> ../output/tabsfigs/table7.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table7.tex

cp ../input/dissimilarity_cftl_venue_level.tex ../output/tabsfigs/dissimilarity_cftl_venue_level.tex

##Figure 9
echo "\begin{figure}[h] \caption{Harlem gentrification scenario} \label{fig:Harlem-gentrification-scenario}" > ../output/tabsfigs/figure9.tex
echo "\begin{center}" >> ../output/tabsfigs/figure9.tex
echo "\begin{minipage}[t][1\totalheight][c]{0.3\textwidth}" >> ../output/tabsfigs/figure9.tex
echo "\begin{center} \includegraphics[width=0.65\textwidth]{../input/gentrify_Harlem_manhattan_gray_edited2.png} \end{center}" >> ../output/tabsfigs/figure9.tex
echo "\end{minipage}" >> ../output/tabsfigs/figure9.tex
echo "\begin{minipage}[t][1\totalheight][c]{0.69\textwidth}" >> ../output/tabsfigs/figure9.tex
echo "\input{../input/gentrify_covars_Harlem.tex}" >> ../output/tabsfigs/figure9.tex
echo "\end{minipage}" >> ../output/tabsfigs/figure9.tex
echo "\begin{minipage}[t]{0.95\textwidth}" >> ../output/tabsfigs/figure9.tex
echo "{\footnotesize \textsc{Notes}: " >> ../output/tabsfigs/figure9.tex
echo "We compute the change in black residents' expected utility in the striped tract if the surrounding light gray tracts were to exhibit the characteristics of the dark gray tracts." >> ../output/tabsfigs/figure9.tex
echo "The table reports the changes in these characteristics.\par}" >> ../output/tabsfigs/figure9.tex
echo "\end{minipage}" >> ../output/tabsfigs/figure9.tex
echo "\end{center}\end{figure}" >> ../output/tabsfigs/figure9.tex

cp  ../input/gentrify_covars_Harlem.tex ../output/tabsfigs/gentrify_covars_Harlem.tex

##Table 8
echo '\begin{table} \caption{Welfare losses due to gentrification of surrounding Harlem neighborhoods}  \label{tab:gentrify-loss-decomposition}' > ../output/tabsfigs/table8.tex
echo '\begin{center}' >> ../output/tabsfigs/table8.tex
cat ../input/table_gentrification_Harlem.tex >> ../output/tabsfigs/table8.tex
echo "\begin{minipage}[t]{0.95\textwidth}" >> ../output/tabsfigs/table8.tex
echo "{\footnotesize \textsc{Notes}: " >> ../output/tabsfigs/table8.tex
echo "Welfare loss is expressed as the percentage increase in transit times from home that would be equivalent to the welfare loss associated with the covariate changes due to gentrification. See appendix \ref{appendix:subsec:Gentrification-exercise} for details." >> ../output/tabsfigs/table8.tex
echo "Initial visit share is $\sum_{j\in\mathcal{J}^{G}}P_{ij}$." >> ../output/tabsfigs/table8.tex
echo 'Social frictions are EDD, SSI, EDD$\times$SSI, and racial and ethnic population shares of $k_{j}$.' >> ../output/tabsfigs/table8.tex
echo "Restaurant traits are price, rating, cuisine category, and price and rating interacted with median household income." >> ../output/tabsfigs/table8.tex
echo "Other traits are destination income, differences in incomes, and robberies per resident.\par}" >> ../output/tabsfigs/table8.tex
echo "\end{minipage}" >> ../output/tabsfigs/table8.tex
echo '\end{center}\end{table}' >> ../output/tabsfigs/table8.tex


##APPENDIX 

echo "\begin{figure}[h] \caption{Restaurants reviewed by users in estimation sample} \label{fig:venues-visited}" > ../output/tabsfigs/figure_A1.tex
echo "\begin{center} \includegraphics[width=0.65\textwidth]{../input/figure_A1.pdf}" >> ../output/tabsfigs/figure_A1.tex
echo "\begin{minipage}[t]{0.63\textwidth}" >> ../output/tabsfigs/figure_A1.tex
echo "{\footnotesize \textsc{Notes}: This map depicts the locations of 5363 Yelp restaurant venues reviewed by users in our estimation sample. Each dot represents a venue.\par}" >> ../output/tabsfigs/figure_A1.tex
echo "\end{minipage} \end{center} \end{figure}" >> ../output/tabsfigs/figure_A1.tex

echo "\begin{figure}[h] \caption{Venue counts by ZIP code, Yelp vs NYC DOHMH} \label{fig:Venue-counts-Yelp-DOHMH}" > ../output/tabsfigs/figure_A2.tex
echo "\begin{center}\includegraphics[width=0.52\textwidth]{../input/figure_A2.pdf}" >> ../output/tabsfigs/figure_A2.tex
echo "\begin{minipage}{0.5\textwidth}" >> ../output/tabsfigs/figure_A2.tex
echo "{\footnotesize \textsc{Notes}: This plot compares the number of food establishments in each ZIP code reported in New York City Department of Health \& Mental Hygiene inspections data for 2011-2014 to the number of restaurants listed in our Yelp data covering 2005-2011. See Appendix \ref{subsec:Yelp-venue-data} for notes on outliers.\par}" >> ../output/tabsfigs/figure_A2.tex
echo "\end{minipage}\end{center}\end{figure}" >> ../output/tabsfigs/figure_A2.tex

echo '\begin{table} \caption{Venue review summary statistics} \label{tab:trip_stats}  \begin{center} ' > ../output/tabsfigs/table_A01.tex
echo '\vspace{-4mm}' >> ../output/tabsfigs/table_A01.tex
sed 's/} \&[[:blank:]]*\&/} \&/' ../input/table_A01.tex >> ../output/tabsfigs/table_A01.tex
echo '\begin{minipage}[t]{.9\textwidth} {\footnotesize \textsc{Notes}:'  >> ../output/tabsfigs/table_A01.tex
echo 'The upper panel summarizes the distribution of reviews across different venue characteristics for '  >> ../output/tabsfigs/table_A01.tex
echo 'all Yelp reviews of NYC restaurants (column 1), our estimation sample (column 2), and by race within our estimation sample (columns 3--5).'  >> ../output/tabsfigs/table_A01.tex
echo 'The lower panel summarizes the within-reviewer across-review dispersion in physical distance and Euclidean demographic distance for both the estimation sample and non-located reviewers for whom we inferred racial demographics.\par}' >> ../output/tabsfigs/table_A01.tex
echo '\end{minipage}\end{center}\end{table}'  >> ../output/tabsfigs/table_A01.tex

echo '\begin{table}[htbp] \caption{NYC census tract summary statistics} \label{tab:summarystats:tracts:appendix} \begin{center}' >  ../output/tabsfigs/table_A02.tex
echo '\begin{tabular}{lcc} \toprule \multicolumn{1}{c}{{Variable}} & {Mean} & {Std. Dev.} \\ \midrule' >>  ../output/tabsfigs/table_A02.tex
echo '\textit{Tract characteristics} \\' >>  ../output/tabsfigs/table_A02.tex
sed -n '6,8p' ../input/table_A02_upper.tex | sed 's/\([0-9]\{4\}\)\.[0-9]\{3\}/\1/g' >>  ../output/tabsfigs/table_A02.tex
echo '\textit{Tract-pair characteristics} \\' >>  ../output/tabsfigs/table_A02.tex
sed -n '6,10p' ../input/table_A02_lower.tex  >>  ../output/tabsfigs/table_A02.tex
echo '\bottomrule \end{tabular} \vspace{0.3cm}' >> ../output/tabsfigs/table_A02.tex
echo '\begin{minipage}[t]{0.80\textwidth} \footnotesize{\textsc{Notes}: ' >> ../output/tabsfigs/table_A02.tex
echo 'The upper panel describes ' >> ../output/tabsfigs/table_A02.tex
grep 'multicolumn{2}{c}{' ../input/table_A02_upper.tex | sed 's/\\multicolumn{1}{c}{N} & \\multicolumn{2}{c}{\([0-9]*\)}\\\\ \\hline\\end{tabular}/\1/' | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' >> ../output/tabsfigs/table_A02.tex
echo 'NYC census tracts for which an estimate of median household income is available. ' >> ../output/tabsfigs/table_A02.tex
echo 'The lower panel describes'  >> ../output/tabsfigs/table_A02.tex
grep 'multicolumn{2}{c}{' ../input/table_A02_lower.tex | sed 's/\\multicolumn{1}{c}{N} & \\multicolumn{2}{c}{\([0-9]*\)}\\\\ \\hline\\end{tabular}/\1/' | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' >> ../output/tabsfigs/table_A02.tex
echo 'pairs of 2010 NYC census tracts for which estimates of median household income and travel times are available.' >> ../output/tabsfigs/table_A02.tex
echo 'Data on incomes from 2007-2011 American Community Survey, demographics from 2010 Census of Population, robberies from NYPD, and travel times from Google Maps.\par}' >> ../output/tabsfigs/table_A02.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A02.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A02.tex

echo '\begin{table} \caption{Spatial frictions with home, work, and commuting-path origins} \label{tab:spatialfrictions}' > ../output/tabsfigs/table_A03.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.95\textwidth}{!}{' >> ../output/tabsfigs/table_A03.tex
cat  ../input/table_spatialfrictionsonly.tex >> ../output/tabsfigs/table_A03.tex
echo '}' >> ../output/tabsfigs/table_A03.tex
echo '\begin{minipage}[t]{.93\textwidth}' >> ../output/tabsfigs/table_A03.tex
echo '{\footnotesize \textsc{Notes}: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A03.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A03.tex
echo 'Unreported controls are 28 area dummies.\par}' >> ../output/tabsfigs/table_A03.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A03.tex
echo ' \end{center} \end{table}' >> ../output/tabsfigs/table_A03.tex

echo '\begin{table} \caption{Six-origin-mode specifications: Asian reviewers (part 1)} \label{tab:asian_robust1_sixom}' > ../output/tabsfigs/table_A04_a.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.92\textwidth}{!}{' >> ../output/tabsfigs/table_A04_a.tex
cat  ../input/tab_robustnesschecks1_asian_sixom.tex >> ../output/tabsfigs/table_A04_a.tex
echo '}' >> ../output/tabsfigs/table_A04_a.tex
echo '\begin{minipage}[t]{.90\textwidth}' >> ../output/tabsfigs/table_A04_a.tex
echo '{\tiny \textsc{Notes}: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A04_a.tex
echo 'Column 1 shows specification from main text.' >> ../output/tabsfigs/table_A04_a.tex
echo 'Columns 2 and 3 show specifications in which randomly generated choice sets have 50 and 100 restaurants, respectively.' >> ../output/tabsfigs/table_A04_a.tex
echo 'Columns 4 and 5 show specifications in which observations are limited to the first half and first fifth of NYC restaurant reviews posted by each reviewer, respectively.' >> ../output/tabsfigs/table_A04_a.tex
echo 'Column 6 drops observations that are restaurant reviews containing locational information used to identify the residence or workplace of the reviewer.' >> ../output/tabsfigs/table_A04_a.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A04_a.tex
echo 'Unreported controls are 28 area dummies.\par}' >> ../output/tabsfigs/table_A04_a.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A04_a.tex
echo ' \end{center} \end{table}' >> ../output/tabsfigs/table_A04_a.tex

echo '\addtocounter{table}{-1} \begin{table} \caption{Six-origin-mode specifications: Asian reviewers (continued)} \label{tab:asian_robust2_sixom}' > ../output/tabsfigs/table_A04_b.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.91\textwidth}{!}{' >> ../output/tabsfigs/table_A04_b.tex
sed 's/\&(1)\&(2)\&(3)\&(4)\&(5)\&(6)\&(7)/\&(1)\&(7)\&(8)\&(9)\&(10)\&(11)\&(12)/' ../input/tab_robustnesschecks2_asian_sixom.tex | sed 's/Disagg cuisine/Cuisine/' >> ../output/tabsfigs/table_A04_b.tex
echo '}' >> ../output/tabsfigs/table_A04_b.tex
echo '\begin{minipage}[t]{.9\textwidth}' >> ../output/tabsfigs/table_A04_b.tex
echo '{\tiny \textsc{Notes}: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A04_b.tex
echo 'Column 1 shows specification from main text.' >> ../output/tabsfigs/table_A04_b.tex
echo 'Columns 7 and 8 split the estimation sample into reviewers with residences located using information contained in one or two reviews in column 2 and three or more reviews in column 3.' >> ../output/tabsfigs/table_A04_b.tex
echo 'Column 9 restricts the sample to Yelp reviewers with later-than-median dates of first review written.' >> ../output/tabsfigs/table_A04_b.tex
echo 'Column 10 introduces dummies for 39 more disaggregated cuisine categories.' >> ../output/tabsfigs/table_A04_b.tex
echo 'Column 11 controls for origin-destination differences in vehicle ownership.' >> ../output/tabsfigs/table_A04_b.tex
echo 'Column 12 controls for the number of Yelp reviews of each restaurant and its membership in a chain with more than eight NYC locations.' >> ../output/tabsfigs/table_A04_b.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A04_b.tex
echo 'Unreported controls are 28 area dummies.\par}' >> ../output/tabsfigs/table_A04_b.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A04_b.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A04_b.tex

echo '\begin{table} \caption{Six-origin-mode specifications: Black reviewers (part 1)} \label{tab:black_robust1_sixom}' > ../output/tabsfigs/table_A05_a.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.95\textwidth}{!}{' >> ../output/tabsfigs/table_A05_a.tex
cat  ../input/tab_robustnesschecks1_black_sixom.tex >> ../output/tabsfigs/table_A05_a.tex
echo '}' >> ../output/tabsfigs/table_A05_a.tex
echo '\begin{minipage}[t]{.93\textwidth}' >> ../output/tabsfigs/table_A05_a.tex
echo '{\footnotesize \textsc{Notes}: See notes to Table \ref{tab:asian_robust1_sixom}.\par}' >> ../output/tabsfigs/table_A05_a.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A05_a.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A05_a.tex

echo '\addtocounter{table}{-1} \begin{table} \caption{Six-origin-mode specifications: Black reviewers (continued)}' > ../output/tabsfigs/table_A05_b.tex
echo '\begin{center} \vspace{-3mm} \resizebox{.95\textwidth}{!}{' >> ../output/tabsfigs/table_A05_b.tex
sed 's/\&(1)\&(2)\&(3)\&(4)\&(5)\&(6)\&(7)/\&(1)\&(7)\&(8)\&(9)\&(10)\&(11)\&(12)/' ../input/tab_robustnesschecks2_black_sixom.tex | sed 's/Disagg cuisine/Cuisine/' >> ../output/tabsfigs/table_A05_b.tex
echo '}' >> ../output/tabsfigs/table_A05_b.tex
echo '\begin{minipage}[t]{.93\textwidth}' >> ../output/tabsfigs/table_A05_b.tex
echo '{\footnotesize \textsc{Notes}: See notes to Table \ref{tab:asian_robust2_sixom}.\par}' >> ../output/tabsfigs/table_A05_b.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A05_b.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A05_b.tex

echo '\begin{table} \caption{Six-origin-mode specifications: White/Hispanic reviewers (part 1)} \label{tab:whithisp_robust1_sixom}' > ../output/tabsfigs/table_A06_a.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.95\textwidth}{!}{' >> ../output/tabsfigs/table_A06_a.tex
cat  ../input/tab_robustnesschecks1_whithisp_sixom.tex >> ../output/tabsfigs/table_A06_a.tex
echo '}' >> ../output/tabsfigs/table_A06_a.tex
echo '\begin{minipage}[t]{.93\textwidth}' >> ../output/tabsfigs/table_A06_a.tex
echo '{\footnotesize \textsc{Notes}{: See notes to Table \ref{tab:asian_robust1_sixom}.\par}}' >> ../output/tabsfigs/table_A06_a.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A06_a.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A06_a.tex

echo '\addtocounter{table}{-1} \begin{table} \caption{Six-origin-mode specifications: White/Hispanic reviewers (continued)} \label{tab:whithisp_robust2_sixom}' > ../output/tabsfigs/table_A06_b.tex
echo '\begin{center} \vspace{-3mm} \resizebox{.95\textwidth}{!}{' >> ../output/tabsfigs/table_A06_b.tex
sed 's/\&(1)\&(2)\&(3)\&(4)\&(5)\&(6)\&(7)/\&(1)\&(7)\&(8)\&(9)\&(10)\&(11)\&(12)/' ../input/tab_robustnesschecks2_whithisp_sixom.tex | sed 's/Disagg cuisine/Cuisine/' >> ../output/tabsfigs/table_A06_b.tex
echo '}' >> ../output/tabsfigs/table_A06_b.tex
echo '\begin{minipage}[t]{.93\textwidth}' >> ../output/tabsfigs/table_A06_b.tex
echo '{\footnotesize \textsc{Notes}: See notes to Table \ref{tab:asian_robust2_sixom}.\par}' >> ../output/tabsfigs/table_A06_b.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A06_b.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A06_b.tex

echo '\begin{table} \caption{Minimum-time specifications: Asian reviewers} \label{tab:asian_robust_mintime}' > ../output/tabsfigs/table_A07.tex
echo '\resizebox{\textwidth}{!}{' >> ../output/tabsfigs/table_A07.tex
cat  ../input/tab_robustnesschecks_asian_mintime.tex >> ../output/tabsfigs/table_A07.tex
echo '}'>> ../output/tabsfigs/table_A07.tex
echo '\begin{minipage}[t]{.98\textwidth}' >> ../output/tabsfigs/table_A07.tex
echo '{\tiny \textsc{Notes}{: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A07.tex
echo 'Column 1 shows specification from main text.' >> ../output/tabsfigs/table_A07.tex
echo 'Column 1 shows specification from main text.' >> ../output/tabsfigs/table_A07.tex
echo 'Columns 2 and 3 show specifications in which randomly generated choice sets have 50 and 100 restaurants, respectively.' >> ../output/tabsfigs/table_A07.tex
echo 'Columns 4 and 5 show specifications in which observations are limited to the first half and first fifth of NYC restaurant reviews posted by each reviewer, respectively.' >> ../output/tabsfigs/table_A07.tex
echo 'Columns 6 and 7 split the estimation sample into reviewers  with residences located using information contained in one or two reviews in column 6 and three or more reviews in column 7.' >> ../output/tabsfigs/table_A07.tex
echo 'Column 8 restricts the sample to Yelp reviewers with later-than-median dates of first review written.' >> ../output/tabsfigs/table_A07.tex
echo 'Column 9 drops observations that are restaurant reviews containing locational information used to identify the residence or workplace of the reviewer.' >> ../output/tabsfigs/table_A07.tex
echo 'Column 10 introduces dummies for 39 more disaggregated cuisine categories.' >> ../output/tabsfigs/table_A07.tex
echo 'Column 11 controls for origin-destination differences in vehicle ownership.' >> ../output/tabsfigs/table_A07.tex
echo 'Column 12 controls for the number of Yelp reviews of each restaurant and its membership in a chain with more than eight NYC locations.' >> ../output/tabsfigs/table_A07.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A07.tex
echo 'Unreported controls are 28 area dummies.\par}}' >> ../output/tabsfigs/table_A07.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A07.tex
echo '\end{table}' >> ../output/tabsfigs/table_A07.tex

echo '\begin{table} \caption{Minimum-time specifications: Black reviewers} \label{tab:black_robust_mintime}' > ../output/tabsfigs/table_A08.tex
echo '\resizebox{\textwidth}{!}{' >> ../output/tabsfigs/table_A08.tex
cat  ../input/tab_robustnesschecks_black_mintime.tex >> ../output/tabsfigs/table_A08.tex
echo '}'>> ../output/tabsfigs/table_A08.tex
echo '\begin{minipage}[t]{.98\textwidth}' >> ../output/tabsfigs/table_A08.tex
echo '{\footnotesize \textsc{Notes}{: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A08.tex
echo 'See notes to Table \ref{tab:asian_robust_mintime}.\par}}' >> ../output/tabsfigs/table_A08.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A08.tex
echo '\end{table}' >> ../output/tabsfigs/table_A08.tex

echo '\begin{table} \caption{Minimum-time specifications: White/Hispanic reviewers} \label{tab:whithisp_robust_mintime}' > ../output/tabsfigs/table_A09.tex
echo '\resizebox{\textwidth}{!}{' >> ../output/tabsfigs/table_A09.tex
cat  ../input/tab_robustnesschecks_whithisp_mintime.tex  >> ../output/tabsfigs/table_A09.tex
echo '}' >> ../output/tabsfigs/table_A09.tex
echo '\begin{minipage}[t]{.98\textwidth}' >> ../output/tabsfigs/table_A09.tex
echo '{\footnotesize \textsc{Notes}{: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A09.tex
echo 'See notes to Table \ref{tab:asian_robust_mintime}.\par}}' >> ../output/tabsfigs/table_A09.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A09.tex
echo '\end{table}' >> ../output/tabsfigs/table_A09.tex


echo '\begin{table} \caption{Minimum-time specifications: Asian reviewers (part 1)} \label{tab:asian_robust1_mintime}' > ../output/tabsfigs/table_A07_a.tex
echo '\begin{center} \vspace{-8mm} \resizebox{1\textwidth}{!}{' >> ../output/tabsfigs/table_A07_a.tex
cat  ../input/tab_robustnesschecks1_asian_mintime.tex >> ../output/tabsfigs/table_A07_a.tex
echo '}' >> ../output/tabsfigs/table_A07_a.tex
echo '\begin{minipage}[t]{.98\textwidth}' >> ../output/tabsfigs/table_A07_a.tex
echo '{\scriptsize \textsc{Notes}: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A07_a.tex
echo 'Column 1 shows specification from main text.' >> ../output/tabsfigs/table_A07_a.tex
echo 'Columns 2 and 3 show specifications in which randomly generated choice sets have 50 and 100 restaurants, respectively.' >> ../output/tabsfigs/table_A07_a.tex
echo 'Columns 4 and 5 show specifications in which observations are limited to the first half and first fifth of NYC restaurant reviews posted by each reviewer, respectively.' >> ../output/tabsfigs/table_A07_a.tex
echo 'Column 6 drops observations that are restaurant reviews containing locational information used to identify the residence or workplace of the reviewer.' >> ../output/tabsfigs/table_A07_a.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A07_a.tex
echo 'Unreported controls are 28 area dummies.\par}' >> ../output/tabsfigs/table_A07_a.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A07_a.tex
echo ' \end{center} \end{table}' >> ../output/tabsfigs/table_A07_a.tex


echo '\addtocounter{table}{-1} \begin{table} \caption{Minimum-time specifications: Asian reviewers (continued)} \label{tab:asian_robust2_mintime}' > ../output/tabsfigs/table_A07_b.tex
echo '\begin{center} \vspace{-2mm} \resizebox{.98\textwidth}{!}{' >> ../output/tabsfigs/table_A07_b.tex
sed 's/\&(1)\&(2)\&(3)\&(4)\&(5)\&(6)\&(7)/\&(1)\&(7)\&(8)\&(9)\&(10)\&(11)\&(12)/' ../input/tab_robustnesschecks2_asian_mintime.tex | sed 's/Disagg cuisine/Cuisine/' >> ../output/tabsfigs/table_A07_b.tex
echo '}' >> ../output/tabsfigs/table_A07_b.tex
echo '\begin{minipage}[t]{.96\textwidth}' >> ../output/tabsfigs/table_A07_b.tex
echo '{\scriptsize \textsc{Notes}: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A07_b.tex
echo 'Column 1 shows specification from main text.' >> ../output/tabsfigs/table_A07_b.tex
echo 'Columns 7 and 8 split the estimation sample into reviewers with residences located using information contained in one or two reviews in column 2 and three or more reviews in column 3.' >> ../output/tabsfigs/table_A07_b.tex
echo 'Column 9 restricts the sample to Yelp reviewers with later-than-median dates of first review written.' >> ../output/tabsfigs/table_A07_b.tex
echo 'Column 10 introduces dummies for 39 more disaggregated cuisine categories.' >> ../output/tabsfigs/table_A07_b.tex
echo 'Column 11 controls for origin-destination differences in vehicle ownership.' >> ../output/tabsfigs/table_A07_b.tex
echo 'Column 12 controls for the number of Yelp reviews of each restaurant and its membership in a chain with more than eight NYC locations.' >> ../output/tabsfigs/table_A07_b.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A07_b.tex
echo 'Unreported controls are 28 area dummies.\par}' >> ../output/tabsfigs/table_A07_b.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A07_b.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A07_b.tex


echo '\begin{table} \caption{Minimum-time specifications: Black reviewers (part 1)} \label{tab:black_robust1_mintime}' > ../output/tabsfigs/table_A08_a.tex
echo '\begin{center} \vspace{-8mm} \resizebox{1\textwidth}{!}{' >> ../output/tabsfigs/table_A08_a.tex
cat  ../input/tab_robustnesschecks1_black_mintime.tex >> ../output/tabsfigs/table_A08_a.tex
echo '}' >> ../output/tabsfigs/table_A08_a.tex
echo '\begin{minipage}[t]{.98\textwidth}' >> ../output/tabsfigs/table_A08_a.tex
echo '{\footnotesize \textsc{Notes}: See notes to Table \ref{tab:asian_robust1_mintime}.\par}' >> ../output/tabsfigs/table_A08_a.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A08_a.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A08_a.tex

echo '\addtocounter{table}{-1} \begin{table} \caption{Minimum-time specifications: Black reviewers (continued)}' > ../output/tabsfigs/table_A08_b.tex
echo '\begin{center} \vspace{-3mm} \resizebox{1\textwidth}{!}{' >> ../output/tabsfigs/table_A08_b.tex
sed 's/\&(1)\&(2)\&(3)\&(4)\&(5)\&(6)\&(7)/\&(1)\&(7)\&(8)\&(9)\&(10)\&(11)\&(12)/' ../input/tab_robustnesschecks2_black_mintime.tex | sed 's/Disagg cuisine/Cuisine/' >> ../output/tabsfigs/table_A08_b.tex
echo '}' >> ../output/tabsfigs/table_A08_b.tex
echo '\begin{minipage}[t]{.98\textwidth}' >> ../output/tabsfigs/table_A08_b.tex
echo '{\footnotesize \textsc{Notes}: See notes to Table \ref{tab:asian_robust2_mintime}.\par}' >> ../output/tabsfigs/table_A08_b.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A08_b.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A08_b.tex

echo '\begin{table} \caption{Minimum-time specifications: White/Hispanic reviewers (part 1)} \label{tab:whithisp_robust1_mintime}' > ../output/tabsfigs/table_A09_a.tex
echo '\begin{center} \vspace{-8mm} \resizebox{1\textwidth}{!}{' >> ../output/tabsfigs/table_A09_a.tex
cat  ../input/tab_robustnesschecks1_whithisp_mintime.tex >> ../output/tabsfigs/table_A09_a.tex
echo '}' >> ../output/tabsfigs/table_A09_a.tex
echo '\begin{minipage}[t]{.98\textwidth}' >> ../output/tabsfigs/table_A09_a.tex
echo '{\footnotesize \textsc{Notes}{: See notes to Table \ref{tab:asian_robust1_mintime}.\par}}' >> ../output/tabsfigs/table_A09_a.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A09_a.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A09_a.tex

echo '\addtocounter{table}{-1} \begin{table} \caption{Minimum-time specifications: White/Hispanic reviewers (continued)} \label{tab:whithisp_robust2_mintime}' > ../output/tabsfigs/table_A09_b.tex
echo '\begin{center} \vspace{-3mm} \resizebox{1\textwidth}{!}{' >> ../output/tabsfigs/table_A09_b.tex
sed 's/\&(1)\&(2)\&(3)\&(4)\&(5)\&(6)\&(7)/\&(1)\&(7)\&(8)\&(9)\&(10)\&(11)\&(12)/' ../input/tab_robustnesschecks2_whithisp_mintime.tex | sed 's/Disagg cuisine/Cuisine/' >> ../output/tabsfigs/table_A09_b.tex
echo '}' >> ../output/tabsfigs/table_A09_b.tex
echo '\begin{minipage}[t]{.98\textwidth}' >> ../output/tabsfigs/table_A09_b.tex
echo '{\footnotesize \textsc{Notes}: See notes to Table \ref{tab:asian_robust2_mintime}.\par}' >> ../output/tabsfigs/table_A09_b.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A09_b.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A09_b.tex



echo '\begin{table} \caption{Robustness of spatial frictions} \label{tab:spatialfrictions:robustness} \begin{center}' > ../output/tabsfigs/table_A10.tex
echo '\vspace {-6mm} \resizebox{\textwidth}{!}{' >> ../output/tabsfigs/table_A10.tex
cat  ../input/table_spatialfrictions_robustness.tex >> ../output/tabsfigs/table_A10.tex
echo '}' >> ../output/tabsfigs/table_A10.tex
echo '\begin{minipage}[t]{.98\textwidth}' >> ../output/tabsfigs/table_A10.tex
echo '{\footnotesize \textsc{Notes}{: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A10.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A10.tex
echo 'For brevity, we do not report the following covariates: dollar-bin dummies, rating, cuisine-category dummies, interactions of dollar-bin dummies and rating with home tract median income, percent absolute difference in median incomes, percent difference in median incomes, log median household income in restaurant tract, average annual robberies per resident in restaurant tract, and 28 area dummies.\par}}' >> ../output/tabsfigs/table_A10.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A10.tex
echo '\end{center}\end{table}' >> ../output/tabsfigs/table_A10.tex

echo '\begin{table} \caption{Estimates with home as only origin} \label{tab:homeonlysample}' > ../output/tabsfigs/table_A11.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.94\textwidth}{!}{' >> ../output/tabsfigs/table_A11.tex
sed 's/Home only sample/\\underline{Home only sample}/' ../input/table_homeonlysample_homeonly.tex | sed 's/Home-only sample/\\underline{Home-only sample}/' | sed 's/Estimation sample/\\underline{Estimation sample}/' >> ../output/tabsfigs/table_A11.tex
echo '}' >> ../output/tabsfigs/table_A11.tex
echo '\begin{minipage}[t]{.92\textwidth}' >> ../output/tabsfigs/table_A11.tex
echo '{\footnotesize \textsc{Notes}{: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A11.tex
echo 'Columns 1-3 report parameter estimates for a sample of reviewers for whom we do not have workplace locational information. Columns 4-6 repeat the specifications in Table \ref{tab:spatialfrictions} in which home is the only origin.' >> ../output/tabsfigs/table_A11.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A11.tex
echo 'Unreported controls are 28 area dummies.\par}}' >> ../output/tabsfigs/table_A11.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A11.tex
echo '\end{center}\end{table}' >> ../output/tabsfigs/table_A11.tex

echo '\begin{table} \caption{Estimates with origin-mode-specific intercepts} \label{tab:estimates:omintercepts}' > ../output/tabsfigs/table_A12.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.85\textwidth}{!}{' >> ../output/tabsfigs/table_A12.tex
cat  ../input/omintercepts.tex >> ../output/tabsfigs/table_A12.tex
echo '}' >> ../output/tabsfigs/table_A12.tex
echo '\begin{minipage}[t]{.83\textwidth}' >> ../output/tabsfigs/table_A12.tex
echo '{\footnotesize \textsc{Notes}{: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A12.tex
echo 'This specification adds five origin-mode-specific intercepts to the specification in Table \ref{tab:mainestimates}.' >> ../output/tabsfigs/table_A12.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A12.tex
echo 'For brevity, we do not report the following covariates: dollar-bin dummies, rating, cuisine-category dummies, interactions of dollar-bin dummies and rating with home tract median income, percent absolute difference in median incomes, percent difference in median incomes, log median household income in restaurant tract, average annual robberies per resident in restaurant tract, and 28 area dummies.\par}}' >> ../output/tabsfigs/table_A12.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A12.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A12.tex


echo '\begin{table} \caption{Estimates employing only tract-level demographics} \label{tab:estimates:raceblind}' > ../output/tabsfigs/table_A13.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.5\textwidth}{!}{' >> ../output/tabsfigs/table_A13.tex
cat  ../input/tab_raceblind.tex >> ../output/tabsfigs/table_A13.tex
echo '}' >> ../output/tabsfigs/table_A13.tex
echo '\begin{minipage}[t]{1.0\textwidth}' >> ../output/tabsfigs/table_A13.tex
echo '{\scriptsize \textsc{Notes}{: Each column reports an estimated conditional-logit model of the decision to visit a Yelp venue.' >> ../output/tabsfigs/table_A13.tex
echo 'This specification uses no information on user-level racial demographics.' >> ../output/tabsfigs/table_A13.tex
echo 'Standard errors in parentheses. Statistical significance denoted by \textit{a} (1\%), \textit{b} (5\%), \textit{c} (10\%).' >> ../output/tabsfigs/table_A13.tex
echo 'Unreported controls are 28 area dummies.\par}}' >> ../output/tabsfigs/table_A13.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A13.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A13.tex


echo '\begin{table}\caption{Tract-level residential and consumption segregation}' > ../output/tabsfigs/table_A14.tex
echo '\begin{center} \vspace{-4mm} \resizebox{.92\textwidth}{!}{\input{../input/dissimilarity_tracts_mainspec.tex}}' >> ../output/tabsfigs/table_A14.tex
echo '\end{center} \end{table}' >> ../output/tabsfigs/table_A14.tex

echo '\begin{table} \caption{Demographics of residents and consumers in three Manhattan communities} \label{tab:Sumstat-three-neighbors}'  > ../output/tabsfigs/table_A17.tex
echo '\begin{center}' >> ../output/tabsfigs/table_A17.tex
cat  ../input/sumstats_dotmap_UES_racespcfc.tex >> ../output/tabsfigs/table_A17.tex
echo '\begin{minipage}[t]{0.72\textwidth}' >> ../output/tabsfigs/table_A17.tex
echo '{\footnotesize \textsc{Notes}: ' >> ../output/tabsfigs/table_A17.tex
echo 'This table reports the share of residents and model-predicted restaurant visitors by race in the three community districts illustrated in Figure \ref{fig:Manhattan-segregation-example}.' >> ../output/tabsfigs/table_A17.tex
echo 'The five columns correspond to the five scenarios reported in the five columns of Table \ref{tab:dissimilarity:bootstrap}. \par}' >> ../output/tabsfigs/table_A17.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A17.tex
echo '\end{center}\end{table}'  >> ../output/tabsfigs/table_A17.tex

echo '\begin{table} \caption{Demographics of residents and consumers in lower Manhattan and west Brooklyn} \label{tab:sumstats:LES-and-Brooklyn}'  > ../output/tabsfigs/table_A18.tex
echo '\begin{center}' >>../output/tabsfigs/table_A18.tex
cat  ../input/sums_stats_neighbors_brooklyn.tex >> ../output/tabsfigs/table_A18.tex
echo '\begin{minipage}[t]{0.72\textwidth}' >> ../output/tabsfigs/table_A18.tex
echo '{\footnotesize \textsc{Notes}: ' >> ../output/tabsfigs/table_A18.tex
echo 'This table reports the share of residents and model-predicted restaurant visitors by race in the four community districts illustrated in Figure \ref{fig:Williamsburg-dotmap}.' >> ../output/tabsfigs/table_A18.tex
echo 'The five columns correspond to the five scenarios reported in the five columns of Table \ref{tab:dissimilarity:bootstrap}. \par}' >> ../output/tabsfigs/table_A18.tex
echo '\end{minipage}' >> ../output/tabsfigs/table_A18.tex
echo '\end{center}\end{table}'  >> ../output/tabsfigs/table_A18.tex

echo '\begin{table} \caption{Choice sets and consistency in simulated data} \label{tab:simulate_estimator} \begin{center}' > ../output/tabsfigs/table_C1.tex
cat  ../input/estimator_simulations.tex >> ../output/tabsfigs/table_C1.tex
echo '\begin{minipage}{.93\textwidth}' >> ../output/tabsfigs/table_C1.tex
echo '{\footnotesize \textsc{Notes}: Standard errors in parentheses. All five columns use information on the 400 users that form the randomly generated population of interest. Each of these users makes 40 choices. For each trip, each user writes a review about visited restaurant with probability 0.5.\par}' >> ../output/tabsfigs/table_C1.tex
echo '\end{minipage}\end{center}\end{table}' >> ../output/tabsfigs/table_C1.tex

echo '\begin{table} \caption{Estimation in the presence of permanent $\omega_{ij}$ shocks} \label{tab:Estimation-permanent-shocks}'  > ../output/tabsfigs/table_C2.tex
echo '\vspace{-4mm} \begin{center}' >> ../output/tabsfigs/table_C2.tex
cat  ../input/estimates_persistent_preferences_MLE.tex >> ../output/tabsfigs/table_C2.tex
echo -e '\n \\begin{minipage}[t]{0.93\\textwidth}' >> ../output/tabsfigs/table_C2.tex
echo "{\footnotesize \textsc{Notes}: Each triplet of columns reports three estimates applied to subsets of one draw from the data-generating process \$U_{ijt}=1.0\times\text{rating}_{j}-1.0\times\text{distance}_{ij}+a\times\omega_{ij}+\nu_{ijt}\$. In each draw, there are 100 users who make 40 trips to restaurants. Since users do not review restaurants they have previously visited, there are fewer than 4,000 reviews. In the second and third columns of each triplet, the estimation sample is restricted to the first half and first fifth of each user\'s reviews, respectively.\par}" >> ../output/tabsfigs/table_C2.tex 
echo '\end{minipage}' >> ../output/tabsfigs/table_C2.tex
echo '\end{center}\end{table}'  >> ../output/tabsfigs/table_C2.tex



echo "\begin{figure}[h] \caption{Bedford-Stuyvesant gentrification scenario} \label{fig:Bedford-Stuyvesant-gentrification}" > ../output/tabsfigs/figure_E2.tex
echo "\begin{center}" >> ../output/tabsfigs/figure_E2.tex
echo "\begin{minipage}[t][1\totalheight][c]{0.4\textwidth}" >> ../output/tabsfigs/figure_E2.tex
echo "\begin{center} \includegraphics[width=1.0\textwidth]{../input/gentrify_Bedstuy.pdf} \end{center}" >> ../output/tabsfigs/figure_E2.tex
echo "\end{minipage}" >> ../output/tabsfigs/figure_E2.tex
echo "\begin{minipage}[t][1\totalheight][c]{0.58\textwidth}" >> ../output/tabsfigs/figure_E2.tex
echo "\input{../input/gentrify_covars_Bedstuy.tex}" >> ../output/tabsfigs/figure_E2.tex
echo "\end{minipage}" >> ../output/tabsfigs/figure_E2.tex
echo "\begin{minipage}[t]{0.95\textwidth}" >> ../output/tabsfigs/figure_E2.tex
echo "{\footnotesize \textsc{Notes}: " >> ../output/tabsfigs/figure_E2.tex
echo "We compute the change in black residents' expected utility in the white polygon if the surrounding green tracts were to exhibit the characteristics of the orange tracts." >> ../output/tabsfigs/figure_E2.tex
echo "The table reports the changes in these characteristics.\par}" >> ../output/tabsfigs/figure_E2.tex
echo "\end{minipage}" >> ../output/tabsfigs/figure_E2.tex
echo "\end{center}\end{figure}" >> ../output/tabsfigs/figure_E2.tex

cp ../input/gentrify_covars_Bedstuy.tex ../output/tabsfigs/gentrify_covars_Bedstuy.tex

echo '\begin{table} \caption{Welfare losses due to gentrification of surrounding Bedford-Stuyvesant tracts} \label{tab:gentrify-loss-decomposition-BedStuy}' > ../output/tabsfigs/table_E1.tex
echo '\begin{center}' >> ../output/tabsfigs/table_E1.tex
cat  ../input/table_gentrification_Bedstuy.tex >> ../output/tabsfigs/table_E1.tex
echo "\begin{minipage}[t]{1\textwidth}" >> ../output/tabsfigs/table_E1.tex
echo "{\footnotesize \textsc{Notes}: " >> ../output/tabsfigs/table_E1.tex
echo "Welfare loss is expressed as the percentage increase in transit times from home that would be equivalent to the welfare loss associated with the covariate changes due to gentrification. See appendix \ref{appendix:subsec:Gentrification-exercise} for details." >> ../output/tabsfigs/table_E1.tex
echo "Initial visit share is $\sum_{j\in\mathcal{J}^{G}}P_{ij}$." >> ../output/tabsfigs/table_E1.tex
echo 'Social frictions are EDD, SSI, EDD$\times$SSI, and racial and ethnic population shares of $k_{j}$.' >> ../output/tabsfigs/table_E1.tex
echo "Restaurant traits are price, rating, cuisine category, and price and rating interacted with median household income." >> ../output/tabsfigs/table_E1.tex
echo "Other traits are destination income, differences in incomes, and robberies per resident.\par}" >> ../output/tabsfigs/table_E1.tex
echo "\end{minipage}" >> ../output/tabsfigs/table_E1.tex
echo '\end{center}\end{table}' >> ../output/tabsfigs/table_E1.tex

