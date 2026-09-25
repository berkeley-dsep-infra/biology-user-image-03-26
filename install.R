#!/usr/bin/env Rscript

# PPM snapshot already set in Rprofile.site, but restated here for
# standalone reproducibility
options(repos = c(CRAN = "https://packagemanager.posit.co/all/__linux__/noble/2026-05-11+Fksl5Ok_"))

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

failed_packages <- c()
for (pkg in packages) {
  tryCatch(
    renv::install(pkg, prompt = FALSE),
    error = function(e) {
      cat(sprintf("WARNING: failed to install '%s': %s\n", pkg, conditionMessage(e)))
      failed_packages <<- c(failed_packages, pkg)
    }
  )
}

if (length(failed_packages) > 0) {
  stop(sprintf(
    "Failed to install %d package(s): %s",
    length(failed_packages), paste(failed_packages, collapse = ", ")
  ))
}