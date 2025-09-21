-- 1. Indice su id_passeggero nella tabella Biglietti
CREATE INDEX idx_biglietti_passeggero ON Biglietti(id_passeggero);
-- 2. Indice su data nella tabella Corse
CREATE INDEX idx_corse_data ON Corse(data);
-- 3. Indice su id_tratta nella tabella Segmenti
CREATE INDEX idx_segmenti_tratta ON Segmenti(id_tratta);
-- 4. Indice su luogo_partenza e luogo_arrivo nella tabella Tratte
CREATE INDEX idx_tratte_luogo ON Tratte(luogo_partenza, luogo_arrivo);
-- 5. Indice su targa_mezzo nella tabella Segmenti
CREATE INDEX idx_segmenti_mezzo ON Segmenti(targa_mezzo);
-- 6. Indice su id_autista nella tabella Segmenti
CREATE INDEX idx_segmenti_autista ON Segmenti(id_autista);


-- a) Ricerca delle corse programmate in una data specifica su una tratta
SELECT C.id_corsa, C.data, C.ora_partenza,
T.luogo_partenza, T.luogo_arrivo
FROM Corse C
JOIN Segmenti S ON C.id_corsa = S.id_corsa
JOIN Tratte T ON S.id_tratta = T.id_tratta
WHERE C.data = '2025-10-03'
AND T.luogo_partenza = 'Trebisacce'
AND T.luogo_arrivo = 'Roma';

-- b) Verifica della disponibilità di posti su una corsa
SELECT S.id_corsa,
M.targa_mezzo,
M.numero_posti - COUNT(B.id_biglietto) AS posti_disponibili
FROM Segmenti S
JOIN Mezzi M ON S.targa_mezzo = M.targa_mezzo
LEFT JOIN Biglietti B ON B.id_corsa = S.id_corsa
WHERE S.id_corsa = 29 -- ID della corsa di interesse (es. 29)
GROUP BY S.id_corsa, M.targa_mezzo, M.numero_posti;

-- c) Storico dei biglietti acquistati da un passeggero
SELECT B.id_biglietto, B.data_emissione,
C.data AS data_corsa, C.ora_partenza,
T.luogo_partenza, T.luogo_arrivo
FROM Biglietti B
JOIN Passeggeri P ON B.id_passeggero = P.id_passeggero
JOIN Corse C ON B.id_corsa = C.id_corsa
JOIN Segmenti S ON C.id_corsa = S.id_corsa
JOIN Tratte T ON S.id_tratta = T.id_tratta
WHERE P.email = 'pico.pallo@email.it' -- indirizzo email del passeggero
ORDER BY C.data DESC;

-- d) Controllo validità di un biglietto
SELECT B.id_biglietto,
C.data AS data_corsa,
C.ora_partenza,
CASE
WHEN C.data > CURDATE()
OR (C.data = CURDATE() AND C.ora_partenza > CURTIME())
THEN 'Valido'
ELSE 'Scaduto'
END AS stato_biglietto
FROM Biglietti B
JOIN Corse C ON B.id_corsa = C.id_corsa
WHERE B.id_biglietto = 123; -- ID del biglietto da verificare (es. 123)

-- e) Associazione tra mezzi, corse e autisti in una data
SELECT S.id_corsa, C.data,
S.targa_mezzo, M.modello,
S.id_autista, A.nome, A.cognome
FROM Segmenti S
JOIN Corse C ON S.id_corsa = C.id_corsa
JOIN Mezzi M ON S.targa_mezzo = M.targa_mezzo
JOIN Autisti A ON S.id_autista = A.id_autista
WHERE C.data = '2025-10-04';

-- f) Fermate e orari di una tratta
SELECT FT.id_tratta, T.luogo_partenza, T.luogo_arrivo,
F.id_fermata, F.luogo, FT.orario_fermata
FROM Fermate_Tratte FT
JOIN Tratte T ON FT.id_tratta = T.id_tratta
JOIN Fermate F ON FT.id_fermata = F.id_fermata
WHERE T.id_tratta = 5 -- ID della tratta di interesse (es. 5)
ORDER BY FT.orario_fermata;

-- g) Elenco delle tratte disponibili tra due località
SELECT id_tratta, luogo_partenza, luogo_arrivo
FROM Tratte
WHERE luogo_partenza = 'Milano'
AND luogo_arrivo = 'Metaponto';