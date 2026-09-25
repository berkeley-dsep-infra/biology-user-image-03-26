#!/usr/bin/env Rscript

# renv and BiocManager are needed to install the packages below
required_packages <- c("renv", "BiocManager")

# Check and install required packages
new_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]
if (length(new_packages) > 0) {
  install.packages(new_packages)
}


packages <- c(
  # --- CRAN packages ---
  "adegenet",
  "pegas",
  "phytools",
  "ape",
  "seqinr",
  "hierfstat",
  "poppr",
  "detectRUNS",
  "pwr",
  "mixtools",
  "mclust",
  "pheatmap",
  "phangorn",
  "qqman",

  # DH-757 - PopGenome is archived on CRAN; pin the last release for IB-134L
  "PopGenome@2.7.5",

  # --- Bioconductor packages ---
  "bioc::EBSeq",
  "bioc::Rhtslib",
  "bioc::dada2",
  "bioc::phyloseq",
  "bioc::Biostrings",
  "bioc::cummeRbund",
  "bioc::DESeq2",
  "bioc::apeglm",
  "bioc::EnhancedVolcano"
)

   renv::install(packages)	