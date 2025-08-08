-- Create Dim Table untuk Youtuber
CREATE TABLE "Dim_Youtuber" (
    youtuber_name VARCHAR(100) PRIMARY KEY,
    gender VARCHAR(10),
    email VARCHAR(255),
    "type" VARCHAR(10)
);

-- Create Dim Table untuk Channel
CREATE TABLE "Dim_Channel" (
    youtube_channel_link VARCHAR(255) PRIMARY KEY,
    channel_name VARCHAR(255),
    "description" TEXT,
    type_of_channel VARCHAR(50),
    since DATE
);

-- Insert data ke Dim_Youtuber dari tabel youtubers
INSERT INTO "Dim_Youtuber" (youtuber_name, gender, email, "type")
SELECT
    youtuber_name,
    gender,
    email,
    "type"
FROM
    youtubers
ON CONFLICT (youtuber_name) DO NOTHING;

-- Insert data ke Dim_Channel dari tabel channels
INSERT INTO "Dim_Channel" (youtube_channel_link, channel_name, description, type_of_channel, since)
SELECT
    youtube_channel_link,
    channel_name,
    description,
    type_of_channel,
    TO_DATE(since, 'Mon YYYY')
FROM
    channels
ON CONFLICT (youtube_channel_link) DO NOTHING;

-- Create Fact Table
CREATE TABLE "Fact_Top_Channels" (
    youtuber_name VARCHAR(100) REFERENCES "Dim_Youtuber"(youtuber_name),
    youtube_channel_link VARCHAR(255) REFERENCES "Dim_Channel"(youtube_channel_link),
    youtube_subscribers INTEGER,
    facebook_followers INTEGER,
    instagram_followers INTEGER
);

-- Insert data ke Fact_Top_Channels dari tabel youtubers dan channels
INSERT INTO "Fact_Top_Channels" (youtuber_name, youtube_channel_link, youtube_subscribers, facebook_followers, instagram_followers)
SELECT
    y.youtuber_name,
    c.youtube_channel_link,
    y.youtube_subscribers,
    y.facebook_followers,
    y.instagram_followers
FROM
    youtubers AS y
JOIN
    channels AS c ON y.youtuber_name = c.youtuber_name;

-- Contoh Query Analitik

-- Analisis: Rata-rata subscribers YouTube berdasarkan tipe influencer
--SELECT
--    "type",
--    AVG(youtube_subscribers) AS avg_yt_subscribers
--FROM
--    "Dim_Youtuber"
--JOIN
--    "Fact_Top_Channels" ON "Dim_Youtuber".youtuber_name = "Fact_Top_Channels".youtuber_name
--GROUP BY
--    "type";

-- Analisis: Rata-rata followers Instagram berdasarkan tipe influencer
--SELECT
--    "type",
--    AVG(instagram_followers) AS avg_ig_followers
--FROM
--    "Dim_Youtuber"
--JOIN
--    "Fact_Top_Channels" ON "Dim_Youtuber".youtuber_name = "Fact_Top_Channels".youtuber_name
--GROUP BY
--    "type"
--ORDER BY
--    avg_ig_followers DESC;