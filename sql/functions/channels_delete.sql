CREATE FUNCTION 'f_main'.'channels_delete' (
    id INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        DELETE
          FROM 'channels'
         WHERE 'id' = id;

        RETURN FOUND;
    END;
$$;