INDICES SOBRE FOREIGN KEYS 

Acelerar consultas

-- Mejora joins entre pedidos y clientes
CREATE INDEX idx_pedidos_id_cliente ON pedidos(id_cliente);

-- Mejora joins entre detalles_pedido y pedidos
CREATE INDEX idx_detalles_pedido_id_pedido ON detalles_pedido(id_pedido);

-- Mejora joins entre detalles_pedido y vinilos
CREATE INDEX idx_detalles_pedido_id_vinilo ON detalles_pedido(id_vinilo);

-- Mejora joins entre vinilos y artista/sello/genero/categoria
CREATE INDEX idx_vinilos_id_artista ON vinilos(id_artista);
CREATE INDEX idx_vinilos_id_sello ON vinilos(id_sello);
CREATE INDEX idx_vinilos_id_genero ON vinilos(id_genero);
CREATE INDEX idx_vinilos_id_categoria ON vinilos(id_categoria);

-- Mejora joins entre pedidos y metodos_pago
CREATE INDEX idx_pedidos_id_metodo ON pedidos(id_metodo);


Claves foráneas: conectan tablas (relaciones).

Índices en claves foráneas: aceleran joins y filtros.

Hazlo tú mismo: PostgreSQL no los crea por defecto.}


script SQL para PostgreSQL que detecta todas las claves foráneas en tu base de datos que no tienen un índice asociado y genera automáticamente los comandos CREATE INDEX recomendados:

Script: generar índices faltantes en claves foráneas

WITH fk_columns AS (
  SELECT
    conname AS constraint_name,
    conrelid::regclass AS table_name,
    a.attname AS column_name
  FROM pg_constraint AS c
  JOIN unnest(c.conkey) AS colnum ON true
  JOIN pg_attribute AS a ON a.attrelid = c.conrelid AND a.attnum = colnum
  WHERE c.contype = 'f'
),
indexed_columns AS (
  SELECT
    t.relname AS table_name,
    a.attname AS column_name
  FROM pg_index i
  JOIN pg_class t ON t.oid = i.indrelid
  JOIN unnest(i.indkey) WITH ORDINALITY AS ind(attnum, ord) ON true
  JOIN pg_attribute a ON a.attrelid = t.oid AND a.attnum = ind.attnum
),
missing_indexes AS (
  SELECT fk.table_name, fk.column_name
  FROM fk_columns fk
  LEFT JOIN indexed_columns idx
    ON fk.table_name::text = idx.table_name AND fk.column_name = idx.column_name
  WHERE idx.column_name IS NULL
)
SELECT
  'CREATE INDEX idx_' || table_name || '_' || column_name || ' ON ' || table_name || '(' || column_name || ');' AS create_index_sql
FROM missing_indexes;


fk_columns: identifica todas las columnas que son claves foráneas.

indexed_columns: lista columnas que ya están indexadas.

missing_indexes: compara ambas listas para ver qué claves foráneas no tienen índice.

Ejecuta el script en tu base de datos.

Copia los resultados (que serán comandos CREATE INDEX ...).

Luego, pega esos comandos y ejecútalos para crear los índices realmente.




