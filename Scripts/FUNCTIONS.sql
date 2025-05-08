FUNCIONES

CLIENTE

CREATE OR REPLACE FUNCTION insertar_cliente(
    p_nom_cliente VARCHAR,
    p_apellido VARCHAR,
    p_email VARCHAR,
    p_contrasena TEXT,
    p_telefono VARCHAR,
    p_direccion TEXT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO clientes (nom_cliente, apellido, email, contrasena, telefono, direccion, estado)
    VALUES (p_nom_cliente, p_apellido, p_email, p_contrasena, p_telefono, p_direccion, TRUE);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_clientes_activos()
RETURNS TABLE(
    id_cliente INTEGER,
    nom_cliente VARCHAR,
    apellido VARCHAR,
    email VARCHAR,
    telefono VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT c.id_cliente, c.nom_cliente, c.apellido, c.email, c.telefono
    FROM clientes c
    WHERE c.estado = TRUE;
END;
$$ LANGUAGE plpgsql;


PEDIDOS


CREATE OR REPLACE FUNCTION insertar_pedido(
    p_id_cliente INTEGER,
    p_total NUMERIC,
    p_id_metodo INTEGER
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO pedidos (id_cliente, total, estado, id_metodo)
    VALUES (p_id_cliente, p_total, TRUE, p_id_metodo);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_pedidos_por_cliente(p_id_cliente INTEGER)
RETURNS TABLE(
    id_pedido INTEGER,
    fecha_pedido TIMESTAMP,
    total NUMERIC,
    estado_pedido VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT p.id_pedido, p.fecha_pedido, p.total, p.estado_pedido
    FROM pedidos p
    WHERE p.id_cliente = p_id_cliente;
END;
$$ LANGUAGE plpgsql;


VINILOS

CREATE OR REPLACE FUNCTION insertar_vinilo(
    p_nom_vinilo VARCHAR,
    p_descripcion TEXT,
    p_precio NUMERIC,
    p_stock INTEGER,
    p_id_artista INTEGER,
    p_id_sello INTEGER,
    p_id_genero INTEGER,
    p_id_categoria INTEGER
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO vinilos (nom_vinilo, descripcion, precio, stock, id_artista, id_sello, id_genero, id_categoria, estado)
    VALUES (p_nom_vinilo, p_descripcion, p_precio, p_stock, p_id_artista, p_id_sello, p_id_genero, p_id_categoria, TRUE);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION obtener_vinilos_disponibles()
RETURNS TABLE(
    id_vinilo INTEGER,
    nom_vinilo VARCHAR,
    precio NUMERIC,
    stock INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT v.id_vinilo, v.nom_vinilo, v.precio, v.stock
    FROM vinilos v
    WHERE v.estado = TRUE AND v.stock > 0;
END;
$$ LANGUAGE plpgsql;



