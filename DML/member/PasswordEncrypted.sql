-- password 암호화 SHA256 방식.

delimiter //

CREATE OR REPLACE PROCEDURE PasswordEncrypted(
    IN password varchar(255),
    OUT encryptedPassword VARCHAR(255)
)
BEGIN

SELECT SHA2(password , 256) INTO encryptedPassword;

END //

delimiter ; 


