Voor deze transcriptomicsanalyse zijn RNA‑seq datasets van vier reumapatiënten en vier gezonde controles gebruikt. Alle analyses zijn uitgevoerd in R. Eerst is een werkdirectory ingesteld waarin de FASTQ‑bestanden, het referentiegenoom (GRCh38) en de annotatiebestanden aanwezig waren. Met het pakket Rsubread is een index van het humane referentiegenoom gebouwd, waarna de paired‑end FASTQ‑reads van alle acht samples zijn gemapt met align(). De resulterende BAM‑bestanden zijn gesorteerd en geïndexeerd met Rsamtools.



Gen‑tellingen zijn verkregen met featureCounts() op basis van de GTF‑annotatie. De tellingenmatrix is vervolgens ingelezen in DESeq2, waarbij een experimenteel design is opgesteld met twee condities: RA en Normal. Met DESeq() zijn normalisatie, dispersieschatting en differentiële expressie uitgevoerd. De resultaten zijn opgeslagen en gevisualiseerd met o.a. een volcano plot.



Voor functionele analyse is goseq gebruikt. SYMBOL‑namen zijn omgezet naar ENSEMBL‑ID’s, waarna lijsten van alle genen en significante genen zijn gemaakt. Met nullp() is gecorrigeerd voor genlengtebias en zijn GO‑termen verrijkt. De top‑GO‑termen zijn gevisualiseerd met ggplot2.



Tot slot is KEGG‑pathwayanalyse uitgevoerd met pathview, waarbij log2‑fold changes uit DESeq2 zijn gebruikt om pathway hsa05323 (Rheumatoid arthritis) in te kleuren.

