#!/usr/bin/env bash

if [ ! -e .env ]; then
        python3 -m venv .env
        . .env/bin/activate
        pip3 install mysql-connector-python
        sudo mysql << EOF
        CREATE USER IF NOT EXISTS 'user' IDENTIFIED BY 'password';
        GRANT ALL PRIVILEGES ON DB2.* to 'user';
        FLUSH PRIVILEGES;
EOF
else
        . .env/bin/activate
fi
python3 sql.py
