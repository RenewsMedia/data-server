CREATE FUNCTION 'f_main'.'channel_roles_delegate' (
    role    TEXT,
    channel INTEGER,
    user_id INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        UPDATE 'channel_roles'
           SET 'role' = role
         WHERE 'channel'    = channel,
               'user'       = user_id;

        IF FOUND <> TRUE THEN
            INSERT
              INTO 'channel_roles' ('role', 'channel', 'user')
            VALUES (role, channel, user_id);
        END IF;

        RETURN FOUND;
    END;
$$;