from helpers import db, config


def install_db():
    cursor = db.cursor()

    for c_dir in config['db']['install_order']:
        for c_file in config['db']['install'][c_dir]:
            with open('sql/' + c_dir + '/' + c_file + '.sql') as part:
                cursor.execute(part.read())

    db.commit()
    cursor.close()
    db.close()

    print('Database successfully installed')

if __name__ == '__main__':
    install_db()
