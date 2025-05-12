CREATE OR REPLACE FUNCTION fn_auditoria_general()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_operacion TEXT;
    v_datos_anteriores JSONB;
    v_datos_nuevos JSONB;
BEGIN
    -- Determinar la operación realizada
    IF TG_OP = 'INSERT' THEN
        v_operacion := 'INSERT';
        v_datos_anteriores := NULL;
        v_datos_nuevos := to_jsonb(NEW);
    ELSIF TG_OP = 'UPDATE' THEN
        v_operacion := 'UPDATE';
        v_datos_anteriores := to_jsonb(OLD);
        v_datos_nuevos := to_jsonb(NEW);
    ELSIF TG_OP = 'DELETE' THEN
        v_operacion := 'DELETE';
        v_datos_anteriores := to_jsonb(OLD);
        v_datos_nuevos := NULL;
    ELSE
        RAISE NOTICE 'Operación no soportada para auditoría: %', TG_OP;
        RETURN NULL;
    END IF;

    -- Validar que la tabla auditoria_general existe antes de insertar
    IF EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_name = 'auditoria_general'
        AND table_schema = 'public'
    ) THEN
        -- Insertar el registro de auditoría
        INSERT INTO auditoria_general(
            tabla_afectada,
            operacion,
            usuario,
            datos_anteriores,
            datos_nuevos,
            fecha
        )
        VALUES (
            TG_TABLE_NAME,
            v_operacion,
            current_user,
            v_datos_anteriores,
            v_datos_nuevos,
            CURRENT_TIMESTAMP
        );
    ELSE
        RAISE WARNING 'La tabla de auditoría_general no existe. Auditoría no registrada.';
    END IF;

    RETURN NULL;
END;
$$;



CREATE TRIGGER trg_auditoria_artistas
AFTER INSERT OR UPDATE OR DELETE ON artistas
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_sellos_discograficos
AFTER INSERT OR UPDATE OR DELETE ON sellos_discograficos
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_generos
AFTER INSERT OR UPDATE OR DELETE ON generos
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_categorias
AFTER INSERT OR UPDATE OR DELETE ON categorias
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_clientes
AFTER INSERT OR UPDATE OR DELETE ON clientes
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_metodos_pago
AFTER INSERT OR UPDATE OR DELETE ON metodos_pago
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_pedidos
AFTER INSERT OR UPDATE OR DELETE ON pedidos
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_vinilos
AFTER INSERT OR UPDATE OR DELETE ON vinilos
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_detalles_pedido
AFTER INSERT OR UPDATE OR DELETE ON detalles_pedido
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_envios
AFTER INSERT OR UPDATE OR DELETE ON envios
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_resenas_producto
AFTER INSERT OR UPDATE OR DELETE ON reseñas_producto
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_carritos_compra
AFTER INSERT OR UPDATE OR DELETE ON carritos_compra
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_carritos_vinilos
AFTER INSERT OR UPDATE OR DELETE ON carritos_vinilos
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_listas_deseo
AFTER INSERT OR UPDATE OR DELETE ON listas_deseo
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


CREATE TRIGGER trg_auditoria_listas_vinilos
AFTER INSERT OR UPDATE OR DELETE ON listas_vinilos
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();
