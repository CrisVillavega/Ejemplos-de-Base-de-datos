-- MySQL Script generated by MySQL Workbench
-- Sun Nov 21 19:43:21 2021
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`Solicitante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Solicitante` (
  `Ced_Juridica` INT NOT NULL,
  `Nombre_Org` VARCHAR(50) NOT NULL,
  `Pagina Web` VARCHAR(100) NOT NULL,
  `Localidad_Org` VARCHAR(40) NOT NULL,
  `Pais_Org` VARCHAR(20) NOT NULL,
  `Fecha_ina` YEAR(4) NOT NULL,
  `Fax` INT NOT NULL,
  `Telefono_Org` INT NOT NULL,
  `Correo_Org` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Ced_Juridica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ActividadesOrg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ActividadesOrg` (
  `Ced_Juridica` INT NOT NULL,
  `AH_Org` LONGTEXT NULL,
  PRIMARY KEY (`Ced_Juridica`),
  CONSTRAINT `F.S-A`
    FOREIGN KEY (`Ced_Juridica`)
    REFERENCES `mydb`.`Solicitante` (`Ced_Juridica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Garantias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Garantias` (
  `Ced_Juridica` INT NOT NULL,
  `Garantias` LONGTEXT NOT NULL,
  PRIMARY KEY (`Ced_Juridica`),
  CONSTRAINT `F.S-G`
    FOREIGN KEY (`Ced_Juridica`)
    REFERENCES `mydb`.`Solicitante` (`Ced_Juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Desc_Solicitante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Desc_Solicitante` (
  `Ced_Juridica` INT NOT NULL,
  `Estructura` LONGTEXT NOT NULL,
  `Amb.Act.` LONGTEXT NOT NULL,
  `Financiacion` LONGTEXT NOT NULL,
  `Incoado` ENUM("Si", "No") NOT NULL,
  `Proy_Similar` ENUM("Si", "No") NOT NULL,
  `Colaborado` ENUM("Si", "No") NOT NULL,
  PRIMARY KEY (`Ced_Juridica`),
  CONSTRAINT `F.S-D`
    FOREIGN KEY (`Ced_Juridica`)
    REFERENCES `mydb`.`Solicitante` (`Ced_Juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Representante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Representante` (
  `Ced_Juridica` INT NOT NULL,
  `Id_Rep` INT NOT NULL,
  `Nombre_Rep` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_Rep`),
  CONSTRAINT `F.S-R`
    FOREIGN KEY (`Ced_Juridica`)
    REFERENCES `mydb`.`Solicitante` (`Ced_Juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rep-Desc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rep-Desc` (
  `Id_Rep` INT NOT NULL,
  `Cualidades_Rep` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`Id_Rep`),
  CONSTRAINT `F.R.R`
    FOREIGN KEY (`Id_Rep`)
    REFERENCES `mydb`.`Representante` (`Id_Rep`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Datos_Bancarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Datos_Bancarios` (
  `Ced_Juridica` INT NOT NULL,
  `Cuenta` INT NOT NULL,
  PRIMARY KEY (`Cuenta`),
  CONSTRAINT `F.S-DB`
    FOREIGN KEY (`Ced_Juridica`)
    REFERENCES `mydb`.`Solicitante` (`Ced_Juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entidad` (
  `Cuenta` INT NOT NULL,
  `Entidad` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Cuenta`),
  CONSTRAINT `F.DB-E`
    FOREIGN KEY (`Cuenta`)
    REFERENCES `mydb`.`Datos_Bancarios` (`Cuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Socio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Socio` (
  `Ced_juridica` INT NOT NULL,
  `Nombre_Org` VARCHAR(50) NULL,
  `Pagina web` VARCHAR(100) NULL,
  `Localidad_Org` VARCHAR(40) NULL,
  `Pais_Org` VARCHAR(20) NULL,
  `Fecha_Ina` YEAR(4) NULL,
  `Socio` INT NOT NULL,
  PRIMARY KEY (`Ced_juridica`, `Socio`),
  INDEX `F.S-SC_idx` (`Socio` ASC) VISIBLE,
  UNIQUE INDEX `Ced_juridica_UNIQUE` (`Ced_juridica` ASC) VISIBLE,
  CONSTRAINT `F.S-SC`
    FOREIGN KEY (`Socio`)
    REFERENCES `mydb`.`Solicitante` (`Ced_Juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ActividadesOrgS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ActividadesOrgS` (
  `Ced_Juridica` INT NOT NULL,
  `AH_Org` LONGTEXT NULL,
  PRIMARY KEY (`Ced_Juridica`),
  CONSTRAINT `F.S-A0`
    FOREIGN KEY (`Ced_Juridica`)
    REFERENCES `mydb`.`Socio` (`Ced_juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Desc_Socio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Desc_Socio` (
  `Ced_Juridica` INT NOT NULL,
  `Estructura` LONGTEXT NULL,
  `Amb.Act.` LONGTEXT NULL,
  `Financiacion` LONGTEXT NULL,
  PRIMARY KEY (`Ced_Juridica`),
  CONSTRAINT `F.S-D0`
    FOREIGN KEY (`Ced_Juridica`)
    REFERENCES `mydb`.`Socio` (`Ced_juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Interlocutor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Interlocutor` (
  `Id_Int` INT NOT NULL,
  `Nombre_Int` VARCHAR(20) NOT NULL,
  `Apellido_Int` VARCHAR(40) NOT NULL,
  `Funcion` VARCHAR(100) NOT NULL,
  `Telefono_Int` INT NOT NULL,
  `Correo_Int` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id_Int`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proyecto` (
  `Cod_Proy` INT NOT NULL,
  `Nombre_Proy` VARCHAR(20) NOT NULL,
  `MontoS` FLOAT NOT NULL,
  `MontoD` FLOAT NULL,
  `Inicio` DATE NOT NULL,
  `Fin` DATE NOT NULL,
  `Pais_Proy` VARCHAR(20) NOT NULL,
  `Localidad_Proy` VARCHAR(100) NOT NULL,
  `Solicitante` INT NOT NULL,
  `Ejecutor` INT NULL,
  PRIMARY KEY (`Cod_Proy`, `Solicitante`),
  INDEX `F.S-P_idx` (`Solicitante` ASC) VISIBLE,
  INDEX `F.SC-P_idx` (`Ejecutor` ASC) VISIBLE,
  CONSTRAINT `F.S-P`
    FOREIGN KEY (`Solicitante`)
    REFERENCES `mydb`.`Solicitante` (`Ced_Juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `F.SC-P`
    FOREIGN KEY (`Ejecutor`)
    REFERENCES `mydb`.`Socio` (`Ced_juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Union`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Union` (
  `Id_Int` INT NOT NULL,
  `Ced_Juridica` INT NOT NULL,
  `Cod_Proy` INT NOT NULL,
  PRIMARY KEY (`Id_Int`, `Ced_Juridica`, `Cod_Proy`),
  INDEX `F.S-U_idx` (`Ced_Juridica` ASC) VISIBLE,
  INDEX `F.P-U_idx` (`Cod_Proy` ASC) VISIBLE,
  CONSTRAINT `F.I-U`
    FOREIGN KEY (`Id_Int`)
    REFERENCES `mydb`.`Interlocutor` (`Id_Int`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `F.S-U`
    FOREIGN KEY (`Ced_Juridica`)
    REFERENCES `mydb`.`Solicitante` (`Ced_Juridica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `F.P-U`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Desc_Int`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Desc_Int` (
  `Id_Int` INT NOT NULL,
  `Cualidades_Int` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`Id_Int`),
  CONSTRAINT `F.I-DI`
    FOREIGN KEY (`Id_Int`)
    REFERENCES `mydb`.`Interlocutor` (`Id_Int`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Detalles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Detalles` (
  `Cod_Proy` INT NOT NULL,
  `EfectoL` LONGTEXT NOT NULL,
  `Desc_Ini` MEDIUMTEXT NOT NULL,
  `RiesgoD` ENUM("Si", "No") NOT NULL,
  `Existe` ENUM("Si", "No") NOT NULL,
  `Just_Estado` MEDIUMTEXT NULL,
  PRIMARY KEY (`Cod_Proy`),
  CONSTRAINT `F.P-Dt`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Indicadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Indicadores` (
  `Cod_Proy` INT NOT NULL,
  `Indicador` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`Cod_Proy`),
  CONSTRAINT `F.P-Ind`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Efecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Efecto` (
  `Cod_Proy` INT NOT NULL,
  `Efecto` LONGTEXT NOT NULL,
  `Seguro` LONGTEXT NOT NULL,
  PRIMARY KEY (`Cod_Proy`),
  CONSTRAINT `F.P-E`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Objetivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Objetivo` (
  `Cod_Proy` INT NOT NULL,
  `Id_Obj` INT NOT NULL,
  `Objetivo` LONGTEXT NOT NULL,
  PRIMARY KEY (`Id_Obj`),
  CONSTRAINT `F.P-O`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Desc_Obj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Desc_Obj` (
  `Id_Obj` INT NOT NULL,
  `Medidas` VARCHAR(45) NOT NULL,
  `Riesgos` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Obj`),
  CONSTRAINT `F.O-DO`
    FOREIGN KEY (`Id_Obj`)
    REFERENCES `mydb`.`Objetivo` (`Id_Obj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fomento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fomento` (
  `Cod_Proy` INT NOT NULL,
  `LiquidacionF` ENUM("Si", "No") NULL,
  `ReferenciaF` MEDIUMTEXT NULL,
  PRIMARY KEY (`Cod_Proy`),
  CONSTRAINT `F.P-F`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estado` (
  `Cod_Proy` INT NOT NULL,
  `MedidaG` MEDIUMTEXT NULL,
  `GastoM` FLOAT NULL,
  PRIMARY KEY (`Cod_Proy`),
  CONSTRAINT `F.P-Es`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Destinatario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Destinatario` (
  `Cod_Proy` INT NOT NULL,
  `Quien` MEDIUMTEXT NOT NULL,
  `Consideraciones` MEDIUMTEXT NOT NULL,
  `Razon` MEDIUMTEXT NOT NULL,
  `Id_Quien` INT NOT NULL,
  PRIMARY KEY (`Cod_Proy`, `Id_Quien`),
  CONSTRAINT `Fk.P-Dt`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Actores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Actores` (
  `Id_Actor` INT NOT NULL,
  `Cod_Proy` INT NOT NULL,
  `Actor` MEDIUMTEXT NOT NULL,
  `Aprobado` ENUM("Si", "No", "Proceso") NOT NULL,
  `Otro_Proy` ENUM("Si", "No") NOT NULL,
  PRIMARY KEY (`Id_Actor`, `Cod_Proy`),
  INDEX `F.P-A_idx` (`Cod_Proy` ASC) VISIBLE,
  CONSTRAINT `F.P-A`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Otro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Otro` (
  `Nombre_Otro` VARCHAR(40) NULL,
  `Objetivos_Otro` MEDIUMTEXT NULL,
  `Socios_Otro` MEDIUMTEXT NULL,
  `Finan_Otro` MEDIUMTEXT NULL,
  `Result_Otro` MEDIUMTEXT NULL,
  `Cod_Proy` INT NOT NULL,
  PRIMARY KEY (`Cod_Proy`),
  CONSTRAINT `Fk.Py-Ot`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plan_Financiero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Plan_Financiero` (
  `Cod_Proy` INT NOT NULL,
  `Id_Plan` INT NOT NULL,
  `Material` FLOAT NOT NULL,
  `Personal` FLOAT NOT NULL,
  `Inverciones` FLOAT NOT NULL,
  `FondosP` FLOAT NOT NULL,
  `FondosT` FLOAT NOT NULL,
  `FondoSub` FLOAT NOT NULL,
  `Comentario` MEDIUMTEXT NULL,
  PRIMARY KEY (`Id_Plan`),
  CONSTRAINT `Fk.P-PF`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Finanzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Finanzas` (
  `Cod_Proy` INT NOT NULL,
  `Id_Plan` INT NOT NULL,
  `Fin_General` ENUM("Si", "No") NOT NULL,
  `Rango_Protec` MEDIUMTEXT NOT NULL,
  `Seguimiento` ENUM("Si", "No") NOT NULL,
  PRIMARY KEY (`Id_Plan`, `Cod_Proy`),
  INDEX `F.P-PF_idx` (`Id_Plan` ASC) VISIBLE,
  CONSTRAINT `Fk.P-Fi`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `F.P-PF`
    FOREIGN KEY (`Id_Plan`)
    REFERENCES `mydb`.`Plan_Financiero` (`Id_Plan`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Desglose`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Desglose` (
  `Id_Plan` INT NOT NULL,
  `Ingreso` FLOAT NULL,
  `FondosP-T` FLOAT NULL,
  `Subvencion` FLOAT NULL,
  `Total` FLOAT NULL,
  PRIMARY KEY (`Id_Plan`),
  UNIQUE INDEX `Total_UNIQUE` (`Total` ASC) VISIBLE,
  UNIQUE INDEX `Subvencion_UNIQUE` (`Subvencion` ASC) VISIBLE,
  UNIQUE INDEX `FondoP-T_UNIQUE` (`FondosP-T` ASC) VISIBLE,
  UNIQUE INDEX `Ingreso_UNIQUE` (`Ingreso` ASC) VISIBLE,
  INDEX `F.PF-Dg_idx` (`Id_Plan` ASC) VISIBLE,
  CONSTRAINT `F.PF-Dg`
    FOREIGN KEY (`Id_Plan`)
    REFERENCES `mydb`.`Plan_Financiero` (`Id_Plan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Gastos_Personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gastos_Personal` (
  `Id_GP` INT NULL,
  `Cod_Proy` INT NOT NULL,
  `Monto_GP` FLOAT NULL,
  `Just_GP` LONGTEXT NULL,
  PRIMARY KEY (`Cod_Proy`),
  INDEX `F.P-GP_idx` (`Cod_Proy` ASC) VISIBLE,
  CONSTRAINT `F.P-GP`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Gastos_Material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gastos_Material` (
  `Id_Prod` INT NULL,
  `Cod_Proy` INT NOT NULL,
  `Nombre_Prod` VARCHAR(40) NULL,
  `Uso_Prod` LONGTEXT NULL,
  `Monto_Prod` FLOAT NULL,
  PRIMARY KEY (`Cod_Proy`),
  INDEX `F.P-Prod_idx` (`Cod_Proy` ASC) VISIBLE,
  CONSTRAINT `F.P-Prod`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Gastos_Adm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gastos_Adm` (
  `Cod_Proy` INT NOT NULL,
  `Id_GA` INT NULL,
  `Desc_GA` MEDIUMTEXT NULL,
  `Monto_GA` FLOAT NULL,
  `Just_GA` MEDIUMTEXT NULL,
  `Just_Monto_GA` MEDIUMTEXT NULL,
  `Tipo_GA` MEDIUMTEXT NULL,
  PRIMARY KEY (`Cod_Proy`),
  CONSTRAINT `F.P-GA`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Gastos_Sub`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gastos_Sub` (
  `Id_GS` INT NULL,
  `Cod_Proy` INT NOT NULL,
  `Monto_GS` FLOAT NULL,
  `Desc_GS` MEDIUMTEXT NULL,
  PRIMARY KEY (`Cod_Proy`),
  INDEX `F.P-GS_idx` (`Cod_Proy` ASC) VISIBLE,
  CONSTRAINT `F.P-GS`
    FOREIGN KEY (`Cod_Proy`)
    REFERENCES `mydb`.`Proyecto` (`Cod_Proy`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Anexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Anexo` (
  `Id_Plan` INT NOT NULL,
  `Anexo` BINARY NULL,
  PRIMARY KEY (`Id_Plan`),
  CONSTRAINT `F.PF-An`
    FOREIGN KEY (`Id_Plan`)
    REFERENCES `mydb`.`Plan_Financiero` (`Id_Plan`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
