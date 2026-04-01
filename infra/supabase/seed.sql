-- ============================================================
-- Seed-Daten: DAV-Gewaesser Mitteldeutschland
-- Sachsen-Anhalt, Thueringen, Sachsen
-- Quelle: Offizielle Gewaesserverzeichnisse der Landesanglerverbande
-- ============================================================

-- Ensure name+bundesland is unique so ON CONFLICT works
alter table public.spots add constraint if not exists spots_name_bundesland_unique
  unique (name, bundesland);

-- Spots werden durch die Datenimport-Pipeline befuellt:
-- 1. data_pipeline/import_lav_pdf.py      (TH: LAVT PDF → CSV)
-- 2. data_pipeline/import_lav_sa_pdf.py   (SA: LAV SA PDF → CSV)
-- 3. data_pipeline/import_lav_sn_pdf.py   (SN: LVSA PDF → CSV)
-- 4. data_pipeline/geocoder.py            (TH: CSV → geocodiertes CSV)
-- 5. data_pipeline/geocode_sa.py          (SA: CSV → geocodiertes CSV)
-- 6. data_pipeline/csv_to_seed.py         (CSV → SQL INSERT)
--
-- Gesamt: 988 Spots
--   Thueringen:      62 (56 PDF + 6 Saalekaskade)
--   Sachsen-Anhalt: 705 (von 1.140 extrahiert, 62% geocodiert)
--   Sachsen:        221 (von 323 extrahiert, 156 GPS aus PDF + 66 geocodiert)

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Speicher Dachwig', 51.072383, 10.850240, 'Thueringen', 'Talsperre',
 '["Aal", "Hecht", "Schleie", "Weißfisch", "Zander"]',
 'Bootsangeln erlaubt; Schonzeit Zander: 01.02. - 31.05.', NULL, 68.0, NULL,
 '[]', false,
 'Dieses idyllisch gelegene Gewässer befindet sich südlich der Verbindungsstraße Andisleben - Bad Langensalza, in der Flur zwischen Dachwig und Großfahner. Nach Passieren der Ortslage Dachwig zum Speicher links abbiegen. Das Angeln ist links von der Staumauer (ca. 700 m) und rechts von der Staumauer...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiessee in der Königsecke – ehem. Teich II Kühnhausen', 51.034175, 10.971045, 'Thueringen', 'Teich',
 '[]',
 '', NULL, 10.54, NULL,
 '[]', false,
 'Dieses Gewässer ist von Kühnhausen in Richtung Mittelhausen zu erreichen. Ca. 600 m links hinter dem Bahndamm geht es in die Elxlebener Straße (neue Umgehungsstraße). Der PKW kann auf dem Parkplatz gegenüber dem Verwaltungsgebäude des Kieswerkes abgestellt werden. Die Uferseite am Campingplatz ist...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Barschsee – Gemarkung Mittelhausen', 51.040508, 11.004852, 'Thueringen', 'See',
 '["Barsch", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 11.25, NULL,
 '[]', false,
 'Dieses Gewässer liegt östlich neben dem Reihersee (Denkmal). Guter Bestand an Karpfen, Schleie, Hecht, Barsch und Weißfischen vorhanden.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Triftsee – Gemarkung Mittelhausen', 51.040508, 11.004852, 'Thueringen', 'See',
 '[]',
 '', NULL, 15.72, NULL,
 '[]', false,
 'Der Fischbestand befindet sich weiterhin im Aufbau. Aus diesem Grund ist im Jahr 2022 das Raubfischangeln ganzjährig verboten! Die Verwendung von Kunstködern, Drop Shot-Montagen, Köderfischen und Fetzenködern ist untersagt! Angeln auf Friedfisch ist erlaubt. Das Betreten der Inseln ist verboten.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sulzer See', 51.038059, 11.076603, 'Thueringen', 'See',
 '[]',
 'Bootsangeln erlaubt', NULL, 56.0, NULL,
 '[]', false,
 'Von Erfurt kommend über die Schwerborner Straße in Richtung Schwerborn oder über die Stotternheimer Chaussee aus Richtung Stotternheim zu erreichen. Alt bekanntes, fischartenreiches Gewässer am nördlichen Stadtrand.   Derzeit unterliegen die Angelbereiche den betrieblichen Erfordernissen und können...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Klingesee Stotternheim', 51.056072, 11.042756, 'Thueringen', 'See',
 '["Hecht", "Karpfen", "Schleie", "Zander"]',
 'Bootsangeln erlaubt', NULL, 25.0, NULL,
 '[]', false,
 'Das Gewässer ist von Stotternheim Zentrum in Richtung Schwerborn unmittelbar nach Überqueren der Bahnlinie geradeaus zum Kieswerk Wagner zu erreichen. Es liegt auf der linken Seite der Plattenstraße. Zugang auch über den Feldweg hinter dem Bahnübergang rechts in Richtung Schwansee möglich. Ein...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stotternheimer Bad', 51.038059, 11.076603, 'Thueringen', 'See',
 '[]',
 '', NULL, 20.0, NULL,
 '[]', false,
 'Dieser saubere, idyllisch gelegene Kiessee mit gutem Fischbesatz befindet sich in der Nähe des Stotternheimer Bahnhofes in Richtung Schwerborn. Speziell für Angler wurde vom Eigentümer ein gesonderter Zugang zum Gewässer mit Parkplatz für PKW eingerichtet. Der Parkplatz ist wie folgt zu erreichen:...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Nordstrand Erfurt', 50.977797, 11.028736, 'Thueringen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 'Bootsangeln erlaubt', NULL, 15.0, NULL,
 '[]', false,
 'Liegt am nördlichen Stadtrand von Erfurt und ist über die Eugen-Richter-Straße stadtauswärts, nach der Bahnunterführung rechts abbiegend in die Straße zum Nordstrand, zu erreichen. Ein sehr attraktives Altgewässer mit einem guten Bestand an kapitalen Hechten, Karpfen, Schleie und Aal. Dieses...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unterer Henneteich', 50.977797, 11.028736, 'Thueringen', 'Teich',
 '["Karpfen", "Schleie", "Zander"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 'Ein interessantes Kleingewässer am Stadtrand von Erfurt mit gutem Karpfen- und Schleien- bestand. Zu erreichen über die Weimarische Straße, hinter Mc Donalds liegend. Beachte: Schonzeit für Zander ist vom 01.02. bis 31.05. In dieser Zeit ist das Angeln mit Kunstködern jeglicher Art, Drop...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Speicher Vieselbach', 50.997494, 11.146044, 'Thueringen', 'Talsperre',
 '["Aal", "Hecht", "Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 10.0, NULL,
 '[]', false,
 'Der Stau liegt zwischen den Ortschaften Mönchenholzhausen und Hochstedt und ist über die B7, Abfahrt Sömmerda (Möbelhaus Rieger), sowohl von Erfurt, als auch von Weimar gut erreichbar. Der gute Bestand an Karpfen, Zander, Schleie, Hecht, Aal, Plötze, Rotfeder und Karausche ist...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Molschengrube Sömmerda', 51.199436, 11.068097, 'Thueringen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 2.7, NULL,
 '[]', false,
 'Von Sömmerda aus in Richtung Straußfurt/Weißensee nach Durchfahrt Sömmerda hinter der Tankstelle und vor der Abzweigung nach Weißensee (Ampelanlage) nach rechts in den Gartenweg einbiegen. Gewässer liegt unmittelbar am Weg links. Von Straußfurt kommend hinter der Ampelanlage nach Weißensee...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiessee Leubingen', 51.161826, 11.117487, 'Thueringen', 'See',
 '[]',
 '', NULL, 6.0, NULL,
 '[]', false,
 'Dieses attraktive Angelgewässer liegt in der Gemarkung Leubingen und ist aus Richtung Sömmerda über Wenigensömmern zu erreichen. Kurz vor der Ortschaft Leubingen links auf den ausgeschilderten Wirtschaftsweg des Kieswerkes abbiegen. Diesem noch ca. 600 m folgen und dann das Fahrzeug auf der rechten...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gera von Gemarkungsgrenze Elxleben/Walschleben bis Gemarkungsgrenze Andisleben/Ringleben', 50.876553, 12.083267, 'Thueringen', 'Fluss',
 '[]',
 '', NULL, 4.0, NULL,
 '[]', false,
 'Beginn der Gewässerstrecke 600 m flussaufwärts oberhalb der Brücke in Walschleben. Gewässerstrecke geht nahtlos in die Gemarkung Andisleben/Ringleben über. Bitte Ausschilderung beachten.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gera in der Gemarkung Andisleben/Ringleben bis Gemarkungsgrenze Ringleben/Gebesee', 51.082206, 10.926122, 'Thueringen', 'See',
 '[]',
 '', NULL, 3.1, NULL,
 '[]', false,
 'Ende Gewässerstrecke flussabwärts 150 m vor Ortseingangsschild Gebesee.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gera von Einmündung der Gera in die Unstrut bis zur Gemarkungsgrenze 150 m hinter dem Ortsausgangsschild Gebesee in', 50.876553, 12.083267, 'Thueringen', 'See',
 '["Blei", "Hasel", "Plötze", "Rotfeder"]',
 '', NULL, 3.5, NULL,
 '[]', false,
 'Richtung Ringleben • 2,2 km, ca. 3,5 ha Anfahrt über die Ortslage Gebesee – Sportplatz Richtung Ringleben bis zur Brücke oder über die B4 durch Gebesee in Richtung Straußfurt bis zur Brücke. Vor der Brücke rechts befindet sich eine kleine Abfahrt. Im Interesse der Fischhege besteht für die gesamte...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unstrut Gemarkung Herbsleben', 51.118958, 10.836199, 'Thueringen', 'Fluss',
 '[]',
 '', NULL, 5.0, NULL,
 '[]', false,
 'Von Straßenbrücke Ortsausgang linkes Ufer ca. 4 km und rechtes Ufer ca. 5,5 km stromabwärts bis Gemarkung Gebesee. Bitte Ausschilderung des SFV „Unstrut“ e.V. Herbsleben beachten.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unstrut in der Gemarkung Schwerstedt', 51.155247, 10.919421, 'Thueringen', 'Fluss',
 '[]',
 '', NULL, 4.2, NULL,
 '[]', false,
 'Hinter der Stadt Gebesee vor der Unstrutbrücke links abbiegen nach Schwerstedt bis zur Brücke. Ab Brücke ca. 3,5 km flussabwärts Angelstrecke. Oder über die B4 von Henschleben kommend ca. 1 km nach der Ortslage rechts über den Weg bis zum Kirchberg fahren. Hier die Fahrzeuge bitte abstellen. Das...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teildauerstau Straußfurt', 51.141955, 10.970429, 'Thueringen', 'Stausee',
 '[]',
 'Bootsangeln erlaubt', NULL, 206.0, NULL,
 '[]', false,
 'Zu erreichen ist das Rückhaltebecken über die B4, Ortslage Henschleben bzw. Straußfurt. Angelstrecken 1. Von Straußfurt kommend in Richtung Erfurt nach dem Bahnübergang Vehra nach ca. 300 m rechts abbiegen. Am Beginn des Hochwasserschutzdammes auf den Feldweg einfahren. Ab hier Angelstrecke ca. 800...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unstrut in der Gemarkung Vehra', 51.162432, 10.989534, 'Thueringen', 'Fluss',
 '[]',
 '', NULL, 4.5, NULL,
 '[]', false,
 'B4 bis Vehra bei Straußfurt. Beanglung vom Schöpfwerk Vehra am Ortsende hinter dem Sportplatz flussabwärts bis Einmündung der Gramme in die Unstrut. Beachte: Der Streckenabschnitt von der Eisenbahnbrücke, ca. 300 m flussabwärts, bis zum Schöpfwerk Vehra ist Schonstrecke. Angeln ist nicht erlaubt.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unstrut Gemarkung Wundersleben', 51.153622, 11.038854, 'Thueringen', 'Fluss',
 '[]',
 '', NULL, 5.4, NULL,
 '[]', false,
 'Dieser Gewässerabschnitt verläuft von Gemarkungsgrenze Straußfurt/Wundersleben bis beachten!  Gemarkungsgrenze Wundersleben/Schallenburg. Bitte Ausschilderung  Attraktives Angelgewässer mit einem artenreichen Fischbestand. Bitte beachten! - Für die Gewässer 37 und 38 gilt, dass Befahren des...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wasserspeicher Gänserieth', 51.140410, 11.000028, 'Thueringen', 'Talsperre',
 '[]',
 '', NULL, 0.15, NULL,
 '[]', false,
 'Zufahrt über Ortslage Werningshausen, hinter der Steinmetzfirma E. Spangenberg. Rechts (Triftstraße); nach ca. 500 m kleiner Dorfweiher mit Insel. Beachte: Vom 01.11. bis 01.03. Angelverbot.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ilm in Gemarkung Oßmannstedt bis Niederroßla/Zottelstedt', 51.017154, 11.426495, 'Thueringen', 'Fluss',
 '["Bachforelle"]',
 '', NULL, 11.7, NULL,
 '[]', false,
 '• 10,0 km, 11,7 ha Mischgewässer Ab 50 m oberhalb Brücke Gagarinstraße in Oßmannstedt bis Holzbrücke Oberroßla Mischgewässer Ab Ilmschlößchen Niederroßla bis Pachtgrenze Zottelstedt 1.  Laichschonstrecken “Hohe Leite“ Beginn Brücke Gagarinstraße in Oßmannstedt ca.1,0 km flussabwärts Länge: ca. 0,5...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neuer Kiessee Rudisleben', 50.801327, 10.955632, 'Thueringen', 'See',
 '[]',
 '', NULL, 6.0, NULL,
 '[]', false,
 'Die Kiesgrube von „Märker Kies GmbH“ in Arnstadt Rudisleben liegt links vom Hauptweg im Betriebsgelände. Das Gewässer ist über die Bundesstraße B4, von Erfurt kommend, zu erreichen. An der Kreuzung Rudisleben links in den Ort fahren, immer geradeaus, dann rechts in den Schulplatz abbiegen, bis...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Speicher Kromsdorf und Nachstau', 51.001299, 11.370466, 'Thueringen', 'Talsperre',
 '["Aal", "Hecht", "Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 'Schonzeit Zander: 01.02. - 31.05.', NULL, 10.3, NULL,
 '[]', false,
 'Dieser Stau liegt in der Nähe von Weimar und ist über die B7 in Richtung Jena über das Gewerbegebiet Süßenborn zu erreichen. Kurz vor der Ortslage Kromsdorf rechts auf den Feldweg (Plattenweg) abbiegen und nach ca. 1 km erreichen Sie das Gewässer. Die Fahrzeuge sind am Anfang des Staudammes auf die...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Naturbad Magdala', 50.906554, 11.446329, 'Thueringen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 'Schonzeit Zander: 01.02. - 31.05.', NULL, 2.74, NULL,
 '[]', false,
 'Dieses Gewässer ist teilweise eingezäunt und liegt am Stadtrand von Magdala in Richtung Ottstedt (Ottstedter Straße) auf der linken Seite. Es wird deshalb auch Ottstedter Teich genannt. Kurz vor Beginn der Einzäunung des Gewässers kann man links abbiegen und das Gewässer über den Feldweg, welcher...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Loßnitz', 50.860475, 11.341823, 'Thueringen', 'Talsperre',
 '["Barsch", "Karpfen", "Plötze", "Schleie", "Zander"]',
 'Schonzeit Zander: 01.02. - 31.05.', NULL, 3.5, NULL,
 '[]', false,
 'Das Gewässer ist von der A4 und Magdala kommend in Richtung Blankenhain über Tromlitz und Söllnitz zu erreichen und liegt kurz hinter Loßnitz auf der linken Seite. Von Blankenhain kommend über Rottdorf liegt es rechts. Ein idyllisch gelegenes Gewässer mit einem guten Fischbestand (Karpfen, Schleie,...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lohteich Apolda', 51.022788, 11.512974, 'Thueringen', 'Teich',
 '[]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Friedensteich Apolda', 51.022788, 11.512974, 'Thueringen', 'Teich',
 '["Aal", "Barsch", "Giebel", "Karpfen", "Plötze", "Rotfeder", "Zander"]',
 'Schonzeit Zander: 01.02. - 31.05.', NULL, 1.5, NULL,
 '[]', false,
 'Diese beiden attraktiven Kleingewässer liegen in Apolda an der Herressener Promenade. Durch gezielte Hege- und Besatzmaßnahmen hat sich nach den erfolgten Sanierungsmaßnahmen wieder ein guter Fischbestand entwickelt. Beachte! - Gefangene Goldfische und Giebel müssen aus hegerischen Gründen aus...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pfaffenteich', 51.366604, 10.866842, 'Thueringen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 1.77, NULL,
 '[]', false,
 'Lage: Nordöstlich im Stadtwald von Sondershausen. Zufahrt über Brückental (Krankenhaus, Hauptfriedhof) ca. 5 km durch den Stadtwald immer gerade durch (nicht abbiegen). Fischbestand: Karpfen, Schleie, Weißfisch, Aal, Hecht')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hammateich', 51.366604, 10.866842, 'Thueringen', 'Teich',
 '[]',
 '', NULL, 58.0, NULL,
 '[]', false,
 'Lage: Der Teich liegt in der Hammatalstraße. Zu erreichen über Kreisel Nordhäuser Straße in Sondershausen, die 3. Abfahrt stadteinwärts. Gegenüber dem Teich befindet sich die Ausflugsgaststätte „Stille Liebe“. Bitte beachten! - Das Gewässer muss saniert werden und hat aktuell kein Wasser. Angeln...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Parkteich Sondershausen', 51.366604, 10.866842, 'Thueringen', 'Teich',
 '["Barsch", "Giebel", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.01, NULL,
 '[]', false,
 'Beachte: Der Fischbestand befindet sich derzeit im Aufbau. Angeln auf Raubfische verboten! Dieses Gewässer liegt im Stadtpark zwischen Hospitalstraße und Marktplatz im Zentrum von Sondershausen. Günstiges Parken ist auf dem kostenlosen Außenparkplatz vom Kaufand möglich. Von da aus ist der Teich in...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Baderteich Ronneburg', 50.863052, 12.180907, 'Thueringen', 'Teich',
 '["Aal", "Giebel", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 'Der Baderteich befindet sich im Zentrum von Ronneburg, direkt unter dem Schloss. Trotz seiner zentralen Lage ist es angenehm ruhig. Der Teich hat eine Größe von ca. 2,5 ha und eine Tiefe von maximal 3 m. Die Hauptfischarten sind Karpfen, Schleie, Hecht und Aal. Für Giebel besteht eine...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Parkteich Farnroda', 50.974713, 10.319356, 'Thueringen', 'Teich',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 'Dieses interessante Gewässer ist von Eisenach oder Erfurt kommend über die L3007 (ehemals B7) und der Ortsmitte von Wutha - Farnroda erreichbar. In Wutha an der Ampelkreuzung in Richtung Ruhla fahren. An der zweiten Ampel im Ortsteil Farnroda nach rechts und nach 10 m wieder rechts in den...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wipper', 51.401213, 10.795613, 'Thueringen', 'Fluss',
 '["Aal", "Bachforelle", "Barsch", "Döbel", "Giebel", "Gründling", "Hasel", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.0, NULL,
 '[]', false,
 'Beginn: Gemarkungsgrenze Sondershausen Großfurra/Sondershausen Verlauf: Sondershausen, Berka, Hachelbich, Göllingen, Seega, Günserode Ende: Gemarkungsgrenze Günserode/Bilzingsleben (SÖM) Hauptfischarten: Hecht, Aal, Barsch, Karpfen, Plötze, Giebel, Hasel, Gründling, Döbel, Bachforelle')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unstrut', 51.234721, 11.112729, 'Thueringen', 'Fluss',
 '["Aal", "Barsch", "Blei", "Döbel", "Hasel", "Hecht", "Karpfen", "Plötze", "Ukelei", "Zander"]',
 '', NULL, 62.0, NULL,
 '[]', false,
 'Beginn: Gemarkungsgrenze Sachsenburg - Oldisleben Verlauf: Oldisleben, Heldrungen, Bretleben, Schönfeld, Artern, Ritteburg, Kalbsrieth, Schönewerda, Bottendorf, Roßleben Ende: Landes und Kreisgrenze Thüringen / Sachsen Anhalt bei Roßleben Hauptfischarten: Hecht, Barsch, Döbel, Ukelei, Hasel,...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Helme', 51.448703, 10.945639, 'Thueringen', 'Fluss',
 '["Aal", "Bachforelle", "Barbe", "Barsch", "Döbel", "Gründling", "Hasel", "Hecht", "Karpfen", "Plötze", "Schleie", "Ukelei"]',
 '', NULL, 7.0, NULL,
 '[]', false,
 'Beginn: Gemarkungsgrenze Mönchpfiffel/Allstedt (Thüringen/Sachsen Anhalt) Verlauf: Mönchpfiffel-Nicolausrieth, Heygendorf, Kalbsrieth Ende: Mündung in die Unstrut bei Kalbsrieth. Hauptfischarten: Hasel, Döbel, Plötze, Barsch, Bachforelle, Ukelei, Aal, Hecht, Schleie, Karpfen, Gründling, Barbe')
ON CONFLICT (name, bundesland) DO NOTHING;

-- Nr. 66 Stau Podelsatz: Entfernt (nicht mehr im LAVT Gewässerverzeichnis)

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stau Ruttersdorf', 50.858267, 11.726364, 'Thueringen', 'Stausee',
 '["Aal", "Barsch", "Hecht", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 3.8, NULL,
 '[]', false,
 'Anfahrt: Über die L1077, in Stadtroda in Richtung Bahnhof und weiter in Richtung Ruttersdorf, 1 km vor Ruttersdorf in Richtung Lotschen links abbiegen. Besonderheiten: Angeln in Schilfzonen sowie das Befahren des Mönchgeländes und der Wiese südlich vom Gewässer sind verboten. Fischarten: Aal,...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Saale', 50.904125, 11.732191, 'Thueringen', 'Fluss',
 '[]',
 '', NULL, 65.5, NULL,
 '[]', false,
 'Anfahrt: Über B 88 und öffentliche Wege der Stadt Jena. Angelbereich: Stadtgebiet Jena, von 600 m oberhalb der Saalebrücke Maua bis zum Erdengraben in der Gemarkung Neuengönna/Dorndorf. Dieser kr euzt die B88 in einer S-Kurve bei Neuengönna. Schongebiete im Bereich Wehr Stadtrodaer Straße und...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Speicher Römhild', 50.392758, 10.567828, 'Thueringen', 'Talsperre',
 '["Zander"]',
 'Schonzeit Zander: 01.02. - 31.05.', NULL, 5.2, NULL,
 '[]', false,
 'Der Speicher, ein interessantes Angelgewässer mit einem guten Fischbestand, befindet sich am westlichen Fuß des kleinen Gleichbergs. Die Anfahrt erfolgt über die Ortsverbindungsstraße Römhild – Hildburghausen. Ca. 1 km nach Römhild nach links vor der Siloanlage auf den Feldweg abbiegen. Das Parken...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Speicher Roth', 50.426623, 10.730011, 'Thueringen', 'Talsperre',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Zander"]',
 'Schonzeit Zander: 01.02. - 31.05.', NULL, 4.0, NULL,
 '[]', false,
 'Der Speicher liegt im Gleichberggebiet zwischen den Ortschaften Römhild - Zeilfeld -Roth Die Anfahrt erfolgt über die Ortsverbindungsstraße Römhild - Zeilfeld. Ca. 750 m nach dem Waldhaus in Richtung Hildburghausen rechts auf den Waldweg abbiegen. Dann ca. 750 m in einem Kreisverkehr das Auto...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Wechmar', 50.891604, 10.777913, 'Thueringen', 'Talsperre',
 '["Aal", "Bachforelle", "Barsch", "Gründling", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 39.0, NULL,
 '[]', false,
 'Sehr idyllisch gelegenes Gewässer im Osten des Gemeindegebietes von Wechmar im Landkreis Gotha. Anfahrt: L 1045 in Richtung Wechmar fahren. Unmittelbar vor dem Ortseingang rechts auf den Wirtschaftsweg abbiegen und diesen bis zur Talsperre folgen. Alternativ: Von Wandersleben nach Wechmar kommend,...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neu. – Luhneteiche', 51.258813, 10.311029, 'Thueringen', 'Teich',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 'Diese Teiche sind durch einen Naturdamm geteilt und liegen am Rande eines ruhigen Waldgebiets. Anfahrt: Diese Gewässer sind von Büttstedt (PLZ 37359) in Richtung Küllstedt (PLZ 37359) über die Bahnhofstraße fahrend zu erreichen. Dazu fahren Sie ca. 500 m nach Ortsausgang Büttstedt rechts auf einen...')
ON CONFLICT (name, bundesland) DO NOTHING;

-- Nr. 79 Neu.- Seeloch Gernrode: Entfernt (nicht mehr im LAVT Gewässerverzeichnis)

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Apfelstädt', 50.866360, 10.736093, 'Thueringen', 'Fluss',
 '["Äsche"]',
 '', NULL, 17.0, NULL,
 '[]', false,
 'Beginn von Flurgrenze Gemarkungsgrenze Wechmar/Wandersleben, Einmündung Schmallgraben bis Mündung Gera bei Mariental. Einst ein attraktives Salmonidenge- wässer im Nahbereich von Erfurt. Auf Grund eines fragwürdigen Wassermanagements des Freistaates Thüringen und zu geringer Niederschläge in den...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gera, Gemarkung Plaue, Dosdorf und Siegelbach', 50.777649, 10.898091, 'Thueringen', 'Fluss',
 '[]',
 '', NULL, 4.5, NULL,
 '[]', false,
 'Die Angelstrecke beginnt am Zusammenlauf der Wilden und Zahmen Gera, an der Uferstraße in Plaue. Erreichbar über B4 an der Brücke gegenüber Einkaufszentrum, in Dosdorf über die Straße zur Rindermastanlage und in Siegelbach an der Straßenbrücke am Ortseingang.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gera, Gemarkung Arnstadt', 50.801327, 10.955632, 'Thueringen', 'Fluss',
 '["Bachforelle"]',
 '', NULL, 4.32, NULL,
 '[]', false,
 'Die Angelstrecke schließt sich nahtlos an die Gewässerstrecke Nr. 131 an. Sie endet an der Gemarkungsgrenze Arnstadt - Rudisleben. Im gesamten Stadtgebiet von Arnstadt ist sie gut zugänglich. Beide Gewässerstrecken der Gera (Nr. 131 und 132) sind attraktive Salmonidengewässer mit einem guten...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gera Gemarkung Molsdorf', 50.904433, 10.960882, 'Thueringen', 'Fluss',
 '[]',
 '', NULL, 8.4, NULL,
 '[]', false,
 'Von der Gemarkung Eischleben (ca. 1,5 km von der Autobahnbrücke Molsdorf in Richtung Eischleben) flussabwärts bis Mariental, kurz hinter der Ei nmündung der Apfelstädt in die Gera.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gera/Flutgraben Gemarkung Erfurt einschließl. der innerstädtischen Gewässer: Bergstrom, Walkstrom, Breitstrom u. schmale Gera', 50.977797, 11.028736, 'Thueringen', 'Kanal',
 '[]',
 '', NULL, 24.0, NULL,
 '[]', false,
 'km, ca. 24 ha Von Papierwehr Erfurt (Dreienbrunnenbad) flussabwärts bis zur Brücke Straße der Nationen. Flugangelstrecken: 1. Die innerstädtischen Gewässer Bergstrom, Walkstrom, Breitstrom und schmale Gera 2. Gera/Flutgraben von Papierwehr bis Wehr Talbrücke In diesen Gewässern/Gewässerabschnitten...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Linderbach von Gemarkung Linderbach bis Einmündung', 50.978980, 11.100599, 'Thueringen', 'Fluss',
 '[]',
 '', NULL, 2.8, NULL,
 '[]', false,
 'in die Gramme bei Kleinmölsen • 7 km, ca. 2,8 ha')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ilm Gemarkung Kranichfeld/Bad Berka', 50.852652, 11.199890, 'Thueringen', 'See',
 '[]',
 '', NULL, 4.5, NULL,
 '[]', false,
 'Von Flurgrenze Kranichfeld (Einlauf Haubach oberhalb Tannroda) flussabwärts bis Flurgrenze Bad Berka unterhalb Wehr München. Ortslage Dienstedt (ca. 100 m unterhalb Klunkermühle bis Einlauf Mettbach Ortsausgang Dienstedt)')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ilm von Gemarkung Weimar, 400 m oberhalb des Ortsschildes', 50.979330, 11.329792, 'Thueringen', 'Fluss',
 '["Äsche"]',
 '', NULL, 12.0, NULL,
 '[]', false,
 'Weimar an der Taubacher Straße der oberen Pachtgrenze flussabwärts in Richtung Weimar, Tiefurt, Kromsdorf bis 2. Brücke Denstedt • 12,7 km, ca. 12 ha Die gesamte Pachtstrecke darf mit der Flugangel beangelt werden. Spinnangeln nur in den nachfolgend genannten Gewässerabschnitten erlaubt: - von...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ilm Gemarkung Denstedt', 51.017154, 11.426495, 'Thueringen', 'Fluss',
 '["Äsche"]',
 '', NULL, 4.6, NULL,
 '[]', false,
 'Beginn 2. Brücke Denstedt in Richtung Linkershof bis Brücke Ulrichshalben, Richtung Oßmannstedt. Guter Bestand an Äschen. Flugangelstrecke ab Brücke Denstedt bis ehemals „offener Stall“ Oßmannstedt. Spinn- und Flugangelstrecke ab ehemals „offener Stall“ Oßmannstedt bis 50 m oberhalb der Brücke...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ilm Gemarkung Niederroßla/Zottelstedt', 51.037040, 11.475478, 'Thueringen', 'Fluss',
 '["Bachforelle"]',
 '', NULL, 0.9, NULL,
 '[]', false,
 'Spinn- und Flugangelstrecke 500 m oberhalb vom Wehr Zottelstedt Sportplatz in Richtung Niederroßla flussaufwärts. Zufahrt über die B87, BP Tankstelle Apolda, Abzweig Zottelstedt. Guter Bestand an Bachforellen. Wichtig: Bitte die Ausschilderung beachten. Zugang zum Gewässer über das...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schnauder, Gemarkung Meuselwitz', 51.047500, 12.297500, 'Thueringen', 'Fluss',
 '["Bachforelle", "Barsch", "Döbel", "Gründling", "Hasel", "Hecht", "Plötze"]',
 '', NULL, 3.05, NULL,
 '[]', false,
 'Die Spinn- und Flugangelstrecke beginnt aus Richtung Zeitz kommend ca. 1 km nach der Ausfahrt Oelsen der B180 (rechts abbiegend in Kopfsteinpflasterweg), geht durch das gesamte Stadtgebiet von Meuselwitz und endet ca. 800 m nach der Schnauderbrücke Heukendorfer Weg im Stadtteil...')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hörsel, Gemarkung Eisenach Wutha bis Straßenbrücke Schönau', 50.974713, 10.319356, 'Thueringen', 'Fluss',
 '["Bachforelle"]',
 '', NULL, 4.0, NULL,
 '[]', false,
 'Ein attraktives Fließgewässer mit einem guten Bestand an Bachforellen. Die Gewässerstrecke beginnt in Höhe des Kreisverkehrs zur Autobahn A4 vor Wutha und endet an der Straßenbrücke Schönau. Beachte: Der in Wutha einmündende Bach „Erbstrom“ ist ein Aufzuchtgewässer und darf nicht beangelt werden.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stau Fuchsgrund', 50.974713, 10.319356, 'Thueringen', 'Stausee',
 '["Bachforelle"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 'Der Fuchsgrund, welcher durch zwei Waldbäche gespeist wird, beherbergt auf Grund seines sauberen, kühlen Wassers vor allem Bachforellen. Bitte beachten: Das Angeln ist erst ab 1. Mai erlaubt! Zu erreichen von Eisenach oder Erfurt kommend über die L3007 (ehemals B7) bis Ortsmitte Wutha - Farnroda....')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neu. - Unstrut', 51.234721, 11.112729, 'Thueringen', 'Fluss',
 '["Bachforelle"]',
 '', NULL, NULL, NULL,
 '[]', false,
 'Dieses Fließgewässer zeichnet sich durch viele kleine Kolke aus. In dem Gewässerabschnitt befinden sich auch mehrere Wehre. Bitte die Ausschilderung beachten! Wichtiger Hinweis! - Es handelt sich um ein Fließgewässer der EU-Kategorie 1. Vor Beginn des Angelns müssen sämtliche Gerätschaften, Stiefel...')
ON CONFLICT (name, bundesland) DO NOTHING;

-- ── Saalekaskade (Nr. 201-206) — Nur auf lavt.de, nicht im PDF ──────

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bleilochstausee', 50.471021, 11.701825, 'Thueringen', 'Talsperre',
 '["Aal", "Barsch", "Blei", "Döbel", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Ukelei", "Wels", "Zander"]',
 'Bootsangeln teilweise erlaubt', NULL, 920.0, NULL,
 '[]', false,
 'Größter Stausee Deutschlands an der oberen Saale. Teil der Saalekaskade. Teilweise Bootsangeln erlaubt, Einschränkungen in Teilbereichen beachten.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ausgleichbecken Burgkhammer', 50.549864, 11.719340, 'Thueringen', 'Stausee',
 '["Bachforelle", "Barsch", "Plötze", "Regenbogenforelle"]',
 'Angeln nur 01.04.-30.09.; nur Spinn- und Flugangeln; nur Kunstköder', NULL, 78.0, NULL,
 '[]', false,
 'Ausgleichbecken der Saalekaskade zwischen Bleilochstausee und Talsperre Walsburg. Angeln ausschließlich mit Kunstködern (Spinn- oder Flugangel) vom 1. April bis 30. September.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Walsburg', 50.578904, 11.677039, 'Thueringen', 'Talsperre',
 '["Bachforelle", "Barsch", "Plötze", "Regenbogenforelle"]',
 'Angeln nur 01.04.-30.09.; nur Spinn- und Flugangeln; nur Kunstköder', NULL, NULL, NULL,
 '[]', false,
 'Talsperre der Saalekaskade bei Walsburg. Angeln ausschließlich mit Kunstködern (Spinn- oder Flugangel) vom 1. April bis 30. September.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wisentastausee Grochwitz', 50.569635, 11.728611, 'Thueringen', 'Stausee',
 '["Aal", "Barsch", "Blei", "Döbel", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 28.0, NULL,
 '[]', false,
 'Stausee der Saalekaskade bei Grochwitz. Ca. 2.400 m lang, durchschnittlich 116 m breit. Guter Bestand an Zander, Hecht, Karpfen und weiteren Arten.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hohenwartetalsperre', 50.614014, 11.492125, 'Thueringen', 'Talsperre',
 '["Aal", "Bachforelle", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Wels", "Zander"]',
 'Flugangelstrecke ab Ziegenrück', NULL, 730.0, NULL,
 '[]', false,
 'Zweitgrößte Talsperre der Saalekaskade. Vielfältiger Fischbestand mit Zander, Hecht, Karpfen, Wels und weiteren Arten. Flugangelzone ab Ziegenrück.')
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ausgleichbecken Eichicht', 50.611439, 11.435240, 'Thueringen', 'Stausee',
 '["Bachforelle", "Barsch", "Plötze"]',
 'Angeln nur 01.04.-30.09.; nur Spinn- und Flugangeln; nur Kunstköder', NULL, 71.0, NULL,
 '[]', false,
 'Ausgleichbecken der Saalekaskade zwischen Hohenwartetalsperre und Eichicht. Ca. 4.300 m lang, durchschnittlich 165 m breit. Angeln ausschließlich mit Kunstködern (Spinn- oder Flugangel) vom 1. April bis 30. September.')
ON CONFLICT (name, bundesland) DO NOTHING;

-- ============================================================
-- Sachsen-Anhalt: LAV SA Gewässerverzeichnis 2022
-- Quelle: lav-sachsen-anhalt.de/PDF/Gewaesserwirtschaft/Gewaesserverzeichnis_2022.pdf
-- Pipeline: import_lav_sa_pdf.py → geocode_sa.py → csv_to_seed.py
-- ============================================================

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Brüders Teich bei Gardelegen', 52.526943, 11.392738, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.53, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wasserspeicher Lüffingen', 52.577987, 11.417079, 'Sachsen-Anhalt', 'Talsperre',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.36, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kieskuhle (Die lange Wohrde) bei Gardelegen', 52.526943, 11.392738, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stadtgraben in Gardelegen', 52.526943, 11.392738, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 1.63, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lindenthaler Teich bei Gardelegen', 52.526943, 11.392738, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wilhelmskanal von Straße Taterberg-Miesterhorst bis Mündung in die Ohre', 52.625577, 11.154891, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rötzen´s Loch bei Breiteiche', 52.449662, 11.226834, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiessee Gäde bei Solpke', 52.504508, 11.287456, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Karpfen", "Schleie", "Zander"]',
 'Anfüttern verboten!', NULL, 7.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('5 Teiche am Ipser Weg', 52.500893, 11.383617, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.31, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mahlbusen-Heidberg bei Estedt', 52.575911, 11.361664, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.38, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Försterteich bei Jerchel', 52.468499, 11.321462, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.36, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Milde von Gardelegen- Isenschnibbe bis Kalbe', 52.526943, 11.392738, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 11.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Blechbudenteich bei Mieste/Breiteiche', 52.446833, 11.216048, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.85, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich „Faule Breite“ bei Letzlingen', 52.448037, 11.485260, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Wernitz', 52.485546, 11.232053, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Wels", "Zander"]',
 'Anfüttern verboten!', NULL, 9.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Secantsgraben von Str.-Br. Kalbe/M. – Neuendorf a. D. bis Mündung in die Milde', 52.626329, 11.152032, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Hecht"]',
 '', NULL, 3.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Grube Minna bei Kassieck', 52.585771, 11.485487, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen"]',
 '', NULL, 0.65, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich am Anglerheim (Burggraben)         A, B, H, K, Pl, Ro, in Kalbe/M.                              S, Z', 51.773972, 10.797270, 'Sachsen-Anhalt', 'Teich',
 '[]',
 '', NULL, 2.31, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Milde von Kalbe (Straßenbrücke)          A, B, Bl, D, H, PL, bis Eimündung des Secantsgraben          Ro, S 4', 52.656200, 11.387175, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 8.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Untere Milde von Winkelstedt             A, B, Bl, D, H, Pl, bis Brücke Kahrstedt-Karritz             Ro, S', 52.679419, 11.310889, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 8.22, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Miesterhorst', 52.460160, 11.141772, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen"]',
 '', NULL, 0.05, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Anglerteiche Apenburg', 52.710955, 11.205386, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 7.83, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Prozeßbusch in Dannefeld', 52.506066, 11.141201, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.36, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sauergrund bei Dannefeld', 52.506066, 11.141201, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Schleie"]',
 '', NULL, 0.17, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Beregnungsteich bei Lockstedt', 52.664860, 11.203427, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neues Gewässer in Klötze', 52.627646, 11.165058, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 'Anfüttern verboten!', NULL, 2.26, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich am ehemaligen Agrarflugplatz bei Lockstedt', 52.664860, 11.203427, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Jeetze von Dorfstraße im Amt Dambeck bis Landesgrenze', 52.843206, 11.121371, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Hasel", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 23.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Badeanstalt bei Jahrstedt', 52.560416, 10.975275, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.16, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Steimke', 52.588068, 10.966513, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.09, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ohre in Steimke', 52.588068, 10.966513, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 3.02, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ohre in Jahrstedt', 52.560416, 10.975275, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.82, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('ehemalige Klärteiche in Kusey', 52.582366, 11.096554, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.98, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Dannefeld', 52.506066, 11.141201, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze"]',
 '', NULL, 0.38, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Moorgraben Cheinitz/Brüchau', 52.696877, 11.240671, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Plötze", "Rotfeder"]',
 '', NULL, 2.41, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Plattensee bei Winterfeld', 52.739304, 11.244909, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 'Boote ohne Motor/max 0,5 l Futter je Tag', NULL, 1.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pfefferteich bei Salzwedel', 52.852846, 11.153970, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 'Boote ohne Motor/max 0,5 l Futter je Tag', NULL, 1.66, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('1. Tonstich in den Beekwiesen bei Salzwedel - max 0,5 l Futter je Tag', 52.852846, 11.153970, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 1.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Brietzer Teiche', 52.868280, 11.099876, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 'Boote ohne Motor/max 0,5 l Futter je Tag', NULL, 4.29, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Langenapel max 0,5 l Futter je Tag', 52.816875, 10.967169, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.09, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Blaukuhlen in Fleetmark 5', 52.795695, 11.387050, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 'Boote ohne Motor/max 0,5 l Futter je Tag', NULL, 7.52, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Salzwedeler Dumme von Bödden- stedter Mühle b. Mündung in die Jeetze', 52.815561, 10.977840, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 'Boote ohne Motor', NULL, 5.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tonstich (Seibtscher Teich) in Hoyersburg max 0,5 l Futter je Tag', 52.886271, 11.172454, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 1.81, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Purnitz bei Dambeck', 52.802581, 11.154839, 'Sachsen-Anhalt', 'Fluss',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.23, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Jeetze bei Dambeck', 52.802581, 11.154839, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 'Boote ohne Motor', NULL, 1.58, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Dumme Osterwohle/Tylsen', 52.823640, 11.030272, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.78, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Beeke bei Wallstawe bis Mündung in die Dumme', 52.796660, 11.018203, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Bachforelle", "Regenbogenforelle"]',
 '', NULL, 1.32, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kalter Graben bei Wallstawe bis Mündung in die Dumme', 52.796660, 11.018203, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Bachforelle", "Regenbogenforelle"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Molmker Bach von Schinkenmühle/Diesdorf bis Peckensen', 52.752236, 10.919512, 'Sachsen-Anhalt', 'See',
 '["Aal", "Bachforelle", "Regenbogenforelle"]',
 '', NULL, 3.92, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Flöt- und Mühlgraben bei Mechau 6 Landkreis Stendal', 52.871466, 11.348441, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 3.11, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kolk in Bismark', 52.644396, 11.625105, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Plötze"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Secantsgraben von Straßenbrücke Lindstedt/Holzhausen bis Straßenbrücke Kalbe/Neuendorf am Damm', 52.617703, 12.098707, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 6.92, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner See bei Schönfeld', 52.726608, 12.060821, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.61, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner Klietzer See', 52.670205, 12.059135, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 10.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gewässer vor dem Weiher in Sandau', 52.789070, 12.048005, 'Sachsen-Anhalt', 'See',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wenddorfteich in Sandau', 52.789070, 12.048005, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 0.38, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Eichenschlenke bei Havelberg             A, B, H, K,', 52.825043, 12.074193, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 1.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kampierung bei Havelberg', 52.825043, 12.074193, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Große Wiesenschlenke bei Havelberg', 52.825043, 12.074193, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Güster", "Hecht", "Plötze"]',
 '', NULL, 1.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hornings Bracke bei Havelberg', 52.825043, 12.074193, 'Sachsen-Anhalt', 'Fluss',
 '["Blei", "Güster", "Hecht", "Plötze"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kühnsches Loch bei Havelberg', 52.825043, 12.074193, 'Sachsen-Anhalt', 'See',
 '["Aal", "Güster", "Hecht", "Plötze"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Karpfenlöcher bei Havelberg 2–220-16 Müllerhafen bei Sandau                   A, B, Bl, H, Pl, Z   10,00', 52.825043, 12.074193, 'Sachsen-Anhalt', 'Fluss',
 '["Blei", "Güster", "Hecht", "Plötze"]',
 '', NULL, 0.35, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe km 428-431 rechtsseitig 2–220-19 Großer Schönfelder See                   A, B, Bl, Gü, H,     17, 71', 52.861230, 11.982205, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Wels", "Zander"]',
 '', NULL, 18.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Garzer See in Havelberg', 52.825043, 12.074193, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Weidenwerder bei Losenrade', 52.966539, 11.765354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'LSG „Elbe-Aland“ beachten!', NULL, 4.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Streitwerder bei Losenrade', 52.966539, 11.765354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'LSG „Elbe-Aland“ beachten!', NULL, 11.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kuhweide bei Losenrade', 52.966539, 11.765354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'LSG „Elbe-Aland“ beachten!', NULL, 0.63, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Die Benähen bei Losenrade', 52.966539, 11.765354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'LSG „Elbe-Aland“ beachten!', NULL, 0.12, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Das Heisterrevier bei Losenrade', 52.966539, 11.765354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'LSG „Elbe-Aland“ beachten!', NULL, 0.91, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neuer Werder bei Losenrade', 52.966539, 11.765354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'LSG „Elbe-Aland“ beachten!', NULL, 0.82, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Werder bei Losenrade', 52.966539, 11.765354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'LSG „Elbe-Aland“ beachten!', NULL, 0.63, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe von km 428 - 454 linksseitig        A, Bl, H, Pl, R,', 52.861230, 11.982205, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 'Uferbetretungsverbot km 450,9 -452       W, Q, Z', NULL, 479.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gewässer Feldneuendorf bei Seehausen', 52.889184, 11.752083, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Flachspuhl bei Erxleben', 52.750000, 11.766700, 'Sachsen-Anhalt', 'See',
 '["Karpfen"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Uchte von Einmündung des Land- grabens bis Kämereigraben bei Düsedau', 52.763994, 11.794164, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 14.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mittelsbruch bei Losenrade', 52.966539, 11.765354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'LSG „Elbe-Aland“ beachten!', NULL, 2.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Eisenbahnerbruch bei Losenrade', 52.966539, 11.765354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'LSG „Elbe-Aland“ beachten!', NULL, 3.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Der Haken am Hausberg bei', 51.524489, 11.235777, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 'Losenrade - LSG „Elbe-Aland“ beachten!', NULL, 1.86, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Blauer See Sandauerholz', 52.807841, 11.985542, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 2.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Milde/Biese von Einmündung des           A, B, Bl, H, Secantsgrabens (bei Butterhorst) bis     Gü, K, Pl, S Einmündung des Augrabens (bei Gladigau)', 52.679927, 11.454687, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 13.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bleichwehl bei Werben/Elbe', 52.861230, 11.982205, 'Sachsen-Anhalt', 'Fluss',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Marschners Loch bei Werben/Elbe', 52.861230, 11.982205, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barbe", "Blei", "Hecht", "Plötze", "Schleie", "Zander"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wasserkuhle Langes Loch bei Werben/Elbe', 52.861230, 11.982205, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barbe", "Blei", "Hecht", "Plötze", "Schleie", "Zander"]',
 '', NULL, 1.35, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Schwimmbad bei Wendemark', 52.859824, 11.926360, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Völkes Löcher in Räbel', 52.838496, 12.018272, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barbe", "Blei", "Hecht", "Plötze", "Schleie", "Zander"]',
 '', NULL, 3.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Köhnsee Kläden 8', 52.638329, 11.648323, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 2.91, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schlüdenlanke (Elbnebengewässer) in Arneburg', 52.674454, 12.003502, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Zander"]',
 '', NULL, 6.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schwanenteich in Stendal', 52.605078, 11.859428, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stadtsee in Stendal', 52.605078, 11.859428, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Zander"]',
 '', NULL, 9.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Schernikau', 52.638021, 11.766170, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe km 392 - 402 linksseitig            A, B, Bl, H, Pl,', 52.861230, 11.982205, 'Sachsen-Anhalt', 'Fluss',
 '["Rapfen", "Wels", "Zander"]',
 '', NULL, 105.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Uchte von Straße Tornau- Döbbelin bis Einmündung Landgraben', 52.595948, 11.873138, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 7.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fieber in Stendal', 52.605078, 11.859428, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbnebengewässer bei Hämerten            A, B, Bl, H, Pl,', 52.589669, 11.987517, 'Sachsen-Anhalt', 'See',
 '["Rapfen", "Wels", "Zander"]',
 '', NULL, 2.28, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bauernwiehl bei Fischbeck', 52.540015, 12.015767, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.47, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dollgraben', 52.437759, 11.762484, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.68, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßteich Briest', 52.437764, 11.842715, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gr. und Kl. Parkteich in Tangerhütte', 52.434216, 11.806105, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich in Klein Schwarzlosen', 52.709206, 11.833717, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lehmkuhle in Cobbel', 52.394277, 11.860290, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kreutzkolk in Uetz', 52.365458, 11.846552, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe km 372, 4 – km 378 linksseitig      A, B, Bl, H, Pl,', 52.861230, 11.982205, 'Sachsen-Anhalt', 'Fluss',
 '["Rapfen", "Wels", "Zander"]',
 '', NULL, 49.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fichtenwiehl bei Fischbeck', 52.540015, 12.015767, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 4.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Altes Kiesloch bei Tangermünde', 52.543110, 11.972252, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 6.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neues Kiesloch bei Tangermünde', 52.543110, 11.972252, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 7.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hartsteinwerke bei Tangermünde', 52.543110, 11.972252, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 6.66, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tankstellenloch bei Fischbeck', 52.540015, 12.015767, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.34, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Junkerwiehl bei Fischbeck', 52.540015, 12.015767, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 10.03, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe km 386-392 beidseitig, km 391-392   A, B, Bl, H, Pl,', 52.861230, 11.982205, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 'rechtsseitig Uferbetretungsverbot        R, S, Q, W, Z', NULL, 126.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bölsdorfer Tanger', 52.517646, 11.937435, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Trollsee bei Bölsdorf', 52.507369, 11.925647, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen"]',
 '', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Glüming in Grieben', 52.435629, 11.957822, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner Glüming in Grieben', 52.435629, 11.957822, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Jaeneckes Teiche bei Stendal        A, B, Bl, H, K, Pl, 10 Landkreis Börde', 52.605078, 11.859428, 'Sachsen-Anhalt', 'Teich',
 '["Schleie", "Zander"]',
 '', NULL, 14.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sieben-Insel-Teich in Flechtingen', 52.332141, 11.239453, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Holzmühlenteich in Flechtingen', 52.332141, 11.239453, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 3.26, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßteich in Flechtingen', 52.332141, 11.239453, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 10.48, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich in Nordgermersleben', 52.200175, 11.341948, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlenteich Bodendorf bei Süplingen', 52.293279, 11.312264, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Nachtwiese bei Bebertal', 52.242058, 11.345878, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.54, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Haidteich bei Bebertal', 52.242058, 11.345878, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ehemalige Schweineweide bei Oebisfelde', 52.429497, 10.987264, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.18, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neuer Teich in Bebertal', 52.242058, 11.345878, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 3.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Königsee bei Bebertal', 52.242058, 11.345878, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.48, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('1. Teich des Doppelstaubeckens am Mammendorfer Weg', 52.159351, 11.412498, 'Sachsen-Anhalt', 'Stausee',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gutsteich Kleinsantersleben bei Schackensleben', 52.201504, 11.422913, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gutsteich Brumby (2 Teile) bei Nordgermersleben', 52.200175, 11.341948, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hörsinger Spitze bei Hörsingen', 52.285064, 11.155618, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schäferteich bei Hörsingen', 52.285064, 11.155618, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.18, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tongrube bei Ivenrode', 52.273267, 11.231583, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Heckenrosensteinbruch (Polkenbruch) bei Altenhausen', 52.262253, 11.253542, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wiemeckenbruch bei Belsdorf', 52.349899, 11.155213, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.34, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Speicher an der Speetze bei Everingen', 52.367840, 11.100177, 'Sachsen-Anhalt', 'Talsperre',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wegenstedter Teich bei Calvörde', 52.394873, 11.296916, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ohre von Straßenbrücke Calvörde       A, B, Bl, H, K, bis Vahlsdorfer Brücke                Ad, D, Q, S', 52.479630, 11.003108, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 22.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('3 Teiche Rosenhagen bei Erxleben', 52.219441, 11.242522, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schafbade bei Erxleben', 52.219441, 11.242522, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Törner See bei Bülstringen', 52.320037, 11.347778, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Silbersee bei Calvörde', 52.394873, 11.296916, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Aller von BAB 2 bis Landesgrenze Niedersachsen bei Saaldorf', 52.101744, 11.234519, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Hecht", "Karpfen"]',
 '', NULL, 7.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Beber von Einmündung der Rie bis zur Mündung in die Ohre', 52.239141, 11.341261, 'Sachsen-Anhalt', 'Fluss',
 '["Döbel", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 3.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wanneweh von Einmündung des Brückengrabens bis zur Mündung in die Ohre', 52.436778, 11.402202, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Markgrafenteich bei Bebertal', 52.242058, 11.345878, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Papenteich bei Emden', 52.265427, 11.286946, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 6.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich am Siekweg in Rottmersleben', 52.210759, 11.398601, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.11, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Regenrückhaltebecken in Hermsdorf', 52.183305, 11.483294, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 8.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Speicher am Butterberg Breggenstedt/Ivenrode', 52.265265, 11.212847, 'Sachsen-Anhalt', 'Talsperre',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 1.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Waldsteinbruch Hundisburg', 52.257141, 11.406873, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Rätzlingen', 52.413131, 11.110778, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.87, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Ivenrode', 52.273267, 11.231583, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Schleie", "Zander"]',
 '', NULL, 0.37, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Oberteich in Uhrsleben', 52.199168, 11.264416, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.16, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich Hasselburg', 52.325466, 11.266632, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Aller westlich von Everingen', 52.367840, 11.100177, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Blei", "Döbel", "Güster", "Hecht", "Plötze"]',
 '', NULL, 6.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich in Breitenrode', 52.473873, 10.962130, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlaller mit Regenauffangbecken bei Oebisfelde', 52.429497, 10.987264, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 2.26, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Landgraben bei Oebisfelde', 52.429497, 10.987264, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 1.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schillingsteich in Niendorf', 52.442326, 11.066600, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Regenwasserbecken hinter der BEFA bei Oebisfelde', 52.429497, 10.987264, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Badekuhle in Wassensdorf', 52.457513, 11.003471, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesschacht in Kroppenstedt 12', 51.941665, 11.308517, 'Sachsen-Anhalt', 'See',
 '["Blei", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 3.24, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteiche in Ampfurth', 52.062432, 11.313111, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Priesterteich in Eggenstedt', 52.104325, 11.231482, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlenteich in Schermcke', 52.055837, 11.289921, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.9, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bode von Einmündung des Mühl- grabens an der Bodebrücke Hadmers- leben bis Wehr Egeln-Nord (Oberwasser)', 52.026653, 11.227781, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Blei", "Güster", "Hecht", "Plötze"]',
 '', NULL, 16.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fabrikenteich in Seehausen', 52.101206, 11.293939, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Über der Olbe-Baggergelände bei Druxberge', 52.157882, 11.301977, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Ovelgünne', 52.144262, 11.272589, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.54, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Runder Teich in Siegersleben', 52.132996, 11.259952, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.06, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Parkteich Meyendorf', 52.088215, 11.331152, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.61, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Das Grundlos bei Heynburg', 51.940090, 11.253473, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '(Teilfläche) Privatgelände beachten!', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Beregnungsspeicherbecken bei Drackenstedt', 52.151357, 11.348632, 'Sachsen-Anhalt', 'Talsperre',
 '["Aal", "Karpfen", "Zander"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Umkehr bei Wanzleben', 52.075851, 11.420522, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.65, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Hemsdorf', 52.137500, 11.395725, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.81, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Altes Bad in Hötensleben', 52.120652, 11.020200, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.63, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Stemmern', 51.996759, 11.571742, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.48, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rahl Hötensleben', 52.119154, 11.044345, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tonkuhle bei Altenweddingen             A, B, Bl, Gü, H, K,', 51.991099, 11.516349, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 4.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Karpfenteich Krottorf', 51.970760, 11.178195, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ententeich Barleben', 52.198609, 11.626645, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Güster", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Moortalsee bei Zielitz/Farsleben        A, B, Bl, Gü, H, K,', 52.292582, 11.669342, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Schleie"]',
 '', NULL, 3.77, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Kiesgrube (Rabe) bei Groß Ammensleben', 52.191766, 11.458146, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.88, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mittellandkanal Bereich Wolmirstedt Kanalkarte erforderlich 3 -470-07 2 Tonlöcher in Elbeu bei Wolmirstedt   A, B, Bl, Gü, K, Pl,        9,66', 52.237194, 11.618504, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 73.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Zielitzer See', 52.287548, 11.684934, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Kiesbagger bei Wolmirstedt', 52.248492, 11.626739, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Güster", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.02, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Döbberitz bei Glindenberg', 52.235145, 11.685287, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.01, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinkolk bei Glindenberg', 52.235145, 11.685287, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.96, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Specklacke bei Glindenberg', 52.235145, 11.685287, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.35, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ohre von Vahldorfer Brücke bis          A, B, Bl, Gü, H, K, Ortsgrenze Wolmirstedt                  Pl, Ro, S, Z', 52.234437, 11.495626, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 18.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Braunschweiger Loch (Kiesgrube)         A, B, Bl, Gü, H, K, bei Glindenberg                         Pl, S, Z', 52.235145, 11.685287, 'Sachsen-Anhalt', 'See',
 '[]',
 '', NULL, 14.04, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kläne bei Glindenberg', 52.235145, 11.685287, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 2.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Daukuhle bei Samswegen', 52.272210, 11.575914, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karausche", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 1.61, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Dahlenwarsleben', 52.191011, 11.564833, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.43, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('See im Technologiepark Ostfalen bei Barleben', 52.200738, 11.620358, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ohre von Wolmirstedt bis Elbmündung     A, B, Bl, Gü, H, K,', 52.248492, 11.626739, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 'Beachte NSG „Rogätzer Hang“             Pl, Ro, S, Z', NULL, 17.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mittellandkanal km 320, 10 – 321, 10    A, B, Bl, Gü, H, K,', 52.377080, 11.314687, 'Sachsen-Anhalt', 'Kanal',
 '[]',
 'nur nordseitig                          Pl, S, Z', NULL, 10.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unterholz und Haken bei Rogätz', 52.317632, 11.768400, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 'Beachte NSG „Rogätzer Hang“', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pfennigsee bei Farsleben                A, Bl, Gü, H, K,', 52.277292, 11.653115, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.31, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner Kiesbagger bei Wolmirstedt      A, Bl, Gü, H, K, Pl,', 52.248492, 11.626739, 'Sachsen-Anhalt', 'See',
 '["Rotfeder", "Schleie"]',
 '', NULL, 1.96, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Küchenhorn bei Wolmirstedt              A, B, Bl, Gü, H, K,', 52.248492, 11.626739, 'Sachsen-Anhalt', 'See',
 '[]',
 'LSG beachten                            Pl, S', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Zollau bei Glindenberg                  A, B, Bl, Gü, H, K,', 52.235145, 11.685287, 'Sachsen-Anhalt', 'See',
 '[]',
 'LSG beachten                            Pl, Ro, S, Z', NULL, 4.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Hohenwarsleben', 52.177522, 11.502011, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karausche", "Plötze", "Rotfeder"]',
 '', NULL, 0.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Nördliches Entlastungsgerinne am Wasserstraßenkreuz bei Glindenberg 14', 52.229526, 11.688717, 'Sachsen-Anhalt', 'See',
 '["Blei", "Güster", "Plötze", "Rotfeder"]',
 'LSG beachten', NULL, 7.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Biotop am Anger', 52.276358, 11.736414, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Schleie"]',
 '', NULL, 0.36, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('An der Tränke Ochtmersleben 15 Landkreis Jerichower Land', 52.155206, 11.409831, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Schleie"]',
 '', NULL, 0.15, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Elbe Lostau', 52.171619, 11.702020, 'Sachsen-Anhalt', 'Stausee',
 '["Aal", "Blei", "Hecht", "Karpfen"]',
 'Angelverbot Westseite beachten!', NULL, 39.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ihle von Brücke BAB 2 bis Mündung', 52.396274, 12.283729, 'Sachsen-Anhalt', 'Fluss',
 '["Blei", "Plötze", "Regenbogenforelle"]',
 'in den EHK (Salmostrecken beachten)', NULL, 6.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Niegripper See', 52.267322, 11.787916, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Zander"]',
 'Angeln im Vogelschutzgebiet verboten!; Angelverbot Badestrand 01.05. – 31.08.', NULL, 65.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fenn in Möser', 52.216370, 11.792546, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Plötze"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teiche bei Nedlitz', 52.128203, 11.829526, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Karpfen", "Schleie"]',
 '', NULL, 0.94, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Große Wehle bei Niegripp', 52.264729, 11.759136, 'Sachsen-Anhalt', 'See',
 '["Blei", "Karpfen", "Plötze"]',
 '', NULL, 1.19, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schweinekolk bei Niegripp', 52.264729, 11.759136, 'Sachsen-Anhalt', 'See',
 '["Blei", "Plötze"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Moorslake bei Schartau', 52.288200, 11.790337, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 5.65, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Katzenkolk bei Schartau', 52.288200, 11.790337, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dedens-Gewässer bei Lostau', 52.210721, 11.738623, 'Sachsen-Anhalt', 'Stausee',
 '["Blei", "Hecht", "Plötze"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe km 334-350 beidseitig', 52.379593, 12.012215, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Blei", "Hecht", "Plötze", "Wels", "Zander"]',
 '', NULL, 311.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ehle von Vehlitz bis Mündung in die Umflutehle', 52.106144, 11.878908, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Blei", "Hecht", "Plötze", "Zander"]',
 '', NULL, 6.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ehle vom Ablauf der Fischteiche Möckern-Lochow bis Vehlitz', 52.106144, 11.878908, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Plötze"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Feldschlößchenkolk in Burg', 52.270563, 11.858820, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßgewässer Ehleteich in Möckern', 52.140516, 11.953277, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Plötze", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Niegripper Verbindungskanal', 52.249456, 11.739500, 'Sachsen-Anhalt', 'Kanal',
 '["Barsch", "Blei", "Plötze", "Zander"]',
 'von km 0, 95 - 1, 60 nur Südufer', NULL, 1.54, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dunker-See Burg', 52.295362, 11.824107, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 2.98, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Elbe bei Niegripp', 52.264729, 11.759136, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Blei", "Hecht", "Plötze", "Zander"]',
 '', NULL, 3.86, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lehmkuhlengraben bei Parchen', 52.351650, 12.081162, 'Sachsen-Anhalt', 'Kanal',
 '["Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 1.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Zernau-See bei Mützel', 52.379103, 12.175312, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 6.67, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlengraben bei Mützel', 52.379103, 12.175312, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Blei", "Plötze"]',
 '', NULL, 0.22, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Brettiner Chaussee Ein-', 52.415911, 12.151843, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 'schränkungen (Beschilderung) beachten!', NULL, 2.24, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Roßdorfer Altkanal km 0, 0 bis          A, B, Bl, Gü, H, K, Brücke Dunkelforth (B1) am Nordufer     Pl, Ro, S, Z', 51.494331, 11.692656, 'Sachsen-Anhalt', 'Kanal',
 '[]',
 '', NULL, 14.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Zabakuck', 52.456541, 12.212604, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 'Angelordnung gemäß Aushang beachten!', NULL, 10.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe-Havel-Kanal von km 360 bis 364, 5 A, B, Bl, H, K, (Brücke B1 Ortsausgang Genthin) und     Pl, S, Z von km 365, 7 (Einmündung Neuer Graben) bis km 372, 8 Beachte Betriebsanlagenverordnung für Bundeswasserstraßen!', 52.407042, 12.076119, 'Sachsen-Anhalt', 'Kanal',
 '[]',
 '', NULL, 71.92, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Netzband bei Derben', 52.415185, 11.997378, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 3.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesschacht Wenzlau bei Derben', 52.415185, 11.997378, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Güster", "Hecht", "Plötze", "Rotfeder", "Zander"]',
 '', NULL, 1.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlenlanke-Herrenseegraben bei Parey', 52.379620, 11.986040, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Plötze", "Rotfeder"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube an der MTS in Parey', 52.379620, 11.986040, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 3.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Elbe mit Tunnel und Königsdamm bei Parey', 52.379620, 11.986040, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Badeteich bei Güsen', 52.342930, 11.979979, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Güster", "Karpfen"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Feuerlöschteich bei Ferchland', 52.439911, 12.002301, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Güster", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesloch Born bei Derben', 52.415185, 11.997378, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen"]',
 '', NULL, 1.44, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wulsch Kieslöcher bei Derben', 52.415185, 11.997378, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Güster", "Hecht", "Plötze", "Rotfeder", "Zander"]',
 '', NULL, 10.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte und Neue Kieslöcher bei Derben     A, B, Bl, Gü, H, Pl, 17', 52.415185, 11.997378, 'Sachsen-Anhalt', 'See',
 '["Rotfeder", "Zander"]',
 '', NULL, 40.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Baggerelbe bei Derben                    A, B, Bl, Gü, H, Pl,', 52.415185, 11.997378, 'Sachsen-Anhalt', 'Fluss',
 '["Rapfen", "Rotfeder", "Zander"]',
 '', NULL, 10.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stromelbe von km 372,4                   B, Bl, Gü, H, Pl, bis km 378 bei Derben rechtsseitg       R, W', 52.415185, 11.997378, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 49.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Waldmühlenlanke bei Parey', 52.379620, 11.986040, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pappelloch bei Parey', 52.379620, 11.986040, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wolfsloch 1 und 2 bei Parey', 52.379620, 11.986040, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Güster", "Hecht", "Plötze", "Rapfen"]',
 '', NULL, 1.41, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Erdegraben bei Parey', 52.379620, 11.986040, 'Sachsen-Anhalt', 'Kanal',
 '["Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 0.09, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hemslake bei Parey', 52.379620, 11.986040, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Güster", "Hecht", "Plötze", "Rapfen", "Zander"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Badingslanke bei Zerben', 52.357209, 11.951529, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Güster", "Hecht", "Plötze", "Rapfen", "Zander"]',
 '', NULL, 2.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lemmerweide bei Derben', 52.415185, 11.997378, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 0.24, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe-Havel-Kanal von km 344 bis km 353 Beachte Betriebsanlagenverordnung für Bundeswasserstraßen!', 52.407042, 12.076119, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Blei", "Karpfen", "Plötze", "Zander"]',
 '', NULL, 60.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Herrensee Parey', 52.362393, 11.939082, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Zander"]',
 '', NULL, 1.97, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe-Havel-Kanal von km 364,5 (Brücke B1 Ortsausgang Genthin bis km 365,7 (Einmündung Neuer Graben). Beachte Betriebsanlagenverordnung für Bundeswasserstraßen!', 52.407042, 12.076119, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Blei", "Karpfen", "Plötze", "Zander"]',
 '', NULL, 7.44, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Roßdorfer Altkanal von                   A, B, Bl, Gü, H, K, Brücke Dunkelforth (B1) bis zur         Pl, Ro, Z Einmündung in den EHK', 52.422245, 12.206709, 'Sachsen-Anhalt', 'Kanal',
 '[]',
 '', NULL, 3.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe-Havel-Kanal von km 353 - km 360 Beachte Betriebsanlagenverordnung für Bundeswasserstraßen!', 52.407042, 12.076119, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Blei", "Karpfen", "Plötze", "Zander"]',
 '', NULL, 31.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich 1 und 2 bei Leitzkau       A, B, Bl, Gü, H,', 52.057758, 11.952907, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 2.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßteich und 2 Nebenteiche in Leitzkau 18', 52.057758, 11.952907, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich in Ladeburg', 52.083601, 11.936850, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.15, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Prödeler See - 2 Teiche          A, B, Bl, H, K,', 52.026010, 11.895556, 'Sachsen-Anhalt', 'Teich',
 '["Rotfeder", "Schleie", "Zander"]',
 '', NULL, 3.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Griebensee bei Prödel            A, B, Bl, H, K,', 52.037377, 11.918173, 'Sachsen-Anhalt', 'See',
 '["Rotfeder", "Schleie", "Zander"]',
 '', NULL, 3.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pappelteich bei Hobeck           A, B, Bl, K, Pl, Ro,', 52.077567, 12.041103, 'Sachsen-Anhalt', 'Teich',
 '["Schleie", "Zander"]',
 '', NULL, 0.78, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Teich bei Dalchau         A, B, Bl, Gü, H, K,', 52.112325, 11.989254, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder", "Zander"]',
 '', NULL, 0.65, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner Teich bei Dalchau', 52.112325, 11.989254, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Göbel', 52.076304, 12.015103, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Plötze", "Rotfeder"]',
 '', NULL, 0.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Loburg', 52.114075, 12.077031, 'Sachsen-Anhalt', 'See',
 '["Blei", "Güster", "Hecht", "Karpfen", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 5.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ellernteich in Reinstedt', 51.760184, 11.354988, 'Sachsen-Anhalt', 'Teich',
 '["Güster", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube zwischen Aschersleben und Hoym', 51.843790, 11.135213, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pappelteich Ermsleben', 51.728987, 11.314455, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.94, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Burgteich Ermsleben', 51.712895, 11.347305, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.64, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Krummer Teich bei Dingelstedt', 51.975782, 10.977817, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 2.28, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Parkteich Mahndorf', 51.887988, 10.966090, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 0.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Halberstädter See 1 (Badesee)', 51.911916, 11.081902, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 8.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Graben vom Zusammenfluss Schiffgraben und Aue bis zur Straßen- brücke zwischen Aderstedt und Gunsleben', 52.032263, 11.003611, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 4.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Halberstädter See II', 51.912977, 11.085494, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 15.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Untere Schwenneckestau bei Pansfelde', 51.657289, 11.225800, 'Sachsen-Anhalt', 'Stausee',
 '["Aal", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Erichsburger Teich bei Friedrichsbrunn', 51.698132, 11.023340, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Plötze", "Schleie"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bergrat-Müller Teich bei Gernrode', 51.707531, 11.107901, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 1.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neuer Teich bei Gernrode', 51.707531, 11.107901, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.46, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kunstteich in Ballenstedt', 51.718096, 11.219824, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Dachsteich bei Ballenstedt', 51.718096, 11.219824, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 2.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bode vom Einlauf des Quarmbaches bis zur Selkemündung bei Rodersdorf', 51.884064, 11.231722, 'Sachsen-Anhalt', 'Fluss',
 '["Bachforelle", "Barsch", "Hecht", "Plötze", "Rotfeder", "Äsche"]',
 'Salmostrecken beachten!', NULL, 19.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Siebersteinsteich bei Ballenstedt A, B, Bl, H, K,', 51.718096, 11.219824, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 4.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner Siebersteinsteich bei Ballenstedt', 51.718096, 11.219824, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 1.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gondelteich in Friedrichsbrunn', 51.698132, 11.023340, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 4.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Selke von Kreisgrenze                     Ä, B, Bf, D, H, Ro, Salzlandkreis bis Mündung in die Bode 20', 51.674968, 11.181615, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 4.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gondelteich Thale', 51.679946, 11.042797, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.93, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Flottenteich Weddersleben', 51.765269, 11.094429, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Güster", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlgraben Thale', 51.753702, 11.083428, 'Sachsen-Anhalt', 'Kanal',
 '[]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Opperode                B, Pl, Ro,', 51.716930, 11.254332, 'Sachsen-Anhalt', 'Teich',
 '[]',
 '', NULL, 1.06, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßteich Ballenstedt', 51.718096, 11.219824, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 2.16, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lüttgenbörnecke bei Börnecke', 51.823522, 11.005294, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 0.35, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Schachtteich bei Wienrode', 51.756107, 10.975965, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 2.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner Schachtteich bei Wienrode', 51.756107, 10.975965, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 0.47, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wiesenteich bei Wienrode 21 Salzlandkreis', 51.756107, 10.975965, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 0.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bruchfeldsee (Wilslebener See)          A, B, Bl, H, bei Aschersleben -                      K, Pl, Ro, S', 51.755955, 11.462134, 'Sachsen-Anhalt', 'See',
 '[]',
 'Beachte Teilfläche NSG!', NULL, 24.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tonkuhle (Badetonkuhle) in Aschersleben', 51.755955, 11.462134, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hauptseegraben von Einmündung des Grabens aus Wilsleben bis Tagebaurestloch Königsaue', 51.825913, 11.304721, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Hecht", "Karausche", "Plötze", "Rotfeder"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wipper von letzter Brücke Klein Schierstedt bis Brücke Osmarsleben', 51.751490, 11.521424, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Bachforelle", "Barsch", "Hecht", "Plötze", "Rotfeder", "Äsche"]',
 '', NULL, 3.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gondelteich Aschersleben', 51.748658, 11.438328, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dammloch Beesenlaublingen', 51.708315, 11.685192, 'Sachsen-Anhalt', 'See',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.05, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lettenloch bei Könnern', 51.670651, 11.771366, 'Sachsen-Anhalt', 'See',
 '["Aal", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tonloch Hanse, Leau', 52.843314, 11.172815, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Saalealtarm zwischen Plötzkau und Großwirschleben', 51.744063, 11.686202, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 11.87, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Wiendorfer Teich', 51.716525, 11.818393, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 25.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fuhne vom Viadukt bei Kleinwirschleben bis Mündung in die Saale', 51.748322, 11.796223, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Taiga in Gröna                          A, B, Bl, Gü, H, K,       6, 00', 51.757644, 11.723252, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Rotfeder", "Schleie"]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Die Strenge bei Aderstedt', 51.776164, 11.677354, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 5.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Feldlache in der Aue bei Nienburg', 51.837156, 11.767553, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.05, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schachtsee Neugattersleben', 51.859573, 11.709280, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 9.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Bründel', 51.745484, 11.651015, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.69, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Plötzkau', 51.744063, 11.686202, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.16, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Saalealtarm Lesewitz bei Plötzkau', 51.744063, 11.686202, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 'LSG und NSG beachten!', NULL, 6.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fahrt in Preußlitz', 51.734725, 11.803413, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.29, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Teich hinter der Fahrt in Preußlitz', 51.734725, 11.803413, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tonloch Preußlitz', 51.734725, 11.803413, 'Sachsen-Anhalt', 'See',
 '["Karausche", "Karpfen", "Schleie"]',
 '', NULL, 0.15, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schacht 9 bei Eggersdorf', 51.976514, 11.717783, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 3.44, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Seehof bei Wespen-Barby', 51.959421, 11.828739, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Güster", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 30.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Parkteich bei Brumby', 51.895812, 11.717362, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 4.89, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kohls See bei Biere', 51.973934, 11.654025, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 4.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Erdkuten (Grüne Lungen) bei Calbe', 51.903401, 11.776121, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 10.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Damaschkeplan (2 Teiche) bei Calbe', 51.903401, 11.776121, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Güster", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Griebehner Teiche bei Calbe', 51.903401, 11.776121, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 4.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pfannenpfütze bei Plötzky', 52.051250, 11.815331, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Beamtenteich bei Tornitz', 51.930490, 11.848411, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Grüner Teich bei Tornitz', 51.930490, 11.848411, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 25.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pappelteich bei Tornitz', 51.930490, 11.848411, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Güster", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Liesekuhle bei Grünewalde', 52.042940, 11.761519, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Rotfeder"]',
 '', NULL, 1.34, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fährlake bei Grünewalde', 52.042940, 11.761519, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Zander"]',
 '', NULL, 0.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Norderney in Schwarz', 51.892975, 11.813143, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 1.18, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe von km 305 - km 320 beidseitig   A, B, Bl, H, K, Pl,', 52.020600, 11.738328, 'Sachsen-Anhalt', 'Fluss',
 '["Schleie", "Wels", "Zander"]',
 '', NULL, 385.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbumflut von Alte Fähre bis Einmündung neue Ehle', 52.056755, 11.766310, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 20.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hoher Teich bei Glinde', 52.009297, 11.851866, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pfaffenbruch bei Glinde', 52.009297, 11.851866, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.22, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesbaggerloch bei Glinde', 52.009297, 11.851866, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Heiliger See bei Plötzky              B, Bl, Gü, H, Ka,', 52.051250, 11.815331, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('3 Löcher bei Ranies', 52.021923, 11.828202, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 3.69, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiessee Tornitz', 51.930490, 11.848411, 'Sachsen-Anhalt', 'See',
 '["Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 15.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Angerteich in Glöthe', 51.901889, 11.668635, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karausche", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 0.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Worth in Plötzky', 52.051250, 11.815331, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karausche", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 1.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kirchbreite bei Barby', 51.966647, 11.886051, 'Sachsen-Anhalt', 'See',
 '["Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.92, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiessee Pömmelte', 51.997990, 11.815484, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Güster", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 6.64, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bruch 1 bei Breitenhagen', 51.924373, 11.944680, 'Sachsen-Anhalt', 'See',
 '["Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 1.45, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bruch 2 bei Breitenhagen', 51.924373, 11.944680, 'Sachsen-Anhalt', 'See',
 '["Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 1.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bruch 3 bei Breitenhagen', 51.924373, 11.944680, 'Sachsen-Anhalt', 'See',
 '["Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Badebruch bei Breitenhagen', 51.924373, 11.944680, 'Sachsen-Anhalt', 'See',
 '["Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 1.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Drähningensee bei Breitenhagen', 51.924373, 11.944680, 'Sachsen-Anhalt', 'See',
 '["Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 1.79, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Krügersee bei Breitenhagen 24', 51.924373, 11.944680, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 'Angelverbot Nordufer beachten!', NULL, 7.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Landgraben von Einmündung des Laufgrabens bis zur Mündung in die Taube', 51.963384, 11.867851, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 2.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Taube von 700m oberhalb der Straßenbrücke Rajoch-Lödderitz bis Pumpwerk', 51.828430, 12.076888, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dolphus bei Barby', 51.966647, 11.886051, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schächte bei Tarthun', 51.924373, 11.478088, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.37, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ritterflurteich bei Staßfurt', 51.851452, 11.592946, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stockscher Teich bei Wolmirsleben      A, B, Bl, Gü, H, K, Pl,', 51.947360, 11.487107, 'Sachsen-Anhalt', 'Teich',
 '["Rotfeder"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tiefbau Jacobsgrube bei Groß Börnecke', 51.916871, 11.888313, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 8.12, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Badeteteich bei Westeregeln', 51.957907, 11.384222, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.68, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('3 Kulke bei Westeregeln', 51.957907, 11.384222, 'Sachsen-Anhalt', 'See',
 '["Blei", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tagebau bei Westeregeln                A, B, Bl, Gü, H, K, Pl,', 51.957907, 11.384222, 'Sachsen-Anhalt', 'See',
 '["Rotfeder", "Zander"]',
 '', NULL, 3.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Schachtsee bei Wolmirsleben     A, B, Bl, Gü, H, K, Pl,', 51.947360, 11.487107, 'Sachsen-Anhalt', 'See',
 '["Rotfeder", "Schleie", "Zander"]',
 '', NULL, 23.34, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Im Todtleben bei Wolmirsleben', 51.947360, 11.487107, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 9.02, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bode vom Wehr Rothenförde              A, B, Bl, Gü, H, K, (Unterwasser) bis Mühlengraben         Pl, Rf, Ro, S Neugattersleben', 51.907937, 11.783361, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 35.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesschacht Güsten', 51.801483, 11.606963, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Regenrückhaltebecken am Glöther Weg', 51.915186, 11.609284, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wassergräben bei Hohenerxleben', 51.866218, 11.662600, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Mulde bei Rösa', 51.620806, 12.490759, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 6.51, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Mulde Roitzschjora', 51.597051, 12.494249, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 14.49, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch bei Burgkemnitz', 51.678328, 12.387331, 'Sachsen-Anhalt', 'See',
 '["Aal", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Strandbad Sandersdorf', 51.625596, 12.238250, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 40.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Spittelwasser Jeßnitz', 51.698084, 12.286148, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Leipziger Teich Zörbig', 51.623429, 12.122660, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Karausche", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Grube Theodor bei Roitzsch', 51.575580, 12.266029, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Wels", "Zander"]',
 '', NULL, 65.65, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lober bei Jeßnitz', 51.683301, 12.300219, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lober-Leine-Kanal', 51.561489, 12.414926, 'Sachsen-Anhalt', 'Kanal',
 '["Barsch", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mulde v. Landesgr. Sachsen bis Stausee, ohne linkes Ufer Bereich alte Mulde', 51.650315, 12.367581, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Rotfeder", "Wels"]',
 '', NULL, 44.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mulde von ca. 750m oberhalb Wehr Jeßnitz bis Einmündung Mühlgraben', 51.684455, 12.305960, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Rotfeder", "Wels"]',
 '', NULL, 6.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mulde von ca. 500m oberhalb Brücke bis Brücke Raguhn', 51.736168, 11.993404, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Rotfeder", "Wels"]',
 '', NULL, 3.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Salzfurtkapelle 27', 51.692892, 12.193999, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Rotfeder"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Mulde in Friedersdorf', 51.649600, 12.364948, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Hecht", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 7.67, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Auensee bei Holzweißig', 51.600160, 12.307456, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Plötze", "Rotfeder"]',
 '', NULL, 3.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich Seegarten Schierau', 51.711238, 12.301160, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.44, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Teich Bitterfeld', 51.625747, 12.330715, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen", "Plötze"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tränke Thalheim', 51.657444, 12.227008, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Rotfeder", "Schleie"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Thalheim', 51.652628, 12.231089, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.14, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Köckern', 51.606477, 12.197767, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.04, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Generalsteich Schrenz', 51.586641, 12.073973, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.28, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich am Park Schrenz', 52.027216, 12.221365, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.11, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Vergißmeinnicht (Postgrube) bei Zscherndorf', 51.612028, 12.269277, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 42.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Deutsche Grube Zscherndorf', 51.611203, 12.277142, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Wels"]',
 '', NULL, 4.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Dessauer Str. Löberitz', 51.854624, 12.051666, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.68, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Möster altes Wasser', 51.766385, 12.286069, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Niesauer Stillinge', 51.761890, 12.293890, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hausteich in Reupzig', 51.736453, 12.072893, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Zuckerteich bei Osternienburg', 51.793211, 12.029417, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 0.99, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Strandbad Gütersee in Köthen', 51.751033, 11.973698, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 1.28, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Magdalenenteich in Aken', 51.850000, 12.050000, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.89, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Nachthainichte bei Aken', 51.850000, 12.050000, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 'Nur Vereinsboote', NULL, 12.86, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Große Kabel (Langes Loch) bei Aken', 51.850000, 12.050000, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Hecht", "Karausche", "Karpfen", "Rotfeder", "Schleie"]',
 'Nur Vereinsboote', NULL, 14.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleine Kabel bei Aken 28', 51.850000, 12.050000, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bürgersee in Aken', 51.850000, 12.050000, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Güster", "Hecht", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Baufeld Wörbzig 1 - Große Kiesgrube linksseitig der Straße von Gröbzig nach Wörbzig', 51.703072, 11.881882, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Karpfen", "Plötze", "Rotfeder", "Zander"]',
 '', NULL, 38.49, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Baufeld Wörbzig 2 - Kleinere Kiesgrube linksseitig der Straße von Gröbzig nach Wörbzig', 51.703072, 11.881882, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Karpfen", "Plötze", "Rotfeder", "Zander"]',
 'Betriebsgelände beachten!', NULL, 14.51, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Baufeld Wörbzig 3 - Kiesgrube rechts- seitig der Straße von Gröbzig nach Wörbzig', 51.703072, 11.881882, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Karpfen", "Plötze", "Rotfeder", "Zander"]',
 'Beanglung nur von der Straßenseite,; Betriebsgelände beachten!', NULL, 20.21, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Betonwerkteich 3 + 4 bei Gröbzig', 51.683432, 11.876182, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 22.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sandkiete II bei Gröbzig', 51.683432, 11.876182, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Döbel", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 5.72, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sportplatzteich in Görzig', 51.666303, 11.996734, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.17, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Augustateich in Pfaffendorf', 51.698183, 11.908933, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 3.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Reinsdorf', 51.303232, 11.612498, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.51, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Betonwerkteich V bei Gröbzig', 51.683432, 11.876182, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 5.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Gnetsch', 51.682828, 12.088348, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.64, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gutsteich Görzig', 51.662547, 11.991634, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze"]',
 '', NULL, 0.29, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Grubenteich bei Osternienburg', 51.793211, 12.029417, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.53, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleine Sandfürchen bei Osternienburg', 51.793211, 12.029417, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.82, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Brückmannsteich und Pumpenteich bei Osternienburg 29', 51.793211, 12.029417, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 5.27, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Große Sandfürchen bei Osternienburg', 51.793211, 12.029417, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 3.91, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lochmannsteich bei Osternienburg', 51.793211, 12.029417, 'Sachsen-Anhalt', 'Teich',
 '["Karausche"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Baggerteich bei Trebbichau/Aken', 51.826421, 12.020012, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karausche", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.39, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer und Kleiner Parkteich in Trebbichau/Aken', 51.826421, 12.020012, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karausche", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 5.92, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Drei Löcher in Micheln', 51.816874, 11.991511, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.63, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sonntalteich bei Micheln', 51.816874, 11.991511, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Rotfeder", "Schleie"]',
 '', NULL, 4.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hasenteich bei Osternienburg', 51.793211, 12.029417, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlenteich Wulfen', 51.821940, 11.928847, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.93, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kapellenteich Wulfen', 51.819846, 11.938458, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Holzplatzteich Osternienburg', 51.807001, 12.031265, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.36, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Roter Teich Osternienburg', 51.805650, 12.035121, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.43, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Salzteich Osternienburg', 51.809458, 12.019693, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 10.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Pißdorf', 51.793188, 12.009263, 'Sachsen-Anhalt', 'Teich',
 '["Plötze"]',
 '', NULL, 0.07, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stadionteich in Köthen', 51.751033, 11.973698, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schulteich bei Trebbichau/Aken', 51.826421, 12.020012, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 7.13, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich Kleinbadegast', 51.726466, 12.032328, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Schleie"]',
 '', NULL, 0.22, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich am Kulturzentrum Großbadegast', 51.730475, 12.025931, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.22, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlteich Merzien', 51.760846, 12.044961, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karausche", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.43, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stauanlage Klein Leitzkau', 51.978532, 12.240332, 'Sachsen-Anhalt', 'Stausee',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 6.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Waldfrieden bei Zerbst', 51.969740, 12.074546, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 30.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stauanlage Golbogen bei Straguth 30', 52.017585, 12.168124, 'Sachsen-Anhalt', 'Stausee',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 1.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich bei Niederlepte', 51.961305, 12.028303, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 3.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unterer Mühlenteich bei Dobritz', 52.035916, 12.232699, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Ost bei Zerbst Gesperrt bis 31.12.2022!', 51.969740, 12.074546, 'Sachsen-Anhalt', 'See',
 '[]',
 '', NULL, 5.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großes Loch bei Steutz', 51.883024, 12.085957, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 2.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Wehl bei Steutz               A, B, Bl, H, K, Pl, Ro,', 51.883024, 12.085957, 'Sachsen-Anhalt', 'See',
 '["Schleie", "Zander"]',
 '', NULL, 0.81, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Cassinteich bei Lindau 31 Landkreis Wittenberg', 52.046043, 12.095989, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 1.59, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Strohwalder Teich Gräfenhainichen', 51.740974, 12.471409, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.28, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Reudener Grube', 51.772983, 12.599187, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.17, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tiefer Kolk in Selbitz', 51.816101, 12.531716, 'Sachsen-Anhalt', 'See',
 '["Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.27, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Jägerteich bei Söllichau', 51.640953, 12.642530, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gänseteich in Söllichau', 51.640953, 12.642530, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lehmkeite bei Uthausen', 51.756597, 12.548836, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.74, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neuer Teich bei Uthausen', 51.756597, 12.548836, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.03, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schleifbach bei Söllichau', 51.640953, 12.642530, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Barbarasee bei Gräfenhainichen Boote ohne Motor maximal 1 kg Futter je Tag und Angler', 51.730911, 12.458868, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 27.26, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Schleesen', 51.787593, 12.487234, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Blei", "Plötze", "Rotfeder"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Möhlauer See', 51.739031, 12.357263, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Regenbogenforelle", "Schleie"]',
 '', NULL, 18.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('3 Steinbruchteiche in Möhlau', 51.732117, 12.365357, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe von km 244, 5 - km 248, 3 linksseitig', 51.834454, 12.758167, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Blei", "Hecht", "Plötze", "Wels", "Zander"]',
 '', NULL, 52.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talkenloch bei Kakau', 51.804267, 12.432575, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großes Hakenloch bei Vockerode 32', 51.852838, 12.328044, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schiffinge bei Vockerode', 51.852838, 12.328044, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.46, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kapengraben von ehem. B107 bis zur Straßenbrücke Waldersee-Vockerode', 51.846435, 12.306082, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fließgraben von Straßenbrücke Seegrehna-Selbitz bis 300m vor Einmündung in den Schönitzer See/ Radehochse sowie von Brücke ca. 300m hinter Radehochsee bis letzte Brücke vor Schwarzem Wasser', 51.834803, 12.515871, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 12.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hauptgraben von Wörlitz bis Kakau', 51.847079, 12.422603, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 3.53, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Roter See bei Rotta                     A, B, Bl, H, K, Pl,', 51.754565, 12.591992, 'Sachsen-Anhalt', 'See',
 '["Regenbogenforelle", "Schleie", "Zander"]',
 '', NULL, 12.9, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('See am Waldrand bei Rotta', 51.991886, 12.347508, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neues Bad bei Jessen', 51.793116, 12.959074, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 3.19, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Saulug bei Jessen', 51.793116, 12.959074, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.73, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schweinitzer Fließ von Landesgrenze bis Einlauf Morgengraben bei Zwuschen/Dixförda', 51.816228, 13.045791, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 9.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neuer Arm in Jessen', 51.793116, 12.959074, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neugraben von Landesgrenze bis Mündung in die Schwarze Elster', 51.752150, 12.980178, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 13.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiestagebau Elbekies bei Prettin', 51.660679, 12.926507, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 'Beschilderung/Merkblatt beachten!', NULL, 112.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiestagbau (Badesee) bei Prettin', 51.660679, 12.926507, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 15.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elbe km 168, 2 - km 182, 0 rechtss.      A, B, BBl, H, K, Q,', 51.716482, 12.804747, 'Sachsen-Anhalt', 'Fluss',
 '["Rapfen", "Wels", "Zander"]',
 '', NULL, 69.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Elbe in Iserbegka bei Elster        A, B, Bl, Gü, H, K, Pl, gesperrt bis auf Widerruf!', 51.837069, 12.789590, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 2.15, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rötlache bei Elster', 51.832228, 12.818465, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Blei", "Güster", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 1.11, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fischteich bei Elster', 51.832228, 12.818465, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.14, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner Klinker bei Elster', 51.832228, 12.818465, 'Sachsen-Anhalt', 'Fluss',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.67, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Spitzenlöcher in Elster', 51.832228, 12.818465, 'Sachsen-Anhalt', 'Fluss',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Das Loch Annaburg', 51.725254, 13.066537, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hertha bei Löben', 51.765185, 13.077122, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.43, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gewässer Schwertfeger, Ständer und Wiesenloch bei Löben', 51.765185, 13.077122, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 8.93, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wasserloch Klieken', 51.868895, 12.403792, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Güster", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.24, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Klieken', 51.889023, 12.370491, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Waldmühlenteich bei Coswig', 51.884657, 12.456278, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lehmausstiche bei Coswig                 A, B, Bl, Gü, H, K,', 51.884657, 12.456278, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 7.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Klinkerteich bei Bad Schmiedeberg', 51.357545, 11.100687, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 4.44, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Brauteich, Schloßgraben und Dorfteich in Kropstädt', 51.961925, 12.744524, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.72, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Streitlache bei Pratau', 51.841713, 12.640776, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.61, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('1. Flutbrücke bei Pratau', 51.841713, 12.640776, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Plötze"]',
 '', NULL, 0.47, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Förstereiteich bei Pratau', 51.841713, 12.640776, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 0.39, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kuhlienteich bei Pratau', 51.841713, 12.640776, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Blei", "Plötze", "Rotfeder"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sandekolk bei Pratau', 51.841713, 12.640776, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 1.58, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Durchstich bei Pratau', 51.841713, 12.640776, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 6.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fleischerwerder bei Dabrun', 51.827722, 12.714653, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 6.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('3 Waldteiche bei Reinsdorf (Roter Teich, Waldteich, Silberwasser)', 51.901975, 12.606450, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer (ACA) Teich bei Reinsdorf 34', 51.901975, 12.606450, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 3.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich Bleddin', 51.786144, 12.786296, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Plötze", "Rotfeder"]',
 '', NULL, 0.26, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schluft bei Bleddin', 51.786144, 12.786296, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 1.34, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bleddiner Riß', 51.791174, 12.791512, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Plötze", "Rotfeder"]',
 '', NULL, 4.27, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Flutbrücke 2 (Bude 100) bei Pratau', 51.841713, 12.640776, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 4.89, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Moschkolk bei Wartenburg', 51.810474, 12.777933, 'Sachsen-Anhalt', 'See',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Streng (Alte Elbe Bleesern) bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 0.72, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Merkwitzer Teich (Mühlteich) bei Gaditz', 51.766377, 12.673454, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.92, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kolk in den Krebshornwiesen bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner Riß bei Dabrun (Schleienloch)', 51.827722, 12.714653, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 4.65, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Falkenwaiden bei Wartenburg', 51.810474, 12.777933, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Zander"]',
 '', NULL, 19.45, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pfählen bei Wartenburg', 51.810474, 12.777933, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 7.21, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Röthekolk bei Wartenburg', 51.810474, 12.777933, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 5.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schluft Priesitz', 51.709551, 12.836735, 'Sachsen-Anhalt', 'See',
 '["Karausche", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.26, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tiefer Kolk bei Trebitz', 51.752789, 12.751594, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 3.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sandekolk bei Dabrun', 51.827722, 12.714653, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Karpfen", "Zander"]',
 '', NULL, 0.96, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Försterloch bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Zander"]',
 '', NULL, 2.91, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tiefe Lache mit Graben und Loch bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'Kanal',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.66, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Krummer See (Bodemar) bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.24, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Blumenwinkel bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Plötze", "Schleie"]',
 '', NULL, 0.36, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Drehkolk bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.71, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hauskolk bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.48, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hohndorfer Rinne bei Mühlanger', 51.852906, 12.749563, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze"]',
 '', NULL, 6.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer See (Bleesern) bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 5.06, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schwarzes Wasser bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 2.59, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sandebreite bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Blei", "Plötze", "Rotfeder"]',
 '', NULL, 1.05, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Elbe Merschwitz', 51.735159, 12.799636, 'Sachsen-Anhalt', 'Fluss',
 '["Blei", "Plötze", "Rotfeder"]',
 '', NULL, 3.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wendel Wittenberg 35', 51.863636, 12.689620, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Rotfeder"]',
 '', NULL, 7.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Espenkolk I und II bei Gallin/Mühlanger', 51.839914, 12.756229, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Hecht", "Plötze"]',
 '', NULL, 0.23, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wilde Kölke I bei Dabrun/Melzwig', 51.832828, 12.710603, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großen Lache bei Pratau', 51.841713, 12.640776, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Plötze", "Rotfeder", "Zander"]',
 '', NULL, 3.06, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wasserrückhaltebecken (Grube A-Sandwäsche) bei Nudersdorf', 51.922483, 12.591979, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schwarzes Loch (1-3) im Großen Lug bei Wittenberg', 51.866653, 12.646761, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Plötze"]',
 '', NULL, 0.76, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alter See bei Trebitz', 51.752789, 12.751594, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.74, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bräken bei Trebitz', 51.752789, 12.751594, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 3.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Das Tiefe Loch bei Trebitz', 51.752789, 12.751594, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.23, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Katzenergel bei Seegrehna', 51.844557, 12.556681, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.81, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rehkolk Apollensdorf', 51.872268, 12.537443, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Plötze", "Rotfeder"]',
 '', NULL, 0.29, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kl. und gr. Loch bei Pratau (3 Eichen) 36 Landkreis Mansfeld – Südharz', 51.841713, 12.640776, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Plötze"]',
 '', NULL, 0.67, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Klosterrode', 51.499428, 11.445034, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.17, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ottilienteich bei Röblingen', 51.461813, 11.672723, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 4.89, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Marthateich bei Wansleben', 51.459200, 11.755037, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.21, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('restl. Tonlöcher Ost bei Wansleben', 51.459200, 11.755037, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 3.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hofteich in Stedten', 51.438842, 11.707756, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.23, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schäferteich in Stedten', 51.438842, 11.707756, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.23, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rüdels Teich bei Helfta', 51.501579, 11.572374, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 1.19, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tonloch bei Hettstedt                   A, B, Bl, H, K, Pl,', 51.650005, 11.499999, 'Sachsen-Anhalt', 'See',
 '["Rotfeder", "Schleie", "Zander"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ölgrundteich bei Hettstedt', 51.650005, 11.499999, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 2.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mansfelder Teich', 51.581689, 11.429876, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 2.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Sylda', 51.678286, 11.425308, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Amtsteich bei Vatterode                 A, B, Bl, H, K, Pl,', 51.601149, 11.425509, 'Sachsen-Anhalt', 'Teich',
 '["Rotfeder", "Schleie", "Zander"]',
 '', NULL, 6.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Greifenhagen', 51.626468, 11.419353, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.09, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Melmensee bei Tilleda 37', 51.419762, 11.143097, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Zander"]',
 'LSG beachten', NULL, 0.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Toter Arm „Lange Helme“ bei Wallhausen', 51.460555, 11.207852, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Toter Arm „Eichgraben“ bei Wallhausen   A, B, Bl, Gü, H, K,', 51.460555, 11.207852, 'Sachsen-Anhalt', 'Kanal',
 '["Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.98, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Passbruch', 51.553976, 11.126571, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.41, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßteich Rottleberode', 51.518381, 10.948648, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 'Beachte Westseite NSG!', NULL, 7.63, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neuvorwerksteich bei Allstedt', 51.402697, 11.387382, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 'Schwimmbrot verboten!', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich Karlsrode', 51.548202, 11.059809, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Regenbogenforelle", "Rotfeder", "Schleie"]',
 '', NULL, 2.04, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hüttenteich in Breitenstein', 51.621937, 10.951396, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karausche", "Karpfen", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gänseteich in Breitenstein', 51.621937, 10.951396, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Feuerlöschteich in Dittichenrode', 51.474845, 11.100976, 'Sachsen-Anhalt', 'Teich',
 '["Schleie"]',
 '', NULL, 0.54, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Rotha', 51.541055, 11.147285, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen", "Plötze"]',
 '', NULL, 0.13, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kunstteich bei Wettelrode 15.02. - 30.04. Salmonidengewässer', 51.516323, 11.285192, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Zander"]',
 '', NULL, 2.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Helme ab 200m unterhalb Straßen- brücke Kelbra einschließlich Nebengewässer Barbe und Äsche ganzjährig', 51.460555, 11.207852, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Bachforelle", "Barbe", "Barsch", "Döbel", "Hasel"]',
 'geschont! Salmostrecken beachten!', NULL, 42.58, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('3 Tonlöcher bei Morungen –', 51.516576, 11.232935, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 'NSG beachten!', NULL, 0.66, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Kiesgrube Berga 15.02. - 30.04. Salmogewässer', 51.448856, 11.018604, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Karpfen", "Regenbogenforelle", "Schleie", "Wels"]',
 '', NULL, 4.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Beyernaumburg/Othal', 51.469869, 11.379442, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.39, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Toter Helmearm bei Bennungen 38', 51.461072, 11.121666, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßteich Grillenberg', 51.533221, 11.309842, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stausee Kelbra                   A, B, H, K, Pl, 39 Landkreis Saalekreis', 51.435819, 11.041443, 'Sachsen-Anhalt', 'See',
 '[]',
 'Hinweise im Anhang beachten!     Ro, S, Z', NULL, 500.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Friedrichsbad in Zwintschöna', 51.447350, 12.050765, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich in Zwintschöna', 51.447350, 12.050765, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 3.11, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlteich in Zwintschöna', 51.447350, 12.050765, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Rockendorf bei Hohenweiden', 51.412639, 11.933582, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 30.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube in Röpzig', 51.432841, 11.944062, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Plößnitz', 51.534586, 12.061805, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.43, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Hohenthurm', 51.523720, 12.100656, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.99, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teiche in Zscherneddel 10-290-o2 Tonschacht Wallendorf                  A, B, H, K, Pl, Ro, S     0,39', 51.347128, 12.114292, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.09, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Krugs Teich in Schafstädt', 51.382233, 11.774455, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karausche", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.66, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Parkteich in Braunsbedra', 51.284093, 11.885549, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.28, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Zöllschen', 51.272608, 12.118950, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großes Kohlenloch bei Tollwitz', 51.280351, 12.109829, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleines Kohlenloch bei Tollwitz', 51.280351, 12.109829, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Karausche", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pfütze bei Tollwitz', 51.280351, 12.109829, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Zander"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Herrenteich bei Tollwitz', 51.280351, 12.109829, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 0.49, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßteich Dölkau', 51.360368, 12.151378, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 1.04, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kuhteich (Feldsee) bei Wallendorf', 51.355413, 12.081883, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.19, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Geisel von Quelle bei Mücheln bis zur Mündung in den Gotthardsteich', 51.301593, 11.803904, 'Sachsen-Anhalt', 'Fluss',
 '["Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 5.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Luppe von Landesgrenze Sachsen bis zur Mündung in die Saale', 51.365133, 12.089090, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Döbel", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 'NSG beachten!', NULL, 33.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Weiße Elster von Landesgrenze Sachsen bis Straßenbrücke Lochau-Burgliebenau', 51.381074, 12.160075, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Döbel", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 14.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Oebles-Schlechtewitz', 51.254967, 12.064393, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.27, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich 1 Schladebach', 51.318773, 12.117933, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.12, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich 1 Witzschkersdorf', 51.534244, 12.064557, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.07, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich 1 Kötzschau', 51.318773, 12.117933, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.18, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Thalschütz', 51.296145, 12.129069, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.15, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Rampitz', 51.302957, 12.132154, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.11, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Göhren', 51.354403, 12.135332, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Malerteich in Günthersdorf', 51.338698, 12.178408, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.12, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Kröllwitz', 51.304817, 12.046482, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.54, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Brauhausteich Schkopau', 51.392341, 11.986165, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.51, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiessee Wallendorf südl. Gastrasse', 51.355413, 12.081883, 'Sachsen-Anhalt', 'See',
 '["Aal", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 6.11, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Naturstrandbad bei Obhausen Kopie vom FS und FES sichtbar im Auto auslegen', 51.391628, 11.650801, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 20.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich Thalgarten in Querfurt', 51.378707, 11.597408, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 'Nur Querneseitig-Parkgelände verboten', NULL, 0.45, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Langer Teich in Landgrafroda', 51.352378, 11.429345, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.15, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schmoner Stausee', 51.345012, 11.529051, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 2.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlenteich in Schmon', 51.346270, 11.554566, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Hecht", "Karpfen", "Rotfeder"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rost‘s Loch in Lieskau', 51.502804, 11.849647, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gründel Teich bei Teutschenthal', 51.450000, 11.800000, 'Sachsen-Anhalt', 'Teich',
 '["Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.06, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch am Gützer Berg bei Landsberg', 51.526047, 12.142146, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 3.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schmiedern am Gützer Berg bei Landsberg', 51.526047, 12.142146, 'Sachsen-Anhalt', 'See',
 '["Aal", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Obere Steinbreite bei Brachwitz', 51.542223, 11.874027, 'Sachsen-Anhalt', 'See',
 '["Aal", "Karausche", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbrüche am Spitzberg bei Landsberg', 51.521414, 12.123851, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.85, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ihlau bei Wettin', 51.587580, 11.801983, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch bei Niemberg', 51.558706, 12.097820, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lauterbachsloch II bei Gimritz', 51.568170, 11.871495, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karausche", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tonloch bei Teicha', 51.559535, 11.962235, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.14, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Blaues Tonloch bei Salzmünde', 51.531926, 11.804809, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Vorderer Schacht bei Döllnitz', 51.408145, 12.028345, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Rotfeder", "Schleie"]',
 '', NULL, 2.91, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pappelgrund bei Teutschenthal', 51.450000, 11.800000, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 5.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Erlengrund bei Teutschenthal', 51.450000, 11.800000, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.78, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Saale vom Trompeterfelsen               A, B, Bl, Gü, D, zwischen Halle und Brachwitz            H, K, W, Z, Q, R bis zur Kreisgrenze Salzlandkreis', 51.524326, 12.033675, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 105.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gewässer an der Seilbahn I (oberes der 3 Gewässer bei Morl)', 51.546703, 11.911990, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.35, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Salza von Straßenbrücke Wansleben/ Langenbogen bis Saalemündung', 51.495717, 11.789031, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Döbel", "Plötze"]',
 'Beachte NSG „Salzatal Langenbogen“!', NULL, 2.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiestagebau bei Plötz                   A, B, H, K, Rf, Ro,', 51.635840, 11.966876, 'Sachsen-Anhalt', 'See',
 '[]',
 'Betreten der Insel verboten!            Pl, Z', NULL, 12.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('2 Dorfteiche in Niemberg', 51.558706, 12.097820, 'Sachsen-Anhalt', 'Teich',
 '["Karausche", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tonloch Morl', 51.546703, 11.911990, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.87, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Nauendorf 42', 51.604152, 11.893250, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Seilbahn III u. II bei Morl', 51.546703, 11.911990, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Wallwitz', 51.587703, 11.915914, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Zander"]',
 '', NULL, 1.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Schwerz', 51.564316, 12.133313, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Dammendorf', 51.576040, 12.130385, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Lohnsdorf', 51.499432, 12.172282, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Bageritz', 51.480370, 12.163375, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teiche am Wasserwerk', 51.348980, 11.804564, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich am Rodelberg', 51.796936, 12.258768, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.26, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Sietzsch', 51.484311, 12.169832, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.06, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Goethebruch Petersberg', 51.594994, 11.954789, 'Sachsen-Anhalt', 'See',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.48, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Naßpresse Döllnitz', 51.407124, 12.041335, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 2.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Entenfang bei Langenbogen', 51.482681, 11.769247, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Schleie"]',
 'NSG beachten', NULL, 2.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlteich Krosigk 43 Burgenlandkreis', 51.612079, 11.931575, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Blei", "Plötze"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Auensee bei Granschütz', 51.177339, 12.039583, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 4.02, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Vollert bei Trebnitz Anfahrt von Deuben, Parkflächen nutzen!', 51.095241, 12.066385, 'Sachsen-Anhalt', 'See',
 '["Blei", "Karpfen", "Schleie"]',
 '', NULL, 7.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mondsee Pirkau bei Hohenmölsen', 51.157398, 12.098184, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 'Befahrungsregelung beachten!; Anfüttern verboten!', NULL, 35.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Eisensee bei Hohenmölsen', 51.157398, 12.098184, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.83, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tagebaurestloch Kamerad bei Döbris', 51.110917, 12.124668, 'Sachsen-Anhalt', 'See',
 '["Blei", "Karpfen", "Schleie"]',
 '', NULL, 7.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Baggerteich in Naumburg', 51.152565, 11.809919, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.24, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Grubenteich bei Neidschütz', 51.103005, 11.806409, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßteich Klosterhäseler', 51.163792, 11.612284, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Karpfen"]',
 '', NULL, 0.85, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Saale von Landesgrenze Thüringen        A, B, Bl, D, H, K, bis Eisenbahnbrücke bei Eulau           Pl, Q, Ro, W, Z', 51.180171, 11.854360, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 125.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unstrutaltarm bei Memleben/ Wendelstein', 51.264604, 11.491452, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Toter Arm bei Nebra', 51.287308, 11.578788, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Restarm der Unstrut unter der Katzel bei Reinsdorf', 51.303232, 11.612498, 'Sachsen-Anhalt', 'Fluss',
 '["Blei", "Karausche", "Karpfen", "Plötze"]',
 '', NULL, 0.12, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unstrut von Landesgrenze Thüringen      A, B, Bl, D, H, K, bis zur Mündung in die Saale            Pl, Q, W, Z', 51.278116, 11.455785, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 117.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Weiße Grube Altenroda', 51.239042, 11.544124, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Blei", "Plötze", "Rotfeder"]',
 '', NULL, 0.62, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tagebaurestloch bei Gostau Trinkwasserbelehrung erforderlich! befischen freigegeben!', 51.219541, 12.109080, 'Sachsen-Anhalt', 'Stausee',
 '["Aal", "Hecht", "Karpfen", "Plötze"]',
 'Nur das Westufer ist zum Betreten und', NULL, 10.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Saale von Eisenbahnbrücke bei Eulau     A, B, Bl, Ba, D, bis Kleinkorbetha beidseitig und von    K, Pl, Q, R, W, Z Kleinkorbetha bis Einlauf Schleusengraben Bad Dürrenberg rechtsseitig 44', 51.180171, 11.854360, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 100.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Saale von Kleinkorbetha bis Einlauf  A, B, Bl, Ba, D, K, Pl, Schleusengraben Bad Dürrenberg       Q, R, W, Z linksseitig', 51.256011, 12.044017, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 25.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Naturbad Rehmsdorf', 51.058692, 12.212243, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Wels"]',
 '', NULL, 1.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neuer Teich in Meineweh', 51.076086, 11.988335, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Weiße Elster im Kreisgebiet          A, B, Ba, Bf, D, H, mit Ausnahme Posaer Furt bis Höhe    K, Pl, S, Ra, Ro, W Rinderstall Bornitz', 51.256097, 11.348142, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 '', NULL, 48.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Parkteich Hollsteitz', 51.078481, 12.033012, 'Sachsen-Anhalt', 'Teich',
 '["Barsch", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.81, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Phönix Nord', 51.082211, 12.266455, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 5.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alter Elsterarm Profen', 51.125731, 12.232615, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 1.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Revierparkteich Profen', 51.135533, 12.199116, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 6.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Elstermühlgraben Elsteraue', 51.167634, 12.255878, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Döbel", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 7.34, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hasselteich Droyßig', 51.041203, 12.005064, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Döbel", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Schleie"]',
 'Angelverbot vom 28.01. – 14.07.', NULL, 1.37, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wal in Göbitz', 51.085004, 12.185150, 'Sachsen-Anhalt', 'See',
 '["Barsch", "Karpfen", "Plötze"]',
 '', NULL, 0.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlgraben Wetterzeube', 51.004643, 12.014328, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Döbel", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlgraben Göbitz-Ostrau', 51.093309, 12.189195, 'Sachsen-Anhalt', 'Kanal',
 '["Aal", "Barsch", "Döbel", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.32, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Grasteich Spora', 51.039129, 12.279071, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen"]',
 '', NULL, 1.22, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Floßgraben von LG Thüringen bis Abschlagbauwerk Uthmig 45 Stadt Dessau-Roßlau', 51.102494, 12.178300, 'Sachsen-Anhalt', 'Kanal',
 '["Barsch", "Döbel", "Hecht"]',
 '', NULL, 4.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Diepold', 51.835922, 12.262851, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stillinge Nord Ausgenommen am Schwimmbad', 51.908994, 12.248636, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Rotfeder", "Zander"]',
 '', NULL, 0.9, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rehsumpf Ausgenommen Westseite am Tiergarten', 51.854895, 12.271847, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 3.22, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Die Bach (Hofsee) bei Kleutsch', 51.795623, 12.295827, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.43, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sollnitzer See', 51.768217, 12.318878, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 20.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Handelshafen Magdeburg', 52.144613, 11.658182, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Plötze", "Zander"]',
 '', NULL, 7.39, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Industriehafen Magdeburg', 52.174619, 11.673567, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Güster", "Hecht", "Plötze"]',
 '', NULL, 8.68, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Erdkuhle bei Rothensee', 52.183405, 11.659568, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen"]',
 '', NULL, 4.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dreier Kolke bei Zipkeleben', 52.102904, 11.708718, 'Sachsen-Anhalt', 'See',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 0.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Else-Kolke bei Zipkeleben', 52.102904, 11.708718, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.41, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('4 Kolke am Klusdamm', 52.105747, 11.685392, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Rotfeder", "Schleie"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Elbe Kreuzhorst', 52.086926, 11.699786, 'Sachsen-Anhalt', 'Fluss',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 17.45, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Baggerloch Kelterer bei Rothensee', 52.183405, 11.659568, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.17, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Obere Vorhäfen von Elb-km 330- 331,2 (südliche Schleusenkammer)', 51.885382, 12.249538, 'Sachsen-Anhalt', 'Fluss',
 '["Barsch", "Blei", "Plötze", "Zander"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sternsee Olvenstedt', 52.148264, 11.579045, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Schleie", "Wels", "Zander"]',
 '', NULL, 0.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wolter 1 und 2 bei Randau', 52.062160, 11.723004, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Güster", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 5.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Riemer 1, 2 und 3 bei Randau', 52.062160, 11.723004, 'Sachsen-Anhalt', 'See',
 '["Aal", "Blei", "Güster", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 3.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schloßteich in Randau', 52.062160, 11.723004, 'Sachsen-Anhalt', 'Teich',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Langer See (Großer See) bei Randau', 52.062160, 11.723004, 'Sachsen-Anhalt', 'See',
 '["Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gelbes Loch bei Randau', 52.062160, 11.723004, 'Sachsen-Anhalt', 'See',
 '["Karausche", "Karpfen", "Schleie"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Elbe bei Randau/Calenberge', 52.059733, 11.716781, 'Sachsen-Anhalt', 'Fluss',
 '["Barsch", "Blei", "Güster", "Hecht", "Plötze", "Rotfeder", "Schleie"]',
 '', NULL, 7.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesbaggerloch bei Randau', 52.062160, 11.723004, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schwarzer Krüger bei Randau', 52.062160, 11.723004, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.15, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kaltes Loch bei Randau', 52.062160, 11.723004, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Butz bei Randau', 52.062160, 11.723004, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karausche", "Plötze", "Schleie"]',
 '', NULL, 3.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('3 Teiche hinter der 3-Bogenbrücke in Pechau 48 Stadt Halle', 52.084257, 11.724476, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleines Posthorn rechtsseitig am Ortsausgang Halle Richtung Oppin', 52.041465, 12.124912, 'Sachsen-Anhalt', 'See',
 '["Schleie"]',
 '', NULL, 6.73, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Heidesee in Nietleben', 51.482276, 11.893516, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 13.35, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Osendorfer See', 51.431667, 12.022209, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Rotfeder", "Schleie", "Zander"]',
 '', NULL, 21.64, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kalksteinbruch in Neustadt', 51.479982, 11.923473, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 8.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kirchteich in Neustadt', 51.479982, 11.923473, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 2.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bruchsee in Neustadt', 51.479982, 11.923473, 'Sachsen-Anhalt', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.91, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Friedhofsteich Neustadt', 51.476270, 11.874752, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 5.33, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hufeisensee in Kanena                   A, B, Bl, H, K, Ro,', 51.457177, 12.037113, 'Sachsen-Anhalt', 'See',
 '[]',
 'Tauchsport beachten!                   S, W, Z', NULL, 71.64, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pulverweidenteich', 51.473544, 11.954092, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Rotfeder"]',
 '', NULL, 0.91, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Saale von Straßenbrücke B 91            A, B, Ba, Bl, Gü, bis zum Trompeterfelsen zwischen        D, H, K, Pl, Ro, W, Halle und Brachwitz -                   Z, Q, R', 51.415568, 11.954602, 'Sachsen-Anhalt', 'Fluss',
 '[]',
 'Einschränkungen NSG beachten!', NULL, 152.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich am Passendorfer Damm', 51.472186, 11.929530, 'Sachsen-Anhalt', 'Teich',
 '["Plötze", "Rotfeder"]',
 '', NULL, 0.46, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Reide von Braschwitz-Zöberitz bis Mündung in die Weiße Elster', 51.432665, 12.028456, 'Sachsen-Anhalt', 'Fluss',
 '["Aal", "Barsch", "Döbel"]',
 '', NULL, 1.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Cobra in Bruckdorf', 51.444628, 12.028465, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tongrube in Bruckdorf', 51.444628, 12.028465, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 1.08, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unsere Rast in Bruckdorf', 51.444628, 12.028465, 'Sachsen-Anhalt', 'See',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 '', NULL, 0.57, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ententeich in Planena', 51.413703, 11.958986, 'Sachsen-Anhalt', 'Teich',
 '["Hecht", "Karpfen", "Rotfeder", "Schleie"]',
 'Nur Süd- und Südwestufer!', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großes Posthorn linksseitig am Ortsausgang Halle Richtung Oppin 49 Freistaat Thüringen Es gilt das Fischereirecht des Freistaates Thüringen!', 52.041465, 12.124912, 'Sachsen-Anhalt', 'See',
 '["Aal", "Barsch", "Blei", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 'Anfüttern und Wasserfahrzeuge verboten!', NULL, 21.61, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlteich Bad Klosterlausnitz', 51.357545, 11.100687, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie", "Zander"]',
 '', NULL, 1.03, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Brauereiteich Bad Klosterlausnitz 50 Verzeichnis der gewässerbetreuenden Mitgliedsvereine des Landesanglerverbandes Sachsen-Anhalt e.V. Bei den folgenden aufgeführten Vereinen können weitere Informationen über die von ihnen betreuten Gewässer erfragt werden. 100 Anglerverein Aschersleben e.V. Frau Grit Rothhagen Schmidtmannstr. 96 06449 Aschersleben http://avaschersleben.de.tl 101 Angel- und Castingverein Ermsleben e.V. Herr Matthias Wiedmaier Anger 10a 06463 Ermsleben http://acv-ermsleben.mein-verein.de 110 AV Landkreis Bernburg e.V.		              Geschäftsstelle Herr Lutz Jahn 			                         Dr. -John-Rittmeister-Str. 29a Stiftstraße 48 			                         06406 Bernburg 06406 Bernburg www.anglerverein-bernburg.de 111 Anglerverein Nienburg/Saale e.V. Herr Frank Nowotnig Friedrichstraße 22 06429 Nienburg/Saale E-Mail: nowotnig@t-online.de www.anglerverein-nienburg-saale.de 112 AV Plötzkau 1959 e.V. Herr Sven Huns Hauptstraße 22 06425 Plötzkau 113 Preußlitzer Anglerverein e.V. Herr Karsten Lehwalter Preußlitzer Hauptstraße 26 06406 Bernburg/OT Preußlitz http://www.preusslitzer-anglerverein-ev.de/ 51 120 Anglerverein Bitterfeld e.V. Geschäftsstelle Herr Peter Eschke Parsevalstraße 13 OT Bitterfeld 06749 Bitterfeld-Wolfen www.anglerbitterfeld.de 121 AV Vergißmeinnicht Zscherndorf e.V. Herr Dirk Zeissler Siedlung Süd 39 06808 Bitterfeld-Wolfen/OT Holzweißig www.angelverein-vergissmeinnicht.de 122 AV Löberitz ´76 e.V. Herr Lutz Bohne Grötzer Platz 8 06780 Zörbig/OT Löberitz 130 Fischereiverein Burg 1990 e.V. Geschäftsstelle Herr Thomas Wittwer Ihelweg 30 39288 Burg www.fischereiverein-burg.com 140 Anglerverein Dessau e.V. 		            Geschäftsstelle Herr Norbert Wetzel 		                  Friederikenplatz 57 Kleine Schaftrift 72 			                06844 Dessau-Roßlau 06847 Dessau-Roßlau		                   jeden 2. und 4. Mittwoch 17.30 – 19.00 Uhr www.anglerverein-dessau.de 150 Angelsportgemeinschaft Eisleben e.V. Herr Andreas Günther Glück-Auf-Siedlung 54 06317 Seegebiet Mansfelder Land/OT Stedten www.asg-eisleben.de 52 151 DAV Ortsverein Eisleben e.V. Herr Jörg Karl Möhlenweg 1 25572 Kudensee http://dav-eisleben.de 160 KAV Gardelegen e.V. 		 Geschäftsstelle Herr Marco Scheel 			       Stendaler Chaussee 9 Seestr. 2 			               39638 Gardelegen 17166 Schorssow OT Bülow 161 Kalbenser ASV „Mildeufer 1935“ e.V. Herr Kay Grahmann Am Petersberg 2 39624 Kalbe (Milde) Tel. 015254067161 ASV-Mildeufer1935@outlook.de 170 AV Genthin e.V. Herr Bernd Seeger Fröbelstraße 37 39307 Roßdorf 171 Sportanglerclub Parey/Elbe e.V. Herr Torsten Kuhfuß Straße der Freundschaft 13 39307 Genthin 173 AV „Ihle“ Bergzow e.V. Herr Torsten Wiemer Rotdornstr. 3 39307 Bergzow www.anglerverein-bergzow.de 180 AV Gräfenhainichen e.V. Herr Michael Dietrich Schmiedeberger Str. 6 06773 Gräfenhainichen/OT Schköna www.avgraefenhainichen.gmxhome.de 53 181 AV „Heide Gräfenhainichen“ e.V. Herr Karsten Freier Hauptstraße 32 06901 Kemberg/OT Rotta www.av-heide.de 182 Anglerverein Möhlau e.V. Frau Jenny Scholtbach Karl-Liebknecht-Str. 26 06772 Gräfenhainichen www.anglerverein-moehlau.de 183 AV „Wörlitzer Winkel“ e.V. Herr Jochen Jäkel Waldblick 3 06785 Oranienbaum-Wörlitz 184 Bergwitzer Angelverein e.V. Herr Ralph Bachmann Grubenweg 31 06901 Kemberg/OT Bergwitz www.angelverein-bergwitz.de 190 AV Halberstadt-Harzvorland e.V. Herr Dirk Boenigk Juri-Gagarin-Straße 17 38820 Halberstadt 191 Angelsportclub Huy-Fallstein e.V. Herr Werner Lentzen Erich-Weinert-Straße 12 38820 Halberstadt www.huy-fallstein.de 200 KAV Haldensleben e.V. Herr Jan Sandke Bürgerdamm 5 039646 Oebisfelde OT Breitenrode www.kav-haldensleben.de 54 201 AV „Oberes Allertal“ e.V. Herr Stefan Stotmeister Im Kloster 4a 39343 Beendorf www.av-oberes-allertal.de 210 Hallescher Anglerverein e.V. Geschäftsstelle Herr Falk Petzold Mansfelder Straße 33 06108 Halle www.hallescher-anglerverein.de Tel. 0171 2630393 212 AV „Am Posthornsee“ Halle e.V. Geschäftsstelle Herr Harry Kindt			             Anglerheim am Posthornsee Am Grünen Feld 25			            Sprechzeit jeden letzten 06130 Halle			                  Donnerstag im Monat Tel. 0345/5323006			            von 16.30 – 18.00 Uhr www.anglerverein-posthornsee.de 220 „SFV Havelberg e.V. 1990“		          Geschäftsstelle Herr Hans-Joachim Ganzer		            Lange Str. 12 Am Wehl 5 			                         39539 Havelberg 39539 Havelberg/OT Garz 230 AV „Wippertal“ e.V. Herr Jörg Kochan Siedlungsstr. 11 06456 Arnstein/OT Wiederstedt www.av-wippertal.de 240 Anglerverein Hohenmölsen e.V. Herr Christian Dämmerich Landstr. 5 06679 Hohenmölsen OT Aupitz www.verband-der-angler-hohenmoelsen.com 241 Anglerverein Hohenmölsen 1962 e.V. Herr Stephan Meissner August-Bebelstr. 34 06679 Hohenmölsen www.av-hhm1962.de 55 250 DAV Territorialverband Jessen e.V. Herr Gerd Scharfenberg Am Stadtwald 8 06917 Jessen http://angelnjessen.jimdo.com DAVTrVJessen@t-online.de 251 AV „Lachs“ Prettin e.V. Herr Rudolf Weber Hohe Straße 9 06925 Annaburg/OT Prettin 252 ASV Elster/Elbe 1934 e.V. Herr Sven Mickosch Seydaer Straße 23 06895 Zahna-Elster/OT Elster www.angelsportverein-elster.de 253 AV „Ausdauer“ Annaburg e.V. www.dav-annaburg.de 260 Anglerverein Klötze und Umbgebung e.V Herr Karsten Scholz Ringstr. 20 38486 Klötze 261 Anglerverein Oebisfelde e.V.		          Geschäftsstelle Herr Steffen Lachmann		                  Schildplatz 1 Lambrechtsdamm 7		                       39646 Oebisfelde-Weferlingen 39646 Oebisfelde-Weferlingen/OT Breitenrode www.angelverein-oebisfelde1926.de 271 Großgruppe AC 66 Köthen e.V. Herr Bernd Hauschild Jakobstr. 11 06366 Köthen https://ac66.de 272 Anglerverein Aken e.V. Herr Günther Pakendorf Ringstr. 6 06385 Aken/Elbe http://www.av-aken.de 56 273 Regionalverband Fuhnetal e.V. Herr Tino Hilbig Dorfstr. 23 06369 Südliches Anhalt OT Hohnsdorf www.rv-fuhnetal.de 275 Anglerverein Osternienburg e.V. Herr Swen Kolze Aribertstr. 5 06386 Osternienburg 276 AV Köthen e.V. Herr Klaus Kluge Emil-von-Behring-Straße 5 06366 Köthen 280 Magdeburger Anglerverein e.V. Geschäftsstelle Herr Matthias Kabel Beimsstr. 89a 39110 Magdeburg www.magdeburger-anglerverein.de 282 ASV Neustädter See e.V. Geschäftsstelle Frau Christine Beier Am Vogelgesang 2a 39124 Magdeburg www.asv-neustaedter-see.de 290 KAV Merseburg e.V. Geschäftsstelle Neumarkt 5 06217 Merseburg Tel. 03461/249792 www.kav-merseburg.de 300 AV Naumburg/Saale 1924 e.V. Herr Peter Vulpius Zacharias-Hildebrandt-Str. 16 06618 Naumburg www.angler-naumburg.de 57 310 AV Unstruttal e.V. Herr Henry Kaufmann Dorfstr. 12 06642 Nebra/OT Reinsdorf www.anglerverein-unstruttal-nebra.de 330 AV Landkreis Osterburg e.V. Geschäftsstelle Herr Jens Hoffmann Steinstr. 33 39615 Seehausen (Altmark) anglerverein-osterburg@t-online.de 332 AV Heiligenfelde e.V. Herr Jens-Peter von Wiegen Dorftsraße 65 39606 Altmärkische Höhe/OT Kossebau 334 ASV Werben/Elbe e.V. Herr Harald Metz Kirchstraße 6 39615 Werben/Elbe Tel. 01723036713 340 AV Ostharz Quedlinburg e.V. 		           Geschäftsstelle Herr Detlef Kittel 			                    Am Schiffsbleek 4 Benneckenrode 33     		                   06484 Quedlinburg 06502 Thale 351 AV Weitzschkerbach Farnstädt e.V. Herr Dietrich Umpfenbach Röblinger Straße 47 06279 Farnstädt http://av-weitzschkerbach-farnstaedt.de 352 RAV Quernetal e.V. Herr Mario Höfer Gänsewinkel 8 06268 Obhausen 58 353 Angelverein Ziegelroda e.V. Herr Klaus Krumpe Wendelsteiner Straße 6 06268 Querfurt/OT Ziegelroda 360 KAV Roßlau e.V. Herr Steffen Gebauer Fliederweg 1 06869 Coswig/OT Cobbelsdorf 361 Angelfreunde Coswig/Anhalt e.V. Herr Reiner Michna Lugweg 71 06869 Coswig (Anhalt) www.angelfreunde-coswig.de 370 KAV Saalkreis e.V.                     Geschäftsstelle Herr Bernd Schuhmann 		                 Coloniestraße 27 Am Heiderand 6      		                  06198 Brachwitz 06198 Salzatal/OT Lieskau www.kav-saalkreis.de 371 GLAV „Oberes Götschetal e.V. Herr Nick Dohndorf Sommerweg 2 06193 Wettin-Löbejün 380 ASV Salzwedel e.V. 		                  Geschäftsstelle Herr Uwe Hartmann 		                    Böddenstedter Weg 12a Dankensen 16        		                  29410 Salzwedel 29413 Diesdorf hartmann-dankensen@t-online.de 381 ASV Mechauer Angelfreunde e.V. Herr Matthias Herrmann Am Anger 4 29410 Salzwedel 390 KAV Sangerhausen e.V. Herr Gerhard Jarosz Karl-Marx-Straße 8 06526 Sangerhausen www.kreisanglerverein-sangerhausen.de 59 400 KAV Schönebeck e.V. Geschäftsstelle Herr Oliver Kreuseler Wilhelm-Hellge-Straße 233 39218 Schönebeck Tel./Fax 03928/403599 www.kreisanglerverein-schoenebeck.de 401 FV „Elbe-Saale-Winkel“ e.V. Herr Jürgen Alt Zerbster Straße 26 39240 Groß Rosenburg 402 ASV Elbe-Saale-Barby e.V.		 Vereinsbüro Herr Wilhelm Köhler		        Goethestr. 14 Amthofstraße 13			           39249 Barby 39249 Barby/Elbe			          Tel. : 039298-296999 (AB) www.asv-barby.de			          Fax : 039298-296997 Geschäftszeit: Jeden 2. Dienstag im Monat jeweils von 17.00 -18.00 Uhr oder nach tel. Absprache 410 SFV Staßfurt e.V. Herr Mike Beyer Witteanger 24 06463 Falkenstein/Harz OT Reinstedt sfvStassfurt@web.de 411 SFV Löderburg e.V. Herr Andreas Herrmann Hertzstr. 14 39112 Magdeburg www.sfv-loederburg.de 420 Stendaler Anglerverein e.V. 		          Geschäftsstelle Herr Frank Bartels			                    Bruchstr. 1 Vinzelberger Weg 11		                    39576 Stendal 39576 Stendal 			                        Donnerstag 18.00 – 19.00 Uhr www.stendaler-anglerverein.de		          Tel. 03931/7073046 kontakt@stendaler-anglerverein.de 60 421 Anglerverband Tangerhütte e.V. Herr Torsten Schulze August-Bebel-Str. 1 39517 Tangerhütte/OT Kehnert 422 Anglerclub Tangermünde e.V. Herr Frank Weichardt Carlbauer Str. 73 39590 Tangermünde www.tangermuender-anglerclub.de 423 AV Buch e.V. Herr Dirk Seeberger Lindenstraße 25 39517 Köckte 424 SAV Grieben/Elbe e.V. 		                Geschäftsstelle Herr Ronald Fassl			                     Gerald Bauer Bittkauer Gartenstr. 4 		                Haidstr. 14 39517 Tangerhütte OT Bittkau 		          39517 Grieben/Elbe 426 Stendaler Angelfreunde RAW e.V. Herr Frank Eger Wahrburger Straße 134 39576 Stendal www.stendaler-angelfreunde.de 430 KAV „Bördekreis“ e.V. Frau Heike Wanowski Wolfenbütteler Str. 15 39112 Magdeburg heike-wanowski@web.de 431 AV „Altenweddingen und Umgebung“ e.V. Herr Albrecht Fromme Karl-Liebknecht-Str. 2c 39171 Sülzetal/OT Altenweddingen www.anglerverein-altenweddingen.de 61 432 Anglerverein Krottorf e.V. Herr Tino Mönch Sankt-Stephanus-Straße 7a 39387 Oschersleben OT Schermcke 440 KAV Weißenfels e.V. 		                     Geschäftsstelle Herr Gerd Hauser 			                        Schulstr. 11 Bad-Dürrenberger-Straße 6 		                06688 Schkortleben 06686 Lützen/OT Lösau		                     Tel./Fax 034446/900021 www.kav-weissenfels.de 441 AV Lützen e.V. Herr Jürgen Wiesener Friedrich-Engels-Straße 35 06686 Lützen 443 AV Wengelsdorf 2010 e.V. Herr Andre Wasserzier Am Gymnasium 2 06688 Großkorbetha 450 Vereinigung Nordharzer Angelvereine e.V. Herr Udo Leier Kallendorfer Weg 12a 38889 Blankenburg 460 KAV Wittenberg e.V. Herr Oliver Precht Wittenberger Str. 65 06888 Lutherstadt Wittenberg www.kreisanglerverein-wittenberg.de 470 AV „Untere Ohre“ e.V. Geschäftsstelle Manfred Derbe Abendstr. 7 39179 Barleben Tel. 0392035337 471 Fischereiverein Rogätz e.V. Herr Sebastian Beier Magdeburger Straße 19 39326 Rogätz 62 472 Wolmirstedter SAC 1926 e.V. Geschäftsstelle/Geschäftsführer Herr Jörg Hoffmann Gartenstraße 4 39326 Wolmirstedt Tel. 039201/323052 Mobil 01707723595 avwms@t-online.de www.av-wolmirstedt.de 480 KAV „Weiße Elster“ Zeitz e.V. Herr Reinhard Röhling Weißenborner Weg 14 06722 Droyßig www.kreisanglerverein-zeitz.de 482 Zeitzer Angelfischereiverein e.V. Herr Karl-Ulrich Axthelm Leipziger Str. 13 06711 Zeitz-Zangenberg http://zeitzer-angelfischereiverein.de 490 Anglerverein Zerbst e.V. Herr Gerhard Wurche Lange Str. 15 39261 Zerbst www.anglerverein-zerbst.de 491 AV Nuthe-Elbe Gödnitz e.V. Herr Frank Rummel			                      Telefon 03923621947 Kirschallee 3			                          von 9.00 – 13.00 Uhr und 39261 Zerbst			                           von 14.00-18.00 Uhr 492 AV Vorfläming e.V. Herr Oswald Wieczorek Burgstraße 4 39279 Loburg 500 AV Bad Klosterlausnitz e.V. Herr Mike Wendt Uhlandstr. 17 07629 Bad Klosterlausnitz www.av-1990.de 63 Ab sofort können Mitglieder des LAV Sachsen-Anhalt in einem festgelegten Zeltplatz bis zur Mittelwiese und außerhalb des Strandbades. Voraussetzung ist eine Belehrung und der Erwerb einer kostenlosen Angelkarte. Diese Angelkarte gibt es im Bürgerservice der Stadt Kelbra gegenüber vom Penny- Markt. Dieser Bürgerservice hat täglich von 10.00 Uhr bis 15.00 Uhr geöffnet. Gastangler erhalten ebenfalls im Bürgerservice oder an der Zeltplatzrezeption Tages-, Wochen-, Monats- oder Jahreskarten zu moderaten Preisen. Voraussetzung ist ein gültiger Fischereischein. Die Talsperre liegt in Teilen im Freistaat Thüringen und ist dort in Teilbereichen Angeln gibt es einige Einschränkungen, welche auf der Angelkarte vermerkt sind. Die Talsperre darf nicht von Inhabern der Austauschangelberechtigung der beiden Thüringer Verbände beangelt werden. Beschränkungen, welche sich aus dem Fischereipachtvertrag ergeben und unbedingt einzuhalten sind: Dem Pächter bzw. den von diesem mit der Ausübung der Fischerei beauftragten Personen sowie den Inhabern von Angelberechtigungen ist das Befahren der Uferzone mit Kraftfahrzeugen aller Art sowie das Abstellen von Kraftfahrzeugen aller Art und das Aufstellen von Zelten und Wohnwagen in der Allgemeinverfügung des Saalekreises landseitig gekennzeichneten Flächen betreten werden. Die Aufforstungsflächen in den Böschungsbereichen dürfen nicht betreten werden. Ohne Fischereischein und Erlaubnisschein darf die Fischerei nicht ausgeübt werden. Der Pächter ist nicht berechtigt, Erlaubnisscheine an Personen zu erteilen, die nicht im Besitz eines gültigen Fischereischeines sind. Unter Naturschutz stehende Bäume, Gehölze und Pflanzen sowie Getier sind zu schützen. Die Fischereiausübung erfolgt gemäß der rechtskräftigen Allgemeinverfügung des Saalekreises, einsehbar unter www.saalekreis.de 64 Gewässerordnung des Landesanglerverbandes Sachsen-Anhalt 1. Prämbel Die Gewässerordnung des LAV Sachsen-Anhalt e.V. regelt in Umsetzung des Fischereigesetzes für das Land Sachsen-Anhalt und der Fischereiordnung des Landes Sachsen-Anhalt die Ausübung der Angelfischerei an den Gewässern des LAV Sachsen-Anhalt e.V. In der Gewässerordnung werden außerdem die Grundsätze für die Betreuung und die Bewirtschaftung der Gewässer des gemeinsamen Gewässerfonds des LAV Sachsen-Anhalt e.V. dargelegt. Oberstes Prinzip des LAV Sachsen-Anhalt e.V. ist es, die Gewässer als Lebensraum zu erhalten und vor Schädigungen zu schützen, sowie einen der Größe und der Beschaffenheit des Gewässers entsprechenden artenreichen, gesunden, ausgeglichenen und naturnahen Fischbestand zu erhalten und aufzubauen. Die Gewässer als Lebensraum und die in ihnen beheimateten Tiere und Pflanzen sind Bestandteile des Naturhaushaltes. Ordnungsgemäße Fischerei dient der Erhaltung eines ausgewogenen Naturhaushaltes der Gewässer und dem Naturschutz in der historisch gewachsenen Kulturlandschaft. Ordnungsgemäße Fischerei ist ein Teil der Kulturgeschichte. Als Angelfischerei stellt sie neben der zusätzlichen Nahrungserwerbsmöglichkeit eine sinnvolle Freizeit- und Erholungsgestaltung dar. 2. Verhalten der Angler am Wasser Jeder Angler ist verpflichtet, sich vor dem Angeln zu informieren, ob es sich um ein Gewässer des gemeinsamen Gewässerfonds des LAV Sachsen-Anhalt e.V. handelt, Angelfischerei beinhaltet u.a. die Einhaltung von Ordnung und Sauberkeit am Angelgewässer und dessen Zugang, die Beachtung aller über das Fischereigesetz hinaus geltenden Rechtsvorschriften sowie eine aktive Unterstützung aller dem Schutz dieses Gewässers dienenden Maßnahmen. Die Angler haben sich so zu verhalten, dass Personen, andere rechtmäßige Nutzungen und die natürliche Umwelt nicht gefährdet oder geschädigt werden. Dafür sind Verantwortungsbewusstsein, Disziplin, gegenseitige Rücksichtnahme und Vorsicht Grundvoraussetzungen. Hunde müssen angeleint geführt werden. Bei Kontrollen sind alle Hunde außerhalb des Angelbereiches zu führen und zu befestigen. Jeder Angler hat die Angelfischerei so auszuüben, dass andere bei ihrer Fischereiausübung nicht unzumutbar beeinträchtigt werden und dass ein ausreichender Abstand zwischen den Anglern eingehalten wird. Ein Angler kann maximal so viel Platz in Richtung Wasserfläche beanspruchen, wie er die von ihm gewählte Fangmontage selber werfen kann und benachbarte Angelplätze nicht blockiert werden. Das Ausbringen von Bojen und anderen Kennzeichnungen in das Gewässer, um den in Anspruch genommenen Angelplatz abzugrenzen, ist nicht gestattet. Hierunter ist auch das „Abspannen von Angelplätzen“ zu verstehen. Bei der Wahl des Angelplatzes hat der Zuerst kommende das Vorrecht der Angelausübung. Angelplätze sind sauber zu halten und sauber zu hinterlassen. Bei Kontrollen durch Fischereischutzberechtigte gilt derjenige als Verursacher der 1 Verschmutzung der Angelstelle, der an dieser angetroffen wird. Ausgelegte Angeln müssen sich unter ständigem Sichtkontakt des Anglers befinden. Dem Gewässer entnommene Fische müssen vor Ort in die Fangstatistik eingetragen werden. An allen Angelgewässern des LAV hat der Angler die Befugnis, die an das Gewässer angrenzenden Ufer, Anlandungen, Schifffahrtsanlagen sowie Brücken, Wehre, Schleusen und sonstige Wasserbauwerke auf eigene Gefahr zu betreten und zu benutzen, soweit dies zum Zwecke der Fischerei erforderlich ist und öffentlich- rechtliche Vorschriften nicht entgegenstehen. Die Befugnis erstreckt sich nicht auf Gebäude, zum unmittelbaren Haus-, Wohn- und Hofbereich gehörende Grundstücksteile und gewerbliche Anlagen mit Ausnahme von Campingplätzen. Die Befugnis ist so auszuüben, dass Schäden an Gewässern, angrenzenden Ufern und Anlandungen vermieden, die Wassergüte nicht beeinträchtigt und die Funktionsfähigkeit der Anlagen nicht gestört werden. bezeichnet, derer sich der Mensch mittels Hilfsmittel bedient, um sich auf einem Gewässer zu bewegen oder Gegenstände auf einem Gewässer zu transportieren. jeweiligen Gewässer benutzt oder gebaut werden dürfen, trifft der betreuende Verein in Abstimmung mit der zuständigen Umweltbehörde, dem Eigentümer und dem LAV Sachsen-Anhalt e.V.. entnehmen Sie dem Gewässerverzeichnis des LAV Sachsen-Anhalt e.V. In allen Angelarten verankert sein, die Verankerungen sind nach dem Angeln wieder Alle Angler haben die Pflicht, bei der Feststellung von Fischsterben, Fischkrankheiten, Gewässerverunreinigungen und Fischfrevel entsprechend den ihnen zur Verfügung stehenden Möglichkeiten Maßnahmen zur Unterbindung einzuleiten. Fischsterben sind unverzüglich der Unteren Fischereibehörde oder einer Polizeibehörde anzuzeigen, und es ist der Fischereiausübungsberechtigte zu informieren. Biosphärenreservaten und von Naturparken hat sich die Angelfischerei vorrangig an den Zielen des Naturschutzes zu orientieren. Bei der Beangelung von Gewässern in Naturschutz- u.ä. Gebieten sind für diese Nach § 20 c des Bundesnaturschutzgesetzes, bzw. § 30 Naturschutzgesetz 2 des Landes Sachsen-Anhalt,        besonders geschützte Biotope (Gelegezonen, Verlandungsbereiche, naturnahe und unbebaute Uferabschnitte) dürfen nicht zerstört oder erheblich oder nachhaltig beeinträchtigt werden. Gegenüber Fischereischutzberechtigten, bestätigten Fischereiaufsehern und benannten Fischereiaufsehern der Vereine hat sich jeder Angler mit der Mitgliedskarte, dem Fischereischein und den entsprechenden Fischereierlaubnisscheinen auszuweisen und diese Dokumente zur Einsichtnahme auszuhändigen. Beim Angeln in Gewässern des gemeinsamen Gewässerfonds des LAV Sachsen- Anhalt e.V. gilt das Gewässerverzeichnis des LAV Sachsen-Anhalt e.V. als Bestandteil des Fischereierlaubnisscheines und ist deshalb ebenfalls zur Einsichtnahme vorzulegen. Das benutzte Angelgerät, verwendete Köder und gefangene Fische sind zur Kontrolle vorzuweisen. Gegenüber von Personen, die in einem Gewässer unberechtigt fischen oder sonstige Zuwiderhandlungen gegen fischereirechtliche Vorschriften begehen, haben die Fischereischutzberechtigten und die bestätigten Fischereiaufseher weiterhin die Befugnis, sie anzuhalten, ihnen gefangene Fische und Fanggeräte abzunehmen (Sicherstellung) und die Identität ihrer Person festzustellen. Wenn es sich um Verstöße gegen die Gewässerordnung handelt, können auch die benannten Fischereiaufseher die betreffende Person vom Gewässer verweisen bzw. den Fischereierlaubnisschein einbehalten. 3. Bewirtschaftung und Betreuung der Gewässer des LAV Sachsen-Anhalt e.V. Die Gewässer des LAV Sachsen-Anhalt e.V. bestehen aus vom LAV gepachteten, dem LAV zur Nutzung überlassenen Gewässern sowie Gewässern, die Eigentum des LAV sind und aus Gewässern, die die Mitgliedsvereine in den gemeinsamen Gewässerfonds des LAV eingebracht haben. Die Gewässer des LAV werden als Angelgewässer genutzt.Im Sinne der Hegepflicht darf die Intensität der Angelfischerei die nachhaltige Ertragsfähigkeit eines Gewässers nicht beeinträchtigen. Die Angelgewässer des Gewässerfonds des DAFV stehen allen Mitgliedsvereinen des LAV und deren Mitgliedern zum Angeln zur Verfügung, wenn sie im Besitz einer gültigen Fischereierlaubnis des jeweiligen Bundeslandes sind. Die Betreuung und Bewirtschaftung der Angelgewässer obliegt dem jeweils zuständigen betreuenden Angelverein in Abstimmung mit dem LAV Sachsen-Anhalt e.V. Art und Weise der Betreuung der Angelgewässer sowie Maßnahmen der Angelgewässerbewirtschaftung werden in den Pachtverträgen und in den Betreuungsvereinbarungen geregelt. Alle Angler des LAV Sachsen-Anhalt e.V. sind zu Hegeleistungen an den Gewässern verpflichtet. 3 Verein entscheidet in Abstimmung mit dem Landesanglerverband über die Nutzung der Gewässer als allgemeines Angelgewässer bzw. über die Nutzung als Salmonidengewässer. Die Nutzung und Bewirtschaftung aller Angelgewässer des LAV richtet sich nach ökologischen und fischereiwirtschaftlichen Gesichtspunkten, die durch den LAV allen Vereinen zu vermitteln sind. 4. Ausübung des Angelns 4.1 Berechtigung zum Angeln Das Angeln ist erlaubnispflichtig. Der Fischereischein berechtigt zum Erwerb von Fischereierlaubnisscheinen. Fischereibefugte      (Inhaber      eines     Fischereischeines      und       eines Fischereierlaubnisscheines für die      betreffenden Gewässer) können in den allgemeinen Gewässern des LAV Sachsen-Anhalt e.V. das Friedfischangeln, das Raubfischangeln, das Fluganglen und das Nachtangeln ausüben. Für das Angeln in Salmonidengewässern muss eine zusätzliche Angelerlaubnis erworben werden. Beim Angeln sind der Fischereischein, der Fischereierlaubnisschein, das Gewässerverzeichnis und die Gewässerordnung sowie die Fangkarte und von Mitgliedern des LAV Sachsen-Anhalt die Mitgliedskarte mitzuführen. Inhaber des Jugendfischereischeines und des Sonderfischereischeines, die Mitglied in einem Verein des LAV sind, dürfen mit Zustimmung der Erziehungsberechtigten berechtigt. Jugendfischereischeininhaber sollten den Nachweis der Grundstufe im Schwimmen erbringen. Sonderfischereischeininhaber dürfen an den Gewässern des LAV S-A das fischereibefugt sein muss. Vereine betreut werden, Tages-, Wochen- und Monatsfischereierlaubnisscheine erwerben. Beim Erwerb der Fischereierlaubnisscheine ist ein gültiger Fischereischein vorzuweisen. Mitglieder von Vereinen anderer Bundesländer können in den Gewässern des LAV Sachsen-Anhalt e.V. mit den entsprechenden Dokumenten ihres Vereins und unseres Landesverbandes angeln. Die Dokumente unseres Landesverbandes für Landesanglerverband Sachsen-Anhalt e.V. ausgegeben. 4 4.2Angelgeräte 4.2.1.1 Angler dürfen in den allgemeinen Gewässern des LAV Angelgeräte wie folgt verwenden: Inhaber des Fischereischeines und einer gültigen Fischereierlaubnis dürfen mit zwei Wurfruten mit Rolle und einer Kopfrute ohne Rolle (Stippangel) auf Raubfische und Inhaber des Fischereischeines und einer gültigen Fischereierlaubnis dürfen mit einer Spinnangel oder einer Flugangel oder einer Hegene nach 4.2.2 angeln. Wenn die Spinnangel oder die Flugangel oder die Hegene benutzt wird, dürfen gleichzeitig keine weiteren Angeln verwendet werden. Inhaber des Jugendfischereischeines oder des Sonderfischereischeines oder des zwei Friedfischangeln nach 4.2.2 und einer Kopfrute ohne Rolle (Stippangel) auf Friedfisch angeln. Gefangene Raubfische, Hecht, Rapfen, Wels, Zander und Salmoniden sind schonend zurückzusetzen. Eine Unterstützung des Anglers durch eine nicht fischereibefugte Person ist möglich für: 1. den Transport und die Beaufsichtigung aller Fischereigeräte des Anglers 2. das Auswerfen und Halten einer Angelrute, mit Ausnahme von Spinn- und Flugangel 3. den Einsatz des Unterfangkeschers beim Anlanden und 4. weitere Hilfstätigkeiten ohne Kontakt zum lebenden Fisch Die Anzahl und Art der nach §1 Abs.4 Satz 1 und 3 der Fischereiordnung des Landes Sachsen-Anhalt erlaubten Fischereigeräte dürfen hierdurch nicht überschritten werden. 4.2.1.2 Angler dürfen in Salmonidengewässern des LAV Angelgeräte wie folgt verwenden: Inhaber des Fischereischeines und einer gültigen Fischereierlaubnis für Salmonidengewässer dürfen in Salmonidengewässern eine Flugangel oder eine Spinnangel entsprechend Ausschilderung der Gewässerstrecke benutzen. 4.2.2 Die einzelnen Angelgeräte müssen wie folgt beschaffen sein: Friedfischangel Eine Friedfischangel besteht aus einer Rute mit oder ohne Rolle, einer Angelschnur, mit oder ohne Pose und Beschwerung, und einem einschenkligen Haken, der mit pflanzlichen oder tierischen Ködern oder Nachbildungen dieser bestückt ist. Bei Benutzung der Friedfischangel nicht erlaubt ist die Verwendung 5 von Köderfischen, anderen Wirbeltieren, Zehnfußkrebsen oder Teilen von allen diesen Ködern (Fetzenköder), Kunstköder, die zum Fang von Raubfischen geeignet sind, insbesondere Spinner, Blinker, Wobbler, Twister, Pilker und Jigs. Als Friedfischangel zählt auch die Mormyschkaangel. Mormyschkaköder dürfen nur senkrecht im Wasser bewegt werden. Sie dürfen nicht größer als 2 cm sein und zusätzliche Beköderung mit Friedfischködern ist zulässig. Vorrichtungen, die beim Anbiss eines Fisches diesen narkotisieren oder selbstständig einen Anhieb setzen, Raubfischangel Rute mit Rolle und einem toten Köderfisch der erlaubten Arten oder einem geschützte Arten (siehe Pkt. 5.2) als Köder zu verwenden. Lebende Köderfische der Fischereiordnung) verwendet werden. Spinnangel Rute mit Rolle und künstlichem Köder oder totem Köderfisch, bei der der Köder durch den Angler ständig bewegt wird. Die Hakenzahl ist auf drei Einfach-, Doppel- bzw. Drillingshaken begrenzt. Die Verwendung von Ködern mit feststehenden Haken ist nicht gestattet, ausgenommen sind Krautblinker und Weichplastikköder. Montagen und Angelmethoden, bei denen der Köder ständig ausgeworfen, bewegt und wieder eingeholt wird, gelten unabhängig von der Beköderung, als Spinnangel. Schleppangel erteilt der betreuende Verein in Abstimmung mit dem Landesanglerverband. Flugangel 6 Hegeneangel von denen seitlich bis zu fünf, in der Höhe versetzte kurze Seitenarme mit jeweils Würmern oder Maden oder mit Nachbildungen von Fliegenlarven (Nymphen) bestückt sein. 4.3 Besonderheiten beim Raubfischangeln „Als Köderfische dürfen alle Arten gefangen,          verwendet und gehältert werden, die nach der Fischereiordnung des Landes Sachsen-Anhalt und der Gewässerordnung des LAV Sachsen-Anhalt e.V. keinem Fang- und Zum Köderfischfang darf eine Senke verwendet werden,              die maximal 1, 20 x 1, 20 m groß sein darf und eine Maschenweite von mindestens 6 mm hat. 4.4 Besonderheiten beim Angeln in Salmonidengewässern (gekennzeichnet mit Schildern der Anlage 1) Voraussetzung für das Angeln in Salmonidengewässern ist der Erwerb einer Fischereierlaubnis für Salmonidengewässer. Wobbler mit einem Drilling verwendet werden. In Salmonidengewässern ist die Benutzung der Wasserkugel oder anderer Auftriebskörper nicht gestattet, ebenso ist der Einsatz von Ködern aus Weichplastik Köderfischsenken dürfen in Salmonidengewässern nicht verwendet werden. Beim Spinn- und Flugangeln in Salmonidengewässern ist jeder Zusatz von natürlichen Ködern unzulässig. Der betreuende Verein kann einzelne Gewässerstrecken für das Watangeln sperren sowie Flugangelstrecken und Schonstrecken festlegen. Die betreffenden Gewässerstrecken sind dementsprechend zu kennzeichnen (siehe Anlage 1) 7 4.5 Besonderheiten beim Nachtangeln Als Nachtangeln gilt die Zeit von einer Stunde nach Sonnenuntergang bis eine und unter Aufsicht einer Person, die das 18. Lebensjahr vollendet hat, ausüben. 4.6 Regeln für das Eisangeln Eisangeln darf auf allgemeinen Angelgewässern des LAV unter Beachtung der persönlichen und gegenseitigen Sicherheit erfolgen. Das Eisangeln geschieht Die Festlegungen der Rechtsträger und der zuständigen Verwaltungsbehörden sind Eislöcher dürfen an der Unterseite der Eisdecke einen Durchmesser bzw. eine Kantenlänge von 20 cm nicht überschreiten. Sie sind nach der Beendigung des Eisangelns deutlich zu kennzeichnen. 4.7 Regeln für das Angeln in Talsperren und wasserwirtschaftlichen Speichern Vor Beginn des Angelns hat sich jeder Angler über die spezifischen Besonderheiten dieser Gewässer zu informieren. Die Festlegungen der Betreiber, Eigentümer und 4.8 Regelung für gemeinschaftliche Angelveranstaltungen (Hegeangeln) Gemeinschaftliche Angelveranstaltungen bedürfen des vernünftigen Grundes und müssen vom für das Gewässer zuständigen Fischereiausübungsberechtigten und von der zuständigen Unteren Fischereibehörde genehmigt werden, wenn eine anschließende Bewertung erfolgen soll. Ein vernünftiger Grund liegt vor, wenn - eine anschließende Verwertung des Fanges vorgenommen wird, - eine Bestandsregulierung zum Zwecke des Umsetzens in andere Gewässer vorgenommen wird, - Fische für wissenschaftliche Zwecke benötigt werden, - der Fang von Laichfischen betrieben wird. Die Fische sind art- und mengenmäßig zu erfassen. Es ist ein Fangprotokoll zu fertigen. Dies dient als Beleg für die Bewirtschaftungsmaßnahme und zum Führen der Fangstatistik. Traditionsveranstaltungen wie z.B. An- und Abangeln, Veteranentreffen, die als gemeinschaftsfördernde Veranstaltungen durchgeführt werden und bei denen 8 keine Bewertung der Fänge erfolgen soll, sind nicht genehmigungspflichtig. Alle Angelveranstaltungen sind mindestens 4 (vier) Wochen vor Durchführungstermin beim für das Gewässer zuständigen Verein zur Koordinierung anzumelden. 4.9 Sonstige Regelungen Beim Angeln kann ein Wetterschutz (z.B. Schutzschirm, ein Schutzschirm mit Überwurf) benutzt werden. dafür vorgesehenen Flächen erfolgen. Die Anfahrt an die Gewässer und das Parken muss auf dafür freigegebenen Straßen, Wegen und Parkplätzen erfolgen. Der Beschilderung an den Gewässern ist unbedingt Folge zu leisten. gestattet. Geringe Mengen Lockfutter bei der Ausübung der Angelfischerei widersprechen außerhalb von Schutzgebieten nicht den Grundsätzen einer ordnungsgemäßen Fischerei. Eine gewerbliche bzw. kommerzielle Nutzung der in den Gewässerfonds des LAV Sachsen-Anhalt e.V. eingebrachten Gewässer ist nicht gestattet bzw. unzulässig. Dies trifft insbesondere auf Veranstaltungen wie z.B. das Angelguiding zu. In diesem Zusammenhang wird auch auf den § 1 des Tierschutzgesetzes verwiesen. Für gewerbliche bzw. kommerzielle Nutzungen dürfen keine Fischereierlaubnisscheine - allgemein als Gastkarten bezeichnet - erteilt werden; Mitglieder dürfen die ihnen erteilte Fischereierlaubnis in Sachsen-Anhalt nicht dafür nutzen. 5. Schutz- und Schonmaßnahmen 5.1 Die Behandlung gefangener Fische Jeder Angler trägt die Verantwortung, dass die gefangenen Fische schonend und tierschutzgerecht behandelt und einer sinnvollen Verwertung zugeführt werden. der Fische ist nicht zulässig. Das Angelgerät und die Landehilfsmittel sind so auszuwählen, dass die zu erwartenden Fische sicher zu landen sind. sind unverzüglich schonend ins Gewässer zurückzusetzen. Um Verletzungen und Beschädigungen der Schleimschicht und der Oberhaut zu vermeiden, sind diese Der Angelhaken ist mit einem Hakenlöser vorsichtig zu entfernen, oder das Vorfach ist abzuschneiden. Werden Fische beim Fang nachhaltig verletzt, sind sie unverzüglich zu töten. Die 9 Das Hältern von maßigen Fischen im Fanggewässer bedarf des vernünftigen Grundes und ist auf die erforderliche Dauer zu beschränken. verwendet werden. Das Hältern von Forellen, Äschen, Maränen, Zandern, Welsen, Rapfen, Hechten, Beim Hegeangeln sind Setzkescher, die mindestens 3 m lang sind und einen Mindestdurchmesser von 40 cm haben, zu verwenden. 5.1.1 Anlandungs- und Entnahmepflicht Gefangene Fische nicht heimischer Arten, für die weder ein Schonmaß noch eine werden. Dies gilt gleichlautend für Welse, die in stehenden Gewässern < 10 ha zu töten: Bachneunauge, Bitterling, Elritze, Finte, Flußneunauge, Groppe, Lachs, Maifisch, Meerforelle, Meerneunauge, Moderlieschen, Nase, Schlammpeitzger, Schmerle, Schneider, Steinbeißer, Stör, Nordseeschnäpel, Weißflossengründling. Arten (siehe § 10 des Bundesnaturschutzgesetzes) nachzustellen oder sie absichtlich zu fangen oder zu töten. 10 5.3 Mindestmaße Beim Angeln sind die nachstehenden Mindestmaße (gemessen vom Kopf bis zum letzten Schwanzflossenstrahl) einzuhalten: Fischart				Mindestmaße in cm Aal (Anguilla anguilla)				50 Äsche (Thymallus thymallus)			30 Bachforelle (Salmo trutta fario)			25 Barbe (Barbus barbus)				45 Große Maräne (Coregonus lavaretus)		           30 Hecht (Esox lucius)				50 Karpfen (Cyprinus carpio)			35 Kleine Maräne (Coregonus albula)			12 Quappe (Lota lota)				30 Rapfen (Apius aspius)				40 Regenbogenforelle (Oncorhynchus mykiss)		      25 Schleie (Tinca tinca)				25 Zander (Stizostedion lucioperca)			50 Zährte (Vimba vimba)				30 Amerikanischer Flusskrebs (Orconectes limosus)  8 (Maß ohne Schere) nachzustellen oder sie absichtlich zu fangen oder zu töten. Darunter fällt auch das Äsche		                01.12. - 15.05. Bachforelle		          15.09. - 31.03. Barbe		                01.04. - 30.06. Hecht		                15.02. - 30.04. Zander		               15.02. - 31.05. 11 5.4.1. Unzulässigerweise gefangene Fische untermaßige Fische sind unverzüglich schonend in das Gewässer zurückzusetzen. Andere Fische, die nicht absichtlich gefangen wurden, können zurückgesetzt werden, wenn dies aus einem vernünftigen Grund geschieht. Werden sie beim Fang nachhaltig verletzt, sind sie unverzüglich zu töten. Beim Fang getötete sowie entsprechende tot angelandete Fische dürfen nicht verwertet werden; eine Spinnangel in Salmonidengewässern		            15.09. - 31.03. Spinn- und Raubfischangel in allg. Angelgew.		 15.02. - 30.04. Flugangel in Salmonidengewässern			            01.12. - 31.03. Köderfischsenke				                            15.02. - 30.04. Schleppangeln				15.02. - 30.04. 5.5 Fangbegrenzungen 5.5.1 Regelung für allgemeine Angelgewässer Beim Angeln in den allgemeinen Angelgewässern des LAV Sachsen-Anhalt e.V. werden, von diesen Arten aber höchstens: 3 Stück:		 Hecht, Karpfen, Quappe, Regenbogenforelle, Schleie, Zander 2 Stück: 		 Barbe, Rapfen 1 Stück: 		 Äsche, Bachforelle 5.5.2 Regelung für Salmonidengewässer In den Salmonidengewässern des LAV Sachsen-Anhalt e.V. dürfen je Angeltag durch die Fischereierlaubnisscheine anders bestimmt ist. 5.6 Festlegung von Fischschonbezirken Durch den Fischereiausübungsberechtigten können in Abstimmung mit der Fischerei- und Umweltbehörde Teile von Gewässern zu Fischschon- bzw. Laichschonbezirken erklärt werden, in denen das Angeln nicht gestattet ist. Die Festlegung von Fischschonbezirken ist in der Verbandsinfo des LAV Sachsen-Anhalt e.V. bekannt zu machen und am Gewässer auszuschildern. 12 6. Schlussbestimmungen Für die Einhaltung der Gewässerordnung bzw. der konkreten Festlegungen für einzelne Gewässer ist jeder Angler selbst verantwortlich, d.h., er hat sich vor Beginn des Angelns über die geltenden Bestimmungen zu informieren. Anlage 1 Erläuterung zur einheitlichen Beschilderung der Salmoniden-Angelgewässer des LAV Der Grundtyp der Schilder ist ein auf der Spitze stehendes Quadrat mit einer Seitenlänge von 30 cm. 13 Schild A: Schonstrecke Grundfarbe rot. Dieses Schild bedeutet, dass das Gewässer in beiden Richtungen für jegliches Angeln gesperrt ist. Schild B: Angelstrecke Grundfarbe gelb. Kennzeichnung eines Salmoniden- Angelgewässers nach Pkt. 4.4 der Gewässerordnung. Schild C: Begrenzungsschild Es kennzeichnet die Grenzen einer Schonstrecke. Die Grundfarbe der einen Hälfte ist rot, die der anderen gelb. Sind 2 Schilder mit den roten Hälften einander zugekehrt, ist die dazwischen liegende Strecke gesperrt. Sind die beiden gelben Hälften einander zugekehrt, so ist die dazwischen liegende Strecke freigegeben. Zur Kennzeichnung von Flugangelstrecken dienen: 14 Schild D: Flugangelstrecke Grundfarbe gelb, im Zentrum des Schildes ein schwarzes F. Flugangelstrecke in beide Richtungen. Schild E: Begrenzungsschild Es kennzeichnet die Grenzen einer Flugangelstrecke. Grundfarbe gelb, beide Hälften durch einen senkrechten schwarzen Strich getrennt, in einer Hälfte befindet sich ein schwarzes F. Zwischen den mit F gekennzeichneten Hälften von zwei Schildern befindet sich eine Flugangelstrecke. einer Hälfte rot sein kann und es dann zur Kennzeichnung einer der Flugangelstrecke folgenden Schonstrecke dient. Zur Kennzeichnung von Mischgewässern dienen: Schild F: Begrenzungsschild Das Schild ist durch einen senkrechten schwarzen Strich getrennt. Beide Hälften sind entweder gelb oder eine Hälfte rot (Schonstrecke). In einer gelben Hälfte befindet sich ein schwarzes M. Dieses zeigt den Beginn eines allgemeinen Angelgewässers an, für dessen Beangelung Punkt 4.4 der Gewässerordnung nicht anzuwenden ist. 15 gelbes Viereck mit schwarzem W, das mit einem schwarzen Schrägstrich durchgestrichen ist, es kennzeichnet Anlage 2 Beschilderung von Fischschonbezirken Das Zeichen hat eine Seitenlänge von 630 mm der grüne Rand eine Breite von 62 mm. Die geänderte Gewässerordnung wurde auf der Mitgliederversammlung des Landesanglerverbandes Sachsen-Anhalt e.V. am 11. November 2006 in Brambach beschlossen. Sie wurde durch die Mitgliederversammlungen des Landesanglerverbandes Sachsen- Anhalt e.V. am 10.11.2007, am 17.03.2012, am 23.03.2013, am 07.11.2015, am 24.03.2018 und am 10.11.2018 geändert. 16 Katalog zur einheitlichen Ahndung von Verstößen von Verbandsmitgliedern und Gastanglern gegen die Gewässerordnung des LAV Sachsen-Anhalt e.V. Verstöße gegen die Landesfischereiordnung sind grundsätzlich der zuständigen Fischereibehörde anzuzeigen. Verstöße sind mit Punkt und Unterpunkt auf der Rückseite des Fischereierlaubnisscheines einzutragen (mit Datum und Nr. des Gewässers) Eingezogene Fischereierlaubnisscheine sind umgehend mit einem Begleitschreiben entscheiden. Sachverhalt               fahrlässig                vorsätzlich 1. Nichtsauberhalten      Verwarnung, bis 1         mind. 3 Monate Sperre des Angelplatzes          Monat Sperre              bis Ausschluss 2. unbefugtes Abstellen   Verwarnung, Fahrzeug      Anzeige als Ordnungs- sowie Befahren            sofort entfernen          widrigkeit bei der von Uferzonen und                                   zuständigen Behörde Wiesenflächen mit Kfz 3. Nichtbeachtung von     Verwarnung,               mind. 6 Monate Sperre Einschränkungen und       bis 3 Monate Sperre       bis Ausschluss Auflagen 4. Kopfrute mit                                     mind. 3 Monate Sperre Raubfischköder                                      bis Ausschluss 5. unkameradschaft-       Verwarnung, bis 1         mind. 3 Monate Sperre liches Verhalten am       Monat Sperre              bis Ausschluss Gewässer 6. Friedfischangeln                                 mind. 6 Monate Sperre mit mehr als einem                                  bis Ausschluss Einzelhaken oder unerlaubten Angelhaken 7. Spinnangeln mit                                  mind. 6 Monate Sperre mehreren montierten                                 bis Ausschluss Kunstködern 17 Sachverhalt               fahrlässig                 vorsätzlich 8. Angeln mit             Verwarnung,                mind. 6 Monate Sperre unvollständigen           bis 3 Monate Sperre        bis Ausschluss Dokumenten 9. Verwendung             Verwarnung, bis            mind. 6 Monate Sperre unerlaubter Köder         3 Monate Sperre            bis Ausschluss (Kunst- u. Natur-.) 10. Verwendung                                       Entzug der Erlaubnis, unerlaubter Köder in                                 mind. 6 Monate Sperre Salmonidengewässern                                  bis Ausschluss 11. Missachtung           Verwarnung,                Entzug der Erlaubnis und von Schonstrecken         bis 3 Monate Sperre        mind. 6 Monate Sperre bis Ausschluss 12. Nichteinhaltung von                              mind. 6 Monate Sperre Fangbegrenzungen                                     bis Ausschluss Beispielhafte Aufzählung zu Punkt 3. des Ahndungskataloges →    Überschreitung der zulässigen Rutenanzahl →    Nichteintragung entnommener Fische in die Fangkarte →    Verstöße gegen die Beaufsichtigungspflicht der Angelgeräte →    Verstöße gegen Hälterauflagen →    Verstöße gegen Anlandungs- und Entnahmeverpflichtungen →    Eigenmächtiges Umsetzen von Fischen 18 Notizen: 19 Notizen: 20 Altmarkkreis Salzwedel                 Stendal 1                        2 Aktualisierungen zum Gewässerverzeichnis auf unserer Internetseite IMPRESSUM Jerichower Börde 3 Land 4 Herausgeber: 13 MAGDEBURG                                         Landesanglerverband Sachsen-Anhalt e.V. Mansfelder Straße 33 06108 Halle/Saale Salzlandkreis 12                    www.lav-sachsen-anhalt.de Harz                                         DESSAU-   Wittenberg 5                      6 ROSSLAU        8       Stand: 15.09.2021 Anhalt-                        Ausgabe 2022 - 2026 Bitterfeld 7                           Nachdruck mit Quellenangabe gestattet. Um Übersendung eines Belegexemplars wird gebeten. Mansfeld-Südharz 9                         14                              Die Broschüre wurde mit Sorgfalt erarbeitet. HALLE                             Eine Gewähr für die Richtigkeit und Vollständigkeit kann jedoch nicht Saalekreis                                   übernommen werden. 10 Burgenlandkreis                              Gesamtproduktion 11 Druckerei Hessel, Radegaster Straße 9a, 06369 Weißandt-Gölzau Umschlagfoto: LAV - Saale-Elster-Kanal Angelatlas des LAV: Landesanglerverband Sachsen-Anhalt e.V. Nr.: Gewässerordnung & Gewässerverzeichnis Landesanglerverband Sachsen-Anhalt e.V.                                                      Gewässerverzeichnis Mansfelder Str. 33 - 06108 Halle (Saale)                                                    & Gewässerordnung Stand: 15.09.2021                                                                 Ausgabe für 2022 - 2026', 51.755955, 11.462134, 'Sachsen-Anhalt', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 'Hinweise zum Stausee Kelbra 09-390-32; Uferbereich an der Talsperre Kelbra angeln. Gestattet ist dies nur am Südufer vom; Die Beschilderung ist zu beachten. Anfüttern ist verboten.; Naturschutzgebiet. Auch das Bootsangeln ist z.Z. nur eingeschränkt gestattet. Beim; Hinweise zur Fischereiausübung auf und am Geiseltalsee 10-29-52; Uferzone verboten. Für das Abstellen von Kraftfahrzeugen sind ausschließlich die; öffentlichen Parkplätze zu nutzen. Das Ufer darf nur in den in der aktuellen; und ob Einschränkungen beim Angeln zu beachten sind. Die ordnungsgemäße; Wasserfahrzeuge; Festlegung: Als Wasserfahrzeuge werden alle Gegenstände zur Fortbewegung; Die Entscheidung darüber, ob Wasserfahrzeuge, Boots- und Angelstege im; Die Gewässer auf denen eine Nutzung von Wasserfahrzeugen gestattet ist,; Salmonidengewässern dürfen keine Wasserfahrzeuge zum Angeln benutzt werden.; Wasserfahrzeuge müssen (außer beim Spinn-, Hegene- und Schleppangeln) bei; zu entfernen. Alle Wasserfahrzeuge sind deutlich sichtbar zu kennzeichnen, für die; Registrierung der Wasserfahrzeuge sind die Mitgliedsvereine zuständig.; Das Betreten und Befahren des Geleges ist untersagt, die Beangelung ist nur vom; Ufer oder vom vor dem Gelege liegenden Boot aus gestattet.; In Naturschutzgebieten, NSG-gleichen Totalreservaten und Kernzonen von; Gebiete zutreffende Behandlungsrichtlinien und Gebietsverordnungen zu beachten.; Ein eigenmächtiges Umsetzen von Fischen durch Angler ist verboten.; Hinweise entnehmen sie bitte der Gewässerfondsordnung. Der betreuende; einen Fischereierlaubnisschein erwerben, der jedoch nur zum Friedfischfang; Angeln nur in Begleitung eines volljährigen Fischereischeininhabers ausüben, der; Fischereischeininhaber können nur bei den Vereinen für die Gewässer, die durch diese; die Nutzung der Gewässer des gemeinsamen Gewässerfonds werden nur vom; auf Friedfische angeln. Die Kopfrute darf nur als Friedfischangel verwendet werden.; Friedfischfischereischeins und einer gültigen Fischereierlaubnis dürfen nur mit; nur einen Einfachhaken ab Größe 8 und kleiner der internat. Skala haben. Eine; sind verboten.; Fetzenköder an bis zu drei Einfach-, Doppel- bzw. Drillingshaken.Es ist verboten,; dürfen nur mit Ausnahmegenehmigung der Oberen Fischereibehörde (nach § 23; Am Boot befestigte Rute oder Schleppvorrichtung mit einem Spinnköder, der durch; die Bewegung des Bootes bewegt wird. Das Schleppangeln ist nur auf stehenden; Gewässern mit einer Fläche über       30 ha und mit Bootszulassung gestattet. Das; Schleppangeln ist nur mit einer Rute je Angler zulässig. Die Genehmigung hierzu; Flugrute mit Flugrolle, Flugschnur und Vorfach sowie maximal einer künstlichen; Fliege als Köder, Künstliche Fliegen nur mit Einfachhaken.; Nur zulässig zum Fang von Maränen in Gewässern mit nachgewiesenem; Maränenbestand. Rute mit Rolle, Schnur mit Verwendung beschwerter Vorfächer,; einer Anbissstelle abzweigen. Die Anbissstellen einer Hegene dürfen nur mit; Nachstellverbot unterliegen (5.2 GWO) und die nicht mit einem Mindestmaß; (5.3 GWO) und/oder einer Schonzeit (5.4 GWO) belegt sind sowie Meeresfische.; Köderfische dürfen nur tot, auch in Teilen (Fetzenköder) verwendet werden.; In Salmonidengewässern ist nur das Spinn- und Flugangeln gestattet.; Beim Spinnangeln in Salmonidengewässern dürfen nur künstliche Spinnköder oder; bzw. Gummi verboten.; Stunde vor Sonnenaufgang. Das Nachtangeln ist nur in allgemeinen Angelgewässern; erlaubt, in Salmonidengewässern ist Nachtangeln verboten.; Inhaber eines Jugendfischereischeines dürfen das Nachtangeln nur in Begleitung; auf eigene Gefahr. Auf Fließgewässern ist Eisangeln grundsätzlich verboten.; zu beachten.; Aufsichtsbehörden sind zu beachten.; Das Zelten bzw. Campen an Angelgewässern ist erlaubnispflichtig und darf nur auf; Das Füttern wildlebender Fische ist verboten.; Eine Anfütterung zum Zwecke des Fischfangs ist nur während dessen Ausübung; Gefangene Fische dürfen nur für den Eigenbedarf verwendet werden, ein Verkauf; Fische, die während der Schonzeit gefangen werden und untermaßige Fische; Fische nur mit nassen Händen anzufassen.; Aneignung dieser Fische ist verboten, wenn sie untermaßig sind oder während der; Schonzeit gefangen wurden oder für sie ein Fangverbot besteht.; Es dürfen nur hinreichend geräumige Setzkescher aus knotenfreiem Material; Barben und Barschen ist bei der Angelfischerei verboten.; In Gewässern mit Schiffs- und Motorbootverkehr und von fahrenden; Wasserfahrzeugen aus ist das Hältern in Setzkeschern verboten.; Schonzeit festgesetzt sind, müssen angelandet und dürfen nicht zurück gesetzt; gefangen werden. Das Umsetzten in andere Gewässer ist verboten.; 5.2 Fangverbote; Es ist verboten, Fischen folgender Arten nachzustellen, sie absichtlich zu fangen und; Es ist verboten, Krebsen, Muscheln und Fischnährtieren der besonders geschützten; 5.4 Schonzeiten; Es ist verboten, Fischen nachstehender Arten während folgender Zeiten; Verwendungsverbot bestimmter Fanggeräte.; Fischart		             Schonzeit; Regenbogenforelle      15.09. - 31.03. (nur in Salmonidengewässern); Fische, die trotz Fangverbotes oder während der Schonzeit gefangen werden, und; Aneignung ist verboten.; 5.4.2 Verwendungsverbote; Fanggerät                                 		   Verwendungsverbot; dürfen je Angeltag insgesamt 3 Fische nachstehender Arten gefangen und behalten; insgesamt 3 Salmoniden gefangen und mitgenommen werden, sofern dies nicht; Zu beachten ist, dass dieses Schild auch auf; Schild G: Watangelverbot; eine Strecke mit Watverbot.; an den ausstellenden Verein zu übersenden. Nur dieser kann über die Ahndung; →    Unzulässige Verwendung von Wasserfahrzeugen; →    Verstöße gegen Verwendungsverbote bestimmter Angelmethoden; →    vorrätiges Anfüttern ohne gleichzeitige Fischereiausübung', NULL, 0.47, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

-- ============================================================
-- Sachsen: LVSA Gewässerordnung/Gewässerverzeichnis (ältere Ausgabe)
-- Quelle: av-plauen-chrieschwitz.de (PDF mit Gewässerverzeichnis inkl. GPS-Koordinaten)
-- Pipeline: import_lav_sn_pdf.py → geocode (Nominatim-Fallback) → csv_to_seed.py
-- ============================================================

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich Görlitz', 51.17921388888889, 14.993416666666667, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.85, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Weinlache Görlitz', 51.137483333333336, 14.992988888888888, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 3.85, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bumbasloch Ludwigsdorf', 51.21334166666667, 14.97645, 'Sachsen', 'See',
 '["Barsch", "Hecht", "Karpfen"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Reichenbach', 51.146430555555554, 14.801411111111111, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Golicklache Ludwigsdorf', 51.21138055555556, 14.981169444444445, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.85, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Volksbad Görlitz', 51.134322222222224, 14.98951111111111, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 9.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Tongrube Buchholz', 51.19662777777778, 14.6964, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Weißfisch", "Zwergwels"]',
 '', NULL, 1.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schlossteich Hagenwerder', 51.07018888888889, 14.947383333333333, 'Sachsen', 'Teich',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 0.16, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bad Leuba/Hagenwerder', 51.05340833333333, 14.958088888888888, 'Sachsen', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 2.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Weißer Bruch See', 51.28439722222222, 14.78125, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.45, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tiefe Schacht Kosel', 51.35348333333334, 14.7928, 'Sachsen', 'See',
 '["Hecht", "Karpfen"]',
 '', NULL, 0.35, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Baggerloch Lodenau                      5,75     A,H,K,S,W,Wf,Z    		               N51°21‘12,54“ E14°47‘34,08“', 51.37363333333333, 14.973816666666666, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Parkstraße Niesky', 51.27961388888889, 14.830894444444445, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Reitergrund Steinbach', 51.34476111111111, 14.68126111111111, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 0.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Feuerlöschteich Rothenburg', 51.33182222222223, 14.972288888888889, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Weißfisch"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlgraben Rothenburg', 51.341833333333334, 14.974725, 'Sachsen', 'Kanal',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlteich Mücka mit Mühlgraben', 51.31546944444444, 14.699783333333334, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Jahnteich Weißwasser', 51.510216666666665, 14.637869444444444, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 6.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleiner und Großer Nickelteich', 51.54558333333333, 14.619852777777778, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlteich Teicha', 51.386697222222224, 14.820880555555556, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 2.45, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Badeteich Kromlau', 51.541469444444445, 14.628686111111112, 'Sachsen', 'Teich',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 5.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Quitzdorf                         686,00 A,H,K,S,W,Wf,Z      		               N51°32‘29,29“ E14°37‘43,27“', 51.269822, 14.756989, 'Sachsen', 'Talsperre',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Braunsteich', 51.275925, 14.763963888888888, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 23.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Große Karoline Gablenz', 51.52577222222222, 14.664672222222222, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 5.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Blaue Adria Krauschwitz', 51.51657222222222, 14.728191666666667, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Grüner Teich Krauschwitz', 51.52055277777778, 14.73098888888889, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.65, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Siedlungsteich', 51.52699722222222, 14.672916666666666, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 2.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Fichte I, II, III, IV und Erle Weißwasser 5,40          A,H,K,S,Wf,Z    FLIEßGEWÄSSER                                           km', 51.51958888888889, 14.659769444444445, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neiße im Landkreisgebiet', 51.52520555555555, 14.652038888888889, 'Sachsen', 'Fluss',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 26.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Weißer Schöps, einschl. Neugraben', 51.526405555555556, 14.642741666666666, 'Sachsen', 'Kanal',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 17.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schwarzer Schöps', 51.299955, 14.726191, 'Sachsen', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 17.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Badeteich Groß Düben', 51.56988333333334, 14.588152777777779, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Weißfisch"]',
 '', NULL, 3.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neugraben', 50.750715, 13.715819, 'Sachsen', 'Kanal',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 13.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bombkeschacht Krauschwitz', 51.51501388888889, 14.726655555555556, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 1.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Spree', 51.349815, 14.879726, 'Sachsen', 'Fluss',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Wels", "Zander"]',
 '', NULL, 11.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich Weißwasser', 51.515725, 14.613841666666666, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Raklitza', 51.413858, 14.762660, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Weißfisch"]',
 '', NULL, 4.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wehrlache Rothenburg', 51.32014166666667, 14.99458611111111, 'Sachsen', 'See',
 '["Schleie", "Weißfisch"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Spree', 51.349815, 14.879726, 'Sachsen', 'Fluss',
 '["Aal", "Hecht", "Weißfisch", "Wels", "Zander"]',
 '', NULL, 9.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mauersteinlöcher Kodersdorf                   0,65            K,S,Wf    		               von Kreisgrenze bei Uhyst bis Wehr Bärwalde', 51.365402, 14.509190, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pließnitz', 51.25588333333334, 14.923147222222221, 'Sachsen', 'See',
 '["Aal", "Döbel", "Weißfisch"]',
 '', NULL, 3.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Klärteiche Biesig', 51.16, 14.777155555555556, 'Sachsen', 'Teich',
 '["Karpfen", "Schleie"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Jendeteiche Gersdorf', 51.129397222222224, 14.8642, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bräuteich Beiersdorf', 51.070175000000006, 14.529519444444444, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Landzunge (Waldsee) Weißwasser                5,00         K,H,S,ZW     		            N51°04‘12,63“ E14°31‘46,27“', 51.5194, 14.654241666666667, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Engeleiteiche Dürrhennersdorf', 51.043731, 14.621005, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 2.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Spinnereiteich Ebersbach', 51.01951388888889, 14.591636111111113, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 2.05, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wiesenteich Ebersbach', 51.021169444444446, 14.594080555555555, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gondelteich Oppach', 51.05325833333333, 14.497544444444443, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 3.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Olbersdorfer See                     60,00   A,GM,H,K,S,Ss', 50.98751388888889, 14.859252777777778, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Vogelteich Burkersdorf', 50.989893, 14.859977, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich Oberoderwitz', 50.986129, 14.692146, 'Sachsen', 'Teich',
 '["Aal", "Karpfen", "Schleie"]',
 '', NULL, 0.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Burgteich – Gondelteich Zittau            1,50             H,K,S   		          nur Vereinsangeln nach Anmeldung möglich', 50.986308333333334, 14.692077777777778, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch „Neuer Hutberg“ Ostritz', 51.01471388888889, 14.921752777777778, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 4.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mittelteich Neugersdorf', 50.98055, 14.606458333333332, 'Sachsen', 'Teich',
 '["Aal", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kirchteich Neugersdorf', 50.979822222222225, 14.608044444444443, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Irmerteich', 50.876058, 14.799112, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 1.65, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Grundbachsenke Olbersdorf', 50.863236111111114, 14.810761111111113, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 5.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bischdorfer Teiche', 50.913736111111106, 14.703766666666667, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 2.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Streunenteich Mauschwitz', 50.88175555555556, 14.678419444444444, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Weißfisch"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schwarzer Teich Spitzkunnersdorf', 50.954325000000004, 14.67556111111111, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bleichteiche Herrnhut', 51.017130, 14.731498, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.65, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mittlerer Bleicheteich Oberoderwitz 0,65            A,H,K,S,Wf,Z   		          (Wendeplatz) in unmittelbarer Nähe des Teichdammes', 50.963302777777784, 14.671927777777777, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Oberer Bleicheteich Oberoderwitz', 51.099944444444446, 14.639694444444444, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.15, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Oelsaer Teich Löbau', 51.099979, 14.639597, 'Sachsen', 'Teich',
 '["Regenbogenforelle", "Schleie", "Weißfisch"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unterer Bleicheteich Oberoderwitz', 50.96458333333334, 14.671744444444444, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.55, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hofeteich Schlegel', 50.984769444444446, 14.863130555555555, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Spree', 51.349815, 14.879726, 'Sachsen', 'Fluss',
 '["Bachforelle", "Hecht", "Weißfisch"]',
 '', NULL, 14.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Bautzen                      533,00           A,B,H,K', 51.180913, 14.427600, 'Sachsen', 'Talsperre',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Löbauer Wasser                       30,00         Bf,H,S,Wf   		            beachten', 51.21203888888889, 14.455419444444443, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neiße', 51.360001, 14.965716, 'Sachsen', 'Fluss',
 '["Aal", "Hecht", "Karpfen", "Weißfisch"]',
 '', NULL, 12.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mandau                               12,00       A,Bf,H,K,Wf   		            Sperrbereiche an der Staumauer beidseitig ca. 30 m', 51.19650277777777, 14.445805555555555, 'Sachsen', 'Stausee',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pließnitz', 51.066216, 14.963644, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Weißfisch", "Äsche"]',
 '', NULL, 12.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Nadelwitzer Teich', 51.180883333333334, 14.501583333333333, 'Sachsen', 'Teich',
 '["Barsch", "Karpfen", "Regenbogenforelle"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Speicherbecken Rachlau', 51.13505, 14.462833333333332, 'Sachsen', 'Talsperre',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 5.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bürgerteich Bischofswerda', 51.13468888888889, 14.175644444444444, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.28, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Froschteich (Kleiner Horkaer Teich)', 51.13042222222222, 14.199844444444444, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 0.9, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbrüche im Klosterberggebiet', 51.13120555555555, 14.23606111111111, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Regenbogenforelle", "Schleie", "Weißfisch"]',
 '', NULL, 2.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gondelteich Schirgiswalde', 51.07177777777778, 14.430674999999999, 'Sachsen', 'Teich',
 '["Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.35, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rückhaltebecken Göda', 51.17566111111111, 14.327133333333332, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 8.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kohlengrube Luttowitz', 51.25197222222222, 14.44615, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Seitschen                         0,30               H,K    FLIEßGEWÄSSER		                                            km', 51.16403611111111, 14.327222222222222, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Toter Arm Guttau', 51.255116666666666, 14.55986388888889, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Löbauer Wasser', 51.197332, 14.652147, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 31.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kotitzer Wasser', 51.169100, 14.617728, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Hecht", "Karpfen", "Weißfisch"]',
 '', NULL, 15.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Neue Tongrube Guttau                   9,60         A,H,K,S,W    		                 teilweise grüne Strecke', 51.25738333333334, 14.580694444444445, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alte Tongrube Guttau                   10,30        A,H,K,S,W    		                 von Kreisgrenze Görlitz bis Vorsperre Bautzen;             S,Wf,Z', 51.262372222222226, 14.5813, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Kleinsaubernitz              8,10        A,H,K, Wf,Z   		                 Mindestmaß Bf - 32 cm und', 51.26604444444445, 14.609166666666667, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlteich Putzkau', 51.098269, 14.230839, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Spree', 51.349815, 14.879726, 'Sachsen', 'Fluss',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 31.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleine Spree', 51.098222222222226, 14.230852777777779, 'Sachsen', 'Fluss',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander", "Zwergwels"]',
 '', NULL, 25.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Unterer Lehnberg Schmölln', 51.12623888888889, 14.227069444444444, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Weißfisch"]',
 '', NULL, 0.35, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rosenbach Sohland', 51.037248, 14.449857, 'Sachsen', 'See',
 '["Bachforelle", "Äsche"]',
 '', NULL, 1.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rückhaltebecken Karlsdorf                   5,80        H,K,S,Wf,Z    		                 Mindestmaß Bf – 32 cm', 51.15013888888889, 14.26388888888889, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Cunewalder Wasser', 51.097504, 14.509800, 'Sachsen', 'See',
 '["Bachforelle", "Äsche"]',
 '', NULL, 1.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hoyerswerdaer Schwarzwasser', 51.057916666666664, 14.437925, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Hecht", "Karpfen", "Regenbogenforelle", "Weißfisch"]',
 '', NULL, 25.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wesenitz', 51.075205, 14.086552, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Barsch", "Hecht", "Weißfisch", "Äsche"]',
 '', NULL, 20.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich Steinigtwolmsdorf             0,60      A,H,K,Rf,S,Wf   		                 von Neukirch bis Buschmühle bei Rennersdorf;', 51.069234, 13.608531, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Drei Anglerteiche Weißenberg                0,47             A,H,K    		                 ACHTUNG!!! SONDERPROJEKT FLIEßGEWÄSSERKOMMISSION:', 51.20003888888889, 14.66153888888889, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gröditzer Angelteich                        0,20             H,K,S    		                 davon maximal 1 Äsche', 51.20133333333334, 14.618341666666668, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dorfteich Kotitz', 51.18416666666666, 14.620555555555557, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.46, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Brauereiteich Pulsnitz', 51.182788888888886, 14.020919444444445, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schlossteich Pulsnitz', 51.18027222222222, 14.011091666666667, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Badegrube Skaska', 51.35295277777778, 14.184513888888889, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 1.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Inselgrube Skaska', 51.34881111111111, 14.176833333333333, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tongrube Thonberg-Schusterloch', 51.256252777777775, 14.14046111111111, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Vogelberg', 51.279925, 14.068755555555555, 'Sachsen', 'Fluss',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 3.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Schweinerden', 51.22548611111111, 14.221594444444445, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Regenbogenforelle", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Steinberge Jesau', 51.27777777777778, 14.120702777777778, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Niederteich Kriepitz', 51.220385, 14.156417, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 1.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Schäfereiteich Häslich', 51.22065555555556, 14.156591666666667, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Feuerlöschteich Kriepitz                    0,30               K', 51.253083333333336, 14.022886111111111, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Oberteich Kriepitz                          0,70               K', 51.21701388888889, 14.157086111111111, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich Cunnersdorf', 51.306172, 14.073259, 'Sachsen', 'Teich',
 '["Karpfen", "Schleie"]',
 '', NULL, 1.57, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Rietschel Bischheim', 51.30596388888888, 14.073086111111111, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.45, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Birkenberg Obersteina', 51.25185, 13.921272222222221, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('BN Forstteich Schmorkau', 51.194341666666666, 14.074944444444444, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Weißfisch", "Zander"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Haustein Obersteina', 51.194552, 13.099261, 'Sachsen', 'See',
 '["Karpfen", "Regenbogenforelle", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('BN See der Freundschaft Königsbrück', 51.20433611111111, 14.059327777777778, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Wels", "Zander"]',
 '', NULL, 4.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Ritscher Reichenbach', 51.24330555555556, 13.968488888888889, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tulpengrube Liebegast', 51.35749722222222, 14.195219444444446, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Badegrube Liebegast', 51.35908055555556, 14.196275, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 0.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großmanns-Teich Großröhrsdorf', 51.149205555555554, 14.022027777777778, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Großer Ziegeleiteich Bröthen', 51.42325833333333, 14.18311111111111, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 6.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Brettmühlenteich Bretnig', 51.15882777777777, 14.058066666666667, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 3.9, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Siedlungsteich Laubusch', 51.44956944444444, 14.13438888888889, 'Sachsen', 'Teich',
 '["Karpfen", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Blauer See Wiednitz', 51.37016666666667, 14.029194444444446, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Flachstau Kleindittmannsdorf                  3,50        A,H,K,S,Wf,Z    		               N51°22‘12,60“ E14°01‘45,10“', 51.16728888888888, 13.928191666666667, 'Sachsen', 'Stausee',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Waldsee Wiednitz', 51.37075277777778, 14.024969444444446, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 3.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kirchteich Wachau                             0,40                A,H,S   		               N51°22‘14,71“ E14°01‘29,89“', 51.157805555555555, 13.903294444444445, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schmelzteich Bernsdorf', 51.37755, 14.064008333333334, 'Sachsen', 'Teich',
 '["Aal", "Karpfen", "Weißfisch"]',
 '', NULL, 4.9, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('BN Dorfteich Wachau                            0,80              A,H,K,S   		               N51°22‘39,18“ E14°03‘50,43“', 51.16354444444444, 13.907144444444445, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mittelteich Kriepitz', 51.217686111111114, 14.157591666666667, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schweinegrube Skaska', 51.14565555555556, 14.039741666666666, 'Sachsen', 'See',
 '["Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Wallroda', 51.114143, 13.956870, 'Sachsen', 'Talsperre',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Wels", "Zander"]',
 '', NULL, 34.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Klosterwasser', 51.163271, 14.174557, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 10.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pulsnitz', 51.182577, 14.013973, 'Sachsen', 'See',
 '["Bachforelle", "Hecht", "Karpfen", "Regenbogenforelle"]',
 '', NULL, 12.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Haselbach', 51.39821388888889, 14.414533333333333, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Hecht", "Karpfen", "Regenbogenforelle"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Große Röder', 51.37773055555556, 14.393530555555555, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Hecht", "Karpfen", "Regenbogenforelle", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 33.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stausee Radeburg', 51.212995, 13.747989, 'Sachsen', 'Stausee',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Wels", "Zander"]',
 '', NULL, 28.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schwarze Elster und                    37,00     A,H,K,S,Wf,Z    		            siehe Grafik/Bemerkungen Seiten 62-63', 51.21441666666667, 13.741513888888887, 'Sachsen', 'Fluss',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleine Spree                           28,00       A,H,K,S,Wf    		            Achtung Schlüsselpflicht (LVSA-Schließsystem)', 51.10514444444445, 13.608274999999999, 'Sachsen', 'Fluss',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich Augustusberg', 51.04243333333333, 13.294319444444444, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.46, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lindiggutsteich Leippen', 51.13243333333333, 13.322888888888889, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karausche", "Karpfen", "Schleie"]',
 '', NULL, 0.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Teich in Bockwen/Scharfenberg', 51.137458333333335, 13.470447222222223, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Löschteich Niederjahna', 51.166725, 13.434555555555555, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.37, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wasserspeicher Roitzsch', 51.234455555555556, 13.273694444444445, 'Sachsen', 'Talsperre',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Tongrubenteich Adria Ockrilla', 51.20968055555556, 13.502266666666667, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Meißen', 51.166847222222216, 13.495308333333332, 'Sachsen', 'See',
 '["Hecht", "Karpfen"]',
 '', NULL, 0.37, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Heidehofteich Weinböhla                         0,87              H,K,S   FLIEßGEWÄSSER		                                          km', 51.18541666666666, 13.632072222222222, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Formsandgrube Steinbach', 51.18468055555555, 13.615133333333333, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 1.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Haudel Coswig                    5,90      A,B,H,K,S,Wf    		               Allgemeine Festlegungen Elbe auf den Seiten 38 und 44-45', 51.12845277777778, 13.562005555555556, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Große Röder', 51.222813, 13.719212, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Barsch", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 7.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Freiberger Mulde', 51.12119722222222, 13.559080555555557, 'Sachsen', 'Fluss',
 '["Aal", "Hecht", "Karpfen", "Regenbogenforelle"]',
 '', NULL, 12.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Inselteich Niederjahna', 51.16648055555555, 13.436533333333333, 'Sachsen', 'Teich',
 '["Karpfen", "Schleie"]',
 '', NULL, 0.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ketzerbach', 51.140236, 13.314960, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Karpfen", "Regenbogenforelle", "Weißfisch"]',
 '', NULL, 9.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Große Triebisch', 51.23705277777778, 13.404041666666666, 'Sachsen', 'See',
 '["Bachforelle", "Weißfisch"]',
 '', NULL, 4.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wilde Sau – Saubach', 51.050462, 13.541406, 'Sachsen', 'See',
 '["Aal", "Bachforelle", "Hecht", "Weißfisch"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Parkteich Seerhausen', 51.267875, 13.250905555555555, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Weißfisch"]',
 '', NULL, 0.75, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('P,S Kiesgrube Nieska', 51.41970277777777, 13.36018611111111, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Regenbogenforelle", "Schleie", "Zander"]',
 '', NULL, 19.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Torflöcher bei Nasseböhla', 51.336674, 13.525119, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.3, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Döllnitz', 51.34352777777778, 13.52321388888889, 'Sachsen', 'See',
 '["Bachforelle", "Weißfisch"]',
 '', NULL, 10.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Jahna', 51.231532, 13.190939, 'Sachsen', 'See',
 '["Bachforelle", "Weißfisch"]',
 '', NULL, 14.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Grödel-Elsterwerda-Kanal', 51.327377777777784, 13.688222222222223, 'Sachsen', 'Kanal',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alschteich Ponickau', 51.336715, 13.783345, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 5.2, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleine Röder', 51.33665277777778, 13.783341666666667, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Weißfisch"]',
 '', NULL, 15.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Große Röder', 51.222813, 13.719212, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Wels", "Zander"]',
 '', NULL, 45.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Colm-Dallwitz', 51.251647222222225, 13.563241666666668, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 0.25, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Steinbruch Zschauitz', 51.26663611111111, 13.52403888888889, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Torfstich Krauschütz', 51.334891, 13.600839, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.95, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Dobrabach', 51.33482777777778, 13.601116666666666, 'Sachsen', 'See',
 '["Karpfen", "Weißfisch"]',
 '', NULL, 9.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bad – Kiesgrube Röderau', 51.329597222222226, 13.314755555555557, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.45, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Merzdorfer Teich', 51.31506666666667, 13.244752777777776, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 3.15, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Knobloch (Leuben)', 51.25503333333333, 13.198897222222222, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Regenbogenforelle", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 5.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Alter See bei Glaubitz                 1,10          H,K          		            N51°01‘06,40“ E13°49‘27,43“', 51.323049, 13.378780, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Lehmgrube Hellerau', 51.31154722222222, 13.384194444444445, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Zander"]',
 '', NULL, 0.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiessee Sporbitz                         5,70       A,H,K,Rf,S,Z   D 03-02		        Vereinigte Weißeritz', 50.99294444444445, 13.856208333333333, 'Sachsen', 'See',
 '["Bachforelle", "Äsche"]',
 '', NULL, 6.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Malter', 51.07116944444445, 13.602461111111111, 'Sachsen', 'Talsperre',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Wels", "Zander"]',
 '', NULL, 52.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Staubecken Niederwartha                     40,00   A,B,H,K,S,Wf,Z    		             im Staubecken und die Vorsperre dürfen nicht', 50.91724166666666, 13.654541666666667, 'Sachsen', 'Stausee',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Klingenberg                   110,00A,         B,Bf,H,K', 51.09167777777778, 13.61571111111111, 'Sachsen', 'Talsperre',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Trache (Leuben)                     9,15    A,H,K,S,Rf,Wf,Z   		             sowie an den Vorbecken Hennersdorf und Röthenbach', 50.89745, 13.547397222222223, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Lehnmühle                     104,30            A,Bf,H', 51.016416666666665, 13.821180555555555, 'Sachsen', 'Talsperre',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Heidemühlenteich', 50.92977222222222, 13.698827777777778, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 3.82, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich Mohorn                        1,00      A,H,K,S,Wf    Bereich Sächsische Schweiz', 50.99286388888889, 13.442536111111112, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Birkwitzer See', 50.983805555555556, 13.897619444444445, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Naherholungszentrum Pirna/Copitz', 50.979475, 13.92311111111111, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 5.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Staubecken Pirna/Copitz', 50.97, 13.917277777777777, 'Sachsen', 'Stausee',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kiesgrube Pratzschwitz', 50.97387222222223, 13.895544444444443, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Wels", "Zander"]',
 '', NULL, 44.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Wölmsteich Sebnitz', 50.979755555555556, 14.300658333333335, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Regenbogenforelle", "Schleie"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stadtbad Neustadt', 51.018122222222225, 14.223572222222222, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Regenbogenforelle", "Schleie", "Weißfisch"]',
 '', NULL, 2.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stau Lauterbach', 51.05777222222222, 14.114547222222221, 'Sachsen', 'Stausee',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.7, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hofeteich Wilschdorf', 51.06283333333333, 14.015077777777778, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie", "Weißfisch", "Zander"]',
 '', NULL, 1.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Gottleuba', 50.877506, 13.951973, 'Sachsen', 'See',
 '["Bachforelle", "Weißfisch", "Äsche"]',
 '', NULL, 8.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Müglitz', 51.04929166666666, 14.138041666666666, 'Sachsen', 'See',
 '["Bachforelle", "Weißfisch"]',
 '', NULL, 7.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kleinstau Langenwolmsdorf                     0,50           H,K,Rf,S    		               bis Mündung Elbe – Radwegbrücke ;', 51.04320833333333, 14.121063888888889, 'Sachsen', 'Stausee',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Förstereiteich Lohmen                                                    FORELLENGEWÄSSER                                      km', 50.99008333333333, 14.023258333333334, 'Sachsen', 'Teich',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Talsperre Gottleuba                        54,40 B,Bf,H,K,Rf,Ss,Wf    		           von Landesgrenze stromabwärts', 50.83226388888889, 13.930241666666666, 'Sachsen', 'Talsperre',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Biela                                    3,00              Bf,Wf    		           bis Einmündung Seidewitz bei Zehista', 50.937226, 13.924557, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bahnteich Flöha', 50.853770, 13.078690, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Stau Niederschöna', 50.962752, 13.422587, 'Sachsen', 'Stausee',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.1, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schwarzer Teich', 50.835262, 12.817986, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Bobritzscher Teich', 50.902714, 13.455687, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schlüsselteich Freiberg', 50.922670, 13.343037, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hüttenteich Freiberg-Zug', 50.877679, 13.361315, 'Sachsen', 'Teich',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 6.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rothbächer Teich Brand-Erbisdorf', 50.856786, 13.344173, 'Sachsen', 'Teich',
 '["Barsch", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 2.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Mühlteich Brand-Erbisdorf', 50.799798, 13.276105, 'Sachsen', 'Teich',
 '["Barsch", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.9, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Freiberger Mulde', 50.981820, 13.301031, 'Sachsen', 'Fluss',
 '["Bachforelle", "Döbel", "Plötze", "Regenbogenforelle"]',
 '', NULL, 26.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Rauschenbach Neuhausen', 50.692481, 13.498663, 'Sachsen', 'See',
 '["Aal", "Barsch", "Hecht", "Karpfen", "Plötze", "Regenbogenforelle", "Zander"]',
 '', NULL, 94.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Torfgrube Mittweida', 50.978238, 12.953739, 'Sachsen', 'See',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Torfgrube Altmittweida', 50.976181, 12.943802, 'Sachsen', 'See',
 '["Karpfen", "Plötze", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Kuhteich Biensdorf', 50.932383, 13.016597, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 3.6, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Sandgrube Biesern                      20,0 K,S,H,Pl,B,A,Ro,Bl    		             bei Reitzenhain', 50.557971, 13.219037, 'Sachsen', 'See',
 '[]',
 '', NULL, NULL, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Vorsperre Forchheim', 50.728827, 13.277433, 'Sachsen', 'See',
 '["Bachforelle", "Barsch", "Hecht", "Karpfen", "Plötze", "Regenbogenforelle", "Schleie"]',
 '', NULL, 6.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Heiliger Teich', 50.679489, 12.794870, 'Sachsen', 'Teich',
 '["Barsch", "Karpfen", "Regenbogenforelle", "Schleie"]',
 '', NULL, 2.0, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Schieferloch am Trockenwerk', 51.022444, 14.017306, 'Sachsen', 'See',
 '["Aal", "Hecht", "Karpfen", "Plötze"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Hammerteich', 50.909580, 13.326581, 'Sachsen', 'Teich',
 '["Hecht", "Karpfen", "Schleie"]',
 '', NULL, 0.4, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Brettmühlenteich', 51.250133, 13.750302, 'Sachsen', 'Teich',
 '["Aal", "Hecht", "Karpfen", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Naturbad Johanngeorgenstadt', 50.431162, 12.701524, 'Sachsen', 'See',
 '["Barsch", "Karpfen", "Plötze"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Vorbecken Rohrbach', 50.548608, 12.580797, 'Sachsen', 'See',
 '["Barsch", "Hecht", "Schleie"]',
 '', NULL, 2.8, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Pochwerksteich', 50.394593, 12.452214, 'Sachsen', 'Teich',
 '["Barsch", "Hecht", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;

INSERT INTO public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) VALUES
('Ziegeleiteich Hohenstein-Ernstthal', 50.802373, 12.737401, 'Sachsen', 'Teich',
 '["Aal", "Karpfen", "Plötze", "Schleie"]',
 '', NULL, 1.5, NULL,
 '[]', false,
 NULL)
ON CONFLICT (name, bundesland) DO NOTHING;
