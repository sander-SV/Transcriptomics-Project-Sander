Transcriptomics Analyse van Rheumatoïde Artritis (RA): Van Raw Reads tot Pathway‑Inzicht
Dit project onderzoekt verschillen in genexpressie tussen vier reumapatiënten en vier gezonde controles met behulp van RNA‑sequencing. De volledige workflow — van raw FASTQ tot functionele interpretatie — is uitgevoerd in R en gedocumenteerd in deze repository.

De analyse omvat:

Mapping van reads op het humane referentiegenoom (GRCh38)

Genereren van een count matrix met featureCounts

Differentiële expressieanalyse met DESeq2

GO‑verrijking met goseq

KEGG‑pathwayvisualisatie met pathview

Repository structuur
Code
/data        → FASTQ, BAM, GTF en referentiegenoom
/scripts     → volledig R‑script (mapping → DE → GO → KEGG)
/results     → DESeq2‑tabellen, GO‑resultaten, KEGG‑tabellen
/figures     → volcano plot, GO‑plot, KEGG‑pathway
/docs        → Inleiding, Methode, Resultaten, Conclusie
/beheren     → Data Stewardship & GitHub beheer
RESULTATEN
Hieronder worden de belangrijkste resultaten van de analyse gepresenteerd, met verwijzingen naar de gegenereerde figuren en een korte toelichting per afbeelding.

1. Volcano plot – differentiële genexpressie  
![poep](results/Rplot_volcano plot.png)

Uitleg:  
Deze volcano plot toont de log2‑fold change (x‑as) tegenover de −log10(p‑waarde) (y‑as).
Genen rechts zijn opgereguleerd in RA, genen links zijn neer‑gereguleerd.
Hoe hoger een punt staat, hoe sterker de statistische significantie.
De plot laat duidelijk zien dat meerdere ontstekingsgerelateerde genen sterk opgereguleerd zijn.

2. GO‑analyse – Top 10 verrijkte biologische processen
Bestand:  
figures/GO_top10.png

Uitleg:  
Deze figuur toont de tien meest verrijkte GO‑termen (Biological Process).
De grootte van de bol geeft het aantal betrokken genen weer; de kleur geeft de p‑waarde aan.
Belangrijke processen zoals immune response, leukocyte activation en adaptive immune response zijn sterk verrijkt, wat past bij de pathofysiologie van RA.

3. KEGG‑pathway – hsa05323 (Rheumatoid arthritis)
Bestanden:  
figures/hsa05323.pathview.png  
figures/hsa05323.png

Uitleg:  
Deze KEGG‑pathway is automatisch ingekleurd met log2‑fold changes uit DESeq2.
Rood = opregulatie, groen = neerregulatie.
De pathway laat activatie zien van o.a. TNF‑signaling, IL‑1/IL‑6‑routes, chemokines, T‑celactivatie, B‑celactivatie en RANKL‑gemedieerde osteoclastvorming.
Dit bevestigt dat RA‑samples sterke immuunactivatie en weefselremodellering vertonen.

INLEIDING
Rheumatoïde artritis (RA) is een chronische auto‑immuunziekte waarbij het immuunsysteem het synoviale weefsel aanvalt. Dit leidt tot ontsteking, gewrichtsschade en functieverlies. Transcriptomics maakt het mogelijk om genexpressiepatronen tussen patiënten en gezonde individuen te vergelijken en zo inzicht te krijgen in de moleculaire processen die bijdragen aan RA.

In dit project zijn RNA‑seq data van vier RA‑patiënten en vier gezonde controles geanalyseerd. Het doel is om differentieel tot expressie komende genen te identificeren en te bepalen welke biologische processen en pathways betrokken zijn. De volledige workflow — van mapping tot pathway‑analyse — is reproduceerbaar uitgevoerd en gedocumenteerd in deze GitHub‑repository.

METHODE
Voor deze analyse zijn paired‑end RNA‑seq datasets gebruikt. Eerst is een index van het humane referentiegenoom (GRCh38) gebouwd met Rsubread, waarna alle FASTQ‑reads zijn gemapt. De BAM‑bestanden zijn gesorteerd en geïndexeerd met Rsamtools.

Gen‑tellingen zijn verkregen met featureCounts op basis van een GTF‑annotatie. De tellingenmatrix is ingevoerd in DESeq2, waarbij een design met twee condities (RA vs Normal) is gebruikt. Met DESeq() zijn normalisatie, dispersieschatting en differentiële expressie uitgevoerd. De resultaten zijn gevisualiseerd met o.a. een volcano plot.

Voor functionele analyse is goseq gebruikt. SYMBOL‑namen zijn omgezet naar ENSEMBL‑ID’s, waarna lijsten van alle genen en significante genen zijn gemaakt. Met nullp() is gecorrigeerd voor genlengtebias en zijn verrijkte GO‑termen bepaald.

Tot slot is KEGG‑pathwayanalyse uitgevoerd met pathview, waarbij log2‑fold changes uit DESeq2 zijn gebruikt om de pathway hsa05323 (Rheumatoid arthritis) in te kleuren.

RESULTATEN (uitgebreid)
De KEGG‑pathway hsa05323 (Rheumatoid arthritis) toont duidelijke activatie van ontstekingsroutes in RA‑samples. Pro‑inflammatoire cytokines zoals TNF‑α, IL‑1, IL‑6 en IL‑18 zijn sterk opgereguleerd, wat de ontstekingscascade versterkt via NF‑κB‑signaling.

Daarnaast zijn meerdere chemokines verhoogd tot expressie, waaronder CXCL1, CXCL5, IL‑8, CCL2, CCL3 en CCL20, wat duidt op actieve rekrutering van immuuncellen naar het synoviale weefsel.

Ook pathways betrokken bij T‑celactivatie, B‑celactivatie en RANKL‑gemedieerde osteoclastvorming zijn verhoogd, wat past bij zowel auto‑immuniteit als botresorptie. Angiogenese‑factoren zoals VEGF ondersteunen de vorming van pannusweefsel.

Deze resultaten bevestigen dat RA‑samples sterke immuunactivatie en weefselremodellering vertonen, consistent met de bekende pathofysiologie van RA.

CONCLUSIE
De RNA‑seq analyse toont duidelijke verschillen in genexpressie tussen RA‑patiënten en gezonde controles. Ontstekingsgerelateerde genen zijn sterk opgereguleerd in RA‑samples. GO‑analyse laat verrijking zien van immuunactivatie, cytokineproductie en leukocytenmigratie. De KEGG‑pathwayanalyse bevestigt activatie van belangrijke ontstekingsroutes, waaronder TNF‑signaling, chemokine‑signaling en osteoclastvorming.

Deze geïntegreerde analyse geeft een consistent biologisch beeld dat overeenkomt met de klinische kenmerken van RA. Toekomstig onderzoek kan zich richten op RA‑subtypes of op het identificeren van genen die mogelijk therapeutische targets vormen.

COMPETENTIE BEHEREN
Zie de bestanden in de map /beheren:

DataStewardship.md

GitHubBeheren.md

Hierin wordt uitgelegd hoe data‑organisatie, versiebeheer en reproduceerbaarheid zijn toegepast binnen dit project.

Sander – J2P4 Transcriptomics, NHL Stenden Hogeschool
