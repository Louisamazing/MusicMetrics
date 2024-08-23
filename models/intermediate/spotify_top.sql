-- models/intermediate/spotify_top.sql

SELECT
    ARTIST,
    SUM(SPOTIFY_STREAMS) AS spotify_streams
FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
GROUP BY ARTIST
