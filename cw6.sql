-- a)
UPDATE ksiegowosc.pracownicy
SET telefon = '(+48) ' || telefon
WHERE telefon IS NOT NULL;

-- b)
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(SUBSTRING(telefon, 7, 3), '-', SUBSTRING(telefon, 10, 3), '-', SUBSTRING(telefon, 13))
WHERE telefon IS NOT NULL;

-- c)
SELECT
    id_pracownika,
    imie,
    UPPER(nazwisko) AS nazwisko,
	adres,
    telefon
FROM
    ksiegowosc.pracownicy
ORDER BY
    LENGTH(UPPER(nazwisko)) DESC
LIMIT 1;

-- d)
SELECT
    pracownicy.id_pracownika,
    imie,
    nazwisko,
    adres,
    telefon,
    MD5(CAST(pensje.kwota AS VARCHAR)) AS zakodowana_pensja
FROM
    ksiegowosc.pracownicy
JOIN
    ksiegowosc.wynagrodzenia ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenia.id_pracownika
JOIN
    ksiegowosc.pensje ON ksiegowosc.wynagrodzenia.id_pensji = ksiegowosc.pensje.id_pensji;

-- f)
SELECT
    pracownicy.id_pracownika,
    imie,
    nazwisko,
    adres,
    telefon,
    pensje.kwota AS pensja,
    premie.kwota AS premia
FROM
    ksiegowosc.pracownicy
LEFT JOIN
    ksiegowosc.wynagrodzenia ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
LEFT JOIN
    ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
LEFT JOIN
    ksiegowosc.premie ON wynagrodzenia.id_premii = premie.id_premii;

-- g)
SELECT 
    CONCAT('Pracownik ', p.imie, ' ', p.nazwisko, ', w dniu 7.08.2017 otrzymał pensję całkowitą na kwotę ', (pn.kwota + pr.kwota), ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', pn.kwota, ' zł, premia: ', pr.kwota, ' zł, nadgodziny: ',  '0 zł.') AS raport
FROM 
    wynagrodzenie w
JOIN
    pracownicy p ON w.id_pracownika = p.id_pracownika
JOIN
	pensje pn ON w.id_pensji = pn.id_pensji
JOIN
	premie pr ON w.id_premii = pr.id_premii
WHERE
    p.imie = 'Jan' AND p.nazwisko = 'Nowak'





