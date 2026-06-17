# =========================
#  1. WORKING DIRECTORY
# =========================
# Zet je map waar alle FASTQ/BAM/GENOME files staan
setwd("C:/Users/sande/Documents/R data/genoom")
getwd()


# =========================
#  2. PACKAGES INSTALL + LOAD
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
BiocManager::install("ggplot2")

# Laden van packages
library(Rsubread)
library(Rsamtools)
library(DESeq2)
library(EnhancedVolcano)
library(goseq)
library(geneLenDataBase)
library(GO.db)
library(org.Hs.eg.db)
library(ggplot2)

# =========================
#  3. REFERENTIEGENOOM INDEX
# =========================
# Maakt zoekindex voor mapping (1x nodig)
buildindex(
  basename = "ref_genoom",
  reference = "GCF_000001405.40_GRCh38.p14_genomic.fna",
  memory = 10000,
  indexSplit = TRUE
)


# =========================
#  4. MAPPING (FASTQ → BAM)
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
#  5. SORT + INDEX BAM
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
#  6. COUNT MATRIX (featureCounts)
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
#  7. COUNT MATRIX OPSLAAN
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

count_matrix <- as.matrix(read.table("count_matrix_RA.txt",
                                     header = TRUE,
                                     row.names = 1,
                                     sep = "\t"))

# =========================
#  8. DIFFERENTIËLE EXPRESSIE (DESeq2)
# =========================

treatment <- c("Normal","Normal","Normal","Normal","RA","RA","RA","RA")

coldata <- data.frame(row.names = colnames(count_matrix),treatment = factor(treatment))

dds <- DESeqDataSetFromMatrix(countData = count_matrix, colData = coldata, design = ~ treatment)

dds <- DESeq(dds)

results <- results(dds, contrast = c("treatment","RA","Normal"))

# DE-resultaten opslaan voor GitHub
write.csv(as.data.frame(results), "DE_results.csv")

# =========================
#  9. VOLCANO PLOT
# =========================

EnhancedVolcano(results,
                lab = rownames(results),
                x = "log2FoldChange",
                y = "padj")


#=================================
#  10. GENE ONTOLOGY (GO) ANALYSE — GOSEQ
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
#werkt dit niet verander dan "hg38 -> hg19"

# =========================
# 10.5 GO-enrichment uitvoeren
# =========================

GO.wall <- goseq(pwf, "hg19", "ensGene")
#werkt dit niet verander dan "hg38 -> hg19"

# Resultaten bekijken
head(GO.wall)

#===============================
#  11. GO ENRICHMENT ANALYSE (GOSEQ)
#===============================

library(goseq)
library(GO.db)
library(org.Hs.eg.db)
library(ggplot2)

#-------------------------------
# 11.1 Maak DE gene vector
#-------------------------------

# Significant genes (FDR < 0.01)
sigData <- as.integer(!is.na(results$padj) & results$padj < 0.01)

names(sigData) <- results$ensembl

# Verwijder NA’s
sigData <- sigData[!is.na(names(sigData))]

#-------------------------------
# 11.2 Fit Probability Weighting Function (PWF)
#-------------------------------

pwf <- nullp(sigData, "hg19", "ensGene")
#werkt dit niet verander dan "hg38 -> hg19"

#-------------------------------
# 11.3 GO enrichment analyse
#-------------------------------

GO.wall <- goseq(pwf, "hg19", "ensGene", test.cats = c("GO:BP"))
#werkt dit niet verander dan "hg38 -> hg19"

#-------------------------------
# 11.4 Filter significante GO termen
#-------------------------------

enriched.GO <- GO.wall[
  !is.na(GO.wall$over_represented_pvalue) &
    GO.wall$over_represented_pvalue < 0.05,
]

write.csv(enriched.GO, "GO_results.csv")

cat("Aantal significante GO-termen:", nrow(enriched.GO), "\n")

#-------------------------------
# 11.5 Plot top 10 GO termen
#-------------------------------

if(nrow(enriched.GO) > 0){
  
 # Filter brede GO-termen die weinig biologisch zeggen
  broad_terms <- c("macromolecule", "catabolic", "metabolic process")
  enriched.GO <- enriched.GO[!grepl(paste(broad_terms, collapse="|"), enriched.GO$term), ]
  
  
  topGO <- enriched.GO[
    order(enriched.GO$over_represented_pvalue),
  ][1:min(10, nrow(enriched.GO)), ]
  
  # hits eerst berekenen
  topGO$hitsPerc <- topGO$numDEInCat * 100 / topGO$numInCat
  
  p1 <- ggplot(topGO,
               aes(
                 x = hitsPerc,
                 y = reorder(term, over_represented_pvalue),
                 colour = -log10(over_represented_pvalue),
                 size = numDEInCat
               )) +
    geom_point() +
    expand_limits(x = 0) +
    labs(
      title = "GO enrichment analysis (top 10)",
      x = "Hits (%)",
      y = "GO term",
      colour = "p-value",
      size = "Gene count"
    ) +
    theme_minimal()
    scale_colour_gradient(low = "lightblue", high = "darkblue")  
  
  print(p1)
  ggsave("GO_top10.png", plot = p1, width = 10, height = 6)
  
} else {
  cat("Geen significante GO-termen gevonden\n")
}

#-------------------------------
# 11.6 GO term uitleg (optioneel)
#-------------------------------

if(nrow(enriched.GO) > 0){
  GOTERM[[enriched.GO$category[1]]]
}
#=========================
#  12. GO‑TERMEN UITLEZEN (optioneel)
#=========================

for (go in enriched.GO$category) {
  print(GOTERM[[go]])
  cat("--------------------------------------\n")
}

# =========================
# 13. KEGG PATHWAY ANALYSE (PATHVIEW)
# =========================

BiocManager::install("pathview")
library(pathview)

# Maak log2FC vector
log2fc <- results$log2FoldChange
names(log2fc) <- results$ensembl
log2fc <- log2fc[!is.na(names(log2fc))]

# Kies een KEGG pathway (voorbeeld: hsa04110 = Cell cycle)
pathview(
  gene.data = log2fc,
  pathway.id = "hsa05323",
  species = "hsa",
  gene.idtype = "ENSEMBL",
  limit = list(gene = 5))


