USE <database name>;
SHOW TABLES;
SHOW VARIABLES LIKE "secure_file_priv";

SELECT *
INTO OUTFILE '<secure_file_priv path>'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
FROM <table name>;
