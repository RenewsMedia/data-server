CREATE FUNCTION 'channels_create' (
    id          INTEGER,
    name        TEXT,
    description TEXT DEFAULT ''
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        UPDATE 'channels'
           SET 'name'           = name,
               'description'    = description
         WHERE 'channels'.'id' = id;

        RETURN FOUND;
    END;
$$;