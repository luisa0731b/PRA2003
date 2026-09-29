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
This project was conducted in the programming language "R". Visual Studio Code was used as the platform on the programs for conducting the statistical analyses were coded.

## Research Results
1. What are the average counts of each bacterial strain and their statistical uncertainties?
After determining how many of each unique ID was in every event (experiment), the overall mean average per event was determined"

$$
\text{Average per event} =
\frac{\text{Total number of bacteria}}
{\text{Number of events containing at least one bacterium}}
$$

$$
\text{Uncertainty} =
\frac{\sqrt{\text{Total number of bacteria}}}
{\text{Number of events containing at least one bacterium}}
$$


| ID | Bacterial Strain | Mean Average per Event | Statistical Uncertainty |
| -- | ---------------- | ---------------------- | ----------------------- |
| 211 | E.coli WT | 19.949512 | 0.0327 |
|-211|E.coli mutant|19.917216|0.0319|
|321|Bacillus subtilus WT|2.509147|0.00477|
|-321|Bacillus subtilis mutant|2.50346|0.0055|
|2212|Pseudomonas aeruginosa WT|1.208034|0.0019|
|-2212|Pseudomonas aeruginosa antibiotic-resistant|1.184161|0.00241|
|3122|Streptococcus pneumoniae|0.276258|0.00107|
|-3122|Capsule-deficient S.pneumoniae|0.271695|0.000985|
|3312|Mycobacterium tuberculosis|0.039441|0.000284|
|-3312|Drug-resistant M.tuberculosis|0.039|0.000402|
|3334|Salmonella enterica|0.001188|4.17e-05|
|-3334|Salmonella mutant|0.001152|5.08e-05|
