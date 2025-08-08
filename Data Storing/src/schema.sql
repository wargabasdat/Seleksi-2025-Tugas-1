-- Tabel negara
CREATE TABLE negara (
    id_negara INT PRIMARY KEY,
    nama_negara VARCHAR(100) NOT NULL
);

-- Tabel konstruktor
CREATE TABLE konstruktor (
    id_konstruktor INT PRIMARY KEY,
    nama_konstruktor VARCHAR(100) NOT NULL,
    jenis_mesin VARCHAR(100) NOT NULL
);

-- Tabel tim-balap
CREATE TABLE tim_balap (
    id_tim INT PRIMARY KEY,
    nama_tim VARCHAR(100) NOT NULL,
    id_konstruktor INT,
    FOREIGN KEY (id_konstruktor) REFERENCES konstruktor(id_konstruktor)
);

-- Tabel pembalap
CREATE TABLE pembalap (
    id_pembalap INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    jumlah_kemenangan INT DEFAULT 0 CHECK (jumlah_kemenangan >= 0),
    is_champion BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    id_negara INT,
    FOREIGN KEY (id_negara) REFERENCES negara(id_negara)
);

-- Tabel sponsor
CREATE TABLE sponsor (
    id_sponsor INT PRIMARY KEY,
    nama_sponsor VARCHAR(100) NOT NULL,
    nilai_sponsor DECIMAL(15,2)
);

-- Tabel kerjasama-sponsor
CREATE TABLE kerjasama_sponsor (
    id_pembalap INT,
    id_sponsor INT,
    lama_tahun INT,
    PRIMARY KEY (id_pembalap, id_sponsor),
    FOREIGN KEY (id_pembalap) REFERENCES pembalap(id_pembalap),
    FOREIGN KEY (id_sponsor) REFERENCES sponsor(id_sponsor)
);

-- Tabel pembalap-tim
CREATE TABLE pembalap_tim (
    id_pembalap INT,
    id_tim INT,
    tahun YEAR,
    PRIMARY KEY (id_pembalap, id_tim),
    FOREIGN KEY (id_pembalap) REFERENCES pembalap(id_pembalap),
    FOREIGN KEY (id_tim) REFERENCES tim_balap(id_tim)
);

-- Tabel balapan
CREATE TABLE balapan (
    id_balapan INT PRIMARY KEY,
    tahun YEAR,
    nama_balapan VARCHAR(100) NOT NULL,
    id_pembalap_pemenang INT,
    FOREIGN KEY (id_pembalap_pemenang) REFERENCES pembalap(id_pembalap)
);
