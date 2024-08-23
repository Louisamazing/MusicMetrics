WITH combined_metrics AS (
    SELECT
        ARTIST,
        SUM(SPOTIFY_STREAMS) AS spotify_streams,
        SUM(YOU_TUBE_VIEWS) AS youtube_views,
        SUM(TIK_TOK_VIEWS) AS tiktok_views,
        SUM(PANDORA_STREAMS) AS pandora_streams
    FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
    GROUP BY ARTIST
)

SELECT
    ARTIST,
    spotify_streams,
    youtube_views,
    tiktok_views,
    pandora_streams
FROM combined_metrics
WHERE spotify_streams IS NOT NULL
  AND youtube_views IS NOT NULL
  AND tiktok_views IS NOT NULL
  AND pandora_streams IS NOT NULL
