-- models/intermediate/youtube_top.sql

SELECT
    ARTIST,
    SUM(YOU_TUBE_VIEWS) AS youtube_views
FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
GROUP BY ARTIST
