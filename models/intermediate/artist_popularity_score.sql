SELECT
    ARTIST,
    (COALESCE(SUM(SPOTIFY_STREAMS), 0) * 0.4 +
     COALESCE(SUM(YOU_TUBE_VIEWS), 0) * 0.3 +
     COALESCE(SUM(TIK_TOK_VIEWS), 0) * 0.2 +
     COALESCE(SUM(PANDORA_STREAMS), 0) * 0.1) AS popularity_score
FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
GROUP BY ARTIST
ORDER BY popularity_score DESC
