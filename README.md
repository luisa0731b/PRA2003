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

### Momentum bin creation

- A bin is a momentum range (in units of 10^-20 kg m/s)
- Bacteria are counted per bin, separately for WT and mutant
- The momentum of every bacterium is p = sqrt(px² + py² + pz²); before choosing bins, the distribution of all momenta of a pair was checked (percentiles and maximum) to see where most bacteria lie
- The same bins are used for all 10 subsamples within a pair, so the subsamples can be averaged bin by bin
- The first bin starts at 0, so no bacteria are left out
- Everything above the last edge goes into one extra "overflow" bin (grey area in the plots below)
- More bacteria = narrower bins, fewer bacteria = wider bins
- Rare strains (M. tuberculosis, Salmonella) need wider bins so that every bin still holds enough bacteria
- Because the bins have different widths, the counts are converted from a frequency to a density, which makes bins comparable:

  $$\frac{dN}{dP} = \frac{N}{\text{bin width} \times \text{number of events}}$$

  The overflow bin has no defined width, so it is left out of the dN/dP plots but is used for the asymmetry!

| Pair | Bin edges |
|:---|:---|
| 211 / -211 | 0, 0.25, 0.5, 0.75, 1, 1.5, 2, 3, 4, 6, 8, 12, 16, 24, 32 |
| 321 / -321 | 0, 0.5, 1, 1.5, 2, 2.5, 3, 4, 6, 8, 12, 16, 24, 40 |
| 2212 / -2212 & 3122 / -3122 & 3312 / -3312 | 0, 1, 1.5, 2, 2.5, 3, 4, 6, 8, 12, 16 |
| 3334 / -3334 | 0, 1, 2, 3, 4.5, 7, 10, 15, 21 |

## Research Results
### 1. What are the average counts of each bacterial strain and their statistical uncertainties?

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

### 2. Is there any asymmetry between the normal and the mutant strain?

For each pair, the difference [WT − mutant] and asymmetry are calculated separately in each of the 10 datasets, and then averaged. The uncertainty comes from the spread of these 10 values. By calculating the difference inside each dataset, we can look at the spread of those 10 differences and treat the two counts as independent. The following formula was used:

$$A = \frac{N_{WT} - N_{mut}}{N_{WT} + N_{mut}}$$

Significance = A was calculated by dividing by its uncertainty (number of $\sigma$). A pair is considered asymmetric if that significance is above the $3\sigma$ threshold.

| Pair | Difference (WT − mutant) | Asymmetry A (%) | Significance | Result |
|:---|:---:|:---:|:---:|:---|
| E. coli (211/-211) | 0.0323 ± 0.0045 | 0.08 ± 0.01 | 7.2σ | Asymmetric |
| B. subtilis (321/-321) | 0.0057 ± 0.0033 | 0.11 ± 0.07 | 1.7σ | Symmetric |
| P. aeruginosa (2212/-2212) | 0.0239 ± 0.0024 | 1.0 ± 0.1 | 10σ | Asymmetric |
| S. pneumoniae (3122/-3122) | 0.0049 ± 0.0006 | 0.9 ± 0.1 | 8.5σ | Asymmetric |
| M. tuberculosis (3312/-3312) | 0.0004 ± 0.0005 | 0.6 ± 0.6 | 0.9σ | Symmetric |
| Salmonella (3334/-3334) | 0.00004 ± 0.00007 | 1.6 ± 2.9 | 0.5σ | Symmetric |

When A > 0, it suggests that the wild type is more abundant than the mutant. Below are the graphs displaying the asymmetries of each bacterial pair:

<img width="1600" height="944" alt="211 dndp" src="https://github.com/user-attachments/assets/1088b214-8e9c-4cc7-8f6b-6f5d38f3a2f8" />

211/-211 (E.coli)
- A = 0.08 ± 0.01m, and 7.2 sigma from zero
- Peak dN/dP at ~8
- Nearly all the bins are above zero, and A grows from about 0.0001 at low P to about 0.005 in the overflow bin (P > 32)
- Asymmetry: Yes

<img width="950" height="600" alt="321 dndp" src="https://github.com/user-attachments/assets/f581cd61-a635-4670-ac09-5cc611d45fa0" />

321/-321 (B. subtilis)
- A = 0.11 ± 0.07, and 1.7 sigma from zero
- Peak dN/dP at ~0.7
- Only the overflow bin (P > 40) stands out
- Asymmetry: No

<img width="1063" height="639" alt="2212 dndp" src="https://github.com/user-attachments/assets/605341fc-850e-4a40-a79a-ac52da8d4a09" />

2212/-2212 (P. aeruginosa)
- A = 1.0 ± 0.1, and 10 sigma from zero
- Peak dN/dP at ~ 0.22
- All bins are above zero
- Asymmetry: Yes

<img width="892" height="602" alt="3122 dndp" src="https://github.com/user-attachments/assets/974bf487-fddb-4a30-a852-288ed6b7ab3c" />

3122/-3122 (S. pneumoniae)
- A = 0.9 ± 0.1, and 8.5 sigma from zero
- Peak dN/dP at ~5x10^-2
- All bins are also above zero
- Asymmetry: Yes

<img width="1076" height="683" alt="3312 dndp" src="https://github.com/user-attachments/assets/a596a087-e852-40ae-bca0-7d954615dcef" />

3312/-3312 (M. tuberculosis)
- A = 0.6 ± 0.6, and 0.9 sigma from zero
- Peak dN/dP at ~0.0055
- WT & mutant overlap
- Asymmetry: No, despite the small hint at it

<img width="1120" height="679" alt="3334 dndp" src="https://github.com/user-attachments/assets/9271b5f7-834b-4f6c-851e-e594b338769e" />

3334/-3334 (Salmonella)
- 1.6 ± 2.9, with 0.5 sigma from zero
- Peak dN/dP at ~ 0.00015
- Bins are scattered around zero
- Asymmetry: No

A WT excess is seen for 211, 2212, and 3122, with a significant overall asymmetry. No asymmetry can be statistically declared for the rest of the bacterial pairs.

### 3. Is there any asymmetry as a function of their momentum?
In each bin, the asymmetry is calculated in each of the 10 subsamples, and then averaged.

$A = \frac{N_{WT} - N_{mut}}{N_{WT} + N_{mut}}$

The vertical error bar is the standard deviation of the 10 subsamples, while the horizontal bar is the bin range. The pink band is the overall asymmetry (all momenta combined) with its uncertainty, and the red dashed line is $A = 0$.

<img width="1600" height="1017" alt="211 asymmetry" src="https://github.com/user-attachments/assets/edcc40e2-1631-429f-bbd6-86a2d65d674a" />

211/-211 (E.coli)
- Asymmetry of all bacteria & momenta combined: 0.0008 ± 0.0001
- WT > mutant in nearly all bins
- Asymmetry increases with momentum
- Asymmetry as a function of momentum: Yes

<img width="950" height="600" alt="321 asymmetry" src="https://github.com/user-attachments/assets/2d50e9e2-31f6-4566-bef7-ef7d93a0aee8" />

321/-321 (B. subtilis)
- Asymmetry of all bacteria & momenta combined: 00011 ± 0.0007
- Most bins are consistent with zero within their error bars
- Asymmetry as a function of momentum: No

<img width="1184" height="717" alt="2212 asymmetry" src="https://github.com/user-attachments/assets/129253d9-d41b-4526-84e7-ecc80ee672d6" />

2212/-2212 (P. aeruginosa)
- Asymmetry of all bacteria & momenta combined: 0.0100 ± 0.0010
- WT > mutant at every momentum
- Asymmetry as a function of momentum: Yes

<img width="900" height="595" alt="3122 asymmetry" src="https://github.com/user-attachments/assets/c4d38e54-fc35-469a-8465-7647df1b7c37" />

3122/-3122 (S. pneumoniae)
- Asymmetry of all bacteria & momenta combined: 0.00894 ± 0.00106
- All bins above zero
- Asymmetry as a function of momentum: Yes

<img width="1152" height="727" alt="3312 asymmetry" src="https://github.com/user-attachments/assets/71301692-60a2-47e4-84a3-e8b318985147" />

3312/-3312 (M. tuberculosis)
- Asymmetry of all bacteria & momenta combined: 0.0056 ± 0.0062
- 10 of 11 bins are admittedly above zero, but every bin's error bar crosses over zero, so we cannot confidently say that any observable differences are not due to random chance
- Pink band overlaps the red line, so not asymmetric
- Asymmetry as a function of momentum: No

<img width="1170" height="675" alt="3334 asymmetry" src="https://github.com/user-attachments/assets/ab35cdcb-92b5-4fcb-be25-183e993eaac2" />

3334/-3334 (Salmonella)
- Asymmetry of all bacteria & momenta combined: 0.0152 ± 0.0293
- Bins have very large error bars
- Asymmetry as a function of momentum: No

Below is a summary of whether there is bacterial asymmetry detected:

| Pair | Overall A | Asymmetry vs momentum? |
|:---|:---:|:---:|
| 211 / -211 | 0.0008 ± 0.0001 | Yes |
| 321 / -321 | 0.0011 ± 0.0007 | No |
| 2212 / -2212 | 0.0100 ± 0.0010 | Yes |
| 3122 / -3122 | 0.00894 ± 0.00106 | Yes |
| 3312 / -3312 | 0.0056 ± 0.0062 | No |
| 3334 / -3334 | 0.0152 ± 0.0293 | No |

# Limitations

There were several limitations encountered during this project. Some of them include:

- Varied bin widths: different bins contained different amounts of information, so treating them identically can affect how much influence each bin has on an overall result
- Set 10 complications: Set 10 is a smaller set with a different momentum distribution (especially at high momentum) and this inflates the error bars in some bins, and as such, this set could be removed in future research
- Low statistics: for rare strains (M. tuberculosis, Salmonella) the uncertainties are large, so "No asymmetry" here means "not detected"
- Open overflow bin: they have no width, so they were missing from the dN/dP plots
- Rounding: values may have been rounded when carried over from the previous calculation, so small differences (e.g. 7.2σ vs about 8σ for E. coli) could've appeared
