# Recomendación Personalizada de Vinilos para un Cliente (ID: 10)

Este script SQL genera una lista de recomendaciones personalizadas de vinilos para un cliente específico (en este caso, el cliente con `id_cliente = 10`). Utiliza consultas comunes (CTE) para organizar los pasos lógicos de la recomendación y devuelve los vinilos más comprados por otros usuarios con gustos similares, ordenados por popularidad y calificación promedio.

## Tabla de Contenidos

1. Vinilos comprados por el cliente  
2. Géneros favoritos del cliente  
3. Clientes con gustos similares  
4. Vinilos comprados por esos clientes  
5. Calificaciones promedio de los vinilos  
6. Recomendación final  

---

## 1. Vinilos comprados por el cliente

```sql
vinilos_cliente AS (
  SELECT DISTINCT dp.id_vinilo
  FROM pedidos p
  JOIN detalles_pedido dp ON dp.id_pedido = p.id_pedido
  WHERE p.id_cliente = 10
)
```

Se seleccionan todos los vinilos que el cliente 10 ha comprado previamente.

---

## 2. Géneros favoritos del cliente

```sql
generos_favoritos AS (
  SELECT DISTINCT v.id_genero
  FROM vinilos v
  JOIN vinilos_cliente vc ON vc.id_vinilo = v.id_vinilo
)
```

Se obtienen los géneros musicales de los vinilos previamente comprados por el cliente.

---

## 3. Clientes con gustos similares

```sql
clientes_similares AS (
  SELECT DISTINCT p.id_cliente
  FROM pedidos p
  JOIN detalles_pedido dp ON dp.id_pedido = p.id_pedido
  JOIN vinilos v ON v.id_vinilo = dp.id_vinilo
  WHERE v.id_genero IN (SELECT id_genero FROM generos_favoritos)
    AND p.id_cliente != 10
)
```

Se identifican otros clientes que también hayan comprado vinilos de los mismos géneros, excluyendo al cliente original.

---

## 4. Vinilos comprados por esos clientes

```sql
vinilos_similares AS (
  SELECT v.id_vinilo, COUNT(*) AS veces_comprado
  FROM pedidos p
  JOIN detalles_pedido dp ON dp.id_pedido = p.id_pedido
  JOIN vinilos v ON v.id_vinilo = dp.id_vinilo
  WHERE p.id_cliente IN (SELECT id_cliente FROM clientes_similares)
    AND v.id_vinilo NOT IN (SELECT id_vinilo FROM vinilos_cliente)
  GROUP BY v.id_vinilo
)
```

Se listan los vinilos que esos otros clientes han comprado, excluyendo los que ya compró el cliente 10. También se cuenta cuántas veces fue comprado cada uno.

---

## 5. Calificaciones promedio de los vinilos

```sql
vinilos_con_rating AS (
  SELECT r.id_vinilo, AVG(r.calificacion) AS rating_promedio
  FROM reseñas_producto r
  WHERE r.estado = true
  GROUP BY r.id_vinilo
)
```

Se calculan los promedios de calificaciones (solo de reseñas activas) para cada vinilo.

---

## 6. Recomendación final

```sql
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
```

Se genera la lista final de recomendaciones. Se filtra para mostrar solo vinilos activos, se ordena por popularidad y rating promedio, y se limita a los 10 principales.

---
