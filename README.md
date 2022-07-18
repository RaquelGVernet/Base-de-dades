# Base-de-dades

### Sprint 1 for the IT Academy Course (Data Science - Online) - Raquel García Vernet

En aquest repositori es pot trobar el codi per la resolució dels exercicis del Sprint 1 (Bases de dades relacionals - SQL). La resolució s'ha fet utilitzant **MySQL**, treballant mitjançant la **MySQL Workbench 8.0**. Al mateix codi es poden trobar comentaris específics sobre algunes resolucions, així com solucions alternatives en casos concrets. 

A més, en aquest fitxer README m'agradaria adjuntar (com a part de la resolució de l'Exercici 1) una explicació i visualització de la base de dades que s'ha utilitzat per resoldre els problemes. 

### Explicació de la base de dades problema - Ampliació de l'exercici 1

Per visualitzar la base de dades "movies", a més de les comandes que es mostren al Script, he generat un diagrama EER fent ús de **MySQL Workbench**. En concret, he fet ús de l'eina Reverse Engineer.

![Image of EER diagram](https://github.com/RaquelGVernet/Base-de-dades/blob/main/EER_database_movies.png)

*Figura 1: Resultats del diagrama EER generat a MySQL Workbench*

En aquesta base de dades hi trobem 5 taules. En cada un dels quadrats podem veure els camps o columnes que conté aquesta taula i el tipus de dades que admet cada columna (per exemple, VARCHAR, INT, DATE, etc). 

Tanmateix, podem veure les **claus (KEYS)** de les diverses taules, tant primàries (dibuix de clau de color grogs) com foranies (dibuix de clau color vermell). Per exemple, a la imatge podem veure que a la taula “tb_movie_person” tenim 3 claus foranies que redirigeixen a tres taules diferents. 

En aquest esquema també podem observar el **tipus de relació** que existeix entre les diverses taules. Podem trobar **relacions obligatòries (línia senzilla)**, que vol dir que per cada ocurrència de l'entitat A ha d’existir obligatòriament l’existència de l’entitat B. Aquest tipus de relació és el que trobem entre la taula tb_movie_person amb la resta de taules associades (tb_person, tb_role, tb_movie). També trobem dues **relacions opcionals (no és necessària l’ocurrència)**, que és la que podem veure entre la taula tb_genre amb la taula tb_movie i en la pròpia taula de tb_person. Per acabar, trobem una **relació de recursivitat** a la taula tb_person, mitjançant l’atribut person_parent_id (és a dir, algunes persones registrades poden tenir de pare o mare a alguna persona també registrada en aquesta taula).

Finalment, als extrems de cadascuna de les relacions podem trobar el **tipus de cardinalitat i les seves restriccions** (1 a 1, molts a molts, molts a 1...). Per analitzar un exemple concret, en el cas de la relació de recursivitat de la taula tb_person podem veure una sortida inicial que indica 1 o més (és a dir, el pare o mare haurà de tenir com a mínim un fill, però en podrà tenir molts). La relació és opcional (no és necessari que existeixi relació paternal o maternal entre tots els registres). Finalment, a l’altre extrem de la relació de recursivitat observem dues barres, que indiquen una relació d’un i només un: és a dir, els registres només podran tenir associat un pare o mare.  

### Ara, passem a l'acció!

Un cop hem analitzat el tipus de base de dades que tenim, així com les seves característiques principals, podem començar amb la resolució dels exercicis. En aquest mateix repositori es pot trobar un fitxer amb el nom "Script_Sprint1_RaquelGV". Aquest Script per MySQL permet resoldre els diferents problemes plantejats. 

