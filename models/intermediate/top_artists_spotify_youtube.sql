WITH spotify_top AS (
    SELECT
        ARTIST,
        SUM(SPOTIFY_STREAMS) AS spotify_streams,
        SUM(SPOTIFY_PLAYLIST_REACH) AS spotify_playlist_reach
    FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
    GROUP BY ARTIST
    HAVING SUM(SPOTIFY_STREAMS) IS NOT NULL
       AND SUM(SPOTIFY_PLAYLIST_REACH) IS NOT NULL
),

youtube_top AS (
    SELECT
        ARTIST,
        SUM(YOU_TUBE_VIEWS) AS youtube_views,
        SUM(YOU_TUBE_PLAYLIST_REACH) AS youtube_playlist_reach
    FROM {{ source('raw', 'MUSIC_TRACK_METRICS') }}
    GROUP BY ARTIST
    HAVING SUM(YOU_TUBE_VIEWS) IS NOT NULL
       AND SUM(YOU_TUBE_PLAYLIST_REACH) IS NOT NULL
)

SELECT
    s.ARTIST,
    s.spotify_streams,
    s.spotify_playlist_reach,
    y.youtube_views,
    y.youtube_playlist_reach
FROM spotify_top s
LEFT JOIN youtube_top y ON s.ARTIST = y.ARTIST
WHERE s.spotify_streams IS NOT NULL
  AND s.spotify_playlist_reach IS NOT NULL
  AND y.youtube_views IS NOT NULL
  AND y.youtube_playlist_reach IS NOT NULL
