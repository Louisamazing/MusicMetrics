-- models/intermediate/pandora_top.sql

SELECT
    ARTIST,
    SUM(PANDORA_STREAMS) AS pandora_streams
FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
GROUP BY ARTIST
