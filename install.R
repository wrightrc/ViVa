# install.R

if ("BiocManager" %in% rownames(installed.packages()))
	remove.packages("BiocManager")

install.packages("BiocManager")

library(BiocManager) # shouldn't be necessary
BiocManager::install()

pkgs <- c(
    "biomaRt",
    "Biostrings",
    "BSgenome",
    "BSgenome.Athaliana.TAIR.TAIR9",
    "DECIPHER",
    "GenomicFeatures",
    "VariantAnnotation",
    "vcfR",
    "XVector"
    )

ap.db <- available.packages(contrib.url(BiocManager::repositories()))
ap <- rownames(ap.db)

pkgs_to_install <- pkgs[pkgs %in% ap]

BiocManager::install(pkgs_to_install, update=FALSE, ask=FALSE)

# just in case there were warnings, we want to see them
# without having to scroll up:
warnings()

if (!is.null(warnings()))
{
  w <- capture.output(warnings())
  if (length(grep("is not available|had non-zero exit status", w)))
    quit("no", 1L)
}