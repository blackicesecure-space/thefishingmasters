-- ============================================================
-- Seed-Daten: 35 Angelstellen in Mitteldeutschland
-- Sachsen-Anhalt, Thueringen, Sachsen
-- ============================================================

insert into public.spots (name, latitude, longitude, bundesland, gewaesser_typ, fischarten, regelung, angelkarte_preis_tag, flaeche_ha, max_tiefe_m, strukturen, parkplatz, beschreibung) values

-- ===================== SACHSEN-ANHALT =====================
('Goitzschesee', 51.6240, 12.3460, 'Sachsen-Anhalt', 'See',
 '["Zander","Barsch","Hecht","Aal","Karpfen"]',
 'Angelkarte LAV SA erforderlich', 10.00, 1330.00, 32.0,
 '["Steilkanten","Plateaus","Kraut"]', true,
 'Grosser Tagebausee bei Bitterfeld. Exzellentes Zandergewaesser mit tiefen Kanten und Plateaustrukturen.'),

('Saale bei Halle', 51.4828, 11.9689, 'Sachsen-Anhalt', 'Fluss',
 '["Barbe","Doebel","Rapfen","Zander","Aal"]',
 'Angelkarte LAV SA erforderlich', 10.00, null, 4.5,
 '["Stroemungskanten","Brueckenpfeiler","Buhnen"]', true,
 'Abwechslungsreicher Flussabschnitt durch Halle. Starker Rapfen- und Barbenbestand.'),

('Suesser See', 51.4600, 11.6800, 'Sachsen-Anhalt', 'See',
 '["Hecht","Zander","Karpfen","Schleie","Aal"]',
 'Angelkarte LAV SA erforderlich', 10.00, 257.00, 8.5,
 '["Schilf","Kraut","Seerosen"]', true,
 'Natursee im Mansfelder Land. Reicher Hechtbestand und gute Karpfengewaesser.'),

('Geiseltalsee', 51.3000, 11.8300, 'Sachsen-Anhalt', 'See',
 '["Zander","Barsch","Hecht","Karpfen","Wels"]',
 'Angelkarte LAV SA erforderlich', 10.00, 1840.00, 78.0,
 '["Steilkanten","Plateaus","Steinschuettungen"]', true,
 'Groesster kuenstlicher See Deutschlands. Tiefe Strukturen bieten hervorragende Zanderangelei.'),

('Elbe bei Magdeburg', 52.1205, 11.6276, 'Sachsen-Anhalt', 'Fluss',
 '["Zander","Wels","Rapfen","Barbe","Aal"]',
 'Angelkarte LAV SA erforderlich', 10.00, null, 6.0,
 '["Buhnen","Steinpackungen","Altarme"]', true,
 'Grosser Strom mit starkem Zanderbestand. Buhnenkoepfe sind Top-Hotspots.'),

('Arendsee', 52.8900, 11.4800, 'Sachsen-Anhalt', 'See',
 '["Maraene","Hecht","Barsch","Aal","Zander"]',
 'Angelkarte LAV SA erforderlich', 10.00, 510.00, 49.0,
 '["Tiefwasserzonen","Schilf","Stege"]', true,
 'Tiefster See in Sachsen-Anhalt. Einzigartiger Maraeenbestand.'),

('Mulde bei Dessau', 51.8300, 12.2400, 'Sachsen-Anhalt', 'Fluss',
 '["Barbe","Doebel","Rapfen","Barsch","Hecht"]',
 'Angelkarte LAV SA erforderlich', 10.00, null, 3.0,
 '["Stroemungskanten","Kiesbetten","Totholz"]', true,
 'Naturnaher Flussabschnitt mit gutem Barben- und Doebelbestand.'),

('Bergwitzsee', 51.7600, 12.5800, 'Sachsen-Anhalt', 'See',
 '["Karpfen","Hecht","Zander","Barsch","Schleie"]',
 'Angelkarte LAV SA erforderlich', 10.00, 240.00, 12.0,
 '["Schilf","Seerosen","Baumstrukturen"]', true,
 'Beliebter Angelsee bei Wittenberg. Guter Karpfenbestand.'),

('Halberstadter See', 51.8900, 11.0500, 'Sachsen-Anhalt', 'See',
 '["Karpfen","Hecht","Schleie","Barsch","Aal"]',
 'Angelkarte LAV SA erforderlich', 8.00, 32.00, 6.0,
 '["Schilf","Kraut","Stege"]', true,
 'Stadtnaher See bei Halberstadt. Familienfreundlich mit gutem Fischbestand.'),

('Concordiasee', 51.6700, 11.7100, 'Sachsen-Anhalt', 'See',
 '["Zander","Barsch","Hecht","Karpfen"]',
 'Angelkarte LAV SA erforderlich', 10.00, 340.00, 55.0,
 '["Steilkanten","Unterwasserstrukturen","Plateaus"]', true,
 'Tiefer Tagebausee bei Nachterstedt. Gutes Raubfischgewaesser.'),

('Bode bei Thale', 51.7500, 11.0300, 'Sachsen-Anhalt', 'Fluss',
 '["Forelle","Aesche","Doebel","Barbe"]',
 'Angelkarte LAV SA + Sondergenehmigung', 15.00, null, 1.5,
 '["Felsen","Kolke","Kiesbetten","Totholz"]', false,
 'Gebirgsfluss im Harz. Erstklassiges Salmonidengewaesser.'),

-- ===================== THUERINGEN =====================
('Bleilochtalsperre', 50.6100, 11.7000, 'Thueringen', 'Talsperre',
 '["Zander","Barsch","Hecht","Karpfen","Aal","Maraene"]',
 'Angelkarte LAVT erforderlich', 12.00, 920.00, 58.0,
 '["Steilkanten","Buchten","Inseln","Tiefwasserzonen"]', true,
 'Groesste Talsperre Deutschlands. Legendaeres Zandergewaesser mit Tiefenstruktur.'),

('Hohenwarte-Talsperre', 50.6400, 11.5200, 'Thueringen', 'Talsperre',
 '["Zander","Barsch","Hecht","Karpfen","Wels"]',
 'Angelkarte LAVT erforderlich', 12.00, 730.00, 72.0,
 '["Steilwaende","Buchten","Tiefwasserzonen"]', true,
 'Zweitgroesste Thueringer Talsperre. Sehr guter Barschbestand.'),

('Saale bei Jena', 50.9270, 11.5860, 'Thueringen', 'Fluss',
 '["Barbe","Doebel","Rapfen","Aal","Barsch"]',
 'Angelkarte LAVT erforderlich', 10.00, null, 3.0,
 '["Wehre","Stroemungskanten","Brueckenpfeiler"]', true,
 'Stadtdurchfluss mit vielfaeltigem Fischbestand. Gute Barben ab Mai.'),

('Stausee Hohenfelden', 50.8700, 11.1500, 'Thueringen', 'Talsperre',
 '["Karpfen","Hecht","Zander","Schleie","Barsch"]',
 'Angelkarte LAVT erforderlich', 10.00, 43.00, 12.0,
 '["Schilf","Buchten","Stege"]', true,
 'Beliebter Freizeitsee bei Erfurt. Guter Karpfen- und Hechtbestand.'),

('Unstrut bei Naumburg', 51.1500, 11.8000, 'Thueringen', 'Fluss',
 '["Barbe","Doebel","Aal","Hecht","Zander"]',
 'Angelkarte LAVT erforderlich', 10.00, null, 2.5,
 '["Wehre","Altarme","Totholz","Kraut"]', true,
 'Landschaftlich reizvoller Fluss. Guter Barben- und Aalbestand.'),

('Schmalwasser-Talsperre', 50.8000, 10.6000, 'Thueringen', 'Talsperre',
 '["Forelle","Saibling","Barsch","Hecht"]',
 'Angelkarte LAVT + Sondergenehmigung', 15.00, 24.00, 45.0,
 '["Steilwaende","Tiefwasserzonen","Zulaufbereiche"]', true,
 'Trinkwassertalsperre im Thueringer Wald. Exzellentes Salmonidengewaesser.'),

('Plothener Teiche', 50.6600, 11.8400, 'Thueringen', 'Teich',
 '["Karpfen","Schleie","Hecht","Karausche"]',
 'Angelkarte LAVT erforderlich', 8.00, 150.00, 3.0,
 '["Schilf","Seerosen","Roehricht"]', true,
 'Historische Teichlandschaft. Naturnahes Angeln auf Karpfen und Schleie.'),

('Werra bei Meiningen', 50.5700, 10.4100, 'Thueringen', 'Fluss',
 '["Forelle","Aesche","Doebel","Barbe"]',
 'Angelkarte LAVT erforderlich', 10.00, null, 2.0,
 '["Kiesbetten","Kolke","Wehre","Gehoelz"]', true,
 'Oberlauf der Werra mit gutem Salmonidenbestand.'),

('Talsperre Zeulenroda', 50.6500, 11.9800, 'Thueringen', 'Talsperre',
 '["Zander","Barsch","Hecht","Karpfen","Aal"]',
 'Angelkarte LAVT erforderlich', 10.00, 380.00, 38.0,
 '["Buchten","Steilkanten","Inseln"]', true,
 'Grosse Talsperre im Vogtland. Guter Mischfischbestand.'),

-- ===================== SACHSEN =====================
('Cospudener See', 51.2700, 12.3400, 'Sachsen', 'See',
 '["Zander","Barsch","Hecht","Karpfen","Aal"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, 436.00, 55.0,
 '["Steilkanten","Plateaus","Steinschuettungen"]', true,
 'Beliebter See im Leipziger Neuseenland. Guter Zanderbestand.'),

('Mulde bei Grimma', 51.2400, 12.7200, 'Sachsen', 'Fluss',
 '["Barbe","Doebel","Rapfen","Aal","Hecht"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, null, 3.5,
 '["Wehre","Stroemungskanten","Kiesbetten"]', true,
 'Abwechslungsreicher Flussabschnitt. Guter Barben- und Rapfenbestand.'),

('Talsperre Poehl', 50.5600, 12.2200, 'Sachsen', 'Talsperre',
 '["Zander","Barsch","Hecht","Karpfen","Maraene"]',
 'Angelkarte LAV Sachsen erforderlich', 12.00, 680.00, 42.0,
 '["Buchten","Steilwaende","Inseln","Tiefwasserzonen"]', true,
 'Grosse Talsperre im Vogtland. Hervorragendes Zandergewaesser.'),

('Elbe bei Dresden', 51.0504, 13.7373, 'Sachsen', 'Fluss',
 '["Zander","Wels","Rapfen","Barbe","Aal"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, null, 5.0,
 '["Buhnen","Steinpackungen","Stroemungskanten"]', true,
 'Elbe-Abschnitt bei Dresden. Sehr guter Welsbestand in den letzten Jahren.'),

('Talsperre Malter', 50.9200, 13.6500, 'Sachsen', 'Talsperre',
 '["Forelle","Saibling","Barsch","Hecht","Zander"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, 82.00, 30.0,
 '["Steilwaende","Zulaufbereiche","Buchten"]', true,
 'Talsperre im Osterzgebirge. Gutes Salmonidengewaesser.'),

('Zwenkauer See', 51.2200, 12.3100, 'Sachsen', 'See',
 '["Zander","Barsch","Hecht","Karpfen"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, 963.00, 48.0,
 '["Steilkanten","Plateaus","Steinschuettungen"]', true,
 'Zweitgroesster See im Leipziger Neuseenland. Aufsteigendes Zandergewaesser.'),

('Neisse bei Goerlitz', 51.1536, 14.9878, 'Sachsen', 'Fluss',
 '["Forelle","Aesche","Doebel","Barbe","Barsch"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, null, 2.0,
 '["Kiesbetten","Kolke","Stroemungskanten"]', true,
 'Grenzfluss mit gutem Salmonidenbestand. Naturnaher Flussabschnitt.'),

('Quitzdorfer Stausee', 51.3200, 14.6200, 'Sachsen', 'Talsperre',
 '["Karpfen","Hecht","Zander","Schleie","Aal"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, 750.00, 8.0,
 '["Schilf","Buchten","Inseln","Flachzonen"]', true,
 'Grosser flacher Stausee in der Oberlausitz. Exzellentes Karpfengewaesser.'),

('Markkleeberger See', 51.2600, 12.3900, 'Sachsen', 'See',
 '["Zander","Barsch","Hecht","Aal"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, 252.00, 58.0,
 '["Steilkanten","Plateaus","Kies"]', true,
 'Tiefer See im Leipziger Neuseenland. Guter Barschbestand.'),

('Zwickauer Mulde bei Zwickau', 50.7200, 12.4900, 'Sachsen', 'Fluss',
 '["Barbe","Doebel","Forelle","Barsch","Aal"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, null, 2.5,
 '["Wehre","Stroemungskanten","Kiesbetten","Totholz"]', true,
 'Abwechslungsreicher Fluss mit Uebergang von Forellen- zu Barbenregion.'),

('Talsperre Spremberg', 51.5700, 14.3600, 'Sachsen', 'Talsperre',
 '["Zander","Hecht","Barsch","Karpfen","Aal"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, 400.00, 10.0,
 '["Buchten","Schilf","Steinschuettungen"]', true,
 'Talsperre an der Spree. Guter Mischfischbestand.'),

('Berzdorfer See', 51.0700, 14.9300, 'Sachsen', 'See',
 '["Zander","Barsch","Hecht","Karpfen","Seeforelle"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, 960.00, 72.0,
 '["Steilkanten","Tiefwasserzonen","Buchten"]', true,
 'Einer der tiefsten Seen Sachsens. Junges Gewaesser mit aufstrebendem Fischbestand.'),

('Stausee Oberrabenstein', 50.8300, 12.8800, 'Sachsen', 'Talsperre',
 '["Karpfen","Hecht","Barsch","Schleie","Forelle"]',
 'Angelkarte LAV Sachsen erforderlich', 8.00, 20.00, 18.0,
 '["Buchten","Schilf","Stege"]', true,
 'Kleiner Stausee bei Chemnitz. Familienfreundlich.'),

('Kiesgrube Lober-Leine', 51.5200, 12.4100, 'Sachsen-Anhalt', 'See',
 '["Karpfen","Hecht","Schleie","Barsch"]',
 'Angelkarte LAV SA erforderlich', 8.00, 15.00, 5.0,
 '["Schilf","Kraut","Seerosen","Totholz"]', false,
 'Kleine naturnahe Kiesgrube. Guter Schleienbestand.'),

('Partwitzer See', 51.5000, 14.1000, 'Sachsen', 'See',
 '["Zander","Barsch","Hecht","Karpfen"]',
 'Angelkarte LAV Sachsen erforderlich', 10.00, 1120.00, 28.0,
 '["Inseln","Buchten","Steinschuettungen","Flachwasser"]', true,
 'Grosser See im Lausitzer Seenland. Vielversprechendes Raubfischgewaesser.')

on conflict do nothing;
