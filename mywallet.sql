CREATE SCHEMA IF NOT EXISTS `Alke_Wallet` DEFAULT CHARACTER SET utf8mb4;
USE Alke_Wallet;


CREATE TABLE usuario(
user_id INT primary key auto_increment,
nombre VARCHAR(50) NOT NULL,
correo_electronico VARCHAR(100) NOT NULL UNIQUE,
contrasegna VARCHAR(8) NOT NULL,
saldo DECIMAL(10,2) NOT NULL,
fecha_creacion TIMESTAMP
);

CREATE TABLE transaccion(
transaction_id INT primary key auto_increment,
sender_user_id INT,
receiver_user_id INT,
moneda_id INT,
importe DECIMAL(10,2) NOT NULL,
CONSTRAINT sender_user FOREIGN KEY(sender_user_id) REFERENCES usuario(user_id) ON DELETE SET NULL,
CONSTRAINT receiver_user FOREIGN KEY (receiver_user_id) REFERENCES usuario(user_id) ON DELETE SET NULL,
CONSTRAINT moneda FOREIGN KEY (moneda_id) REFERENCES moneda(currency_id) ON DELETE SET NULL,
transaction_date TIMESTAMP
);

CREATE TABLE moneda(
currency_id INT primary key auto_increment,
currency_name VARCHAR(50) NOT NULL UNIQUE,
currency_symbol CHAR(3),
creationDate timestamp
);

INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('Rublo', '₽', CURRENT_TIMESTAMP);

INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('CLP', '$', CURRENT_TIMESTAMP);

INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('real', 'R$', CURRENT_TIMESTAMP);

INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('USD', '$', CURRENT_TIMESTAMP);

INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('sol', 'S/', CURRENT_TIMESTAMP);

SELECT * FROM moneda;

INSERT INTO usuario (nombre, correo_electronico,contrasegna,saldo,fecha_creacion) 
VALUES ('Claudia','claudia@hotmail.com','18318', 10000000, CURRENT_TIMESTAMP);

INSERT INTO usuario (nombre, correo_electronico,contrasegna,saldo,fecha_creacion) 
VALUES ('vanessa','vcastro461@hotmail.com','1234', 20000, CURRENT_TIMESTAMP);

INSERT INTO usuario (nombre, correo_electronico,contrasegna,saldo,fecha_creacion) 
VALUES ('paul','paulkastro@hotmail.com','4321', 15000, CURRENT_TIMESTAMP);

SELECT * FROM usuario;


INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date) 
VALUES (1,3,5,500.000,CURRENT_TIMESTAMP);

INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date) 
VALUES (2,3,4,700.000,CURRENT_TIMESTAMP);

INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date) 
VALUES (3,2,2,600.000,CURRENT_TIMESTAMP);

INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date) 
VALUES (1,2,3,400.000,CURRENT_TIMESTAMP);

INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date) 
VALUES (2,2,5,600.000,CURRENT_TIMESTAMP);

SELECT * FROM transaccion;

-- Consulta para obtener el nombre de la moneda elegida por un usuario específico
SELECT nombre,currency_name FROM usuario
INNER JOIN transaccion ON transaccion.sender_user_id = usuario.user_id
INNER JOIN moneda ON moneda.currency_id =  transaccion.moneda_id 
WHERE user_id = 1;

-- Consulta para obtener todas las transacciones registradas
SELECT transaction_id, sender.nombre AS sender_user, receiver.nombre AS receiver_user,currency_symbol, importe, transaction_date
FROM transaccion
INNER JOIN usuario AS sender ON sender.user_id = transaccion.sender_user_id
INNER JOIN usuario AS receiver ON receiver.user_id = transaccion.receiver_user_id
INNER JOIN moneda ON currency_id = moneda.currency_id
ORDER BY transaction_id ASC;

SELECT * FROM usuario;
-- Sentencia DML para modificar el campo correo electrónico de un usuario específico
UPDATE usuario SET correo_electronico = 'josefa123@hotmail.com'
WHERE user_id = 1;

SELECT * FROM transaccion;
-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)
DELETE FROM transaccion
WHERE transaction_id = 2;

