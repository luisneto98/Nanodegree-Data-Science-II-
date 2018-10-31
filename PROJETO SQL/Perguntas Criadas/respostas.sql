/*Tempo de musica adquirido por país*/

SELECT i.BillingCountry, SUM(t.milliseconds) AS time
FROM InvoiceLine il
JOIN Invoice i
ON il.InvoiceId = i.InvoiceId
JOIN Track t
ON t.TrackId = il.TrackId
JOIN MediaType m
ON t.MediaTypeId = m.MediaTypeId
WHERE m.name NOT LIKE '%video%'
GROUP BY i.BillingCountry
ORDER BY time DESC

/*Quanto cada pessoa filiada a uma empresa comprou?*/
SELECT c.Company, SUM(i.total) AS Total
FROM Invoice i
JOIN Customer c
ON c.CustomerId = i.CustomerId
WHERE c.Company IS NOT NULL
GROUP BY c.Company
ORDER BY Total DESC;

/*Qual o melhor vendedor de cada Gênero de musica?*/
SELECT Name, Genre, MAX(Quantity) AS SalesQty
FROM (
	SELECT e.FirstName || e.LastName AS Name,g.name AS Genre, COUNT(*) AS Quantity
	FROM InvoiceLine il
	JOIN Invoice i
	ON il.InvoiceId = i.InvoiceId
	JOIN Track t
	ON t.TrackId = il.TrackId
	JOIN Genre g
	ON t.GenreId = g.GenreId
	JOIN Customer c
	ON c.CustomerId = i.CustomerId
	JOIN Employee e
	ON e.EmployeeId = c.SupportRepId
	GROUP BY e.FirstName || e.LastName,g.name
)EmployeeGenre
GROUP BY Genre
ORDER BY Name;
/*Quais as playlists mais famosas?*/

SELECT pl.name AS Playlist,COUNT(*) AS frequence
FROM InvoiceLine il
JOIN Invoice i
ON il.InvoiceId = i.InvoiceId
JOIN Track t
ON t.TrackId = il.TrackId
JOIN PlaylistTrack p
ON p.TrackId = t.TrackId
JOIN Playlist pl
ON pl.PlaylistId = p.PlaylistId
GROUP BY pl.name
ORDER BY frequence DESC
LIMIT 5
