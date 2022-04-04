-- 1. DI CUÁNTOS SURFISTAS HAN SURFEADO EN OLAS DE DIFICULTAD “DIFICIL”.

SELECT COUNT(DISTINCT playas_surfistas.idSurfista) AS "Número de surfistas"
FROM surfistas INNER JOIN playas_surfistas
	ON surfistas.id = playas_surfistas.idSurfista
    INNER JOIN playas 
    ON playas_surfistas.idPlaya = playas.id
    INNER JOIN olas 
    ON playas.id = olas.idPlaya
WHERE olas.dificultad LIKE "dificil";

-- 2. MUESTRA EL NOMBRE Y EL APELLIDO DE LOS SURFISTAS EN  UNA ÚNICA COLUMNA QUE HAYAN SURFEADO EN LA PLAYA DE MAYOR EXTENSIÓN.

SELECT CONCAT(surfistas.nombre, " ", surfistas.apellido) AS "Nombre y apellidos del surfista"
FROM surfistas INNER JOIN playas_surfistas
	ON surfistas.id = playas_surfistas.idSurfista
    INNER JOIN playas 
    ON playas_surfistas.idPlaya = playas.id
WHERE playas.extension = (
	SELECT MAX(extension)
    FROM playas 
);

-- 3. MUESTRA LA INFORMACIÓN DE LOS SURFISTAS QUE HAYAN SURFEADO EN MÁS DE 2 PLAYAS DISTINTAS.

SELECT surfistas.*
FROM surfistas INNER JOIN playas_surfistas
	ON surfistas.id = playas_surfistas.idSurfista
GROUP BY playas_surfistas.idSurfista
HAVING COUNT(DISTINCT playas_surfistas.idPlaya) > 2;

/*4. MUESTRA EL NOMBRE DE LA PLAYA ASÍ COMO EL NOMBRE Y APELLIDOS DE LOS SURFISTAS EN UNA ÚNICA COLUMNA JUNTO CON EL NÚMERO DE PLAYAS EN 
LAS QUE HAN SURFEADO.*/
-- 5. MUESTRA LAS PLAYAS QUE NO FUERON SURFEADAS POR NINGUN SURFISTA CON OLAS CUYA DIFICULTAD NO SEA NI MEDIA NI FACIL.
-- 6.UESTRA LA INFORMACIÓN DE LAS PLAYAS CON UNA EXTENSIÓN MAYOR A 500,00 METROS CUADRADOS QUE HAYAN SIDO SURFEADAS POR MENOS DE 2 SURFISTAS.
-- 7. HAZ QUE LOS SURFISTAS QUE HAYAN SURFEADO EN ALGUNA PLAYA CON OLA DE DIFICULTAD DIFICIL PASEN A SER DE CATEGORIA SENIOR (USAD SUBCONSULTA).
/*8. BORRA EL REGISTRO DE AQUELLOS SURFISTAS CUYO APELLIDO EMPIECE POR “V” Y CUYA PENULTIMA LETRA SEA LA “E” TENIENDO EN CUENTA QUE SU NOMBRE DEBE SUPERAR LOS 
4 CARACTERES, EN CASO DE TENER UN NOMBRE DE 4 O MENOS CARACTERES, EL REGISTRO NO SERÁ BORRADO.*/