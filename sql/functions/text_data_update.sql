CREATE FUNCTION 'text_data_update' (
    id      INTEGER,
    data    TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        UPDATE 'text_data'
           SET 'data' = data
         WHERE 'text_data'.'id' = id;

        RETURN FOUND;
    END;
$$;