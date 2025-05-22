Code for the main analyses in:
Meeks, G. L., Scelza, B., Kichula, K. M., Berevoescu, C., Hardy, K., Farias, T. D. J., Harrison, G. F., Pollock, N. R., Font-Porterias, N., Prall, S., Norman, P. J. & Henn, B. M. No evidence for disassortative mating based on HLA genotype in a natural fertility population. bioRxiv 2025.05.06.652536 (2025).


Allelic_diversity: contains scripts and data for allele frequency pie chart S2 (unrelated individuals) and for S3 comparisons of allelic diveristy including Subsaharan African Class 1 data (from Nemat-Gorgani, N., Guethlein, L. A., Henn, B. M., Norberg, S. J., Chiaroni, J., Sikora, M., Quintana-Murci, L., Mountain, J. L., Norman, P. J. & Parham, P. Diversity of KIR, HLA class I, and their interactions in seven populations of sub-Saharan Africans. J. Immunol. 202, 2636–2647 (2019). and IHWG population data from 	Mack, S.J., and Erlich, H.A. (2007). Anthropology/human genetic diver- sity joint report. In Immunobiology of the MHC Proceedings of the 13th International Histocompatibility Workshop and Conference, J.A. Hansen, ed. (IHWG Press), pp. 557–766.

Partnerhsip_models: Contains the code for the main partnership analyses (Figures 1 and 2, S5-7). Partnership dataframe not provided due to sensitivity of information.

Grantham_distance: Contains the fasta files of the multiple sequence alignments for the amino acid sequences of the peptides binding groups and the pairwise divergence stats.

Pathogen_binding: Contains the code for the pathogen binding cross-referencing. No partnership data provided due to sensitivity of information. Contains binding dataframes with the binding scores to all the pathogen peptides for all alleles in the population. create_children.ipynb contains code to create potential offspring genotypes. Predicted_binding_parallel_class*R contain R code that cross reference potential offspring genotypes to binding dataframes. 

IBD_sharing_rate: Contains code used to calculate IBD sharing rates (Figure 4) [....add in description...]

Phasing: HIBAG_to_phase_HLA_haplotypes.ipynb contains code to phase haplotypes via hibag imputation of paired SNP array data and comparison with known HLA alleles. Comparing_haplotype_freqs.ipynb contains code used to compare haplotype frequencies to sub-Saharan populations. Asymmetric_LD.ipynb contains code used to calculate LD stats (Figure S12). Actual phased haplotype and snp array data not provided here.
