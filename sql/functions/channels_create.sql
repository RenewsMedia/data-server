CREATE FUNCTION 'channels_create' (
    owner       INTEGER,
    name        TEXT,
    description TEXT DEFAULT ''
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        RETURN (
            INSERT
              INTO 'channels' ('owner', 'name', 'description')
            VALUES (owner, name, description)
         RETURNING 'id'
        );
    END;
$$;