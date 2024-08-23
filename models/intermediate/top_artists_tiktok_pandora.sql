WITH tiktok_top AS (
    SELECT
        ARTIST,
        SUM(TIK_TOK_VIEWS) AS tiktok_views,
        SUM(TIK_TOK_POSTS) AS tiktok_posts,
        SUM(TIK_TOK_LIKES) AS tiktok_likes
    FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
    GROUP BY ARTIST
    HAVING SUM(TIK_TOK_VIEWS) IS NOT NULL
       AND SUM(TIK_TOK_POSTS) IS NOT NULL
       AND SUM(TIK_TOK_LIKES) IS NOT NULL
),

pandora_top AS (
    SELECT
        ARTIST,
        SUM(PANDORA_STREAMS) AS pandora_streams,
        SUM(PANDORA_TRACK_STATIONS) AS pandora_track_stations
    FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
    GROUP BY ARTIST
    HAVING SUM(PANDORA_STREAMS) IS NOT NULL
       AND SUM(PANDORA_TRACK_STATIONS) IS NOT NULL
)

SELECT
    t.ARTIST,
    t.tiktok_views,
    t.tiktok_posts,
    t.tiktok_likes,
    p.pandora_streams,
    p.pandora_track_stations
FROM tiktok_top t
LEFT JOIN pandora_top p ON t.ARTIST = p.ARTIST
WHERE t.tiktok_views IS NOT NULL
  AND t.tiktok_posts IS NOT NULL
  AND t.tiktok_likes IS NOT NULL
  AND p.pandora_streams IS NOT NULL
  AND p.pandora_track_stations IS NOT NULL
