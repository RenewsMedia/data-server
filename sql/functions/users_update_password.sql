CREATE FUNCTION 'f_main'.'users_update_password' (
    id          INTEGER,
    password    TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        UPDATE 'users'
           SET 'password' = md5(password)
         WHERE 'id' = id;

        RETURN FOUND;
    END;
$$;