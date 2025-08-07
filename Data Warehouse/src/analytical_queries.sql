-- Query 1: Menghitung jumlah game untuk setiap genre
SELECT
    dg.genre_name,
    COUNT(fgr.game_key) AS total_games
FROM
    FactGameRank fgr
JOIN
    DimGenre dg ON fgr.genre_key = dg.genre_key
GROUP BY
    dg.genre_name
ORDER BY
    total_games DESC;

-- Query 2: Menampilkan 10 genre dengan game terbanyak
SELECT
    dg.genre_name,
    COUNT(fgr.game_key) AS total_games
FROM
    FactGameRank fgr
JOIN
    DimGenre dg ON fgr.genre_key = dg.genre_key
GROUP BY
    dg.genre_name
ORDER BY
    total_games DESC
LIMIT 10;

-- Query 3: Mencari rata-rata peringkat (rank) untuk game bergenre 'RPG'
SELECT
    AVG(fgr.rank) AS average_rank_for_rpg
FROM
    FactGameRank fgr
JOIN
    DimGenre dg ON fgr.genre_key = dg.genre_key
WHERE
    dg.genre_name = 'RPG';

-- Query 4: Menampilkan semua game yang memiliki genre 'Action'
SELECT
    dga.title,
    fgr.rank
FROM
    FactGameRank fgr
JOIN
    DimGame dga ON fgr.game_key = dga.game_key
JOIN
    DimGenre dge ON fgr.genre_key = dge.genre_key
WHERE
    dge.genre_name = 'Action'
ORDER BY
    fgr.rank ASC;
