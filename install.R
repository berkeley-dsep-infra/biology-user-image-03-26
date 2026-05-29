#!/usr/bin/env Rscript

# PPM snapshot already set in Rprofile.site, but restated here for
# standalone reproducibility
options(repos = c(CRAN = "https://packagemanager.posit.co/all/__linux__/noble/2026-05-11+Fksl5Ok_"))

# --- CRAN packages ---
packages <- c(
  "adegenet",
  "pegas",
  "phytools",
  "ape",
  "seqinr",
  "hierfstat",
  "poppr",
  "PopGenome",
  "detectRUNS",
  "pwr",
  "mixtools",
  "mclust",
  "pheatmap",
  "phangorn",
  "qqman"
)

to_install <- packages[!sapply(packages, requireNamespace, quietly = TRUE)]

if (length(to_install) > 0) {
  message("Installing CRAN packages: ", paste(to_install, collapse = ", "))
  install.packages(to_install, dependencies = TRUE)
} else {
  message("All CRAN packages already installed.")
}

# --- Bioconductor packages ---

if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

bioc_packages <- c(
  "EBSeq",
  "Rhtslib",
  "dada2",
  "phyloseq",
  "Biostrings",
  "cummeRbund",
  "DESeq2",
  "apeglm",
  "EnhancedVolcano"
)

bioc_to_install <- bioc_packages[!sapply(bioc_packages, requireNamespace, quietly = TRUE)]

if (length(bioc_to_install) > 0) {
  message("Installing Bioconductor packages: ", paste(bioc_to_install, collapse = ", "))
  BiocManager::install(bioc_to_install, ask = FALSE, update = FALSE)
} else {
  message("All Bioconductor packages already installed.")
}
