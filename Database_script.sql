-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Elainhoito911
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Elainhoito911` ;

-- -----------------------------------------------------
-- Schema Elainhoito911
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Elainhoito911` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Elainhoito911` ;

-- -----------------------------------------------------
-- Table `Elainhoito911`.`Yksikko`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Elainhoito911`.`Yksikko` ;

CREATE TABLE IF NOT EXISTS `Elainhoito911`.`Yksikko` (
  `idyksikko` SMALLINT NOT NULL AUTO_INCREMENT COMMENT '',
  `nimi` VARCHAR(20) NOT NULL COMMENT '',
  `osoite` VARCHAR(25) NOT NULL COMMENT '',
  `postitoimipaikka` VARCHAR(20) NOT NULL COMMENT '',
  `postinumero` SMALLINT NOT NULL COMMENT '',
  `paivystysnumero` VARCHAR(10) NOT NULL COMMENT '',
  `email` VARCHAR(25) NOT NULL COMMENT '',
  PRIMARY KEY (`idyksikko`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elainhoito911`.`Hoitaja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Elainhoito911`.`Hoitaja` ;

CREATE TABLE IF NOT EXISTS `Elainhoito911`.`Hoitaja` (
  `idhoitaja` SMALLINT NOT NULL AUTO_INCREMENT COMMENT '',
  `etunimi` VARCHAR(20) NOT NULL COMMENT '',
  `sukunimi` VARCHAR(20) NOT NULL COMMENT '',
  `puhelinnumero` VARCHAR(13) NOT NULL COMMENT '',
  `osoite` VARCHAR(20) NOT NULL COMMENT '',
  `Postinumero` INT NOT NULL COMMENT '',
  `Postitoimipaikka` VARCHAR(20) NOT NULL COMMENT '',
  `email` VARCHAR(25) NOT NULL COMMENT '',
  `Yksikko_idyksikko` SMALLINT NOT NULL COMMENT '',
  PRIMARY KEY (`idhoitaja`)  COMMENT '',
  INDEX `fk_Hoitaja_Yksikko1_idx` (`Yksikko_idyksikko` ASC)  COMMENT '',
  CONSTRAINT `fk_Hoitaja_Yksikko1`
    FOREIGN KEY (`Yksikko_idyksikko`)
    REFERENCES `Elainhoito911`.`Yksikko` (`idyksikko`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elainhoito911`.`Asiakas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Elainhoito911`.`Asiakas` ;

CREATE TABLE IF NOT EXISTS `Elainhoito911`.`Asiakas` (
  `idasiakas` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `etunimi` VARCHAR(20) NOT NULL COMMENT '',
  `sukunimi` VARCHAR(20) NOT NULL COMMENT '',
  `puhelinnumero` VARCHAR(14) NOT NULL COMMENT '',
  `osoite` VARCHAR(25) NOT NULL COMMENT '',
  `postitoimipaikka` VARCHAR(25) NOT NULL COMMENT '',
  `postinumero` SMALLINT NOT NULL COMMENT '',
  `email` VARCHAR(25) NULL COMMENT '',
  PRIMARY KEY (`idasiakas`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elainhoito911`.`Elain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Elainhoito911`.`Elain` ;

CREATE TABLE IF NOT EXISTS `Elainhoito911`.`Elain` (
  `idelain` SMALLINT NOT NULL AUTO_INCREMENT COMMENT '',
  `Asiakas_idasiakas` INT NOT NULL COMMENT '',
  `laji` VARCHAR(15) NOT NULL COMMENT '',
  `rotu` VARCHAR(20) NULL COMMENT '',
  `nimi` VARCHAR(20) NOT NULL COMMENT '',
  `ika` SMALLINT NOT NULL COMMENT '',
  INDEX `fk_Elain_Asiakas1_idx` (`Asiakas_idasiakas` ASC)  COMMENT '',
  PRIMARY KEY (`idelain`)  COMMENT '',
  CONSTRAINT `fk_Elain_Asiakas1`
    FOREIGN KEY (`Asiakas_idasiakas`)
    REFERENCES `Elainhoito911`.`Asiakas` (`idasiakas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elainhoito911`.`Omistaja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Elainhoito911`.`Omistaja` ;

CREATE TABLE IF NOT EXISTS `Elainhoito911`.`Omistaja` (
  `idomistaja` SMALLINT NOT NULL AUTO_INCREMENT COMMENT '',
  `etunimi` VARCHAR(20) NOT NULL COMMENT '',
  `sukunimi` VARCHAR(25) NOT NULL COMMENT '',
  `puhelinnumero` VARCHAR(14) NOT NULL COMMENT '',
  `osoite` VARCHAR(25) NOT NULL COMMENT '',
  `postitoimipaikka` VARCHAR(20) NOT NULL COMMENT '',
  `postinumero` SMALLINT NOT NULL COMMENT '',
  `email` VARCHAR(25) NULL COMMENT '',
  PRIMARY KEY (`idomistaja`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elainhoito911`.`Omistajuus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Elainhoito911`.`Omistajuus` ;

CREATE TABLE IF NOT EXISTS `Elainhoito911`.`Omistajuus` (
  `Elain_idelain` SMALLINT NOT NULL COMMENT '',
  `Omistaja_idomistaja` SMALLINT NOT NULL COMMENT '',
  INDEX `fk_Omistajuus_Elain1_idx` (`Elain_idelain` ASC)  COMMENT '',
  INDEX `fk_Omistajuus_Omistaja1_idx` (`Omistaja_idomistaja` ASC)  COMMENT '',
  PRIMARY KEY (`Elain_idelain`, `Omistaja_idomistaja`)  COMMENT '',
  CONSTRAINT `fk_Omistajuus_Elain1`
    FOREIGN KEY (`Elain_idelain`)
    REFERENCES `Elainhoito911`.`Elain` (`idelain`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Omistajuus_Omistaja1`
    FOREIGN KEY (`Omistaja_idomistaja`)
    REFERENCES `Elainhoito911`.`Omistaja` (`idomistaja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elainhoito911`.`Huonevaraus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Elainhoito911`.`Huonevaraus` ;

CREATE TABLE IF NOT EXISTS `Elainhoito911`.`Huonevaraus` (
  `hoitotunnus` SMALLINT NOT NULL COMMENT '',
  `pvmaika` DATETIME NOT NULL COMMENT '',
  `huonenumero` VARCHAR(6) NOT NULL COMMENT '',
  `Yksikko_idyksikko1` SMALLINT NOT NULL COMMENT '',
  `Elain_idelain` SMALLINT NOT NULL COMMENT '',
  INDEX `fk_Huonevaraus_Yksikko1_idx` (`Yksikko_idyksikko1` ASC)  COMMENT '',
  PRIMARY KEY (`hoitotunnus`)  COMMENT '',
  INDEX `fk_Huonevaraus_Elain1_idx` (`Elain_idelain` ASC)  COMMENT '',
  CONSTRAINT `fk_Huonevaraus_Yksikko1`
    FOREIGN KEY (`Yksikko_idyksikko1`)
    REFERENCES `Elainhoito911`.`Yksikko` (`idyksikko`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Huonevaraus_Elain1`
    FOREIGN KEY (`Elain_idelain`)
    REFERENCES `Elainhoito911`.`Elain` (`idelain`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Elainhoito911`.`Yksikko`
-- -----------------------------------------------------
START TRANSACTION;
USE `Elainhoito911`;
INSERT INTO `Elainhoito911`.`Yksikko` (`idyksikko`, `nimi`, `osoite`, `postitoimipaikka`, `postinumero`, `paivystysnumero`, `email`) VALUES (1, 'Manala', 'Tuomionvirta 666', 'Manalan portti', 66666, '666 666 666', '666@666.fi');
INSERT INTO `Elainhoito911`.`Yksikko` (`idyksikko`, `nimi`, `osoite`, `postitoimipaikka`, `postinumero`, `paivystysnumero`, `email`) VALUES (2, 'Päivänpaiste', 'Päiväkumpu 27', 'Porvoo', 00002, '200 1700211', 'paivapaiste@hotmail.com');
INSERT INTO `Elainhoito911`.`Yksikko` (`idyksikko`, `nimi`, `osoite`, `postitoimipaikka`, `postinumero`, `paivystysnumero`, `email`) VALUES (3, 'Aamusitruuna', 'Aamukatu 2', 'Turku', 40004, '044 2292877', 'sitruuna@hotmail.com');
INSERT INTO `Elainhoito911`.`Yksikko` (`idyksikko`, `nimi`, `osoite`, `postitoimipaikka`, `postinumero`, `paivystysnumero`, `email`) VALUES (4, 'Suklaakeksi', 'Fazerintie 4', 'Helsinki', 89898, '044 2221132', 'suklaakeksi@hotmail.com');
INSERT INTO `Elainhoito911`.`Yksikko` (`idyksikko`, `nimi`, `osoite`, `postitoimipaikka`, `postinumero`, `paivystysnumero`, `email`) VALUES (5, 'Sikala', 'Karjunkoski 2', 'Oulu', 72721, '044 0948782', 'sikala@hotmail.com');
INSERT INTO `Elainhoito911`.`Yksikko` (`idyksikko`, `nimi`, `osoite`, `postitoimipaikka`, `postinumero`, `paivystysnumero`, `email`) VALUES (6, 'Eläintaivas', 'Taivas 777', 'Taivaanportti ', 77777, '777 777 777', '777@777.fi');
INSERT INTO `Elainhoito911`.`Yksikko` (`idyksikko`, `nimi`, `osoite`, `postitoimipaikka`, `postinumero`, `paivystysnumero`, `email`) VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Elainhoito911`.`Hoitaja`
-- -----------------------------------------------------
START TRANSACTION;
USE `Elainhoito911`;
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (1, 'Charles', 'Roberts', '123 1231233', 'Mainarintie 4A 4', 12444, 'Helsinki', 'Charles@hotmail.com', 1);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (2, 'William', 'Blackwell', '123 5555666', 'Taalasmaankuja 7B 4', 88888, 'Helsinki', 'William@hotmail.com', 1);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (3, 'Heather', 'Hunter', '555 1147888', 'Seppolankatu 7A 5', 88886, 'Helsinki', 'Heather@hotmail.com', 2);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (4, 'Thomas', 'Jones', '446 3557843', 'Taavetinkäännös 7A 88', 45453, 'Turku', 'Thomas@hotmail.com', 2);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (5, 'Audrey', 'Blake', '356 6688432', 'Eskatu 9F 52', 35444, 'Turku', 'Audrey@hotmail.com', 3);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (6, 'Cedric', 'Phillips', '244 7788234', 'Eskatu 6A 777', 45467, 'Joensuu', 'Cedric@hotmail.com', 3);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (7, 'Julie', 'Jackson', '213 5557893', 'Möhkötie 22A 666', 45322, 'Ivalo', 'Julie@hotmail.com', 3);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (8, 'Rosemary', 'Peters', '455 7889966', 'Wannadie 22A 211', 57775, 'Utsjoki', 'Rosemary@hotmail.com', 4);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (9, 'Dexter ', 'Reed', '444 5567788', 'Alkontie 59H 42', 57775, 'Mummola', 'Dexter @hotmail.com', 5);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (10, 'Annabel', 'Morgan', '442 2222444', 'Ninjakatu 4B 22', 54457, 'Jyväskylä', 'Annabel@hotmail.com', 6);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (11, 'William', 'Blake', '423 4455325', 'Kirjastokuja 9B 22', 45646, 'Pori', 'William@hotmail.com', 6);
INSERT INTO `Elainhoito911`.`Hoitaja` (`idhoitaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `Postinumero`, `Postitoimipaikka`, `email`, `Yksikko_idyksikko`) VALUES (12, 'Rosemary', 'Lee', '556 6777777', 'Pöllötie 64F 5896', 46467, 'Oulu', 'Rosemary@hotmail.com', 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Elainhoito911`.`Asiakas`
-- -----------------------------------------------------
START TRANSACTION;
USE `Elainhoito911`;
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (1, 'Seppo', 'Taalasmaa', '044 32411234', 'Pihlajankatu 4B 34', 'Helsinki', 01235, NULL);
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (2, 'Ismo', 'Laitela', '044 1231231', 'Pihlajankatu 4B 42', 'Helsinki', 01235, 'laitela.@hotmail.com');
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (3, 'Nakki', 'Makkara', '044 2313132', 'Makkarakeitto 2A 1', 'Jyväskylä', 01255, NULL);
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (4, 'Pekka', 'Virtanen', '044 1231233', 'Keittokuja 23C 244', 'Turku', 23333, NULL);
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (5, 'Naruto', 'Uzumaki', '404 4206969', 'Nipponintie 5A 22', 'Oulu', 46666, NULL);
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (6, 'Leela', 'Captitan', '012 3010301', 'Spacemanstie 999A 99', 'Ivalo', 22222, 'äliiälaa@gmail.com');
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (7, 'Häkkeri', 'Jäbämies', '420 4204200', 'Koskitie 3A 40', 'Kuusamo', 42000, 'blazeit@hitman.com');
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (8, 'Elisabeth ', 'Hancock', '404 1236006', 'Kuusitie 2A 50', 'Pori', 11111, NULL);
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (9, 'Aspen', 'Blackwell', '000 0001122', 'Roomantie 0A 00', 'Kajaani', 22223, NULL);
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (10, 'James', 'Peters', '123 1232266', 'Engelsmannintie 10A 15', 'Joensuu', 44002, NULL);
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (11, 'Annabell', 'Wright', '999 1237000', 'Hissikuja 420A 62', 'Turku', 23333, NULL);
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (12, 'Terry', 'Adams', '222 5000547', 'Aslakinkuja 5B 71', 'Espoo', 79998, NULL);
INSERT INTO `Elainhoito911`.`Asiakas` (`idasiakas`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Elainhoito911`.`Elain`
-- -----------------------------------------------------
START TRANSACTION;
USE `Elainhoito911`;
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (1, 1, 'Koira', 'Chihahauva', 'Simo', 7);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (2, 1, 'Koira', 'Pitbull', 'Doge', 7);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (3, 1, 'Koira', 'Snautseri', 'Tuo', 7);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (4, 2, 'Kissa', 'Lynx Lynx', 'Katten', 12);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (5, 3, 'Kultakala', 'Onkala', 'Fisu', 1);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (6, 4, 'Virtahepo', 'Hippopotamidae', 'Big Mama', 2);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (7, 5, 'Möhköfantti', 'Mököfanttuminae', 'Fantti', 22);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (8, 6, 'Leijona', NULL, 'Alex', 13);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (9, 7, 'Sinivalas', NULL, 'Kalajäbä', 100);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (10, 8, 'Karhukas', 'Tardigrada', 'Mr. Indestructable', 4);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (11, 9, 'Simpanssin', 'President', 'Trump', 5);
INSERT INTO `Elainhoito911`.`Elain` (`idelain`, `Asiakas_idasiakas`, `laji`, `rotu`, `nimi`, `ika`) VALUES (12, 12, 'Kärpänen', 'Drosophilia', 'Käpä', 999);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Elainhoito911`.`Omistaja`
-- -----------------------------------------------------
START TRANSACTION;
USE `Elainhoito911`;
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (1, 'Ismo', 'Laitela', '044 1231231', 'Pihlajankatu 4B 34', 'Helsinki', 01235, NULL);
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (2, 'Seppo', 'Taalasmaa', '044 32411234', 'Pihlajankatu 4B 42', 'Helsinki', 01235, 'laitela.@hotmail.com');
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (3, 'Häkkeri', 'Jäbämies', '420 4204200', 'Koskitie 3A 40', 'Kuusamo', 42000, 'blazeit@hitman.com');
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (4, 'Annabell', 'Wright', '999 1237000', 'Hissikuja 420A 62', 'Turku', 23333, NULL);
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (5, 'Pekka', 'Virtanen', '044 1231233', 'Keittokuja 23C 244', 'Turku', 23333, NULL);
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (6, 'Charless', 'Philips', '044 0099002', 'Mainstreet 21C 2', 'Jyväskylä', 10029, NULL);
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (7, 'Holly', 'Hunter', '044 1239999', 'Boulevardstreet 9F 82', 'Utsjoki', 66332, NULL);
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (8, 'Faith', 'Walker', '044 2002211', 'Bakerstreet 22B 12', 'Ivalo', 23123, NULL);
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (9, 'Jeremy', 'Smith', '055 9999999', 'Asdstreet 21A 23', 'Joensuu', 44677, NULL);
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (10, 'Aspen', 'Alexander', '993 0404040', 'Asdkatu 23A 37', 'Kajaani', 34412, NULL);
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (11, 'Ashton', 'Wright', '123 3012229', 'Kekkosenkatu 1A 1', 'Joensuu', 34214, NULL);
INSERT INTO `Elainhoito911`.`Omistaja` (`idomistaja`, `etunimi`, `sukunimi`, `puhelinnumero`, `osoite`, `postitoimipaikka`, `postinumero`, `email`) VALUES (12, 'Shirley', 'Harley', '555 0009991', 'Kakkosenkatu 1B 2', 'Pori', 35135, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Elainhoito911`.`Omistajuus`
-- -----------------------------------------------------
START TRANSACTION;
USE `Elainhoito911`;
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (1, 2);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (2, 2);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (3, 2);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (4, 1);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (5, 3);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (6, 4);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (7, 5);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (8, 6);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (9, 8);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (10, 9);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (11, 10);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (12, 7);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (8, 11);
INSERT INTO `Elainhoito911`.`Omistajuus` (`Elain_idelain`, `Omistaja_idomistaja`) VALUES (11, 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Elainhoito911`.`Huonevaraus`
-- -----------------------------------------------------
START TRANSACTION;
USE `Elainhoito911`;
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (1, '2017-05-10 18:00:00', '3', 1, 1);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (2, '2017-05-21 12:30:00', '4', 1, 4);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (3, '2017-05-22 21:00:00', '1', 2, 4);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (4, '2017-06-21 20:00:00', '5', 3, 5);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (5, '2017-06-21 11:00:00', '2', 4, 6);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (6, '2017-07-01 10:00:00', '2', 1, 7);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (7, '2017-07-02 09:00:00', '3', 5, 8);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (8, '2017-09-29 01:00:00', '5', 5, 9);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (9, '2017-05-31 13:00:00', '7', 6, 10);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (10, '2017-12-12 15:00:00', '7', 6, 11);
INSERT INTO `Elainhoito911`.`Huonevaraus` (`hoitotunnus`, `pvmaika`, `huonenumero`, `Yksikko_idyksikko1`, `Elain_idelain`) VALUES (11, '2017-12-12 14:00:00', '8', 3, 12);

COMMIT;

