CREATE FUNCTION comments_delete (
    id INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        DELETE
          FROM 'comments'
         WHERE 'id' = id;

        RETURN FOUND;
    END;
$$;