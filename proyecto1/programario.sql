-- 1) Averigua el DNI de todos los clientes. --

SELECT dni 
FROM cliente;

-- 2) Consulta todos los datos de todos los programas. --

SELECT *
FROM programa;

-- 3) Obtén un listado con los nombres de todos los programas. --

SELECT nombre
FROM programa;

-- 4) Genera una lista con todos los comercios. --

SELECT *
FROM comercio;

/* 5) Genera una lista de las ciudades con establecimientos donde se venden programas, sin que aparezcan 
valores duplicados (utiliza DISTINCT).*/

SELECT DISTINCT comercio.ciudad
FROM comercio INNER JOIN distribuye
    ON comercio.cif = distribuye.cif;

-- Mejor esta forma --

SELECT DISTINCT ciudad
FROM comercio;

-- 6) Obtén una lista con los nombres de programas, sin que aparezcan valores duplicados (utiliza DISTINCT). --

SELECT DISTINCT nombre
FROM programa;

-- 7) Obtén el DNI más 4 de todos los clientes. --

SELECT dni + 4
FROM cliente;

-- 8) Haz un listado con los códigos de los programas multiplicados por 7. --

SELECT codigo * 7
FROM programa;

-- 9) ¿Cuáles son los programas cuyo código es inferior o igual a 10? --

SELECT codigo, nombre
FROM programa
WHERE codigo <= 10;

-- 10) ¿Cuál es el programa cuyo código es 11? --

SELECT *
FROM programa
WHERE codigo = 11;

-- 11) ¿Qué fabricantes son de Estados Unidos? --

SELECT nombre
FROM fabricante
WHERE pais = "Estados Unidos";

/*12. ¿Cuáles son los fabricantes no españoles? Utilizar el operador IN.*/

SELECT nombre
FROM fabricante 
WHERE pais NOT IN ("España");

/*13. -- 13) Obtén un listado con los códigos de las distintas versiones de Windows.*/

SELECT codigo
FROM programa 
WHERE nombre = "Windows";

/*14. -- 14) ¿En qué ciudades comercializa programas El Corte Inglés?*/

SELECT ciudad
FROM comercio
WHERE nombre = "El Corte Inglés";

/*15.  ¿Qué otros comercios hay, además de El Corte Inglés? Utilizar el operador IN.*/

SELECT nombre
FROM comercio
WHERE nombre NOT IN ("El Corte Inglés");

/*16. Genera una lista con los códigos de las distintas versiones de Windows y Access. Utilizar el operador IN.*/

SELECT codigo 
FROM programa
WHERE nombre IN ("Windows", "Access");

/*17. Obtén un listado que incluya los nombres de los clientes de edades comprendidas entre 10 y 25 y de los mayores de 
50 años. Da una solución con BETWEEN y otra sin BETWEEN.*/

SELECT nombre
FROM cliente
WHERE edad BETWEEN 10 AND 25 OR edad > 50;

SELECT nombre
FROM cliente
WHERE (edad > 9 AND edad < 26) OR edad > 50;

/*18. Saca un listado con los comercios de Sevilla y Madrid. No se admiten valores duplicados.*/

SELECT DISTINCT nombre
FROM comercio
WHERE ciudad IN ("Sevilla", "Madrid");

-- 19) ¿Qué clientes terminan su nombre en la letra “o”? --

SELECT nombre
FROM cliente
WHERE nombre LIKE ("%o");

-- 20. ¿Qué clientes terminan su nombre en la letra “o” y, además, son mayores de 30 años? --

SELECT nombre
FROM cliente
WHERE nombre LIKE ("%o") AND edad > 30;

-- 21) Obtén un listado en el que aparezcan los programas cuya versión finalice por una letra i, o cuyo nombre comience por una A o por una W. --

SELECT *
FROM programa
WHERE (version LIKE("%i")) OR (nombre LIKE ("A%") OR nombre LIKE ("W%"));

-- 22) Obtén un listado en el que aparezcan los programas cuya versión finalice por una letra i, o cuyo nombre comience por una A y termine por una S. --

SELECT *
FROM programa
WHERE (version LIKE("%i")) OR (nombre LIKE("A%s"));

-- 23) Obtén un listado en el que aparezcan los programas cuya versión finalice por una letra i, y cuyo nombre no comience por una A. --

SELECT *
FROM programa 
WHERE version LIKE("%i") AND nombre NOT LIKE("A%");

-- 24. Obtén una lista de empresas por orden alfabético ascendente. --

SELECT nombre
FROM fabricante 
ORDER BY nombre ASC;

-- 25. Genera un listado de empresas por orden alfabético descendente. --

SELECT nombre
FROm fabricante
ORDER BY nombre DESC;

-- 26. Obtén un listado de programas por orden de versión --

SELECT nombre, version
FROM programa
ORDER BY version;

-- 27) Genera un listado de los programas que desarrolla Oracle. --

SELECT programa.*
FROM programa INNER JOIN desarrolla
    ON programa.codigo = desarrolla.codigo
    INNER JOIN fabricante
    fabricante.id_fab = desarrolla.id_fab
WHERE fabricante.nombre = "Oracle";

-- Uso de USING (solo cuando unimos dos columnas cuyos ids, FK y PK, tienen el mismo nombre) --

SELECT progrma.*
FROM programa INNER JOIN desarrolla
    USING (codigo)
    INNER JOIN fabricante 
    USING (id_fab)
WHERE fabricante.nombre = "Oracle";

-- 28) ¿Qué comercios distribuyen Windows? --

SELECT comercio*
FROM comercio INNER JOIN distribuye
    ON comercio.cif = distribuye.cif
    INNER JOIN programa
    ON distribuye.codigo = programa.codigo
WHERE programa.nombre = "Windows";

-- Con USING --

SELECT comercio.*
FROM comercio INNER JOIN distribuye
    USING (cif)
    INNER JOIN programa
    USING (codigo)
WHERE programa.nombre = "Windows";

-- 29. Genera un listado de los programas y cantidades que se han distribuido a El  Corte Inglés de Madrid. --

SELECT COUNT(programa.codigo) AS "Programas distribuidos a El Corte Inglés de Madrid"
FROM programa INNER JOIN distribuye
    ON programa.codigo = distribuye.codigo
    INNER JOIN comercio
    ON distribuye.cif = comercio.cif
WHERE comercio.nombre = "El Corte Inglés" AND comercio.ciudad = "Madrid"
GROUP BY nombre;

-- 30. ¿Qué fabricante ha desarrollado Freddy Hardest? --

SELECT fabricante.nombre
FROM fabricante INNER JOIN desarrolla
    ON fabricante.id_fab = desarrolla.id_fab
    INNER JOIN programa
    ON desarrolla.codigo = programa.codigo
WHERE programa.nombre = "Freddy Hardest";

-- 31. ) Selecciona el nombre de los programas que se registran por Internet. --

SELECT programa.nombre
FROM programa INNER JOIN registra
    ON programa.codigo = registra.codigo
WHERE registra.medio = "Internet";

-- 32. ) Selecciona el nombre de las personas que se registran por Internet. --

SELECT cliente.nombre
FROM cliente INNER JOIN registra
    ON cliente.dni = registra.dni
WHERE registra.medio = "Internet";

-- 33) ¿Qué medios ha utilizado para registrarse Pepe Pérez? --

SELECT registra.medio
FROM cliente INNER JOIN registra
    ON cliente.dni = registra.dni
WHERE cliente.nombre = "Pepe Pérez";

-- 34. ) ¿Qué usuarios han optado por Internet como medio de registro? --

SELECT cliente.nombre
FROM cliente INNER JOIN registra
    ON cliente.dni = registra.dni
WHERE registra.medio = "Internet";

-- 35. ) ¿Qué programas han recibido registros por tarjeta postal? --

SELECT programa.nombre
FROM programa INNER JOIN registra
    ON programa.codigo = registra.codigo
WHERE registra.medio = "Tarjeta postal";

-- 36. ) ¿En qué localidades se han vendido productos que se han registrado por Internet? --

SELECT comercio.ciudad
FROM comercio INNER JOIN registra
    ON comercio.cif = registra.cif
WHERE registra.medio = "Internet";

/*37. ) Obtén un listado de los nombres de las personas que se han registrado por Internet, junto al nombre de los programas para los 
que ha efectuado el registro. */

SELECT cliente.nombre, programa.nombre
FROM programa INNER JOIN registra
    ON programa.codigo = registra.codigo
    INNER JOIN cliente
    ON registra.dni = cliente.dni
WHERE registra.medio = "Internet";

/*38. ) Genera un listado en el que aparezca cada cliente junto al programa que ha registrado, el medio con el que lo ha hecho y el 
comercio en el que lo ha adquirido.*/

SELECT cliente.*, programa.nombre, registra.medio, comercio.nombre
FROM cliente INNER JOIN registra USING (dni)
    INNER JOIN programa USING (codigo)
        INNER JOIN distribuye USING (codigo)
            INNER JOIN comercio USING (cif);

SELECT cliente.*, programa.nombre, registra.medio, comercio.nombre
FROM cliente INNER JOIN registra USING(dni)
    INNER JOIN programa USING (codigo)
    INNER JOIN distribuye USING (codigo)
    INNER JOIN comercio 
    ON distribuye.cif = comercio.cif;

SELECT cliente.*, programa.nombre, registra.medio, comercio.nombre
FROM cliente INNER JOIN registra
    ON cliente.dni = registra.dni
    INNER JOIN programa
        ON programa.codigo = registra.codigo
        INNER JOIN distribuye
            ON distribuye.codigo = programa.codigo
            INNER JOIN comercio
            ON comercio.cif = distribuye.cif;

-- Las dos consultas anteriores estarían mal porque no nos hace falta la table distribuye, ya está relacionado por la tabla registra --

-- Corrección --

SELECT cliente.*, programa.nombre, registra.medio, comercio.nombre
FROM cliente INNER JOIN registra 
    USING(dni)
    INNER JOIN programa 
    USING(codigo)
    INNER JOIN comercio
    USING(cif); 


-- 39.Obtén el nombre de los usuarios que han registrado el programa "Paradox" en su versión "2". --

SELECT cliente.nombre 
FROM cliente INNER JOIN registra
    ON cliente.dni = registra.dni
    INNER JOIN programa
    ON registra.codigo = programa.codigo
WHERE programa.nombre = "Paradox" AND programa.version = "2";

-- 40.  Nombre de aquellos fabricantes cuyo país es el mismo que 'Oracle'. (Subconsulta). --

SELECT fabricante.nombre
FROM fabricante
WHERE fabricante.pais = (
    SELECT fabricante.pais
    FROM fabricante INNER JOIN desarrolla
        ON fabricante.id_fab = desarrolla.id_fab
        INNER JOIN programa
        ON desarrolla.codigo = programa.codigo
    WHERE programa.nombre = "Oracle"
);

-- Corrección --

SELECT fabricante.nombre
FROM fabricante
WHERE pais = (
    SELECT pais
    FROM fabricante
    WHERE nombre = "Oracle"
) AND nombre NOT LIKE "Oracle";

-- 41.  Nombre de aquellos clientes que tienen la misma edad que Pepe Pérez. (Subconsulta). --

SELECT cliente.nombre
FROM cliente 
WHERE cliente.edad = (
    SELECT cliente.edad
    FROM cliente
    WHERE cliente.nombre = "Pepe Pérez"
) AND cliente.nombre NOT LIKE "Pepe Pérez";

-- 42. Genera un listado con los comercios que tienen su sede en la misma ciudad que tiene el comercio 'Centro Mail'. (Subconsulta). --

SELECT *
FROM comercio
WHERE comercio.ciudad = (
    SELECT comercio.ciudad
    FROM comercio
    WHERE comercio.nombre = "Centro Mail"
) AND comercio.nombre NOT LIKE "Centro Mail";

-- 43. ) Nombre de aquellos clientes que han registrado un producto de la misma forma que el cliente 'Pepe Pérez'. (Subconsulta). -- 


SELECT cliente.nombre
FROM cliente INNER JOIN registra USING (dni)
WHERE registra.medio IN (
    SELECT registra.medio
    FROM registra INNER JOIN cliente
        ON registra.dni = cliente.dni
    WHERE cliente.nombre = "Pepe Pérez"
) AND cliente.nombre NOT LIKE "Pepe Pérez";

/* No podemos utilizar el = porque la subcosulta nos devuelve dos valores, tenemos que usar la cláusula IN, puede estar contenido en un resultado o en 
el otro */

-- 44. Obtener el número de programas que hay en la tabla programas. --

SELECT COUNT(codigo) AS "Total Progrmas"
FROM programa;

SELECT COUNT(*) AS "Total Programas"
FROM programa;

-- Otra forma --

SELECT COUNT(DISTINCT nombre) 
FROM programa;

-- 45. ) Calcula el número de clientes cuya edad es mayor de 40 años. --

SELECT COUNT(dni) AS "Clientes mayores de 40"
FROM cliente
WHERE edad > 40;

-- 46.  Calcula el número de productos que ha vendido el establecimiento cuyo CIF es 1. --

SELECT COUNT(distribuye.codigo) AS "Productos vendidos por el CIF 1"
FROM cliente INNER JOIN registra
    ON cliente.dni = registra.dni
    INNER JOIN comercio
    ON registra.cif = comercio.cif
    INNER JOIN distribuye
    ON comercio.cif = distribuye.cif
WHERE distribuye.cif = 1;

-- CORRECCIÓN --

SELECT SUM(cantidad)
FROM distribuye
WHERE cif = 1;

-- Solo trabajamos con la tabla distribuye

-- 47. ) Calcula la media de programas que se venden cuyo código es 7. --

SELECT COUNT(programa.codigo)/distribuye.cantidad AS "Media de programas vendidos del código 7"
FROM programa INNER JOIN distribuye
    ON programa.codigo = distribuye.codigo
WHERE programa.codigo = 7;

-- CORRECiÓN --

SELECT AVG(cantidad)
FROM distribuye
WHERE codigo = 7;

-- Si queremos redondear la salida --
SELECT ROUND(AVG(cantidad))
FROM distribuye
WHERE codigo = 7;

-- Otra forma --

SELECT ((SELECT SUM(cantidad)
                        FROM distribuye
                        WHERE codigo = 7) / SUM(cantidad)) * 100
FROM distribuye;

-- 48.  Calcula la mínima cantidad de programas de código 7 que se ha vendido --

SELECT MIN(cantidad) AS "Cantidad mínima de programas de código 7 vendidos"
FROM distribuye
WHERE codigo = 7;

-- 49.  Calcula la máxima cantidad de programas de código 7 que se ha vendido. --

SELECT MAX(cantidad) AS "Cantidad máxima de programas de código 7 vendidos"
FROM distribuye
WHERE codigo = 7;

-- 50. ¿En cuántos establecimientos se vende el programa cuyo código es 7? --

SELECT COUNT(comercio.cif) AS "Establecimientos donde se vende el programa de código 7"
FROM programa INNER JOIN distribuye 
    ON programa.codigo = distribuye.codigo
    INNER JOIN comercio
    ON distribuye.cif = comercio.cif
WHERE programa.codigo = 7;

-- Corrección --

SELECT COUNT(cif) AS "Establecimientos donde se vende el programa de código 7"
FROM distribuye
WHERE codigo = 7;

-- 51. Calcular el número de registros que se han realizado por Internet. --

SELECT COUNT(*) "Número de registros por Internet"
FROM registra
WHERE medio = "Internet";

-- 52. Obtener el número total de programas que se han vendido en 'Sevilla'. --

SELECT COUNT(programa.codigo) AS "Número de programas vendidos en Sevilla"
FROM programa INNER JOIN distribuye
    ON programa.codigo = distribuye.codigo
    INNER JOIN comercio 
    ON distribuye.cif = comercio.cif
WHERE comercio.ciudad = "Sevilla";

-- Corrección --
-- Por codigo de programa --

SELECT COUNT(DISTINCT distribuye.codigo) AS "TOTAL"
FROM comercio INNER JOIN distribuye USING (cif)
WHERE comercio.ciudad = "Sevilla";

-- Por cantidad de cada programa. Esta sería la respuesta correcta --

SELECT SUM(distribuye.cantidad) AS "TOTAL"
FROM comercio INNER JOIN distribuye USING (cif)
WHERE comercio.ciudad = "Sevilla";

-- CANTIDAD TOTAL DE UNIDADES VENDIDAS DE CADA PROGRAMA --

SELECT SUM(distribuye.cantidad) AS "TOTAL", distribuye.codigo
FROM comercio INNER JOIN distribuye USING (cif)
WHERE comercio.ciudad = "Sevilla"
GROUP BY distribuye.codigo;

-- 53. Calcular el número total de programas que han desarrollado los fabricantes cuyo país es 'Estados Unidos'. --

SELECT COUNT(programa.codigo) AS "Número de programas desarrollados por fabricantes de EEUU"
FROM programa INNER JOIN desarrolla
    ON programa.codigo = desarrolla.codigo
    INNER JOIN fabricante
    ON fabricante.id_fab = desarrolla.id_fab
WHERE fabricante.pais = "Estados Unidos";

-- NO HACE FALTA información de la tabla programa porque el código ya lo tenemos en la tabla intermedia --

-- CORRECCIÓN --
-- interpretando que las versiones no cambian el programa --

SELECT COUNT(DISTINCT desarrolla.codigo) AS "TOTAL PROGRAMAS DE EEUU"
FROM fabricante INNER JOIN desarrolla USING (id_fab)
WHERE fabricante.pais = "Estados Unidos";

-- interpretando que distintas versiones cuentan como otro programa--

SELECT COUNT(desarrolla.codigo)
FROM distribuye INNER JOIN fabricante USING (id_fab)
    INNER JOIN programa USING (codigo)
WHERE fabricante.pais = "Estados Unidos"
GROUP BY programa.nombre; -- ver el archivo de Rico --

/* 54.  Visualiza el nombre de todos los clientes en mayúscula. En el resultado de la consulta debe aparecer también la longitud de
 la cadena nombre. (USAR UPPER() Y LENGTH())*/

 SELECT UPPER(nombre) AS "NOMBRE", CHAR_LENGTH(nombre) AS "Longitud del nombre"
 FROM cliente;

 -- LENGTH cuenta los bytes, por lo que las tildes también las cuenta --
 -- CHAR_LENGTH cuenta el número de caracteres --

-- 55. Con una consulta concatena los campos nombre y versión de la tabla programa. (USAR CONCAT()) --

SELECT CONCAT(programa.nombre, " ", programa.version)
FROM programa;

-- Si concatena con un campo nulo, pone toda la fila a null --

SELECT CONCAT_WS(" ", nombre, version)
FROM programa;

-- Primero ponemos el separador y luego las columnas que queremos concatenar --

-- b) Concatena las distintas versiones con el nombre del programa en un mismo registro --

SELECT nombre, GROUP_CONCAT(version SEPARATOR " ; ")
FROM programa
GROUP BY nombre;

-- c) Mostrar la misma información que se pide en el apartado b pero monstrándola en una columna --

SELECT CONCAT_WS(". Versión: ", nombre, GROUP_CONCAT(version SEPARATOR " ; "))
FROM programa
GROUP BY nombre;