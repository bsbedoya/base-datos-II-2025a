CREATE TABLE artistas (
	id_artista SERIAL PRIMARY KEY,
	nom_artita VARCHAR(150),
	pais_origen VARCHAR(100),
	estado BOOLEAN 
);

CREATE TABLE sellos_discograficos (
	id_sello SERIAL PRIMARY KEY,
	nom_sello VARCHAR(150),
	pais VARCHAR(100),
	estado BOOLEAN 
);

CREATE TABLE generos (
	id_genero SERIAL PRIMARY KEY,
	nom_genero VARCHAR(100),
	descripcion TEXT,
	estado BOOLEAN 
);

CREATE TABLE categorias (
	id_categoria SERIAL PRIMARY KEY,
	nom_categoria VARCHAR(100),
	descripcion TEXT,
	estado BOOLEAN 
);

CREATE TABLE clientes (
	id_cliente SERIAL PRIMARY KEY,
	nom_cliente VARCHAR(150),
	apellido VARCHAR(150),
	email VARCHAR(150) UNIQUE,
	contrasena TEXT,
	telefono VARCHAR(30),
	direccion TEXT,
	estado BOOLEAN,
        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE metodos_pago (
	id_metodo SERIAL PRIMARY KEY,
	nom_metodo VARCHAR(100),
	descripcion TEXT,
	estado BOOLEAN 
);

CREATE TABLE pedidos (
	id_pedido SERIAL PRIMARY KEY,
	id_cliente INTEGER REFERENCES clientes(id_cliente) ON UPDATE CASCADE ON DELETE RESTRICT,
	fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	total NUMERIC(10,2),
	estado_pedido VARCHAR(50) DEFAULT 'pendiente',
	estado BOOLEAN,
	id_metodo INTEGER REFERENCES metodos_pago(id_metodo) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE vinilos (
	id_vinilo SERIAL PRIMARY KEY,
	nom_vinilo VARCHAR(255),
	descripcion TEXT,
	precio NUMERIC(10,2),
	stock INTEGER,
	id_artista INTEGER REFERENCES artistas(id_artista) ON UPDATE CASCADE ON DELETE RESTRICT,
	id_sello INTEGER REFERENCES sellos_discograficos(id_sello) ON UPDATE CASCADE ON DELETE RESTRICT,
	id_genero INTEGER REFERENCES generos(id_genero) ON UPDATE CASCADE ON DELETE RESTRICT,
	id_categoria INTEGER REFERENCES categorias(id_categoria) ON UPDATE CASCADE ON DELETE RESTRICT,
	estado BOOLEAN,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE detalles_pedido (
	id_detalle SERIAL PRIMARY KEY,
	id_pedido INTEGER REFERENCES pedidos(id_pedido) ON UPDATE CASCADE ON DELETE RESTRICT,
	id_vinilo INTEGER REFERENCES vinilos(id_vinilo) ON UPDATE CASCADE ON DELETE RESTRICT,
	cantidad INTEGER,
	precio_unitario NUMERIC(10,2),
	subtotal NUMERIC(10,2)
);

CREATE TABLE envios (
	id_envio SERIAL PRIMARY KEY,
	id_pedido INTEGER REFERENCES pedidos(id_pedido) ON UPDATE CASCADE ON DELETE RESTRICT,
	direccion_envio TEXT,
	fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	estado_envio VARCHAR(50),
	empresa_envio VARCHAR(100),
	codigo_seguimiento VARCHAR(100),
	estado BOOLEAN 
);

CREATE TABLE reseñas_producto (
	id_resena SERIAL PRIMARY KEY,
	id_cliente INTEGER REFERENCES clientes(id_cliente) ON UPDATE CASCADE ON DELETE RESTRICT,
	id_vinilo INTEGER REFERENCES vinilos(id_vinilo) ON UPDATE CASCADE ON DELETE RESTRICT,
	calificacion INTEGER,
	comentario TEXT,
	fecha_resena TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	estado BOOLEAN 
);

CREATE TABLE carritos_compra (
	id_carrito SERIAL PRIMARY KEY,
	id_cliente INTEGER REFERENCES clientes(id_cliente) ON UPDATE CASCADE ON DELETE RESTRICT,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	estado BOOLEAN 
);


CREATE TABLE carritos_vinilos (
	id_carrito INTEGER,
	id_vinilo INTEGER,
	cantidad INTEGER,
	PRIMARY KEY(id_carrito, id_vinilo),
	FOREIGN KEY(id_carrito) REFERENCES carritos_compra(id_carrito) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(id_vinilo) REFERENCES vinilos(id_vinilo) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE listas_deseo (
	id_lista SERIAL PRIMARY KEY,
	id_cliente INTEGER REFERENCES clientes(id_cliente) ON UPDATE CASCADE ON DELETE RESTRICT,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	estado BOOLEAN 
);

CREATE TABLE listas_vinilos (
	id_lista INTEGER,
	id_vinilo INTEGER,
	PRIMARY KEY(id_lista, id_vinilo),
	FOREIGN KEY(id_lista) REFERENCES listas_deseo(id_lista) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(id_vinilo) REFERENCES vinilos(id_vinilo) ON UPDATE CASCADE ON DELETE RESTRICT
);
