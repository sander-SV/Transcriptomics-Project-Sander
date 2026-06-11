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
INLEIDING

Rheumatoïde artritis (RA) is een chronische auto-immuunziekte waarbij het immuunsysteem het eigen synoviale weefsel aanvalt. Dit leidt tot ontsteking, gewrichtsschade en progressieve functieverlies. Hoewel RA klinisch goed beschreven is, blijft de onderliggende moleculaire regulatie complex. Transcriptomics biedt een krachtige methode om genexpressiepatronen te vergelijken tussen patiënten en gezonde individuen, waardoor inzicht ontstaat in de biologische processen die bijdragen aan ziekteactiviteit.

In dit project zijn RNA‑seq data van vier reumapatiënten en vier gezonde controles geanalyseerd. Het doel van deze analyse is om verschillen in genexpressie te identificeren en te onderzoeken welke biologische processen en pathways betrokken zijn bij RA. Door gebruik te maken van een volledige bio-informatica workflow — van read‑mapping tot differentiële expressie en pathway‑analyse — wordt een reproduceerbaar en transparant overzicht gegeven van de moleculaire veranderingen die kenmerkend zijn voor RA.

De resultaten worden gepresenteerd via een GitHub‑pagina, waarin scripts, figuren, resultaten en documentatie overzichtelijk zijn georganiseerd. Hiermee wordt niet alleen voldaan aan de inhoudelijke leerdoelen van transcriptomics, maar ook aan de competentie Beheren, waarbij data‑organisatie, versiebeheer en reproduceerbaarheid centraal staan.

METHODE

Voor deze transcriptomicsanalyse zijn RNA‑seq datasets van vier reumapatiënten en vier gezonde controles gebruikt. Alle analyses zijn uitgevoerd in R. Eerst is een werkdirectory ingesteld waarin de FASTQ‑bestanden, het referentiegenoom (GRCh38) en de annotatiebestanden aanwezig waren. Met het pakket Rsubread is een index van het humane referentiegenoom gebouwd, waarna de paired‑end FASTQ‑reads van alle acht samples zijn gemapt met align(). De resulterende BAM‑bestanden zijn gesorteerd en geïndexeerd met Rsamtools.

Gen‑tellingen zijn verkregen met featureCounts() op basis van de GTF‑annotatie. De tellingenmatrix is vervolgens ingelezen in DESeq2, waarbij een experimenteel design is opgesteld met twee condities: RA en Normal. Met DESeq() zijn normalisatie, dispersieschatting en differentiële expressie uitgevoerd. De resultaten zijn opgeslagen en gevisualiseerd met o.a. een volcano plot.

Voor functionele analyse is goseq gebruikt. SYMBOL‑namen zijn omgezet naar ENSEMBL‑ID’s, waarna lijsten van alle genen en significante genen zijn gemaakt. Met nullp() is gecorrigeerd voor genlengtebias en zijn GO‑termen verrijkt. De top‑GO‑termen zijn gevisualiseerd met ggplot2.

Tot slot is KEGG‑pathwayanalyse uitgevoerd met pathview, waarbij log2‑fold changes uit DESeq2 zijn gebruikt om pathway hsa05323 (Rheumatoid arthritis) in te kleuren.

RESULTATEN



Sander – J2P4 Transcriptomics, NHL Stenden Hogeschool

