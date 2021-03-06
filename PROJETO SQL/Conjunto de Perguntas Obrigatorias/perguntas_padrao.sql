/*Quais países possuem mais faturas?*/
SELECT BillingCountry, COUNT(*)
FROM Invoice	
GROUP BY 1
ORDER BY 2 DESC;

/*Use sua consulta para retornar o e-mail, 
nome, sobrenome e gênero de todos os ouvintes de Rock. 
Retorne sua lista ordenada alfabeticamente por endereço 
de e-mail, começando por A. Você consegue encontrar um 
jeito de lidar com e-mails duplicados para que ninguém 
receba vários e-mails?
*/

SELECT DISTINCT c.Email,c.FirstName,c.LastName,g.name
FROM InvoiceLine il
JOIN Invoice i
ON il.InvoiceId = i.InvoiceId
JOIN Track t
ON t.TrackId = il.TrackId
JOIN Genre g
ON t.GenreId = g.GenreId
JOIN Customer c
ON c.CustomerId = i.CustomerId
GROUP BY c.Email
ORDER BY c.Email;

/*Quem está escrevendo as músicas de rock?*/

SELECT ar.ArtistId,ar.Name,COUNT(*)
FROM Track t
JOIN Genre g
ON t.GenreId = g.GenreId
JOIN Album a
ON a.AlbumId = t.AlbumId
JOIN Artist ar
ON ar.ArtistId = a.ArtistId
WHERE g.name = 'rock'
GROUP BY 2,1
ORDER BY 3 DESC;


/*Primeiro, descubra qual artista ganhou mais de acordo com InvoiceLines (linhas de faturamento).

Agora encontre qual cliente gastou mais com o artista que você encontrou acima.

*/
/*passo 1*/
SELECT ar.name,SUM(il.UnitPrice)
FROM InvoiceLine il
JOIN Invoice i
ON il.InvoiceId = i.InvoiceId
JOIN Track t
ON t.TrackId = il.TrackId
JOIN Genre g
ON t.GenreId = g.GenreId
JOIN Album a
ON a.AlbumId = t.AlbumId
JOIN Artist ar
ON ar.ArtistId = a.ArtistId
GROUP BY 1
ORDER BY 2 DESC;

/*passo 2*/
SELECT ar.name,SUM(il.UnitPrice),c.CustomerId,c.FirstName,c.LastName
FROM InvoiceLine il
JOIN Invoice i
ON il.InvoiceId = i.InvoiceId
JOIN Track t
ON t.TrackId = il.TrackId
JOIN Genre g
ON t.GenreId = g.GenreId
JOIN Album a
ON a.AlbumId = t.AlbumId
JOIN Artist ar
ON ar.ArtistId = a.ArtistId
JOIN Customer c
ON c.CustomerId = i.CustomerId
WHERE ar.Name = 'Iron Maiden'
GROUP BY 1,3,4,5
ORDER BY 2 DESC;

