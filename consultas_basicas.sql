-- Listar las pistas (tabla Track) con precio mayor o igual a 1€
SELECT * from dbo.Track WHERE UnitPrice >= 1;

-- Listar las pistas de más de 4 minutos de duración
SELECT * from dbo.Track WHERE Milliseconds > 60000 * 4

-- Listar las pistas que tengan entre 2 y 3 minutos de duración
SELECT * from dbo.Track WHERE Milliseconds BETWEEN 60000 * 2 and 60000 * 3 ORDER BY Milliseconds;

-- Listar las pistas que uno de sus compositores (columna Composer) sea Mercury
SELECT * from dbo.Track WHERE Composer LIKE '%Mercury%';

-- Calcular la media de duración de las pistas (Track) de la plataforma
SELECT AVG(Milliseconds) as duracion_media_pistas from dbo.Track;

-- Listar los clientes (tabla Customer) de USA, Canada y Brazil
SELECT * from dbo.Customer WHERE Country in('Brazil','Canada','USA');

-- Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')
SELECT * from dbo.Track t 
inner JOIN dbo.Album a on a.AlbumId = t.AlbumId
INNER JOIN dbo.Artist ar on ar.ArtistId = a.ArtistId
WHERE ar.Name LIKE 'QUEEN'


-- Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie
SELECT * from dbo.Track t 
inner JOIN dbo.Album a on a.AlbumId = t.AlbumId
INNER JOIN dbo.Artist ar on ar.ArtistId = a.ArtistId
WHERE ar.Name LIKE 'QUEEN'
AND t.Composer LIKE '%David Bowie%';

-- Listar las pistas de la playlist 'Heavy Metal Classic'
SELECT * from dbo.Track t 
inner JOIN dbo.PlaylistTrack pt on pt.TrackId = t.TrackId
INNER JOIN dbo.Playlist p on p.PlaylistId = pt.PlaylistId
WHERE p.Name LIKE 'Heavy Metal Classic'

-- Listar las playlist junto con el número de pistas que contienen
SELECT COUNT(*), p.Name from dbo.Track t 
inner JOIN dbo.PlaylistTrack pt on pt.TrackId = t.TrackId
INNER JOIN dbo.Playlist p on p.PlaylistId = pt.PlaylistId
GROUP by p.Name;

-- Listar las playlist (sin repetir ninguna) que tienen alguna canción de AC/DC
SELECT DISTINCT t.Name, t.* 
from dbo.Track t 
inner JOIN dbo.PlaylistTrack pt on pt.TrackId = t.TrackId
INNER JOIN dbo.Playlist p on p.PlaylistId = pt.PlaylistId
INNER JOIN dbo.Album a on a.AlbumId = t.AlbumId
INNER JOIN dbo.Artist ar on ar.ArtistId = a.ArtistId
where ar.Name LIKE 'AC/DC'


-- Listar las playlist que tienen alguna canción del artista Queen, junto con la cantidad que tienen
SELECT 
    COUNT(*) as songs_of_best_group_ever,
    p.Name 
from dbo.Track t 
inner JOIN dbo.PlaylistTrack pt on pt.TrackId = t.TrackId
INNER JOIN dbo.Playlist p on p.PlaylistId = pt.PlaylistId
INNER JOIN dbo.Album a on a.AlbumId = t.AlbumId
INNER JOIN dbo.Artist ar on ar.ArtistId = a.ArtistId
WHERE t.Composer LIKE '%QUEEN%'
GROUP by p.Name


-- Listar las pistas que no están en ninguna playlist
-- esta query creo que esta bien 
SELECT * from dbo.Track t
LEFT JOIN dbo.PlaylistTrack plt on plt.TrackId = t.TrackId
WHERE plt.TrackId is null; 

-- Listar los artistas que no tienen album
SELECT * from dbo.Artist a
LEFT JOIN dbo.Album ab on ab.ArtistId = a.ArtistId
WHERE ab.ArtistId is null;


-- Listar los artistas con el número de albums que tienen
SELECT count(ab.AlbumId) as has_albums, a.* from dbo.Artist a
LEFT JOIN dbo.Album ab on ab.ArtistId = a.ArtistId
GROUP by a.ArtistId, a.Name
ORDER by has_albums ASC

