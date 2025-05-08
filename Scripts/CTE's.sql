1.Top 5 vinilos más vendidos por género y artista

WITH vinilos_mas_vendidos AS (
    SELECT dp.id_vinilo, SUM(dp.cantidad) AS total_vendidos
    FROM detalles_pedido dp
    JOIN pedidos p ON dp.id_pedido = p.id_pedido
    WHERE p.estado = TRUE
    GROUP BY dp.id_vinilo
),
vinilos_info AS (
    SELECT v.id_vinilo, v.nom_vinilo, v.id_genero, v.id_artista
    FROM vinilos v
    WHERE v.estado = TRUE
),
generos_info AS (
    SELECT id_genero, nom_genero FROM generos WHERE estado = TRUE
),
artistas_info AS (
    SELECT id_artista, nom_artita FROM artistas WHERE estado = TRUE
),
vinilos_completo AS (
    SELECT vmv.total_vendidos, vi.nom_vinilo, gi.nom_genero, ai.nom_artita
    FROM vinilos_mas_vendidos vmv
    JOIN vinilos_info vi ON vmv.id_vinilo = vi.id_vinilo
    JOIN generos_info gi ON vi.id_genero = gi.id_genero
    JOIN artistas_info ai ON vi.id_artista = ai.id_artista
)
SELECT * FROM vinilos_completo
ORDER BY total_vendidos DESC
LIMIT 5;


Explicación de CTEs:

vinilos_mas_vendidos: Suma la cantidad vendida de cada vinilo.

vinilos_info: Filtra solo los vinilos activos y extrae su info básica.

generos_info: Filtra solo géneros activos.

artistas_info: Filtra solo artistas activos.

vinilos_completo: Junta todo para mostrar info de ventas con nombre del vinilo, género y artista.



2. Pedidos recientes con detalles de envío, cliente y método de pago

WITH pedidos_recientes AS (
    SELECT * FROM pedidos
    WHERE estado = TRUE
    ORDER BY fecha_pedido DESC
    LIMIT 10
),
clientes_info AS (
    SELECT id_cliente, nom_cliente, apellido, email FROM clientes WHERE estado = TRUE
),
metodos_pago_info AS (
    SELECT id_metodo, nom_metodo FROM metodos_pago WHERE estado = TRUE
),
envios_info AS (
    SELECT id_pedido, direccion_envio, empresa_envio, estado_envio
    FROM envios WHERE estado = TRUE
)
SELECT pr.id_pedido, pr.fecha_pedido, pr.total,
       ci.nom_cliente, ci.apellido, ci.email,
       mpi.nom_metodo,
       ei.direccion_envio, ei.empresa_envio, ei.estado_envio
FROM pedidos_recientes pr
JOIN clientes_info ci ON pr.id_cliente = ci.id_cliente
JOIN metodos_pago_info mpi ON pr.id_metodo = mpi.id_metodo
LEFT JOIN envios_info ei ON pr.id_pedido = ei.id_pedido;


Explicación:

pedidos_recientes: Últimos 10 pedidos activos.

clientes_info: Info básica de los clientes activos.

metodos_pago_info: Nombres de métodos de pago activos.

envios_info: Datos de envío relacionados a pedidos activos.


3. Carritos activos con los vinilos que contienen y su total estimado

WITH carritos_activos AS (
    SELECT * FROM carritos_compra WHERE estado = TRUE
),
clientes_info AS (
    SELECT id_cliente, nom_cliente, apellido FROM clientes WHERE estado = TRUE
),
vinilos_info AS (
    SELECT id_vinilo, nom_vinilo, precio FROM vinilos WHERE estado = TRUE
),
carritos_detalle AS (
    SELECT cv.id_carrito, cv.id_vinilo, cv.cantidad, v.precio, (cv.cantidad * v.precio) AS subtotal
    FROM carritos_vinilos cv
    JOIN vinilos_info v ON cv.id_vinilo = v.id_vinilo
),
carritos_totales AS (
    SELECT ca.id_carrito, ca.id_cliente, SUM(cd.subtotal) AS total_estimado
    FROM carritos_activos ca
    JOIN carritos_detalle cd ON ca.id_carrito = cd.id_carrito
    GROUP BY ca.id_carrito, ca.id_cliente
)
SELECT ct.id_carrito, ci.nom_cliente, ci.apellido, ct.total_estimado
FROM carritos_totales ct
JOIN clientes_info ci ON ct.id_cliente = ci.id_cliente;

Explicación:

carritos_activos: Carritos en estado activo.

clientes_info: Info básica del cliente.

vinilos_info: Vinilos disponibles con su precio.

carritos_detalle: Detalle de vinilos por carrito con subtotal.

carritos_totales: Total estimado por carrito.


4. Clientes con más pedidos, incluyendo su método de pago más común

WITH pedidos_validos AS (
    SELECT id_cliente, id_metodo, COUNT(*) AS total_pedidos
    FROM pedidos
    WHERE estado = TRUE
    GROUP BY id_cliente, id_metodo
),
clientes_info AS (
    SELECT id_cliente, nom_cliente, apellido FROM clientes WHERE estado = TRUE
),
metodos_info AS (
    SELECT id_metodo, nom_metodo FROM metodos_pago WHERE estado = TRUE
),
ranking_clientes AS (
    SELECT id_cliente, SUM(total_pedidos) AS pedidos_totales
    FROM pedidos_validos
    GROUP BY id_cliente
),
metodo_frecuente AS (
    SELECT DISTINCT ON (id_cliente) id_cliente, id_metodo
    FROM pedidos_validos
    ORDER BY id_cliente, total_pedidos DESC
)
SELECT ci.nom_cliente, ci.apellido, rc.pedidos_totales, mi.nom_metodo
FROM ranking_clientes rc
JOIN clientes_info ci ON rc.id_cliente = ci.id_cliente
JOIN metodo_frecuente mf ON ci.id_cliente = mf.id_cliente
JOIN metodos_info mi ON mf.id_metodo = mi.id_metodo
ORDER BY rc.pedidos_totales DESC
LIMIT 10;


Explicación:

pedidos_validos: Total de pedidos por cliente y método.

clientes_info: Datos del cliente.

metodos_info: Nombre de método de pago.

ranking_clientes: Clientes con más pedidos.

metodo_frecuente: Método más usado por cliente.

5. Ventas por categoría y género de vinilos

WITH ventas AS (
    SELECT dp.id_vinilo, SUM(dp.subtotal) AS total_ventas
    FROM detalles_pedido dp
    JOIN pedidos p ON dp.id_pedido = p.id_pedido
    WHERE p.estado = TRUE
    GROUP BY dp.id_vinilo
),
vinilos_info AS (
    SELECT id_vinilo, id_categoria, id_genero FROM vinilos WHERE estado = TRUE
),
categorias_info AS (
    SELECT id_categoria, nom_categoria FROM categorias WHERE estado = TRUE
),
generos_info AS (
    SELECT id_genero, nom_genero FROM generos WHERE estado = TRUE
),
ventas_cat_gen AS (
    SELECT ci.nom_categoria, gi.nom_genero, SUM(v.total_ventas) AS total
    FROM ventas v
    JOIN vinilos_info vi ON v.id_vinilo = vi.id_vinilo
    JOIN categorias_info ci ON vi.id_categoria = ci.id_categoria
    JOIN generos_info gi ON vi.id_genero = gi.id_genero
    GROUP BY ci.nom_categoria, gi.nom_genero
)
SELECT * FROM ventas_cat_gen
ORDER BY total DESC;


Explicación:

ventas: Total vendido por vinilo.

vinilos_info: Categoría y género del vinilo.

categorias_info: Nombres de categorías.

generos_info: Nombres de géneros.

ventas_cat_gen: Ventas agrupadas por categoría y género.


