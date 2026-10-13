Luisa Burduselu (i6398864)
# **PRA2003 Biology Project**
## Background
This project monitors bacterial movement and populations through a bacterial tracking experiment. Using simulation models, how different bacterial species move and proliferate under specific nutrient or stress conditions will be investigated.
The respective data for this research includes:
- the 3D momentum (with px, py, and pz values)
- the unique ID number associated with the strain of bacteria or its variant
The aforementioned bacteria, their variants, and respective ID's include:
- 211: E. coli WT (wild type)
- -211: E. coli mutant
- 321: Bacillus subtilis WT
- -321: Bacillus subtilis mutant
- 2212: Pseudomonas aeruginosa WT
- -2212: Pseudomonas aeruginosa antibiotic-resistant
- 3122: Streptococcus pneumoniae
- -3122: Capsule-deficient streptococcus pneumoniae
- 3312: Mycobacterium tuberculosis
- -3312: Drug-resistant mycobacterium tuberculosis
- 3334: Salmonella enteric
- -3334: Salmonella mutant

### Research Questions
This project aims to answer the following questions:
1. What are the average counts of each bacterial strain and their statistical uncertainties?
2. Is there any asymmetry between the normal and the mutant strain?
3. Is there any asymmetry as a function of their momentum?

### Programs Used
This project was conducted in the programming language "R". Visual Studio Code was used as the platform on which the programs for conducting the statistical analyses were coded and ran.
R was used for: counting bacteria per dataset, mean counts, uncertainties, asymmetry, and the momentum of each bacterium
Python was used for: binning in momentum and plotting dN/dP and asymmetry against momentum. The packages necessary to run the [Python] code are:
- numpy
- pandas
- matplotlib

## Research Results
1. What are the average counts of each bacterial strain and their statistical uncertainties?

After determining how many of each unique ID was in every event (experiment), the overall mean per event and statistical uncertainties were determined:

- Mean per event (total bacteria divided by total number of events):

  $$\bar{x} = \frac{\sum N_i}{\sum E_i}$$

- Standard deviation (SD) of the 10 per-dataset means, with $n = 10$:

  $$SD = \sqrt{\frac{\sum_{i=1}^{n} (x_i - \bar{x})^2}{n - 1}}$$

- Statistical uncertainty of the mean:

  $$\sigma_{\bar{x}} = \frac{SD}{\sqrt{n}}$$

Below lists the findings of the calculations above:

| ID | Strain | Total count | Mean per event | SD | Uncertainty |
|---:|:---|---:|---:|---:|---:|
| 211 | E. coli WT | 92,126,688 | 19.950 | 0.033 | 0.010 |
| -211 | E. coli mutant | 91,977,542 | 19.917 | 0.032 | 0.010 |
| 321 | B. subtilis WT | 11,587,227 | 2.5091 | 0.0048 | 0.0015 |
| -321 | B. subtilis mutant | 11,560,946 | 2.5035 | 0.0055 | 0.0017 |
| 2212 | P. aeruginosa WT | 5,578,693 | 1.20803 | 0.0019 | 0.00060 |
| -2212 | P. aeruginosa antibiotic-resistant | 5,468,447 | 1.18416 | 0.0024 | 0.00076 |
| 3122 | S. pneumoniae | 1,277,330 | 0.27660 | 0.0011 | 0.00034 |
| -3122 | Capsule-deficient S. pneumoniae | 1,254,690 | 0.27170 | 0.00098 | 0.00031 |
| 3312 | M. tuberculosis | 182,139 | 0.039441 | 0.00028 | 0.000090 |
| -3312 | Drug-resistant M. tuberculosis | 180,104 | 0.03900 | 0.00040 | 0.00013 |
| 3334 | Salmonella enterica | 5,482 | 0.001187 | 0.000042 | 0.000013 |
| -3334 | Salmonella mutant | 5,318 | 0.001152 | 0.000051 | 0.000016 |

It's important to note that rarer strains (e.g. M. tuberculosis, Salmonella) have larger uncertainties relative to their size because of larger counting noise!

2. Is there any asymmetry between the normal and the mutant strain?

For each pair, the difference WT − mutant and the asymmetry

$$A = \frac{N_{WT} - N_{mut}}{N_{WT} + N_{mut}}$$

are calculated **separately in each of the 10 datasets**, then averaged. The uncertainty comes from the spread of these 10 values. Calculating the difference inside each dataset keeps the correlation between the WT and mutant counts (they come from the same events), so the uncertainty is not overestimated by treating the two counts as independent.

Significance = A divided by its uncertainty (number of $\sigma$). A pair is called asymmetric if the significance is above the $3\sigma$ threshold.

| Pair | Difference (WT − mutant) | Asymmetry A (%) | Significance | Result |
|:---|:---:|:---:|:---:|:---|
| E. coli (211/-211) | 0.0323 ± 0.0045 | 0.08 ± 0.01 | 7.2σ | Asymmetric |
| B. subtilis (321/-321) | 0.0057 ± 0.0033 | 0.11 ± 0.07 | 1.7σ | Symmetric |
| P. aeruginosa (2212/-2212) | 0.0239 ± 0.0024 | 1.0 ± 0.1 | 10σ | Asymmetric |
| S. pneumoniae (3122/-3122) | 0.0049 ± 0.0006 | 0.9 ± 0.1 | 8.5σ | Asymmetric |
| M. tuberculosis (3312/-3312) | 0.0004 ± 0.0005 | 0.6 ± 0.6 | 0.9σ | Symmetric |
| Salmonella (3334/-3334) | 0.00004 ± 0.00007 | 1.6 ± 2.9 | 0.5σ | Symmetric |



To determine whether there is asymmetry between normal and mutant bacterial strains, calculated z-scores were compared. A z-score with an absolute value of below 3 suggests that there is not significant evidence that asymmetry is occurring, whereas a value of above 3 suggests there is a significant difference between the two variants.
The z-scores were calculated by comparing the difference between the average number of the normal and mutant strains with their uncertainties:

$$
z = \frac{\bar{X}{\mathrm{normal}}-\bar{X}{\mathrm{mutant}}}
{\sqrt{\sigma_{\mathrm{normal}}^2+\sigma_{\mathrm{mutant}}^2}}
$$

where the respective values were drawn from the data collected earlier (table shown above).

|ID|Pair of bacteria|z-score|Asymmetric?|
|--|----------------|-------|-----------|
|211/-211|E.coli (WT vs mutant)|0.7068|No|
|321/-321|Bacillus subtilis (WT vs mutant|0.78156|No|
|2212/-2212|Pseudomonas aeruginosa WT & antibiotic-resistant P. aeruginosa|7.7781|Yes|
|3122/-3122|Streptococcus pneumoniae * capsule-deficient S. pneumoniae|3.36921|Yes|
|3312/-3312|Mycobacterium tuberculosis & drug-resistant M. tuberculosis|0.89398|No|
|3334/-3334|Salmonella enterica & mutant|0.60861|No|


The z-scores for IDs 211/-211 (E.coli WT & mutant), 321/-321 (Bacillus subtilis WT & mutant), 3312/-3312 (Mycobacterium tuberculosis & drug-resistant M. tuberculosis), and 3334/-3334 (Salmonella enterica & mutant) all have z-scores below 3, so there is no statistically significant evidence of an asymmetry between these strain pairs. In contrast, 2212/-2212 (Pseudomonas aeruginosa WT & antibiotic-resistant P. aeruginosa) has a z-score of 7.7781 and 3122/-3122 (Streptococcus pneumoniae * capsule-deficient S. pneumoniae) has a z-score of 3.36921. As these values are greater than 3, these pairs show evidence of asymmetry.
The results indicate an asymmetry is present in pairs 2212/-2212 and 3122/-3122, while no significant asymmetry is observed for the other four pairs.
