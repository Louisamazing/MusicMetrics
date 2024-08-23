-- models/intermediate/tiktok_top.sql

SELECT
    ARTIST,
    SUM(TIK_TOK_VIEWS) AS tiktok_views
FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
GROUP BY ARTIST
