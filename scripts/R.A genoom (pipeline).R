# =========================
# 📁 1. WORKING DIRECTORY
# =========================
# Zet je map waar alle FASTQ/BAM/GENOME files staan
setwd("C:/Users/sande/Documents/R data/genoom")
getwd()


# =========================
# 📦 2. PACKAGES INSTALL + LOAD
# =========================
# Alleen 1x runnen als je ze nog niet hebt
install.packages("BiocManager")

BiocManager::install("Rsubread")
BiocManager::install("Rsamtools")
BiocManager::install("DESeq2")
BiocManager::install("EnhancedVolcano")
BiocManager::install("goseq")
BiocManager::install("geneLenDataBase")
BiocManager::install("GO.db")
BiocManager::install("org.Hs.eg.db")

# Laden van packages
library(Rsubread)
library(Rsamtools)
library(DESeq2)
library(EnhancedVolcano)
library(goseq)
library(geneLenDataBase)
library(GO.db)
library(org.Hs.eg.db)

# =========================
# 🧬 3. REFERENTIEGENOOM INDEX
# =========================
# Maakt zoekindex voor mapping (1x nodig)
buildindex(
  basename = "ref_genoom",
  reference = "GCF_000001405.40_GRCh38.p14_genomic.fna",
  memory = 10000,
  indexSplit = TRUE
)


# =========================
# 🔬 4. MAPPING (FASTQ → BAM)
# =========================
# Reads mappen naar referentiegenoom
#bij paired moet deze code anders

# SAMPLE 1
align(index="ref_genoom",
      readfile1="SRR4785819_1_subset40k.fastq",
      readfile2="SRR4785819_2_subset40k.fastq",
      output_file="SRR4785819.bam",
      input_format = "PE")

# SAMPLE 2
align(index="ref_genoom",
      readfile1="SRR4785820_1_subset40k.fastq",
      readfile2="SRR4785820_2_subset40k.fastq",
      output_file="SRR4785820.bam",
      input_format = "PE")

# SAMPLE 3
align(index="ref_genoom",
      readfile1="SRR4785828_1_subset40k.fastq",
      readfile2="SRR4785828_2_subset40k.fastq",
      output_file="SRR4785828.bam",
      input_format = "PE")

# SAMPLE 4
align(index="ref_genoom",
      readfile1="SRR4785831_1_subset40k.fastq",
      readfile2="SRR4785831_2_subset40k.fastq",
      output_file="SRR4785831.bam",
      input_format = "PE")

# SAMPLE 5
align(index="ref_genoom",
      readfile1="SRR4785979_1_subset40k.fastq",
      readfile2="SRR4785979_2_subset40k.fastq",
      output_file="SRR4785979.bam",
      input_format = "PE")

# SAMPLE 6
align(index="ref_genoom",
      readfile1="SRR4785980_1_subset40k.fastq",
      readfile2="SRR4785980_2_subset40k.fastq",
      output_file="SRR4785980.bam",
      input_format = "PE")

# SAMPLE 7
align(index="ref_genoom",
      readfile1="SRR4785986_1_subset40k.fastq",
      readfile2="SRR4785986_2_subset40k.fastq",
      output_file="SRR4785986.bam",
      input_format = "PE")

# SAMPLE 8
align(index="ref_genoom",
      readfile1="SRR4785988_1_subset40k.fastq",
      readfile2="SRR4785988_2_subset40k.fastq",
      output_file="SRR4785988.bam",
      input_format = "PE")

# =========================
# 🔁 5. SORT + INDEX BAM
# =========================
# BELANGRIJK: nodig voor featureCounts + IGV

library(Rsamtools)

samples <- c("SRR4785988","SRR4785986","SRR4785980","SRR4785979","SRR4785831","SRR4785828","SRR4785820","SRR4785819")

# Voor elk monster: sorteer en indexeer de BAM-file
# Sorteer BAM-bestanden
lapply(samples, function(s) {sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))})
# Indexeer de gesorteerde BAM-file
lapply(samples, function(s) {indexBam(file = paste0(s, '.sorted.bam'))})

# =========================
# 📊 6. COUNT MATRIX (featureCounts)
# =========================
# Zet BAM → gen-tellingen

bam_files <- c("SRR4785988.sorted.bam",
               "SRR4785986.sorted.bam",
               "SRR4785980.sorted.bam",
               "SRR4785979.sorted.bam",
               "SRR4785831.sorted.bam",
               "SRR4785828.sorted.bam",
               "SRR4785820.sorted.bam",
               "SRR4785819.sorted.bam")

counts <- featureCounts(
  files = bam_files,
  annot.ext = "genomic.gtf",
  isPairedEnd = TRUE,
  isGTFAnnotationFile = TRUE,
  GTF.featureType = "gene",
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE
)

# =========================
# 💾 7. COUNT MATRIX OPSLAAN
# =========================
# Alleen counts eruit halen

count_matrix <- counts$counts

colnames(count_matrix) <- c("SRR4785988.sorted.bam",
                            "SRR4785986.sorted.bam",
                            "SRR4785980.sorted.bam",
                            "SRR4785979.sorted.bam",
                            "SRR4785831.sorted.bam",
                            "SRR4785828.sorted.bam",
                            "SRR4785820.sorted.bam",
                            "SRR4785819.sorted.bam")

write.csv(count_matrix, "count_matrix_genoom.csv")


# =========================
# 📈 8. DIFFERENTIËLE EXPRESSIE (DESeq2)
# =========================

treatment <- c("Normal","Normal","Normal","Normal","RA","RA","RA","RA")

coldata <- data.frame(row.names = colnames(count_matrix),treatment = factor(treatment))

dds <- DESeqDataSetFromMatrix(countData = count_matrix, colData = coldata, design = ~ treatment)

dds <- DESeq(dds)

results <- results(dds, contrast = c("treatment","RA","Normal"))



# =========================
# 📊 9. VOLCANO PLOT
# =========================

EnhancedVolcano(results,
                lab = rownames(results),
                x = "log2FoldChange",
                y = "padj")






#dit hele stuk werkt nog niet (GO analyse)
#=================================
# 🧬 10. GENE ONTOLOGY (GO) ANALYSE — GOSEQ
#=================================

# Benodigde packages laden
library(goseq)
library(geneLenDataBase)
library(GO.db)
library(org.Hs.eg.db)

# =========================
# 10.1 SYMBOL → ENSEMBL mapping
# =========================

symbol_to_ens <- mapIds(
  org.Hs.eg.db,
  keys = rownames(results),
  column = "ENSEMBL",
  keytype = "SYMBOL",
  multiVals = "first"
)

# Voeg ENSEMBL-ID's toe aan results
results$ensembl <- symbol_to_ens

# =========================
# 10.2 ALL en DEG lijsten maken (op basis van ENSEMBL-ID's)
# =========================

ALL <- results$ensembl
DEG <- results$ensembl[which(results$pvalue < 0.05)]

# Verwijder NA's (genen zonder ENSEMBL-ID)
ALL <- ALL[!is.na(ALL)]
DEG <- DEG[!is.na(DEG)]

# Verwijder dubbele ENSEMBL-ID's
ALL <- unique(ALL)
DEG <- unique(DEG)
# =========================
# 10.3 gene.vector maken
# =========================

gene.vector <- as.integer(ALL %in% DEG)
names(gene.vector) <- ALL

# =========================
# 10.4 Lengtecorrectie (nullp)
# =========================

pwf <- nullp(gene.vector, "hg19", "ensGene")

# =========================
# 10.5 GO-enrichment uitvoeren
# =========================

GO.wall <- goseq(pwf, "hg19", "ensGene")

# Resultaten bekijken
head(GO.wall)

#===============================
#  🧬 11. SIGNIFICANTE GO‑TERMEN
#===============================

enriched.GO <- GO.wall[GO.wall$over_represented_pvalue < 0.05, ]

nrow(enriched.GO)
head(enriched.GO)

#=========================
#  🧬 12. GO‑TERMEN UITLEZEN (optioneel)
#=========================

for (go in enriched.GO$category) {
  print(GOTERM[[go]])
  cat("--------------------------------------\n")
}


















