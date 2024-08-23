WITH spotify_top AS (
    SELECT
        ARTIST,
        SUM(SPOTIFY_STREAMS) AS spotify_streams
    FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
    GROUP BY ARTIST
),

youtube_top AS (
    SELECT
        ARTIST,
        SUM(YOU_TUBE_VIEWS) AS youtube_views
    FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
    GROUP BY ARTIST
),

tiktok_top AS (
    SELECT
        ARTIST,
        SUM(TIK_TOK_VIEWS) AS tiktok_views
    FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
    GROUP BY ARTIST
),

pandora_top AS (
    SELECT
        ARTIST,
        SUM(PANDORA_STREAMS) AS pandora_streams
    FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
    GROUP BY ARTIST
)

SELECT
    COALESCE(s.ARTIST, y.ARTIST, t.ARTIST, p.ARTIST) AS ARTIST,
    COALESCE(s.spotify_streams, 0) AS spotify_streams,
    COALESCE(y.youtube_views, 0) AS youtube_views,
    COALESCE(t.tiktok_views, 0) AS tiktok_views,
    COALESCE(p.pandora_streams, 0) AS pandora_streams
FROM spotify_top s
FULL OUTER JOIN youtube_top y ON s.ARTIST = y.ARTIST
FULL OUTER JOIN tiktok_top t ON COALESCE(s.ARTIST, y.ARTIST) = t.ARTIST
FULL OUTER JOIN pandora_top p ON COALESCE(s.ARTIST, y.ARTIST, t.ARTIST) = p.ARTIST
