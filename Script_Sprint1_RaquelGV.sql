/*EXERCICI 1 - Crea una base de dades amb MySQL. Mostra les característiques principals de l'esquema creat i explica les diferents taules i variables que hi ha.
Al README d'aquest repositori es pot trobar una explicació detallada d'un diagrama EER. 
En aquest Codi, he utilizat comandes per obtenir informació de la base de dades i de les seves taules*/

SHOW TABLES; #mostra els noms de les taules que podem trobar
DESCRIBE tb_genre; #Entrem en detalls. Podem obtenir informació detallada de cadascuna de les taules (diferents camps o columnes, tipus de variables, si hi ha valors nulls, si els camps son claus. 
#tb_genre té 5 camps o columnes, una clau primària (genre_id) amb valors numèrics. 
DESCRIBE tb_movie; #8 camps o columnes, una clau primària (movie_id) amb valors numèrics. 
DESCRIBE tb_movie_person; #7 camps o columnes, 3 claus (movie_id, person_id, role_id) sense valors nulls
DESCRIBE tb_person; #9 camps o columnes, 2 claus (person_id com clau primària; person_paren_id com clau MULTIPLE, que a més permet valors nuls)
DESCRIBE tb_role; #5 camps o columnes, 1 clau primària (role_id) amb valors numèrics 

/*EXERCICI 2 - Has d'obtenir el nom, el país i la data de naixement d'aquelles persones per les quals no consti una data de mort i ordenar les dades de la persona més vella a la persona més jove.*/

SELECT person_name, person_country, person_dob FROM movies.tb_person WHERE person_dod IS NULL ORDER BY person_dob ASC;

/*EXERCICI 3 - Has d'obtenir el nom del gènere i el nombre total de pel·lícules d'aquest gènere i ordenar-ho per ordre descendent de nombre total de pel·lícules.  
Per resoldre aquest exercici, faré ús d'una SUBQUERY*/

SELECT genre_name, 
       (SELECT COUNT(movie_genre_id) 
          FROM tb_movie 
          WHERE movie_genre_id = tb_genre.genre_id) Number_movies
  FROM tb_genre
  ORDER BY Number_movies DESC;

/*EXERCICI 4: Has d'obtenir, per a cada persona, el seu nom i el nombre màxim de rols diferents que ha tingut en una mateixa pel·lícula. Posteriorment, mostra únicament aquelles persones que 
hagin assumit més d'un rol en una mateixa pel·lícula.

Per resoldre aquest exercici, suggereixo dues estratègies diferents. Si es fa tot l'exercici complet, es pot realitzar amb una sola QUERY més o menys senzilla. Si es vol fer en dues
parts, primer s'haurien de guardar els resultats previs en una taula temporal i posteriorment extreure els valors màxims i fer el filtratge. Això és degut al fet que MySQL NO permet
fer MAX a sobre de COUNT - així que la resolució més simple que he trobat consisteix a generar una taula temporal*/

SELECT DISTINCT person_name, COUNT(role_id) Number_roles
  FROM tb_person JOIN tb_movie_person
    ON tb_person.person_id = tb_movie_person.person_id
 GROUP BY tb_movie_person.movie_id, tb_movie_person.person_id
 HAVING COUNT(role_id) >1 ; #OPCIÓ 1 - No hi ha problema amb valors repetits, ja que totes les persones amb més d'un rol ho han fet només a una pel·lícula. Això no obstant, no hi ha cap filtratge per MAX.

CREATE TABLE Tabla_pruebita SELECT DISTINCT person_name, COUNT(role_id) AS Number_roles1
  FROM tb_person JOIN tb_movie_person
    ON tb_person.person_id = tb_movie_person.person_id
 GROUP BY tb_movie_person.movie_id, tb_movie_person.person_id
 ORDER BY person_name, COUNT(role_id) DESC; #OPCIÓ 2 - Creació d'una taula, on registrem el nombre de rols per persona i pel·lícula
 
 SELECT person_name, MAX(Number_roles1) FROM Tabla_pruebita
 GROUP BY person_name; #Ara si, podem filtrar per valors màxims i ens surt un registre per actor, amb el nombre màxim de rols
 
 SELECT person_name, MAX(Number_roles1) FROM Tabla_pruebita
 GROUP BY person_name
 HAVING MAX(Number_roles1) >1; #I podem afegir un HAVING a la comanda anterior per obtenir el resultat final.  

/*EXERCICI 5: Has de crear un nou gènere anomenat "Documental" el qual tingui com a identificador el nombre 69.*/
INSERT INTO tb_genre(genre_ID, genre_name, created_by_user) VALUES(69, "Documental", "Raquel");

/*EXERCICI 6: Elimina la pel·lícula "La Gran Familia Española" de la base de dades.
Cal notar que primer hem d'eliminar el registre de les taules filles - sino, no serà possible eliminar el registre. Per tant, i fent ús de la informació de l'exercici 1, primer
obtindrem la "movie_id" de la pel·lícula (clau primària), esborrarem els registres referents a aquesta pel·lícula en la base de dades tb_movie_person (que conté dades referents
a tres de les cinc taules de la base de dades) i després podrem esborrar el registre a la taula corresponent (tb_movie)*/

SELECT movie_id FROM tb_movie WHERE movie_title="La Gran Familia Española"; #Obtenim la ID per poder buscar la pel·lícula a les diferents taules

DELETE FROM tb_movie_person WHERE movie_id=11; #S'eliminen 7 files
DELETE FROM tb_movie WHERE movie_id=11; 

/*EXERCICI 7: Canvia el gènere de la pel·lícula "Ocho apellidos catalanes" perquè consti com a comèdia i no com a romàntica.*/

SELECT genre_name, genre_id from tb_genre WHERE genre_name="Comedia";#Busquem la ID del gènere "Comedia"
UPDATE tb_movie SET movie_genre_id = 3 WHERE movie_title = "Ocho apellidos catalanes"; #Si el SAFE MODE està activat, haurem d'obtenir primer la ID de la pel·lícula

SELECT movie_id FROM tb_movie WHERE movie_title="Ocho apellidos catalanes";
UPDATE tb_movie SET movie_genre_id = 3 WHERE movie_id = 9;


