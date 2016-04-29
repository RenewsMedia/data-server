CREATE FUNCTION 'channels_delete' (
    id INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        DELETE
          FROM 'channels'
         WHERE 'channels'.'id' = id;

        RETURN FOUND;
    END;
$$;