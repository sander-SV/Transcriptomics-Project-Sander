\# Transcriptomics Analyse – Rheumatoïde Artritis (RA)



Dit project onderzoekt verschillen in genexpressie tussen vier reumapatiënten en vier gezonde controles met behulp van RNA‑seq data. De volledige workflow omvat read‑mapping, tellen van genexpressie, differentiële expressieanalyse, GO‑verrijking en KEGG‑pathwayvisualisatie.



\---



\## Repository structuur



\- \*\*/data\*\* – FASTQ, BAM, GTF en referentiegenoom

\- \*\*/scripts\*\* – volledig R‑script van mapping tot KEGG

\- \*\*/results\*\* – DESeq2‑tabellen, GO‑resultaten

\- \*\*/figures\*\* – volcano plot, GO‑plot, KEGG‑pathway

\- \*\*/docs\*\* – Inleiding, Methode, Resultaten, Conclusie

\- \*\*/beheren\*\* – Data Stewardship \& GitHub beheer



\---



\## Analyse workflow



1\. Mapping met \*\*Rsubread\*\*

2\. Tellen van reads met \*\*featureCounts\*\*

3\. Differentiële expressie met \*\*DESeq2\*\*

4\. GO‑analyse met \*\*goseq\*\*

5\. KEGG‑visualisatie met \*\*pathview\*\*



\---



\## Belangrijkste resultaten



\- Sterke opregulatie van ontstekingsgenen in RA

\- Verrijking van immuun‑ en cytokineprocessen

\- KEGG‑pathway \*\*hsa05323 (Rheumatoid arthritis)\*\* significant geactiveerd

\- Duidelijke activatie van TNF‑α, IL‑6, chemokines en RANKL‑signaling



\---



\## Documentatie



\- \[Inleiding](docs/Inleiding.md)

\- \[Methode](docs/Methode.md)

\- \[Resultaten](docs/Resultaten.md)

\- \[Conclusie](docs/Conclusie.md)

\- \[Data Stewardship](beheren/DataStewardship.md)

\- \[GitHub Beheren](beheren/GitHubBeheren.md)



\---



\## Auteur



Sander – J2P4 Transcriptomics, NHL Stenden Hogeschool

