CREATE FUNCTION 'text_data_create' (
    data TEXT
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        RETURN (
            INSERT
              INTO 'text_data' ('data')
            VALUES (data)
         RETURNING 'id'
        );
    END;
$$;