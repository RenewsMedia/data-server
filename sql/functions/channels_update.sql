CREATE FUNCTION 'f_main'.'channels_update' (
    id          INTEGER,
    name        TEXT,
    description TEXT DEFAULT ''
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        UPDATE 'channels'
           SET 'name'           = name,
               'description'    = description
         WHERE 'id' = id;

        RETURN FOUND;
    END;
$$;