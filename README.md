# Code for Main Analyses

**Meeks, G. L., Scelza, B., Kichula, K. M., Berevoescu, C., Hardy, K., Farias, T. D. J., Harrison, G. F., Pollock, N. R., Font-Porterias, N., Prall, S., Norman, P. J., & Henn, B. M.**  
**_No evidence for disassortative mating based on HLA genotype in a natural fertility population._**  
bioRxiv 2025.05.06.652536 (2025)  
[https://doi.org/10.1101/2025.05.06.652536](https://doi.org/10.1101/2025.05.06.652536)

---

## 📁 Directory Overview

### `Allelic_diversity/`
Contains scripts and data for:
- **Figure S2**: Allele frequency pie charts (unrelated individuals).
- **Figure S3**: Comparisons of allelic diversity.

Includes:
- Sub-Saharan African Class I data from:  
  *Nemat-Gorgani, N., Guethlein, L. A., Henn, B. M., Norberg, S. J., Chiaroni, J., Sikora, M., Quintana-Murci, L., Mountain, J. L., Norman, P. J., & Parham, P.*  
  *Diversity of KIR, HLA class I, and their interactions in seven populations of sub-Saharan Africans.*  
  *J. Immunol.* **202**, 2636–2647 (2019).

- IHWG population data from:  
  *Mack, S. J., & Erlich, H. A. (2007). Anthropology/human genetic diversity joint report.*  
  In *Immunobiology of the MHC: Proceedings of the 13th International Histocompatibility Workshop and Conference*,  
  J. A. Hansen (Ed.), IHWG Press, pp. 557–766.

-`Himba_allele_freqs_df.RData` contains allele frequency dataframe for the unrelated set of Himba (n=102, no closer than 4th degree relations)

---

### `Partnership_models/`
Contains code for the main partnership analyses featured in:
- **Figures 1 and 2**
- **Figures S5–S7**

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
- `pathogen_binding_by_haplotypes.ipynb`: cross-referencing common haplotypes to their unique pathogen binding (**Figures S10-11**)

**Note:** No partnership data included due to privacy restrictions.

---

### `IBD_sharing_rate/`
- Code used to calculate IBD sharing rates for **Figure 4**.  
*(Additional documentation to be added.)*

---

### `Phasing/`
- `HIBAG_to_phase_HLA_haplotypes.ipynb`:  
  Phases HLA allele-based haplotypes using imputation via a HIBAG **https://www.bioconductor.org/packages/release/bioc/html/HIBAG.html** model created with paired phased SNP array data (array data available on dbGaP phs001995.v2.p1) and target-capture HLA allele calls. Model is employed on pseudo-homozygous SNP array data extracted from the phased array data, HIBAG imputed pseudo-homozygou allele calls are compared with known target-captured HLA allele calls (to be available at same dbGaP accession) to resolve haplotypes.
  
- `Comparing_haplotype_freqs.ipynb`:  
  Compares inferred haplotype frequencies with Sub-Saharan African reference data (Nemat-Gorgani *et al.*, 2019).
  
- `Asymmetric_LD.ipynb`:  
  Calculates asymmetric linkage disequilibrium statistics using pould **https://cran.r-project.org/web/packages/pould/index.html** (**Figure S12**).

---

