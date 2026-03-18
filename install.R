#!/usr/bin/env Rscript

# Function to install R packages
install_packages_with_versions <- function(packages) {
  available <- available.packages()
  to_install <- names(packages)[!(names(packages) %in% rownames(installed.packages()))]

  if (length(to_install) > 0) {
    install.packages(to_install, available = available,
                     versions = packages[to_install],
                     dependencies = TRUE)
  } else {
    cat("All packages are already installed.\n")
  }
}

# List of packages to ensure are installed
required_packages <- c("remotes", "devtools")

# Check and install required packages
new_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]
if (length(new_packages) > 0) {
  install.packages(new_packages)
}

packages = list(
  "adegenet" = "2.1.3",
  "pegas" = "0.14",
  "phytools" = "0.7-70",
  "ape" = "5.4-1",
  "seqinr" = "4.2-4",
  "hierfstat" = "0.5-7",
  "poppr" = "2.8.6",
  "PopGenome" = "2.7.5", 
  "detectRUNS" = "0.9.6", 
  "pwr" = "1.3" ,
  "mixtools" = "1.2.0",
  "mclust" = "5.4.7",
  "pheatmap" = "1.0.12",
  "phangorn" = "2.7.1",
  "qqman" = "0.1.8"
)

install_packages_with_versions(packages)

## Bioconductor packages
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("EBSeq")
BiocManager::install("Rhtslib")
BiocManager::install("dada2")
BiocManager::install("phyloseq")
BiocManager::install("Biostrings")
BiocManager::install("cummeRbund")
BiocManager::install("DESeq2")
BiocManager::install("apeglm")
BiocManager::install('EnhancedVolcano')
