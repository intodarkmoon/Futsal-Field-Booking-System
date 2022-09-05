--Tabel pengunjung
CREATE TABLE Pengunjung (
Idpengunjung varchar(3) PRIMARY KEY NOT NULL, 
Namapengunjung varchar(50),
Notelp varchar(50));

--Tabel Lapangan
CREATE TABLE Lapangan (Idlapangan varchar(4) PRIMARY KEY NOT NULL,
Namalapangan varchar(50),
Jenislapangan varchar(50),
Harga bigint);

--Tabel Pelayanan
CREATE TABLE Pelayanan (Idpelayan varchar(2) PRIMARY KEY NOT NULL,
Namapelayan varchar(50),
Jeniskelamin varchar(50));

--Tabel Booking
CREATE TABLE Booking (Idbooking varchar(5),
Idpengunjung varchar(3),
Idlapangan varchar(4),
Tanggalbooking timestamp,
Tanggalmain timestamp,
Lamamain int,
PRIMARY KEY(Idbooking),
FOREIGN KEY(Idpengunjung) REFERENCES Pengunjung(Idpengunjung),
FOREIGN key(Idlapangan) REFERENCES Lapangan(Idlapangan));

--Insert data pengunjung
INSERT INTO pengunjung VALUES ('A01', 'Abed', 085899990000);
INSERT INTO pengunjung VALUES ('A02', 'Lala', 085899991234);
INSERT INTO pengunjung VALUES ('A03', 'Lulu', 085899999812);
INSERT INTO pengunjung VALUES ('A04', 'Kali', 085899991111);
INSERT INTO pengunjung VALUES ('A05', 'Nula', 085899999000);

--Insert data lapangan
INSERT INTO lapangan VALUES ('001', 'Anfield','Polimer','50000');
INSERT INTO lapangan VALUES ('002', 'Old Trafford','Rumput','60000');
INSERT INTO lapangan VALUES ('003', 'GBK','Rumput','55000');
INSERT INTO lapangan VALUES ('004', 'GBLA','Polimer','55000');
INSERT INTO lapangan VALUES ('005', 'Camp Nou','Rumput',90000);

--Insert data pelayanan
INSERT INTO PELAYANAN VALUES ('1','Nani','Laki=laki');
INSERT INTO PELAYANAN VALUES ('2','Sarah','Perempuan');
INSERT INTO PELAYANAN VALUES ('3','Tom','Laki=laki');
INSERT INTO PELAYANAN VALUES ('4','Isil','Perempuan');
INSERT INTO PELAYANAN VALUES ('5','Jerry','Laki=laki');

--Insert data booking
INSERT INTO BOOKING VALUES ('B001', 'A01','002','2022-06-22 19:10:25','2022-06-22 22:18:10',3);
INSERT INTO BOOKING VALUES ('B002', 'A04','005','2022-06-22 09:50:15','2022-06-22 10:10:10',5);
INSERT INTO BOOKING VALUES ('B003', 'A03','001','2022-06-22 11:30:45','2022-06-22 14:19:21',1);
INSERT INTO BOOKING VALUES ('B004', 'A04','003','2022-06-22 18:10:35','2022-06-22 20:20:10',2);
INSERT INTO BOOKING VALUES ('B005', 'A05','002','2022-06-22 22:19:15','2022-06-22 23:30:05',3);

--Skenario Analisis

--Cari rata-rata lama main pengunjung?
SELECT AVG(B.LAMAMAIN) FROM BOOKING B; 

--Cari nama pengunjung dengan lama main diatas rata-rata?
SELECT Namapengunjung FROM PENGUNJUNG P 
INNER JOIN BOOKING B ON P.IDPENGUNJUNG = B.IDPENGUNJUNG
WHERE B.LAMAMAIN > (SELECT AVG(B.LAMAMAIN) FROM BOOKING B);

--Jarak waktu booking dan waktu main masing-masing pengunjung?
SELECT Namapengunjung, EXTRACT(HOUR FROM (B.TANGGALMAIN) - (B.TANGGALBOOKING)) AS "Jarak Waktu (Jam)" FROM PENGUNJUNG P 
INNER JOIN BOOKING B ON P.IDPENGUNJUNG = B.IDPENGUNJUNG;

--Lapangan futsal yang sering dipakai untuk bermain?
SELECT L.NAMALAPANGAN, COUNT(L.NAMALAPANGAN) AS Terpakai  FROM LAPANGAN L 
INNER JOIN BOOKING B ON L.IDLAPANGAN = B.IDLAPANGAN 
GROUP BY L.NAMALAPANGAN 
ORDER BY Terpakai DESC 
LIMIT 1;

--Lapangan yang paling lama digunakan untuk main?
SELECT L.NAMALAPANGAN, B.LAMAMAIN AS Longplayhour FROM LAPANGAN L 
INNER JOIN BOOKING B ON L.IDLAPANGAN = B.IDLAPANGAN 
ORDER BY Longplayhour DESC 
LIMIT 1;

