-- password 암호화 SHA256 방식.

delimiter //

CREATE PROCEDURE PasswordEncrypted(
    IN password varchar(255),
    OUT encryptedPassword VARCHAR(255)
)
BEGIN

SELECT SHA2('asd' , 256) INTO encryptedPassword;

END //

delimiter ; 


