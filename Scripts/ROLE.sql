ROLES

-- Crear usuarios
CREATE USER administrador WITH PASSWORD '123';
CREATE USER gestor WITH PASSWORD '123';
CREATE USER cliente WITH PASSWORD '123';

-- Crear roles
CREATE ROLE administrador_rol;
CREATE ROLE gestor_rol;
CREATE ROLE cliente_rol;

-- Permisos para administrador_rol: acceso total a base de datos, tablas y secuencias
GRANT ALL PRIVILEGES ON DATABASE e_commerce_nicho TO administrador_rol;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrador_rol;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO administrador_rol;


-- Permisos para inventario_rol: acceso limitado con lectura y modificación
GRANT CONNECT ON DATABASE e_commerce_nicho TO gestor_rol;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO gestor_rol;
GRANT INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO gestor_rol;


GRANT CONNECT ON DATABASE e_commerce_nicho TO cliente_rol;
GRANT INSERT ON reseñas_producto TO cliente_rol;



-- Asignación de roles a usuarios
GRANT administrador_rol TO administrador;
GRANT gestor_rol TO gestor;
GRANT cliente_rol TO cliente;
