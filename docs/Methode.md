\## Data en methode



\### Data

De dataset voor dit onderzoek bestaat uit acht monsters verkregen via synoviumbiopten (weefsel uit het gewrichtsslijmvlies): vier monsters van patiënten met reumatoïde artritis (RA) en vier monsters van gezonde controles. 

De analyse is uitgevoerd op publiek beschikbare paired-end RNA-sequencing data.

Voor de mapping is gebruikgemaakt van het menselijk referentiegenoom Homo sapiens GRCh38 (versie GCF\_000001405.40), met een bijbehorend GTF-bestand voor de nauwkeurige annotatie van genen. (benoem het artikel waar het weg komt en ook hoe ze het hebben verkregen iluminei)



\### Bioinformatica workflow



De onderstaande workflow (Figuur 1) visualiseert de stappen van de ruwe data naar functionele biologische resultaten. Deze volledige workflow is uitgevoerd in R (versie 4.5.2).



!\[stroomschema](figures/stroomschema-workflow.png)



\*\*Figuur 1.\*\* stroomschema - workflow



De methodiek is als volgt onderverdeeld:

Mapping \& Quantificatie: De ruwe reads zijn gemapt met het package Rsubread (v2.24.0).

Na het sorteren en indexeren van de BAM-bestanden met Rsamtools zijn de gen-tellingen gegenereerd met de functie featureCounts, wat resulteerde in een tellingenmatrix.

Differentiële Expressie Analyse: Met het package DESeq2 (v1.50.2) is de statistische vergelijking uitgevoerd tussen de RA-groep en de gezonde controles. Er is een contrast ingesteld om specifiek de expressieverschillen (log2-fold changes) en gecorrigeerde p-waarden te bepalen.

GO-analyse: Met het package goseq (v1.62.0) is een Gene Ontology analyse uitgevoerd om verrijkte biologische processen te identificeren. Voor deze analyse is gebruikgemaakt van de genlengte-informatie van de hg19 build als proxy voor de hg38 mapping-data. Dit is gedaan omdat de specifieke lengte-database voor hg38 lokaal niet beschikbaar was. Gezien de minimale verschillen in genlengtes tussen deze versies, heeft dit geen significante invloed op de bias-correctie, maar het is vermeld om de volledige reproduceerbaarheid te waarborgen.

KEGG Pathway Analyse: Met het package pathview (v1.50.0) is specifiek ingezoomd op de pathway hsa05323 (Rheumatoid Arthritis). Hierbij lag de focus op de regulatie van matrix-afbrekende enzymen (MMP1, MMP3, CTSL) en de betrokkenheid van het V-ATPase complex bij botafbraak.



\---



\## Repository structuur



Deze repository is ingericht volgens de principes van reproduceerbare bio-informatica.  

Elke map heeft een duidelijke functie binnen de workflow:



\- \*\*/beheren\*\* – Data stewardship en GitHub‑beheer (competentie Beheren).

\- \*\*/data\*\* – ruwe FASTQ, BAM, index en referentiegenoom (niet gecommit i.v.m. grootte).

\- \*\*/docs\*\* – Inleiding, Methode, Resultaten, Conclusie en packages.

\- \*\*/figures\*\* – volcano plot, GO‑plot en KEGG‑visualisaties.      

\- \*\*/results\*\* – tabellen met DE‑genen, GO‑resultaten en KEGG‑uitvoer.  

\- \*\*/scripts\*\* – volledig R‑script voor mapping → DESeq2 → GO → KEGG.



\---



\## Reproduceerbaarheid



Deze analyse is volledig reproduceerbaar door:



1\. De repository te clonen  

&#x20;  ```bash

&#x20;  git clone https://github.com/sander-SV/Transcriptomics-Project-Sander

&#x20;  

2\. Download de ruwe data via NCBI SRA:

&#x20;  SRR4785819, SRR4785820, SRR4785828, SRR4785831,

&#x20;  SRR4785979, SRR4785980, SRR4785986, SRR4785988.

