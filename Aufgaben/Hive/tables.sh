#!/usr/bin/env bash

beeline -u "jdbc:hive2://172.17.0.4:10000/"<<EOF 
CREATE TABLE students (id INT, name STRING, age INT, iPadID INT); 
INSERT INTO students VALUES (1, "Peter", 12, NULL),(2, "Jens", 12, NULL),(3, "Sabine", 12, "xbc"),(4, "Patrick", 12, NULL);
CREATE TABLE iPads (id INT, SerielNumber STRING, PurchaseYear INT); 
INSERT INTO iPads VALUES (1, "xbc", 2022), (2, "acc", 2022), (3, "sda", 2023);
CREATE TABLE teacher (id INT, name STRING, subject STRING); 
INSERT INTO teacher VALUES (1, "Herr Carstens", "English"), (2, "Frau Müller", "Math"), (3, "Frau Meier", "Deutsch");
CREATE TABLE schools (id INT, name STRING, type STRING ); 
INSERT INTO schools VALUES (1, "Paula Modersohn Schule", "Gesamtschule"), (2, "Max Eyth Schule", "Berufliches Gymnasium"), (3, "Altwulsdorfer Schule", "Grundschule");
EOF
