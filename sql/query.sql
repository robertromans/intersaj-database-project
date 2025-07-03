-- 1. Ricerca corse disponibili tra due città in una data specifica
SELECT C.id_corsa, C.data, C.ora_partenza, T.citta_partenza, T.citta_arrivo
FROM Corse C
JOIN Tratte T ON C.id_tratta = T.id_tratta
WHERE T.citta_partenza = 'Trebisacce'
AND T.citta_arrivo = 'Roma'
AND C.data = '2025-07-15';

-- 2. Verifica della disponibilità di posti su una corsa
SELECT M.numero_posti - COUNT(B.id_biglietto) AS posti_disponibili
FROM Corse C
JOIN Mezzi M ON C.targa_mezzo = M.targa_mezzo
LEFT JOIN Biglietti B ON B.id_corsa = C.id_corsa
WHERE C.id_corsa = 29;

-- 3. Storico biglietti acquistati da un passeggero
SELECT B.id_biglietto, B.data_emissione, T.citta_partenza, T.citta_arrivo, C.data, C.ora_partenza
FROM Biglietti B
JOIN Passeggeri P ON B.id_passeggero = P.id_passeggero
JOIN Corse C ON B.id_corsa = C.id_corsa
JOIN Tratte T ON C.id_tratta = T.id_tratta
WHERE P.email = 'john.doe@yahoo.com'
ORDER BY C.data DESC;

-- 4. Controllo validità di un biglietto
SELECT B.id_biglietto, C.data, C.ora_partenza,
  CASE 
    WHEN C.data > CURDATE() OR (C.data = CURDATE() AND C.ora_partenza > CURTIME())
    THEN 'Valido'
    ELSE 'Scaduto'
  END AS stato_biglietto
FROM Biglietti B
JOIN Corse C ON B.id_corsa = C.id_corsa
WHERE B.id_biglietto = 329;

-- 5. Elenco delle tratte effettuate da un mezzo in un intervallo temporale
SELECT C.id_corsa, C.data, T.citta_partenza, T.citta_arrivo
FROM Corse C
JOIN Tratte T ON C.id_tratta = T.id_tratta
WHERE C.targa_mezzo = 'AA052CL'
  AND C.data BETWEEN '2024-08-01' AND '2025-07-31'
ORDER BY C.data;
