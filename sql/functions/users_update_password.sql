CREATE FUNCTION 'users_update_password' (
    id          INTEGER,
    password    TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        UPDATE 'users'
           SET 'password' = md5(password)
           WHERE 'users'.'id' = id;

        RETURN FOUND;
    END;
$$;