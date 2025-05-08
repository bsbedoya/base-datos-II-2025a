INDEXACIONES

CREATE INDEX idx_fecha_clientes ON clientes USING brin (fecha_registro);

CREATE INDEX idx_estado_activo ON generos (estado) WHERE estado = 'true';   ----> Partial Indexes

CREATE INDEX idx_stock_ ON vinilos USING brin (stock);

CREATE INDEX idx_precio ON vinilos USING b-tree (precio);

CREATE INDEX idx_hash_username ON artistas USING hash (nom_artita);

