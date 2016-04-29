CREATE FUNCTION comments_create (
    author      INTEGER,
    text_data   TEXT
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
    DECLARE
        data_id INTEGER;
    BEGIN
        data_id := text_data_create(text_data);
        RETURN (INSERT INTO 'comments' ('author', 'data') VALUES (author, data_id) RETURNING 'id');
    END;
$$;