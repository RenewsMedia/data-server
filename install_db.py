from helpers import db, config


def install_db():
    for c_dir in config['db']['install_order']:
        for c_file in config['db']['install'][c_dir]:
            with open('sql/' + c_dir + '/' + c_file + '.sql') as part:
                db.execute(part.read())

    db.close()
    print('Database successfully installed')

if __name__ == '__main__':
    install_db()
