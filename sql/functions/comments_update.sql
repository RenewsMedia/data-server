CREATE FUNCTION 'comments_update' (
    id          INTEGER,
    text_data   TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    DECLARE
        result BOOLEAN DEFAULT FALSE;
        data_id INTEGER;
    BEGIN
        data_id := (SELECT 'data' FROM 'comments' WHERE 'comments'.'id' = id);

        IF data_id <> NULL THEN
            result := text_data_update(data_id, text_data);
        END IF;

        RETURN result;
    END;
$$;