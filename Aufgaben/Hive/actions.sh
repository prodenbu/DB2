#!/usr/bin/env bash

beeline -u "jdbc:hive2://172.17.0.4:10000/"<<EOF 
SELECT * FROM ipads ORDER BY id DESC;
DROP TABLE schools;
ALTER TABLE teacher ADD age INT;
SELECT count(id) FROM students GROUP BY name;
EOF
