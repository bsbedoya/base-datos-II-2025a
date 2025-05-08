PROCESO ALMACENADO CRUD : VINILOS 

CREATE OR REPLACE PROCEDURE crud_vinilos(
    IN p_accion VARCHAR,           -- 'crear', 'actualizar', 'eliminar', 'leer'
    IN p_id_vinilo INTEGER DEFAULT NULL,
    IN p_nom_vinilo VARCHAR DEFAULT NULL,
    IN p_descripcion TEXT DEFAULT NULL,
    IN p_precio NUMERIC DEFAULT NULL,
    IN p_stock INTEGER DEFAULT NULL,
    IN p_id_artista INTEGER DEFAULT NULL,
    IN p_id_sello INTEGER DEFAULT NULL,
    IN p_id_genero INTEGER DEFAULT NULL,
    IN p_id_categoria INTEGER DEFAULT NULL,
    IN p_estado BOOLEAN DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_registro RECORD;
BEGIN
    IF p_accion = 'crear' THEN
        INSERT INTO vinilos (
            nom_vinilo, descripcion, precio, stock, id_artista,
            id_sello, id_genero, id_categoria, estado
        ) VALUES (
            p_nom_vinilo, p_descripcion, p_precio, p_stock, p_id_artista,
            p_id_sello, p_id_genero, p_id_categoria, TRUE -- se crea activo
        );
        RAISE NOTICE 'Vinilo creado correctamente.';

    ELSIF p_accion = 'actualizar' THEN
        UPDATE vinilos
        SET nom_vinilo = COALESCE(p_nom_vinilo, nom_vinilo),
            descripcion = COALESCE(p_descripcion, descripcion),
            precio = COALESCE(p_precio, precio),
            stock = COALESCE(p_stock, stock),
            id_artista = COALESCE(p_id_artista, id_artista),
            id_sello = COALESCE(p_id_sello, id_sello),
            id_genero = COALESCE(p_id_genero, id_genero),
            id_categoria = COALESCE(p_id_categoria, id_categoria),
            estado = COALESCE(p_estado, estado)
        WHERE id_vinilo = p_id_vinilo;
        RAISE NOTICE 'Vinilo actualizado correctamente.';

    ELSIF p_accion = 'eliminar' THEN
        UPDATE vinilos
        SET estado = FALSE
        WHERE id_vinilo = p_id_vinilo;
        RAISE NOTICE 'Vinilo eliminado lógicamente (estado = FALSE).';

    ELSIF p_accion = 'leer' THEN
        FOR v_registro IN
            SELECT * FROM vinilos
            WHERE id_vinilo = p_id_vinilo
        LOOP
            RAISE NOTICE 'ID: %, Nombre: %, Precio: %, Stock: %, Estado: %',
                v_registro.id_vinilo,
                v_registro.nom_vinilo,
                v_registro.precio,
                v_registro.stock,
                v_registro.estado;
        END LOOP;

    ELSE
        RAISE EXCEPTION 'Acción no válida. Use: crear, actualizar, eliminar o leer.';
    END IF;
END;
$$;



PROCESO ALMACENADO CRUD : CLIENTES

CREATE OR REPLACE PROCEDURE crud_clientes(
    IN p_accion VARCHAR,               -- 'crear', 'actualizar', 'eliminar', 'leer'
    IN p_id_cliente INTEGER DEFAULT NULL,
    IN p_nom_cliente VARCHAR DEFAULT NULL,
    IN p_apellido VARCHAR DEFAULT NULL,
    IN p_email VARCHAR DEFAULT NULL,
    IN p_contrasena TEXT DEFAULT NULL,
    IN p_telefono VARCHAR DEFAULT NULL,
    IN p_direccion TEXT DEFAULT NULL,
    IN p_estado BOOLEAN DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_cliente RECORD;
BEGIN
    IF p_accion = 'crear' THEN
        INSERT INTO clientes (
            nom_cliente, apellido, email, contrasena,
            telefono, direccion, estado
        ) VALUES (
            p_nom_cliente, p_apellido, p_email, p_contrasena,
            p_telefono, p_direccion, TRUE  -- se crea como activo
        );
        RAISE NOTICE 'Cliente creado correctamente.';

    ELSIF p_accion = 'actualizar' THEN
        UPDATE clientes
        SET nom_cliente = COALESCE(p_nom_cliente, nom_cliente),
            apellido = COALESCE(p_apellido, apellido),
            email = COALESCE(p_email, email),
            contrasena = COALESCE(p_contrasena, contrasena),
            telefono = COALESCE(p_telefono, telefono),
            direccion = COALESCE(p_direccion, direccion),
            estado = COALESCE(p_estado, estado)
        WHERE id_cliente = p_id_cliente;
        RAISE NOTICE 'Cliente actualizado correctamente.';

    ELSIF p_accion = 'eliminar' THEN
        UPDATE clientes
        SET estado = FALSE
        WHERE id_cliente = p_id_cliente;
        RAISE NOTICE 'Cliente eliminado lógicamente (estado = FALSE).';

    ELSIF p_accion = 'leer' THEN
        FOR v_cliente IN
            SELECT * FROM clientes
            WHERE id_cliente = p_id_cliente
        LOOP
            RAISE NOTICE 'ID: %, Nombre: % %, Email: %, Teléfono: %, Estado: %',
                v_cliente.id_cliente,
                v_cliente.nom_cliente,
                v_cliente.apellido,
                v_cliente.email,
                v_cliente.telefono,
                v_cliente.estado;
        END LOOP;

    ELSE
        RAISE EXCEPTION 'Acción no válida. Use: crear, actualizar, eliminar o leer.';
    END IF;
END;
$$;



PROCESO ALMACENADO CRUD : PEDIDOS

CREATE OR REPLACE PROCEDURE crud_pedidos(
    IN p_accion VARCHAR,                -- 'crear', 'actualizar', 'eliminar', 'leer'
    IN p_id_pedido INTEGER DEFAULT NULL,
    IN p_id_cliente INTEGER DEFAULT NULL,
    IN p_total NUMERIC DEFAULT NULL,
    IN p_estado_pedido VARCHAR DEFAULT NULL,
    IN p_estado BOOLEAN DEFAULT NULL,
    IN p_id_metodo INTEGER DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_pedido RECORD;
BEGIN
    IF p_accion = 'crear' THEN
        INSERT INTO pedidos (
            id_cliente, total, estado_pedido, estado, id_metodo
        ) VALUES (
            p_id_cliente, p_total, 
            COALESCE(p_estado_pedido, 'pendiente'), 
            TRUE,
            p_id_metodo
        );
        RAISE NOTICE 'Pedido creado correctamente.';

    ELSIF p_accion = 'actualizar' THEN
        UPDATE pedidos
        SET id_cliente = COALESCE(p_id_cliente, id_cliente),
            total = COALESCE(p_total, total),
            estado_pedido = COALESCE(p_estado_pedido, estado_pedido),
            estado = COALESCE(p_estado, estado),
            id_metodo = COALESCE(p_id_metodo, id_metodo)
        WHERE id_pedido = p_id_pedido;
        RAISE NOTICE 'Pedido actualizado correctamente.';

    ELSIF p_accion = 'eliminar' THEN
        UPDATE pedidos
        SET estado = FALSE
        WHERE id_pedido = p_id_pedido;
        RAISE NOTICE 'Pedido eliminado lógicamente (estado = FALSE).';

    ELSIF p_accion = 'leer' THEN
        FOR v_pedido IN
            SELECT * FROM pedidos
            WHERE id_pedido = p_id_pedido
        LOOP
            RAISE NOTICE 'ID: %, Cliente: %, Total: %, Estado Pedido: %, Estado: %, Fecha: %',
                v_pedido.id_pedido,
                v_pedido.id_cliente,
                v_pedido.total,
                v_pedido.estado_pedido,
                v_pedido.estado,
                v_pedido.fecha_pedido;
        END LOOP;

    ELSE
        RAISE EXCEPTION 'Acción no válida. Use: crear, actualizar, eliminar o leer.';
    END IF;
END;
$$;














