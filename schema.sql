CREATE TABLE Passeggeri (
    id_passeggero INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Mezzi (
    targa_mezzo VARCHAR(20) PRIMARY KEY,
    modello VARCHAR(50),
    numero_posti INT NOT NULL
);

CREATE TABLE Autisti (
    id_autista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    patente VARCHAR(20) NOT NULL,
    targa_mezzo VARCHAR(20),
    FOREIGN KEY (targa_mezzo) REFERENCES Mezzi(targa_mezzo)
);

CREATE TABLE Tratte (
    id_tratta INT AUTO_INCREMENT PRIMARY KEY,
    citta_partenza VARCHAR(50) NOT NULL,
    citta_arrivo VARCHAR(50) NOT NULL
);

CREATE TABLE Corse (
    id_corsa INT AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    ora_partenza TIME NOT NULL,
    id_tratta INT NOT NULL,
    targa_mezzo VARCHAR(20),
    FOREIGN KEY (id_tratta) REFERENCES Tratte(id_tratta),
    FOREIGN KEY (targa_mezzo) REFERENCES Mezzi(targa_mezzo)
);

CREATE TABLE Fermate (
    id_fermata INT AUTO_INCREMENT PRIMARY KEY,
    id_corsa INT NOT NULL,
    citta VARCHAR(50) NOT NULL,
    orario_arrivo TIME,
    FOREIGN KEY (id_corsa) REFERENCES Corse(id_corsa)
);

CREATE TABLE Biglietti (
    id_biglietto INT AUTO_INCREMENT PRIMARY KEY,
    data_emissione DATE NOT NULL,
    id_passeggero INT NOT NULL,
    id_corsa INT NOT NULL,
    FOREIGN KEY (id_passeggero) REFERENCES Passeggeri(id_passeggero),
    FOREIGN KEY (id_corsa) REFERENCES Corse(id_corsa)
);
