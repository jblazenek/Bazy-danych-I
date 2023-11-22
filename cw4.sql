CREATE TABLE ksiegowosc.pracownicy
(
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR(50) NOT NULL,
    telefon VARCHAR(15)
);

CREATE TABLE ksiegowosc.godziny
(
    id_godziny INT PRIMARY KEY,
    data DATE NOT NULL,
    liczba_godzin DECIMAL(9, 2) NOT NULL,
    id_pracownika INT NOT NULL,
	FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
);

CREATE TABLE ksiegowosc.pensje
(
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(50) NOT NULL,
    kwota DECIMAL(10, 2) NOT NULL
);

CREATE TABLE ksiegowosc.premie
(
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50) NOT NULL,
    kwota DECIMAL(10, 2) NOT NULL
);

CREATE TABLE ksiegowosc.wynagrodzenia
(
	id_wynagrodzenia int PRIMARY KEY,
	data DATE NOT NULL,
	id_pracownika INT NOT NULL,
	FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
    id_pensji INT,
	FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensje(id_pensji),
	id_premii INT,
	FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii)
);

COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela zawierajaca informacje o pracownikach.';
COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela zawierajaca informacje o godzinach.';
COMMENT ON TABLE ksiegowosc.pensje IS 'Tabela zawierajaca informacje o pensjach.';
COMMENT ON TABLE ksiegowosc.premie IS 'Tabela zawierajaca informacje o premiach.';
COMMENT ON TABLE ksiegowosc.wynagrodzenia IS 'Tabela zawierajaca informacje o wynagrodzeniach.';


INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Jan', 'Kowalski', 'ul. Kwiatowa 1', '123456789'),
(2, 'Anna', 'Nowak', 'ul. Leśna 2', '987654321'),
(3, 'Piotr', 'Lis', 'ul. Szkolna 3', '111222333'),
(4, 'Ewa', 'Wójcik', 'ul. Polna 4', '444555666'),
(5, 'Kamil', 'Zając', 'ul. Ogrodowa 5', '777888999'),
(6, 'Magda', 'Mazur', 'ul. Rzeczna 6', '222333444'),
(7, 'Tomasz', 'Kaczmarek', 'ul. Młyńska 7', '555666777'),
(8, 'Karolina', 'Adamczyk', 'ul. Krótka 8', '999000111'),
(9, 'Michał', 'Wojciechowski', 'ul. Długa 9', '666777888'),
(10, 'Natalia', 'Sikora', 'ul. Zielona 10', '333444555');

INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2023-11-01', 8, 1),
(2, '2023-11-02', 7, 2),
(3, '2023-11-03', 6, 3),
(4, '2023-11-04', 8, 4),
(5, '2023-11-05', 7, 5),
(6, '2023-11-06', 8, 6),
(7, '2023-11-07', 7, 7),
(8, '2023-11-08', 6, 8),
(9, '2023-11-09', 8, 9),
(10, '2023-11-10', 7, 10);

INSERT INTO ksiegowosc.premie (id_premii, rodzaj, kwota)
VALUES
(1, 'Premia za staż', 200),
(2, 'Premia za wyniki', 150),
(3, 'Premia świąteczna', 100),
(4, 'Premia za efektywność', 180),
(5, 'Premia jubileuszowa', 250),
(6, 'Premia motywacyjna', 170),
(7, 'Premia za nadgodziny', 120),
(8, 'Premia uznaniowa', 160),
(9, 'Premia za specjalizację', 190),
(10, 'Premia za osiągnięcia', 140);

INSERT INTO ksiegowosc.pensje (id_pensji, stanowisko, kwota)
VALUES
(1, 'Kierownik', 3500),
(2, 'Specjalista', 2800),
(3, 'Asystent', 2300),
(4, 'Pracownik fizyczny', 2000),
(5, 'Analityk', 3200),
(6, 'Projektant', 3000),
(7, 'Administrator', 2600),
(8, 'Konsultant', 2900),
(9, 'Technik', 2400),
(10, 'Programista', 3100);

INSERT INTO ksiegowosc.wynagrodzenia (id_wynagrodzenia, data, id_pracownika, id_pensji, id_premii)
VALUES
(1, '2023-11-01', 1, 1, 1),
(2, '2023-11-02', 2, 2, 2),
(3, '2023-11-03', 3, 3, 3),
(4, '2023-11-04', 4, 4, 4),
(5, '2023-11-05', 5, 5, 5),
(6, '2023-11-06', 6, 6, 6),
(7, '2023-11-07', 7, 7, 7),
(8, '2023-11-08', 8, 8, 8),
(9, '2023-11-09', 9, 9, 9),
(10, '2023-11-10', 10, 10, 10);


--a)
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--b)
SELECT id_pracownika FROM ksiegowosc.wynagrodzenia WHERE (SELECT kwota FROM ksiegowosc.pensje WHERE id_pensji = wynagrodzenia.id_pensji) > 1000;

--c)
SELECT id_pracownika FROM ksiegowosc.wynagrodzenia WHERE id_premii IS NULL AND (SELECT kwota FROM ksiegowosc.pensje WHERE id_pensji = wynagrodzenia.id_pensji) > 2000;

--d)
SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';

--e)
SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

--f)
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.godziny.liczba_godzin - 160 AS nadgodziny
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika
WHERE ksiegowosc.godziny.liczba_godzin > 160;

--g)
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko 
FROM ksiegowosc.wynagrodzenia
JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenia.id_pensji = ksiegowosc.pensje.id_pensji
JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenia.id_pracownika = ksiegowosc.pracownicy.id_pracownika
WHERE ksiegowosc.pensje.kwota BETWEEN 1500 AND 3000;

--h)
SELECT pracownicy.imie, pracownicy.nazwisko FROM ksiegowosc.godziny
JOIN ksiegowosc.pracownicy ON godziny.id_pracownika = pracownicy.id_pracownika
LEFT JOIN ksiegowosc.wynagrodzenia ON godziny.id_pracownika = wynagrodzenia.id_pracownika
WHERE wynagrodzenia.id_premii IS NULL AND godziny.liczba_godzin > 160;

--i)
SELECT * FROM ksiegowosc.wynagrodzenia
ORDER BY (SELECT kwota FROM ksiegowosc.pensje WHERE id_pensji = wynagrodzenia.id_pensji);

--j)
SELECT * FROM ksiegowosc.wynagrodzenia
ORDER BY (SELECT kwota FROM ksiegowosc.pensje WHERE id_pensji = wynagrodzenia.id_pensji) DESC,
         (SELECT kwota FROM ksiegowosc.premie WHERE id_premii = wynagrodzenia.id_premii) DESC;

--k)
SELECT stanowisko, COUNT(*) AS liczba_pracownikow FROM ksiegowosc.pensje
JOIN ksiegowosc.wynagrodzenia ON pensje.id_pensji = wynagrodzenia.id_pensji
GROUP BY stanowisko;

--l)
SELECT AVG(kwota) AS srednia, MIN(kwota) AS minimalna, MAX(kwota) AS maksymalna FROM ksiegowosc.pensje
WHERE stanowisko = 'Kierownik';

--m)
SELECT SUM(kwota) AS suma_wynagrodzen FROM ksiegowosc.pensje
JOIN ksiegowosc.wynagrodzenia ON pensje.id_pensji = wynagrodzenia.id_pensji;

--n)
SELECT stanowisko, SUM(kwota) AS suma_wynagrodzen FROM ksiegowosc.pensje
JOIN ksiegowosc.wynagrodzenia ON pensje.id_pensji = wynagrodzenia.id_pensji
GROUP BY stanowisko;

--o)
SELECT stanowisko, COUNT(premie.id_premii) AS liczba_premii FROM ksiegowosc.pensje
JOIN ksiegowosc.wynagrodzenia ON pensje.id_pensji = wynagrodzenia.id_pensji
LEFT JOIN ksiegowosc.premie ON wynagrodzenia.id_premii = premie.id_premii
GROUP BY stanowisko;

--p)
DELETE FROM ksiegowosc.wynagrodzenia WHERE (SELECT kwota FROM ksiegowosc.pensje WHERE id_pensji = wynagrodzenia.id_pensji) < 1200;
