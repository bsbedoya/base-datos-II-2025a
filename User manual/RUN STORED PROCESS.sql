CALL_CRUD

CALLS_VINILOS

CALL crud_vinilos(
    'crear',
    NULL,
    'Vinilo de Prueba',
    'Descripción del vinilo de prueba',
    19.99,
    50,
    1,  -- id_artista
    2,  -- id_sello
    3,  -- id_genero
    4,  -- id_categoria
    NULL
);


CALL crud_vinilos(
    'leer',
    1,    -- ID del vinilo que quieres leer
    NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL,
    NULL
);


CALL crud_vinilos(
    'actualizar',
    1,                        -- ID del vinilo a actualizar
    'Nuevo Nombre del Vinilo',
    NULL,                    -- no se actualiza la descripción
    24.99,                   -- nuevo precio
    NULL, NULL, NULL, NULL, NULL,
    NULL                     -- no se actualiza el estado
);


CALL crud_vinilos(
    'eliminar',
    1,    -- ID del vinilo a "eliminar"
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
);


CALLS_CLIENTE

CALL crud_clientes(
    'crear',
    NULL,
    'Juan',
    'Pérez',
    'juan.perez@example.com',
    'secreta123',
    '123456789',
    'Av. Siempre Viva 742',
    NULL
);


CALL crud_clientes(
    'leer',
    1,     -- ID del cliente que quieres leer
    NULL, NULL, NULL, NULL, NULL, NULL, NULL
);

CALL crud_clientes(
    'actualizar',
    1,                         -- ID del cliente a actualizar
    'Juan Carlos',            -- nuevo nombre
    NULL,                     -- no se actualiza el apellido
    NULL,                     -- no se actualiza el email
    NULL,                     -- no se actualiza la contraseña
    '987654321',              -- nuevo teléfono
    NULL,                     -- no se actualiza la dirección
    NULL                      -- no se actualiza el estado
);


CALL crud_clientes(
    'eliminar',
    1,    -- ID del cliente a eliminar
    NULL, NULL, NULL, NULL, NULL, NULL, NULL
);

CALLS_PEDIDOS

CALL crud_pedidos(
    'crear',
    NULL,
    1,             -- id_cliente
    100.50,        -- total
    'pendiente',   -- estado_pedido
    NULL,
    2              -- id_metodo
);

CALL crud_pedidos(
    'leer',
    1,  -- id_pedido
    NULL, NULL, NULL, NULL, NULL
);


CALL crud_pedidos(
    'actualizar',
    1,         -- id_pedido
    NULL,      -- no cambiar id_cliente
    120.75,    -- nuevo total
    'enviado', -- nuevo estado_pedido
    NULL,
    NULL
);


CALL crud_pedidos(
    'eliminar',
    1,
    NULL, NULL, NULL, NULL, NULL
);
