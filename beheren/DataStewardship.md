In dit project is data stewardship toegepast om de kwaliteit, veiligheid en reproduceerbaarheid van de analyse te waarborgen. Alle ruwe data (FASTQ‑bestanden), tussenresultaten (BAM‑files, count matrices) en eindresultaten (DE‑tabellen, GO‑resultaten, KEGG‑figuren) zijn opgeslagen in een duidelijke mappenstructuur binnen de projectdirectory. Deze structuur is consistent gehouden tussen lokale opslag en de GitHub‑repository, zodat bestanden eenvoudig terug te vinden zijn.



Versiebeheer is toegepast via GitHub Desktop. Elke wijziging in scripts, documentatie of resultaten is voorzien van een duidelijke commit message, zodat de voortgang van het project transparant en traceerbaar blijft. Dit maakt het mogelijk om eerdere versies te herstellen en samen te werken zonder verlies van informatie.



Reproduceerbaarheid is gewaarborgd door alle gebruikte R‑scripts volledig op te nemen in de map /scripts. Deze scripts bevatten alle stappen van de workflow, inclusief package‑installaties, mapping, DESeq2‑analyse, GO‑analyse en KEGG‑visualisatie. Door gebruik te maken van vaste bestandsnamen en consistente annotatiebestanden (GRCh38 + GTF) kan de volledige analyse opnieuw worden uitgevoerd door derden.



Tot slot zijn resultaten opgeslagen in open formaten (CSV, PNG), zodat ze toegankelijk blijven zonder specifieke software. Hiermee voldoet het project aan de principes van FAIR data stewardship: Findable, Accessible, Interoperable en Reusable.

