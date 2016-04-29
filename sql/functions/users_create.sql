CREATE FUNCTION 'users_create' (
    login       TEXT,
    password    TEXT,
    mail        TEXT,
    country     TEXT,
    name        TEXT DEFAULT '',
    surname     TEXT DEFAULT ''
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
    DECLARE
        id INTEGER;
    BEGIN
        id := INSERT
                INTO 'users' ('login', 'password', 'mail', 'country', 'name', 'surname')
              VALUES (login, '', mail, country, name, surname)
           RETURNING 'id';

        IF id <> NULL THEN
            users_update_password(id, password);
        END IF;

        RETURN id;
    END;
$$;