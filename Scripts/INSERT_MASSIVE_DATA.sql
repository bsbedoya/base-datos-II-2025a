INSERTAR DATOS 

CLIENTES 1M 

INSERT INTO clientes (nom_cliente, apellido, email, contrasena, telefono, direccion, estado)
SELECT
  'Nombre' || i,
  'Apellido' || i,
  'cliente' || i || '@correo.com',
  'pass' || i,
  '300' || i,
  'Dirección ' || i,
  true
FROM generate_series(1, 1000000) AS i;


METODOS_PAGO 50

INSERT INTO metodos_pago (nom_metodo, descripcion, estado)
SELECT
  'Método ' || i,
  'Descripción del método ' || i,
  true
FROM generate_series(1, 50) AS i;

SELLOS DISCOGRAFICOS 5000

INSERT INTO sellos_discograficos (nom_sello, pais, estado)
SELECT
  'Sello ' || i,
  'País ' || (i % 50),
  true
FROM generate_series(1, 5000) AS i;

ARTISTAS 50.000

INSERT INTO artistas (nom_artita, pais_origen, estado)
SELECT
  'Artista ' || i,
  'País ' || (i % 100),
  true
FROM generate_series(1, 50000) AS i;

GENEROS 500


INSERT INTO generos (nom_genero, descripcion, estado)
SELECT
  'Género ' || i,
  'Descripción género ' || i,
  true
FROM generate_series(1, 500) AS i;


CATEGORIAS 100

INSERT INTO categorias (nom_categoria, descripcion, estado)
SELECT
  'Categoría ' || i,
  'Descripción categoría ' || i,
  true
FROM generate_series(1, 100) AS i;


VINILOS 100.000

INSERT INTO vinilos (nom_vinilo, descripcion, precio, stock, id_artista, id_sello, id_genero, id_categoria, estado)
SELECT
  'Vinilo ' || i,
  'Descripción vinilo ' || i,
  ROUND((random() * 90 + 10)::numeric, 2),    -- Precio 10-100
  (random() * 100)::int,                      -- Stock 0-100
  (random() * 49999 + 1)::int,                -- id_artista
  (random() * 4999 + 1)::int,                 -- id_sello
  (random() * 499 + 1)::int,                  -- id_genero
  (random() * 99 + 1)::int,                   -- id_categoria
  true
FROM generate_series(1, 100000) AS i;


PEDIDOS 2M 

INSERT INTO pedidos (id_cliente, total, estado_pedido, estado, id_metodo)
SELECT
  (random() * 999999 + 1)::int,
  ROUND((random() * 500 + 20)::numeric, 2),  -- Total entre 20 y 520
  CASE 
    WHEN i % 4 = 0 THEN 'pendiente'
    WHEN i % 4 = 1 THEN 'completado'
    WHEN i % 4 = 2 THEN 'cancelado'
    ELSE 'enviado' 
  END,
  true,
  (random() * 49 + 1)::int
FROM generate_series(1, 2000000) AS i;


DETALLES PEDIDO 4M

INSERT INTO detalles_pedido (id_pedido, id_vinilo, cantidad, precio_unitario, subtotal)
SELECT
  (random() * 1999999 + 1)::int,
  (random() * 99999 + 1)::int,
  cantidad,
  precio_unitario,
  ROUND((cantidad * precio_unitario)::numeric, 2)
FROM (
  SELECT
    (random() * 1999999 + 1)::int AS id_pedido,
    (random() * 99999 + 1)::int AS id_vinilo,
    (random() * 5 + 1)::int AS cantidad,
    ROUND((random() * 90 + 10)::numeric, 2) AS precio_unitario
  FROM generate_series(1, 4000000)
) AS subquery;






