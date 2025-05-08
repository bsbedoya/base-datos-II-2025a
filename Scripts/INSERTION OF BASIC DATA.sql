INSERCION DE DATOS

INSERT INTO artistas (nom_artita, pais_origen, estado) VALUES
('The Beatles', 'Reino Unido', true),
('Pink Floyd', 'Reino Unido', true),
('Queen', 'Reino Unido', false),
('Bob Dylan', 'Estados Unidos', true),
('Carlos Vives', 'Colombia', false);


INSERT INTO sellos_discograficos (nom_sello, pais, estado) VALUES
('EMI Records', 'Reino Unido', false),
('Sony Music', 'Estados Unidos', false),
('Universal Music', 'Estados Unidos', true),
('Warner Music', 'Estados Unidos', true),
('Codiscos', 'Colombia', true);

INSERT INTO generos (nom_genero, descripcion, estado) VALUES
('Rock', 'Género musical originado en los años 50.', true),
('Pop', 'Música popular con gran difusión.', true),
('Folk', 'Música tradicional de raíz popular.', false),
('Salsa', 'Género tropical de origen caribeño.', false),
('Reggae', 'Género jamaicano con influencia afrocaribeña.', true);


INSERT INTO categorias (nom_categoria, descripcion, estado) VALUES
('Edición limitada', 'Vinilos de tiraje limitado.', true),
('Clásicos', 'Vinilos de artistas o álbumes clásicos.', true),
('Nuevos lanzamientos', 'Vinilos recién lanzados.', true),
('Coleccionables', 'Vinilos para coleccionistas.', true),
('Reediciones', 'Reediciones de álbumes antiguos.', false);

INSERT INTO clientes (nom_cliente, apellido, email, contrasena, telefono, direccion, estado) VALUES
('Juan', 'Pérez', 'juanperez@mail.com', '123456', '3001234567', 'Calle 123, Bogotá', false),
('Ana', 'García', 'anag@mail.com', 'abcdef', '3101234567', 'Carrera 10, Medellín', false),
('Luis', 'Martínez', 'lmartinez@mail.com', 'qwerty', '3201234567', 'Av. Siempre Viva, Cali', false),
('María', 'López', 'mlopez@mail.com', 'pass1234', '3009876543', 'Diagonal 45, Barranquilla', true),
('Carlos', 'Ríos', 'carlosr@mail.com', 'carlos2024', '3151234567', 'Transversal 67, Cartagena', true);

INSERT INTO metodos_pago (nom_metodo, descripcion, estado) VALUES
('Tarjeta de crédito', 'Visa, MasterCard, American Express', true),
('Transferencia bancaria', 'Transferencia directa desde el banco', true),
('Pago contra entrega', 'Pagar al recibir el pedido', true),
('PayPal', 'Pago seguro con PayPal', true),
('Cripto', 'Pago con criptomonedas', false);

INSERT INTO pedidos (id_cliente, total, estado_pedido, estado, id_metodo) VALUES
(1, 120000.00, 'pendiente', true, 1),
(2, 95000.50, 'enviado', true, 2),
(3, 56000.00, 'entregado', true, 3),
(4, 25000.00, 'cancelado', false, 4),
(5, 78000.00, 'pendiente', true, 1);


INSERT INTO vinilos (nom_vinilo, descripcion, precio, stock, id_artista, id_sello, id_genero, id_categoria, estado) VALUES
('Abbey Road', 'Álbum icónico de The Beatles', 120000.00, 10, 1, 1, 1, 2, true),
('The Dark Side of the Moon', 'Álbum legendario de Pink Floyd', 95000.00, 5, 2, 2, 1, 2, true),
('A Night at the Opera', 'Incluye Bohemian Rhapsody', 85000.00, 8, 3, 2, 2, 3, true),
('Blonde on Blonde', 'Doble LP de Bob Dylan', 78000.00, 7, 4, 3, 3, 2, false),
('Clásicos Vives', 'Grandes éxitos de Carlos Vives', 65000.00, 15, 5, 5, 4, 1, true);


INSERT INTO detalles_pedido (id_pedido, id_vinilo, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 120000.00, 120000.00),
(2, 2, 1, 95000.50, 95000.50),
(3, 5, 2, 28000.00, 56000.00),
(4, 3, 1, 25000.00, 25000.00),
(5, 4, 1, 78000.00, 78000.00);

INSERT INTO envios (id_pedido, direccion_envio, estado_envio, empresa_envio, codigo_seguimiento, estado) VALUES
(1, 'Calle 123, Bogotá', 'pendiente', 'Servientrega', 'AB123456', true),
(2, 'Carrera 10, Medellín', 'en camino', 'Interrapidísimo', 'CD987654', true),
(3, 'Av. Siempre Viva, Cali', 'entregado', 'Coordinadora', 'EF567890', true),
(4, 'Diagonal 45, Barranquilla', 'cancelado', 'Envía', 'GH135790', false),
(5, 'Transversal 67, Cartagena', 'pendiente', 'Servientrega', 'IJ246802', true);

INSERT INTO reseñas_producto (id_cliente, id_vinilo, calificacion, comentario, estado) VALUES
(1, 1, 5, 'Excelente sonido y presentación.', true),
(2, 2, 4, 'Muy buen vinilo, aunque llegó un poco tarde.', true),
(3, 5, 5, 'Me encantó. Recomendado', true),
(4, 3, 3, 'Esperaba más calidad.', false),
(5, 4, 4, 'Muy bueno, aunque un poco caro.', true);

INSERT INTO carritos_compra (id_cliente, estado) VALUES
(1, true),
(2, true),
(3, true),
(4, false),
(5, true);

INSERT INTO carritos_vinilos (id_carrito, id_vinilo, cantidad) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(5, 4, 1), 
(5, 5, 2);

INSERT INTO listas_deseo (id_cliente, estado) VALUES
(1, true),
(2, true),
(3, true), 
(4, true),
(5, true);

INSERT INTO listas_vinilos (id_lista, id_vinilo) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 5),
(4, 4);





