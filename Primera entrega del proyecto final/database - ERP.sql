-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`sellers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sellers` (
  `idSeller` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idSeller`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `idSeller` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `phone` DECIMAL(10,0) NOT NULL,
  `mail` VARCHAR(50) NOT NULL,
  `adress` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCustomer`),
  INDEX `idSeller_idx` (`idSeller` ASC) VISIBLE,
  CONSTRAINT `idSeller`
    FOREIGN KEY (`idSeller`)
    REFERENCES `mydb`.`sellers` (`idSeller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `salePrice` DECIMAL(9,2) NOT NULL,
  `purchasePrice` DECIMAL(9,2) NOT NULL,
  `stock` DECIMAL(9,2) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `mydb`.`providers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`providers` (
  `idProvider` INT NOT NULL AUTO_INCREMENT,
  `idProduct` INT NOT NULL,
  PRIMARY KEY (`idProvider`),
  INDEX `idProduct_idx` (`idProduct` ASC) VISIBLE,
  CONSTRAINT `idProduct`
    FOREIGN KEY (`idProduct`)
    REFERENCES `mydb`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `idCustomer` INT NOT NULL,
  `idSeller` INT NOT NULL,
  `idProduct` INT NOT NULL,
  `date` DATE NOT NULL,
  `pieces` DECIMAL(9,2) NOT NULL,
  `unitaryPrice` DECIMAL(9,2) NOT NULL,
  `productTotal` DECIMAL(9,2) NOT NULL,
  `total` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`idOrder`),
  INDEX `idCustomer_idx` (`idCustomer` ASC) VISIBLE,
  INDEX `idSeller_idx` (`idSeller` ASC) VISIBLE,
  INDEX `idProduct_idx` (`idProduct` ASC) VISIBLE,
  CONSTRAINT `idCustomer`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `mydb`.`customers` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idSeller`
    FOREIGN KEY (`idSeller`)
    REFERENCES `mydb`.`sellers` (`idSeller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProduct`
    FOREIGN KEY (`idProduct`)
    REFERENCES `mydb`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`purchases` (
  `idPurchase` INT NOT NULL AUTO_INCREMENT,
  `idProvider` INT NOT NULL,
  `idProduct` INT NOT NULL,
  `date` DATE NOT NULL,
  `pieces` DECIMAL(9,2) NOT NULL,
  `unitaryPrice` DECIMAL(9,2) NOT NULL,
  `productTotal` DECIMAL(9,2) NOT NULL,
  `total` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`idPurchase`),
  INDEX `idProvider_idx` (`idProvider` ASC) VISIBLE,
  INDEX `idProduct_idx` (`idProduct` ASC) VISIBLE,
  CONSTRAINT `idProvider`
    FOREIGN KEY (`idProvider`)
    REFERENCES `mydb`.`providers` (`idProvider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProduct`
    FOREIGN KEY (`idProduct`)
    REFERENCES `mydb`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
