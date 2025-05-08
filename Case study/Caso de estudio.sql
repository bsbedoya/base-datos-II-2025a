-- Recomendación para un cliente específico (por ejemplo, ID 10)
WITH
-- 1. Vinilos comprados por el cliente
vinilos_cliente AS (
  SELECT DISTINCT dp.id_vinilo
  FROM pedidos p
  JOIN detalles_pedido dp ON dp.id_pedido = p.id_pedido
  WHERE p.id_cliente = 10
),

-- 2. Géneros de los vinilos que compró
generos_favoritos AS (
  SELECT DISTINCT v.id_genero
  FROM vinilos v
  JOIN vinilos_cliente vc ON vc.id_vinilo = v.id_vinilo
),

-- 3. Otros clientes que compraron vinilos de esos géneros
clientes_similares AS (
  SELECT DISTINCT p.id_cliente
  FROM pedidos p
  JOIN detalles_pedido dp ON dp.id_pedido = p.id_pedido
  JOIN vinilos v ON v.id_vinilo = dp.id_vinilo
  WHERE v.id_genero IN (SELECT id_genero FROM generos_favoritos)
    AND p.id_cliente != 10
),

-- 4. Vinilos comprados por clientes similares
vinilos_similares AS (
  SELECT v.id_vinilo, COUNT(*) AS veces_comprado
  FROM pedidos p
  JOIN detalles_pedido dp ON dp.id_pedido = p.id_pedido
  JOIN vinilos v ON v.id_vinilo = dp.id_vinilo
  WHERE p.id_cliente IN (SELECT id_cliente FROM clientes_similares)
    AND v.id_vinilo NOT IN (SELECT id_vinilo FROM vinilos_cliente)
  GROUP BY v.id_vinilo
),

-- 5. Calificaciones promedio de esos vinilos
vinilos_con_rating AS (
  SELECT r.id_vinilo, AVG(r.calificacion) AS rating_promedio
  FROM reseñas_producto r
  WHERE r.estado = true
  GROUP BY r.id_vinilo
)

-- Resultado final: Vinilos recomendados ordenados por popularidad y rating
SELECT
  v.id_vinilo,
  v.nom_vinilo,
  vs.veces_comprado,
  COALESCE(vr.rating_promedio, 0) AS rating
FROM vinilos_similares vs
JOIN vinilos v ON v.id_vinilo = vs.id_vinilo
LEFT JOIN vinilos_con_rating vr ON vr.id_vinilo = vs.id_vinilo
WHERE v.estado = true
ORDER BY vs.veces_comprado DESC, rating DESC
LIMIT 10;
