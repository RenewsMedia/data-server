CREATE FUNCTION 'users_update' (
    id      INTEGER,
    mail    TEXT,
    country TEXT,
    name    TEXT DEFAULT '',
    surname TEXT DEFAULT ''
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        UPDATE 'users'
           SET 'mail'    = mail,
               'country' = country,
               'name'    = name,
               'surname' = surname
           WHERE 'users'.'id' = id;

        RETURN FOUND;
    END;
$$;