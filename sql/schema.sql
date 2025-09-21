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
cognome VARCHAR(50) NOT NULL,
patente VARCHAR(20) NOT NULL
);

CREATE TABLE Tratte (
id_tratta INT AUTO_INCREMENT PRIMARY KEY,
luogo_partenza VARCHAR(50) NOT NULL,
luogo_arrivo VARCHAR(50) NOT NULL
);

CREATE TABLE Corse (
id_corsa INT AUTO_INCREMENT PRIMARY KEY,
data DATE NOT NULL,
ora_partenza TIME NOT NULL
);

CREATE TABLE Fermate (
id_fermata INT AUTO_INCREMENT PRIMARY KEY,
luogo VARCHAR(50) NOT NULL
);

CREATE TABLE Segmenti (
id_corsa INT NOT NULL,
id_tratta INT NOT NULL,
id_autista INT NOT NULL,
targa_mezzo VARCHAR(20) NOT NULL,
PRIMARY KEY (id_corsa, id_tratta, id_autista, targa_mezzo),
FOREIGN KEY (id_corsa) REFERENCES Corse(id_corsa),
FOREIGN KEY (id_tratta) REFERENCES Tratte(id_tratta),
FOREIGN KEY (id_autista) REFERENCES Autisti(id_autista),
FOREIGN KEY (targa_mezzo) REFERENCES Mezzi(targa_mezzo)
);

CREATE TABLE Fermate_Tratte (
id_tratta INT NOT NULL,
id_fermata INT NOT NULL,
orario_fermata TIME,
PRIMARY KEY (id_tratta, id_fermata),
FOREIGN KEY (id_tratta) REFERENCES Tratte(id_tratta),
FOREIGN KEY (id_fermata) REFERENCES Fermate(id_fermata)
);

CREATE TABLE Biglietti (
id_biglietto INT AUTO_INCREMENT PRIMARY KEY,
data_emissione DATE NOT NULL,
id_passeggero INT NOT NULL,
id_corsa INT NOT NULL,
FOREIGN KEY (id_passeggero) REFERENCES Passeggeri(id_passeggero),
FOREIGN KEY (id_corsa) REFERENCES Corse(id_corsa)
);
