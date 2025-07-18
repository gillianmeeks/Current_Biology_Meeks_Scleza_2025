# Code for Main Analyses

**Meeks, G. L., Scelza, B., Kichula, K. M., Berevoescu, C., Hardy, K., Farias, T. D. J., Harrison, G. F., Pollock, N. R., Font-Porterias, N., Prall, S., Norman, P. J., & Henn, B. M.**  
**_No evidence for disassortative mating based on HLA genotype in a natural fertility population._**  
bioRxiv 2025.05.06.652536 (2025)  
[https://doi.org/10.1101/2025.05.06.652536](https://doi.org/10.1101/2025.05.06.652536)

---

## 📁 Directory Overview

### `Allelic_diversity/`
`Sample_size_by_allelic_diversity.ipynb` contains code to produce:
- **Figure 1**: Allelic diversity vs sample size comparisons (unrelated individuals).
- **Figure S3-S4**: Comparisons of allelic diversity.

Includes:
- `sub-saharan_*.csv` Sub-Saharan African Class I data from:  
  *Nemat-Gorgani, N., Guethlein, L. A., Henn, B. M., Norberg, S. J., Chiaroni, J., Sikora, M., Quintana-Murci, L., Mountain, J. L., Norman, P. J., & Parham, P.*  
  *Diversity of KIR, HLA class I, and their interactions in seven populations of sub-Saharan Africans.*  
  *J. Immunol.* **202**, 2636–2647 (2019).

- `IHWG_p_group_all.RData` IHWG population data from:  
  *Mack, S. J., & Erlich, H. A. (2007). Anthropology/human genetic diversity joint report.*  
  In *Immunobiology of the MHC: Proceedings of the 13th International Histocompatibility Workshop and Conference*,  
  J. A. Hansen (Ed.), IHWG Press, pp. 557–766.

-`Himba_allele_freqs_df.RData` contains allele frequency dataframe for the unrelated set of Himba (n=102, no closer than 4th degree relations)

---

### `FINAL_manuscript_models.ipynb`
Contains code for the main partnership analyses featured in:
- **Figures 2 and 3**
- **Figures S6–S8**

**Note:** The partnership dataframe is not provided due to sensitivity of information.

---

### `Grantham_distance/`
- Includes FASTA files of multiple sequence alignments for peptide-binding group amino acid sequences for each HLA gene analyzed.
- Contains the script and Grantham distance matrix for calculating pairwise divergence statistics between partners' alleles, taken directly from **https://granthamdist.sourceforge.io/** **Pierini, F. & Lenz, T. L. Divergent allele advantage at human MHC genes: Signatures of past and ongoing selection. Mol. Biol. Evol. 35, 2145–2158 (2018).** 

---

### `Pathogen_binding/`
- Contains binding dataframes (class*_binding_dfs.RData) with binding scores to all pathogen peptides we provided to netMHCpan **https://services.healthtech.dtu.dk/services/NetMHCpan-4.1/** and NetMHCpanII **https://services.healthtech.dtu.dk/services/NetMHCIIpan-4.3/** for all alleles in the population.
- `create_children.ipynb`: Creates potential offspring genotypes from pairs' genotype data. 
- `Predicted_binding_parallel_class*.R`: R scripts for cross-referencing predicted offspring genotypes with peptide binding data.
- `pathogen_binding_by_haplotypes.ipynb`: cross-referencing common haplotypes to their unique pathogen binding (**Figures S12-13**)

**Note:** No partnership data included due to privacy restrictions.

---

### `IBD_sharing_rate/`
- Code used to calculate IBD sharing rates for **Figure 4**.
- `IBD_sharing_plot.ipynb`:
  	Jupyter notebook with R plotting code to produce **Figure 4**
- `sweepline_script.py`: 
	Program for calculating raw IBD sharing counts (coverage). This program is integrated into `automate_allchr.sh` and `averageIBDcalculator_singlechr.sh` to compute chromosome-wide or genome-wide IBD frequency values, respectively.
- `averageIBDcalculator_singlechr.sh`: 
	Computes chromosome-wide IBD frequency values at all base pairs for a specified chromosome.
- `automate_allchr.sh`: 
	Computes genome-wide IBD frequency values.
- `stacked_plots.R`:
	This R script generates the IBD frequency plot in **Figure 4**. 
- `final_chr6_files`:
	Includes two files, `chr6_binned_random_unrelateds_IBDcoverage.csv` and `chr6_binned_subset_IBDcoverage.csv`, the IBD coverage output files for the unrelated set of individuals used in the partnership analyses (**Figure 4A**) and the subset of unrelated individuals from the allele frequency analyses with common haplotypes (**Figure 4B**), respectively .
	These files are processed output files of the IBD frequency calculator program, `averageIBDcalculator_singlechr.sh`, binned in the method used in the `stacked_plots.R` program - the IBD frequency is averaged and reported for 1000 base pair bins.
- `GRCh37_chromosome_lengths.csv`:
	A file that includes the lengths of GRCh37 chromosomes 1-22, to be used for computing genome-wide IBD sharing rates with `automate_allchr.sh`.

---

### `Phasing/`
- `HIBAG_to_phase_HLA_haplotypes.ipynb`:  
  Phases HLA allele-based haplotypes using imputation via HIBAG **https://www.bioconductor.org/packages/release/bioc/html/HIBAG.html** models created with phased SNP array data (array data available on dbGaP phs001995.v2.p1) and paired target-capture HLA allele calls. The models are used on pseudo-homozygous SNP array data extracted from the phased array data. HIBAG imputed pseudo-homozygou allele calls are then compared with known target-captured HLA allele calls (to be available at same dbGaP accession) to resolve haplotypes.
  **Note:** No hibag models provided because they contain sensitive genotypic information
  
- `Comparing_haplotype_freqs.ipynb`:  
  Compares inferred haplotype frequencies with Sub-Saharan African reference data (Nemat-Gorgani *et al.*, 2019) (**Figure S11**).
  
- `Asymmetric_LD.ipynb`:  
  Calculates asymmetric linkage disequilibrium statistics using pould **https://cran.r-project.org/web/packages/pould/index.html** (**Figure S1**).

---

