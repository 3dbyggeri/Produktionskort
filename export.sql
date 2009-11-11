DROP DATABASE IF EXISTS PDxmlMigration;

CREATE DATABASE PDxmlMigration;

CREATE TABLE PDxmlMigration.`Materiel`
(`id_materiel` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`id_pd` INT NULL, 
`akt�r` VARCHAR(50) NULL, 
`person` VARCHAR(50) NULL, 
`type_materiel` VARCHAR(50) NULL, 
`Materieltekst` VARCHAR(50) NULL, 
`Brugsanvisning` VARCHAR(50) NULL, 
`Placering` VARCHAR(50) NULL, 
`Krav` VARCHAR(50) NULL, 
`Certifikat` VARCHAR(50) NULL, 
`leje/aftale` VARCHAR(50) NULL, 
`Service/kontrakt` VARCHAR(50) NULL, 
`Registrering` VARCHAR(50) NULL, 
`tidstart` DATETIME NULL, 
`tidslut` DATETIME NULL, 
`Kontrol` VARCHAR(50) NULL, 
PRIMARY KEY(`id_materiel`), 
INDEX `Materiel$id`(`id_materiel`), 
INDEX `Materiel$id_akt�r`(`akt�r`), 
INDEX `Materiel$id_person`(`person`), 
INDEX `Materiel$id_sag`(`id_sag`), 
INDEX `Materiel$idpd`(`id_pd`), 
INDEX `Materiel$tid`(`tidstart`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD`
(`id_pd` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`type_bygningsdel` VARCHAR(50) NULL, 
`AKT_aktivitet` VARCHAR(50) NULL, 
`AKT_placering` VARCHAR(50) NULL, 
`AKT_projektoverdragelse_tid` DATETIME NULL, 
`AKT_projektoverdragelse_person` VARCHAR(50) NULL, 
`ARB_Montagevejledning` VARCHAR(50) NULL, 
`PLA_planlagtstart` DATETIME NULL, 
`PLA_planlagtslut` DATETIME NULL, 
`PLA_faktiskstart_tid` DATETIME NULL, 
`PLA_faktiskstart_sted` VARCHAR(50) NULL, 
`PLA_faktiskstart_person` VARCHAR(50) NULL, 
`PLA_faktiskslut_tid` DATETIME NULL, 
`PLA_faktiskslut_sted` VARCHAR(50) NULL, 
`PLA_faktiskslut_person` VARCHAR(50) NULL, 
`PLA_hovedtidstart` DATETIME NULL, 
`PLA_hovedtidslut` VARCHAR(50) NULL, 
`PLA_forudg�ende` VARCHAR(50) NULL, 
`PLA_efterf�lgende` VARCHAR(50) NULL, 
`MAN_socialt_ansvar` VARCHAR(50) NULL, 
`MAN_akkord_kr` DECIMAL(19, 4) NULL, 
`MAN_timel�n_kr` DECIMAL(19, 4) NULL, 
`MAN_bonus` TINYINT NULL, 
`MAN_Eksimentaftale` TINYINT NULL, 
`MAN_till�g` DECIMAL(19, 4) NULL, 
`MAN_tid_p�_d�gn_time` VARCHAR(50) NULL, 
`MAN_Ekstra_arbejde` TINYINT NULL, 
`SSMA_TimeStamp` TINYBLOB NOT NULL, 
PRIMARY KEY(`id_pd`), 
INDEX `PD$id`(`id_pd`), 
INDEX `PD$id_sag`(`id_sag`), 
INDEX `PD$PLA_hovedtid`(`PLA_hovedtidstart`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_aktivitet_foruds�tning`
(`id_foruds�tning` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`type_foruds�tning` VARCHAR(50) NULL, 
`tekst_foruds�tning` VARCHAR(50) NULL, 
PRIMARY KEY(`id_foruds�tning`), 
INDEX `PD_aktivitet_foruds�tning$id_foruds�tning`(`id_foruds�tning`), 
INDEX `PD_aktivitet_foruds�tning$id_pd`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_aktivitet_henvisninger`
(`id_henvisning` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`type_henvisning` VARCHAR(50) NULL, 
`henvisningstekst` VARCHAR(50) NULL, 
`henvisning` VARCHAR(50) NULL, 
PRIMARY KEY(`id_henvisning`), 
INDEX `PD_aktivitet_henvisninger$id`(`id_henvisning`), 
INDEX `PD_aktivitet_henvisninger$id_sag`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_arbejdsmetode_henvisninger`
(`id_henvisning` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`type_henvisning` VARCHAR(50) NULL, 
`henvisningstekst` VARCHAR(50) NULL, 
`henvisning` VARCHAR(50) NULL, 
PRIMARY KEY(`id_henvisning`), 
INDEX `PD_arbejdsmetode_henvisninger$id`(`id_henvisning`), 
INDEX `PD_arbejdsmetode_henvisninger$id_sag`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_kompetence`
(`id` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`Type_Kompetenceovergruppe` VARCHAR(50) NULL, 
`Type_kompetence` VARCHAR(50) NULL, 
`Tekst_kompetence` VARCHAR(50) NULL, 
`Immatriel_m�ntfod` INT NULL, 
PRIMARY KEY(`id`), 
INDEX `PD_kompetence$id`(`id`), 
INDEX `PD_kompetence$id_pd`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_kontrol`
(`id_kontrol` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`type_kontrol` VARCHAR(50) NULL, 
`kontrolmetode` VARCHAR(50) NULL, 
`kontroltekst` VARCHAR(50) NULL, 
`reg_person` VARCHAR(50) NULL, 
`reg_tid` DATETIME NULL, 
`reg_sted` VARCHAR(50) NULL, 
PRIMARY KEY(`id_kontrol`), 
INDEX `PD_kontrol$id`(`id_kontrol`), 
INDEX `PD_kontrol$id_pd`(`id_pd`), 
INDEX `PD_kontrol$tid`(`reg_tid`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_kontrol_dokumentation`
(`id_kontrol_dokumentation` INT NOT NULL AUTO_INCREMENT, 
`id_kontrol` INT NULL, 
`type_dokumentation` VARCHAR(50) NULL, 
`Dokumentation` VARCHAR(50) NULL, 
PRIMARY KEY(`id_kontrol_dokumentation`), 
INDEX `PD_kontrol_dokumentation$id`(`id_kontrol_dokumentation`), 
INDEX `PD_kontrol_dokumentation$pdksid`(`id_kontrol`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_krav`
(`id_krav` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`type_krav` VARCHAR(50) NULL, 
`Krav` VARCHAR(50) NULL, 
`Kravtekst` VARCHAR(50) NULL, 
PRIMARY KEY(`id_krav`), 
INDEX `PD_krav$id`(`id_krav`), 
INDEX `PD_krav$idpd`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_mandskab_henvisninger`
(`id_henvisning` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`type_henvisning` VARCHAR(50) NULL, 
`henvisningstekst` VARCHAR(50) NULL, 
`henvisning` VARCHAR(50) NULL, 
PRIMARY KEY(`id_henvisning`), 
INDEX `PD_mandskab_henvisninger$id`(`id_henvisning`), 
INDEX `PD_mandskab_henvisninger$id_sag`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_materialer`
(`id` INT NOT NULL AUTO_INCREMENT, 
`id_materialepakke` INT NULL, 
`type_materiale` VARCHAR(50) NULL, 
`Anvendelsesomr�de` VARCHAR(50) NULL, 
`m�l` VARCHAR(50) NULL, 
`v�gt` VARCHAR(50) NULL, 
`farver` VARCHAR(50) NULL, 
`tolerancer` VARCHAR(50) NULL, 
`ydeevne` VARCHAR(50) NULL, 
`kemiske_forhold` VARCHAR(50) NULL, 
`Antal` VARCHAR(50) NULL, 
`L�ngder` VARCHAR(50) NULL, 
`Enhed` VARCHAR(50) NULL, 
`leveringstid_lager` VARCHAR(50) NULL, 
`leveringstid_skaffevare` VARCHAR(50) NULL, 
`Opbevaring` TINYINT NULL, 
`T�rt` TINYINT NULL, 
`Montagekontrol` VARCHAR(50) NULL, 
`datablade` VARCHAR(50) NULL, 
`special_v�rkt�j` VARCHAR(50) NULL, 
`Drift_vedligehold` VARCHAR(50) NULL, 
`leverand�r` INT NULL, 
`alternativ_leverand�r` INT NULL, 
`leveringsbetingelser` VARCHAR(50) NULL, 
`returpolitik` VARCHAR(50) NULL, 
`SSMA_TimeStamp` TINYBLOB NOT NULL, 
PRIMARY KEY(`id`), 
INDEX `PD_materialer$id`(`id`), 
INDEX `PD_materialer$leveringstid`(`leveringstid_lager`), 
INDEX `PD_materialer$PD_materialerid_materialepakke`(`id_materialepakke`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_materialer_henvisninger`
(`id_henvisning` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`type_henvisning` VARCHAR(50) NULL, 
`henvisningstekst` VARCHAR(50) NULL, 
`henvisning` VARCHAR(50) NULL, 
PRIMARY KEY(`id_henvisning`), 
INDEX `PD_materialer_henvisninger$id`(`id_henvisning`), 
INDEX `PD_materialer_henvisninger$id_sag`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_materialer_pakker`
(`id_materialepakke` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`unitnr` VARCHAR(50) NULL, 
`l�snr` VARCHAR(50) NULL, 
`portnr` VARCHAR(50) NULL, 
`kran_hejsnr` VARCHAR(50) NULL, 
`planlagt_leveringsdato` DATETIME NULL, 
`indhejsningsvarighed` INT NULL, 
`Afkaldt_leveringstid` DATETIME NULL, 
`leveringsbetingelser` VARCHAR(50) NULL, 
`returpolitik` VARCHAR(50) NULL, 
PRIMARY KEY(`id_materialepakke`), 
INDEX `PD_materialer_pakker$Afkaldt_leveringstid`(`Afkaldt_leveringstid`), 
INDEX `PD_materialer_pakker$id`(`id_materialepakke`), 
INDEX `PD_materialer_pakker$idpd`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_materiel_henvisninger`
(`id_henvisning` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`type_henvisning` VARCHAR(50) NULL, 
`henvisningstekst` VARCHAR(50) NULL, 
`henvisning` VARCHAR(50) NULL, 
PRIMARY KEY(`id_henvisning`), 
INDEX `PD_materiel_henvisninger$id`(`id_henvisning`), 
INDEX `PD_materiel_henvisninger$id_sag`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_planl�gning_henvisninger`
(`id_henvisning` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`type_henvisning` VARCHAR(50) NULL, 
`henvisningstekst` VARCHAR(50) NULL, 
`henvisning` VARCHAR(50) NULL, 
PRIMARY KEY(`id_henvisning`), 
INDEX `PD_planl�gning_henvisninger$id`(`id_henvisning`), 
INDEX `PD_planl�gning_henvisninger$id_pd`(`id_sag`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_spildtid`
(`id_spildtid` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`�rsag` VARCHAR(50) NULL, 
`Start` DATETIME NULL, 
`Slut` DATETIME NULL, 
PRIMARY KEY(`id_spildtid`), 
INDEX `PD_spildtid$id_pd`(`id_pd`), 
INDEX `PD_spildtid$id_spildtid`(`id_spildtid`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`PD_v�rnemiddel`
(`id_v�rnemiddel` INT NOT NULL AUTO_INCREMENT, 
`id_pd` INT NULL, 
`type_v�rnemiddel` VARCHAR(50) NULL, 
`V�rnemiddeltekst` VARCHAR(50) NULL, 
`Skal_benyttes_ved` VARCHAR(50) NULL, 
PRIMARY KEY(`id_v�rnemiddel`), 
INDEX `PD_v�rnemiddel$id`(`id_v�rnemiddel`), 
INDEX `PD_v�rnemiddel$pdid`(`id_pd`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Stamdata`
(`id_sag` INT NOT NULL, 
`navn` VARCHAR(50) NULL, 
`adresse` VARCHAR(50) NULL, 
`Matrikelnummer` INT NULL, 
`postnr` VARCHAR(50) NULL, 
`APVplacering` VARCHAR(50) NULL, 
`sikkerhed_sundhed_bygherrebestemt` TINYINT NULL, 
`sikkerhed_sundhed_entrepren�r_bestemt` TINYINT NULL, 
`plan_sikkerhed_sundhed` TINYINT NULL, 
`plan_sikkerhed_sundhed_placering` VARCHAR(50) NULL, 
`SSMA_TimeStamp` TINYBLOB NOT NULL, 
PRIMARY KEY(`id_sag`), 
INDEX `Stamdata$Matrikelnummer`(`Matrikelnummer`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Stamdata_akt�r`
(`id_akt�r` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`id_pd` INT NULL, 
`type_akt�r` VARCHAR(50) NULL, 
`Firmanavn` VARCHAR(50) NULL, 
`adresse` VARCHAR(50) NULL, 
`postnr` INT NULL, 
`by` VARCHAR(50) NULL, 
`hovedtlf` VARCHAR(50) NULL, 
`fax` VARCHAR(50) NULL, 
`email` VARCHAR(50) NULL, 
`wwwadresse` VARCHAR(0) NULL, 
`SSMA_TimeStamp` TINYBLOB NOT NULL, 
PRIMARY KEY(`id_akt�r`), 
INDEX `Stamdata_akt�r$adresseid`(`id_akt�r`), 
INDEX `Stamdata_akt�r$id_pd`(`id_pd`), 
INDEX `Stamdata_akt�r$idsag`(`id_sag`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Stamdata_byggeplads_henvisninger`
(`id_henvisning` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`type_henvisning` VARCHAR(50) NULL, 
`henvisningstekst` VARCHAR(50) NULL, 
`henvisning` VARCHAR(50) NULL, 
PRIMARY KEY(`id_henvisning`), 
INDEX `Stamdata_byggeplads_henvisninger$id`(`id_henvisning`), 
INDEX `Stamdata_byggeplads_henvisninger$id_sag`(`id_sag`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Stamdata_byggepladsansvar`
(`id_byggepladsansvar` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`akt�r` VARCHAR(50) NULL, 
`person` VARCHAR(50) NULL, 
`type_byggepladsansvar` VARCHAR(50) NULL, 
`tekst_byggepladsansvar` VARCHAR(50) NULL, 
`tekst_uddybende` VARCHAR(50) NULL, 
PRIMARY KEY(`id_byggepladsansvar`), 
INDEX `Stamdata_byggepladsansvar$id_akt�r`(`akt�r`), 
INDEX `Stamdata_byggepladsansvar$id_byggepladsansvar`(`id_byggepladsansvar`), 
INDEX `Stamdata_byggepladsansvar$id_person`(`person`), 
INDEX `Stamdata_byggepladsansvar$id_sag`(`id_sag`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Stamdata_byggepladsdrift`
(`id_byggepladsdrift` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`type_byggepladsdrift` VARCHAR(50) NULL, 
`tekst_byggepladsdrift` VARCHAR(50) NULL, 
PRIMARY KEY(`id_byggepladsdrift`), 
INDEX `Stamdata_byggepladsdrift$m�deid`(`id_byggepladsdrift`), 
INDEX `Stamdata_byggepladsdrift$Stamdata_hensynid_sag`(`id_sag`), 
INDEX `Stamdata_byggepladsdrift$tid`(`type_byggepladsdrift`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`stamdata_byggepladsfokus`
(`id_byggepladsfokus` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`type_byggepladsfokus` VARCHAR(50) NULL, 
`byggepladsfokus_tekst` VARCHAR(50) NULL, 
`Seneste_kontrol` DATETIME NULL, 
PRIMARY KEY(`id_byggepladsfokus`), 
INDEX `stamdata_byggepladsfokus$id_byggepladsfokus`(`id_byggepladsfokus`), 
INDEX `stamdata_byggepladsfokus$id_pd`(`id_sag`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Stamdata_godkendelser`
(`id_godkendelse` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`type_godkendelse` VARCHAR(50) NULL, 
`godkendelsetekst` VARCHAR(50) NULL, 
`tid` VARCHAR(50) NULL, 
PRIMARY KEY(`id_godkendelse`), 
INDEX `Stamdata_godkendelser$m�deid`(`id_godkendelse`), 
INDEX `Stamdata_godkendelser$Stamdata_godkendelserid_sag`(`id_sag`), 
INDEX `Stamdata_godkendelser$tid`(`type_godkendelse`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Stamdata_hensyn`
(`id_hensyn` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`type_hensyn` VARCHAR(50) NULL, 
`hensyntekst` VARCHAR(50) NULL, 
`tid` VARCHAR(50) NULL, 
PRIMARY KEY(`id_hensyn`), 
INDEX `Stamdata_hensyn$m�deid`(`id_hensyn`), 
INDEX `Stamdata_hensyn$Stamdata_hensynid_sag`(`id_sag`), 
INDEX `Stamdata_hensyn$tid`(`type_hensyn`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Stamdata_m�der`
(`id_m�de` INT NOT NULL AUTO_INCREMENT, 
`id_sag` INT NULL, 
`type_m�de` VARCHAR(50) NULL, 
`tid` VARCHAR(50) NULL, 
PRIMARY KEY(`id_m�de`), 
INDEX `Stamdata_m�der$m�deid`(`id_m�de`), 
INDEX `Stamdata_m�der$Stamdata_m�derid_sag`(`id_sag`), 
INDEX `Stamdata_m�der$tid`(`type_m�de`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Stamdata_person`
(`id_person` INT NOT NULL AUTO_INCREMENT, 
`id_akt�r` INT NULL, 
`id_sag` INT NULL, 
`type_person` VARCHAR(50) NULL, 
`navn` VARCHAR(50) NULL, 
`adresse` VARCHAR(50) NULL, 
`postnr` INT NULL, 
`by` VARCHAR(50) NULL, 
`hovedtlf` VARCHAR(50) NULL, 
`direktetlf` VARCHAR(50) NULL, 
`mobiltlf` VARCHAR(50) NULL, 
`fax` VARCHAR(50) NULL, 
`email` VARCHAR(50) NULL, 
`wwwadresse` VARCHAR(0) NULL, 
`SSMA_TimeStamp` TINYBLOB NOT NULL, 
PRIMARY KEY(`id_person`), 
INDEX `Stamdata_person$firmaid`(`id_akt�r`), 
INDEX `Stamdata_person$idsag`(`id_sag`), 
INDEX `Stamdata_person$personid`(`id_person`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`sysdiagrams`
(`name` VARCHAR(128) NOT NULL, 
`principal_id` INT NOT NULL, 
`diagram_id` INT NOT NULL AUTO_INCREMENT, 
`version` INT NULL, 
`definition` BLOB NULL, 
PRIMARY KEY(`diagram_id`), 
UNIQUE `UK_principal_name`(`principal_id`,`name`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_akt�r`
(`type_akt�r` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_akt�r$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_byggepladsansvar`
(`type_byggepladsansvar` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_byggepladsansvar$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_byggepladsdrift`
(`type_byggepladsdrift` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_byggepladsdrift$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_byggepladsfokus`
(`type_byggepladsfokus` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_byggepladsfokus$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_foruds�tning`
(`type_foruds�tning` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_foruds�tning$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_godkendelse`
(`type_godkendelse` VARCHAR(50) NULL, 
`ID` INT NOT NULL AUTO_INCREMENT, 
INDEX `type_godkendelse$ID`(`ID`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_gruppe`
(`gruppe` VARCHAR(50) NULL, 
`id` INT NOT NULL, 
PRIMARY KEY(`id`), 
INDEX `type_gruppe$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_hensyn`
(`type_hensyn` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_hensyn$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_henvisning`
(`type_henvisning` VARCHAR(18) NULL, 
`Id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`Id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Type_kompetence`
(`type_kompetence` VARCHAR(50) NULL, 
`kompetenceovergruppe` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `Type_kompetence$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Type_kompetenceovergruppe`
(`kompetenceovergruppe` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `Type_kompetenceovergruppe$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_kontrol`
(`type_kontrol` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_kontrol$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_kontrol_dokumentation`
(`type_kontroldokumentation` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_kontrol_dokumentation$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Type_kontrolmetodetype`
(`type_kontrolmetode` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `Type_kontrolmetodetype$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_krav`
(`type_krav` VARCHAR(50) NULL, 
`ID` INT NOT NULL AUTO_INCREMENT, 
INDEX `type_krav$ID`(`ID`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_krav_overgruppe`
(`kravgruppe` VARCHAR(50) NULL, 
`ID` INT NOT NULL AUTO_INCREMENT, 
INDEX `type_krav_overgruppe$ID`(`ID`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_materiale`
(`type_materiale` VARCHAR(50) NULL, 
`Materialekode` INT NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_materiale$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Type_materiel`
(`type_materiel` VARCHAR(50) NULL, 
`materielkode` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `Type_materiel$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_m�de`
(`type_m�de` VARCHAR(50) NULL, 
`ID` INT NOT NULL AUTO_INCREMENT, 
INDEX `type_m�de$ID`(`ID`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`type_person`
(`type_person` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `type_person$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`Type_v�rnemiddel`
(`type_v�rnemiddel` VARCHAR(50) NULL, 
`id` INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(`id`), 
INDEX `Type_v�rnemiddel$id`(`id`)) ENGINE InnoDB CHARACTER SET utf8;

CREATE TABLE PDxmlMigration.`UDG�ET_TBL_PD_foruds�tning`
(`IDPD` INT NOT NULL, 
`Vinterforanstaltninger` VARCHAR(50) NULL, 
`Hjelm` TINYINT NULL, 
`H�rev�rn` TINYINT NULL, 
`Sikkerhedsbriller` TINYINT NULL, 
`Sikkerhedssko` TINYINT NULL, 
`Handsker` TINYINT NULL, 
`Kn�beskytter` TINYINT NULL, 
`Forkl�de` TINYINT NULL, 
`Sk�rebukser` TINYINT NULL, 
`St�vdragt/engangsdragt` TINYINT NULL, 
`Regnt�j` TINYINT NULL, 
`Termodragt` TINYINT NULL, 
`Syrefast_t�j` TINYINT NULL, 
`Faldsele` TINYINT NULL, 
`�ndedr�tsv�rn` TINYINT NULL, 
`SSMA_TimeStamp` TINYBLOB NOT NULL, 
PRIMARY KEY(`IDPD`), 
INDEX `UDG�ET_TBL_PD_foruds�tning$IDPD`(`IDPD`)) ENGINE InnoDB CHARACTER SET utf8;

USE PDxmlMigration;

INSERT INTO `Materiel` (`id_materiel`, `id_sag`, `id_pd`, `akt�r`, `person`, `type_materiel`, `Materieltekst`, `Brugsanvisning`, `Placering`, `Krav`, `Certifikat`, `leje/aftale`, `Service/kontrakt`, `Registrering`, `tidstart`, `tidslut`, `Kontrol`)  VALUES(1, 1, 0, NULL, NULL, 'Lift', 'Sakselift', 'Press start', 'bygning 1', NULL, NULL, NULL, NULL, NULL, 20050101000000, 20051001000000, NULL);
INSERT INTO `Materiel` (`id_materiel`, `id_sag`, `id_pd`, `akt�r`, `person`, `type_materiel`, `Materieltekst`, `Brugsanvisning`, `Placering`, `Krav`, `Certifikat`, `leje/aftale`, `Service/kontrakt`, `Registrering`, `tidstart`, `tidslut`, `Kontrol`)  VALUES(2, 1, 0, NULL, NULL, 'Stillads', 'Murerstillads', NULL, 'bygning 2', NULL, NULL, NULL, NULL, NULL, 20050301000000, 20050715000000, NULL);
INSERT INTO `Materiel` (`id_materiel`, `id_sag`, `id_pd`, `akt�r`, `person`, `type_materiel`, `Materieltekst`, `Brugsanvisning`, `Placering`, `Krav`, `Certifikat`, `leje/aftale`, `Service/kontrakt`, `Registrering`, `tidstart`, `tidslut`, `Kontrol`)  VALUES(3, 0, 1, 'Rentskur', 'Gert Bank', 'Mobilkran', NULL, '<link> eller tekst', 'Ved bygning 3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `Materiel` (`id_materiel`, `id_sag`, `id_pd`, `akt�r`, `person`, `type_materiel`, `Materieltekst`, `Brugsanvisning`, `Placering`, `Krav`, `Certifikat`, `leje/aftale`, `Service/kontrakt`, `Registrering`, `tidstart`, `tidslut`, `Kontrol`)  VALUES(4, 0, 1, 'Rentskur', 'Gert Bank', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `PD` (`id_pd`, `id_sag`, `type_bygningsdel`, `AKT_aktivitet`, `AKT_placering`, `AKT_projektoverdragelse_tid`, `AKT_projektoverdragelse_person`, `ARB_Montagevejledning`, `PLA_planlagtstart`, `PLA_planlagtslut`, `PLA_faktiskstart_tid`, `PLA_faktiskstart_sted`, `PLA_faktiskstart_person`, `PLA_faktiskslut_tid`, `PLA_faktiskslut_sted`, `PLA_faktiskslut_person`, `PLA_hovedtidstart`, `PLA_hovedtidslut`, `PLA_forudg�ende`, `PLA_efterf�lgende`, `MAN_socialt_ansvar`, `MAN_akkord_kr`, `MAN_timel�n_kr`, `MAN_bonus`, `MAN_Eksimentaftale`, `MAN_till�g`, `MAN_tid_p�_d�gn_time`, `MAN_Ekstra_arbejde`, `SSMA_TimeStamp`)  VALUES(1, NULL, '1', 'Der skal laves det og det.', 'Alle etager i bygning 1', 18991230000000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, );
INSERT INTO `PD_aktivitet_foruds�tning` (`id_foruds�tning`, `id_pd`, `type_foruds�tning`, `tekst_foruds�tning`)  VALUES(1, 1, 'PD specifik vinterforanstaltning', 'Sprit i bajlen');
INSERT INTO `PD_aktivitet_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(1, 1, 'Tegning', 'Detaljetegning', '<link>');
INSERT INTO `PD_aktivitet_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(2, 1, 'Tegning', 'Snit', '<link>');
INSERT INTO `PD_kompetence` (`id`, `id_pd`, `Type_Kompetenceovergruppe`, `Type_kompetence`, `Tekst_kompetence`, `Immatriel_m�ntfod`)  VALUES(1, 1, 'Arbejdsrealateret kompetencer', 'K�rekort', 'til alm. Bil', 0);
INSERT INTO `PD_kompetence` (`id`, `id_pd`, `Type_Kompetenceovergruppe`, `Type_kompetence`, `Tekst_kompetence`, `Immatriel_m�ntfod`)  VALUES(2, 1, 'Arbejdsrealateret kompetencer', 'Truckcertificat', NULL, 0);
INSERT INTO `PD_kompetence` (`id`, `id_pd`, `Type_Kompetenceovergruppe`, `Type_kompetence`, `Tekst_kompetence`, `Immatriel_m�ntfod`)  VALUES(3, 1, 'Arbejdsrealateret kompetencer', 'Svejsecertifikat', 'max. 1 �r gammelt', 0);
INSERT INTO `PD_kompetence` (`id`, `id_pd`, `Type_Kompetenceovergruppe`, `Type_kompetence`, `Tekst_kompetence`, `Immatriel_m�ntfod`)  VALUES(4, 1, 'Arbejdsrealateret kompetencer', 'produktviden asfalt', NULL, 0);
INSERT INTO `PD_kompetence` (`id`, `id_pd`, `Type_Kompetenceovergruppe`, `Type_kompetence`, `Tekst_kompetence`, `Immatriel_m�ntfod`)  VALUES(5, 1, 'Arbejdsrealateret kompetencer', 'Produktviden epoxy', NULL, 0);
INSERT INTO `PD_kompetence` (`id`, `id_pd`, `Type_Kompetenceovergruppe`, `Type_kompetence`, `Tekst_kompetence`, `Immatriel_m�ntfod`)  VALUES(6, 1, 'Samarbejdskompetencer', NULL, 'Sjakbajs', 3);
INSERT INTO `PD_kontrol` (`id_kontrol`, `id_pd`, `type_kontrol`, `kontrolmetode`, `kontroltekst`, `reg_person`, `reg_tid`, `reg_sted`)  VALUES(1, 1, 'Startkontrol', 'visuel', 'OK', NULL, NULL, NULL);
INSERT INTO `PD_kontrol` (`id_kontrol`, `id_pd`, `type_kontrol`, `kontrolmetode`, `kontroltekst`, `reg_person`, `reg_tid`, `reg_sted`)  VALUES(2, 1, 'Proceskontrol', 'lod', '2 mm p� en 2M loddestok', NULL, NULL, NULL);
INSERT INTO `PD_kontrol_dokumentation` (`id_kontrol_dokumentation`, `id_kontrol`, `type_dokumentation`, `Dokumentation`)  VALUES(1, 1, 'Billede', '<link>');
INSERT INTO `PD_krav` (`id_krav`, `id_pd`, `type_krav`, `Krav`, `Kravtekst`)  VALUES(1, 1, 'Funktion', 'Lys', 'min. 400 LUX');
INSERT INTO `PD_krav` (`id_krav`, `id_pd`, `type_krav`, `Krav`, `Kravtekst`)  VALUES(2, 1, 'Funktion', 'B�reevne', NULL);
INSERT INTO `PD_krav` (`id_krav`, `id_pd`, `type_krav`, `Krav`, `Kravtekst`)  VALUES(3, 1, 'Finish', NULL, NULL);
INSERT INTO `PD_mandskab_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(1, 1, 'F�lgeseddel', '12332323', '<link>');
INSERT INTO `PD_mandskab_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(2, 1, 'Faktura', '545345454', '<link>');
INSERT INTO `PD_mandskab_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(3, 1, 'Faktura', '43453535345', NULL);
INSERT INTO `PD_materialer` (`id`, `id_materialepakke`, `type_materiale`, `Anvendelsesomr�de`, `m�l`, `v�gt`, `farver`, `tolerancer`, `ydeevne`, `kemiske_forhold`, `Antal`, `L�ngder`, `Enhed`, `leveringstid_lager`, `leveringstid_skaffevare`, `Opbevaring`, `T�rt`, `Montagekontrol`, `datablade`, `special_v�rkt�j`, `Drift_vedligehold`, `leverand�r`, `alternativ_leverand�r`, `leveringsbetingelser`, `returpolitik`, `SSMA_TimeStamp`)  VALUES(1, 1, 'Mursten', 'murv�rk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, );
INSERT INTO `PD_materialer` (`id`, `id_materialepakke`, `type_materiale`, `Anvendelsesomr�de`, `m�l`, `v�gt`, `farver`, `tolerancer`, `ydeevne`, `kemiske_forhold`, `Antal`, `L�ngder`, `Enhed`, `leveringstid_lager`, `leveringstid_skaffevare`, `Opbevaring`, `T�rt`, `Montagekontrol`, `datablade`, `special_v�rkt�j`, `Drift_vedligehold`, `leverand�r`, `alternativ_leverand�r`, `leveringsbetingelser`, `returpolitik`, `SSMA_TimeStamp`)  VALUES(2, 1, 'Maling', 'indvendige overflader', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, );
INSERT INTO `PD_materialer_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(1, 1, 'F�lgeseddel', NULL, NULL);
INSERT INTO `PD_materialer_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(2, 1, 'Faktura', NULL, NULL);
INSERT INTO `PD_materialer_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(3, 1, 'Faktura', NULL, NULL);
INSERT INTO `PD_materialer_pakker` (`id_materialepakke`, `id_pd`, `unitnr`, `l�snr`, `portnr`, `kran_hejsnr`, `planlagt_leveringsdato`, `indhejsningsvarighed`, `Afkaldt_leveringstid`, `leveringsbetingelser`, `returpolitik`)  VALUES(1, 1, '1', '1', '1', '1', NULL, 0, NULL, NULL, NULL);
INSERT INTO `PD_materiel_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(1, 1, 'F�lgeseddel', 'nr. 44523', '<link>');
INSERT INTO `PD_materiel_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(2, 1, 'Faktura', 'nr. 54543', '<link>');
INSERT INTO `PD_materiel_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(3, 1, 'Returseddel', 'nr. 1231223', '<link>');
INSERT INTO `PD_materiel_henvisninger` (`id_henvisning`, `id_pd`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(4, 1, 'Produktcertificat', 'AF: For det enkelte stykke materiel?', '<link>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(4, NULL, 'Tegning', 'Byggepladsplan', '<tegningsnr>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(5, NULL, 'Tidsplan', 'Hovedtidsplan', '<link>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(6, NULL, 'Tidsplan', 'detajltidsplan', '<link>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(7, NULL, 'Tegning', 'Byggeppladsindretning', '<tegningsnr>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(8, NULL, NULL, NULL, NULL);
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(9, NULL, NULL, NULL, NULL);
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(10, NULL, NULL, NULL, NULL);
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(11, 1, 'Tidsplan', 'Hovedtidsplan', '<link>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(12, 1, 'Tidsplan', 'Procesplan', '<link>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(13, 1, 'Tidsplan', 'Udf�relsestidsplan', '<link>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(14, 1, 'Tidsplan', 'Periodeplan', '<link>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(15, 1, 'Tidsplan', 'Arbejdsplan', '<link>');
INSERT INTO `PD_planl�gning_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(16, 1, 'Tidsplan', 'Beslutningsplan', '<link>');
INSERT INTO `PD_v�rnemiddel` (`id_v�rnemiddel`, `id_pd`, `type_v�rnemiddel`, `V�rnemiddeltekst`, `Skal_benyttes_ved`)  VALUES(1, 1, 'Hjelm', 'sikkerhedsgodkendt', 'udend�rs');
INSERT INTO `PD_v�rnemiddel` (`id_v�rnemiddel`, `id_pd`, `type_v�rnemiddel`, `V�rnemiddeltekst`, `Skal_benyttes_ved`)  VALUES(2, 1, 'Forkl�de', 'Brandsikkert', 'Svejsning');
INSERT INTO `Stamdata` (`id_sag`, `navn`, `adresse`, `Matrikelnummer`, `postnr`, `APVplacering`, `sikkerhed_sundhed_bygherrebestemt`, `sikkerhed_sundhed_entrepren�r_bestemt`, `plan_sikkerhed_sundhed`, `plan_sikkerhed_sundhed_placering`, `SSMA_TimeStamp`)  VALUES(1, 'byggeprojekt 1', 'fiktionsvej 2', 123123, '2500', NULL, 0, 0, 0, NULL, );
INSERT INTO `Stamdata_akt�r` (`id_akt�r`, `id_sag`, `id_pd`, `type_akt�r`, `Firmanavn`, `adresse`, `postnr`, `by`, `hovedtlf`, `fax`, `email`, `wwwadresse`, `SSMA_TimeStamp`)  VALUES(1, 1, NULL, 'Entrepren�r', 'Solidbyg', 'Bytorvet 3', 2500, 'Valby', '33221122', '33221123', 'firma1@firma1.dk', 'firma1.dk#http://firma1.dk#', );
INSERT INTO `Stamdata_akt�r` (`id_akt�r`, `id_sag`, `id_pd`, `type_akt�r`, `Firmanavn`, `adresse`, `postnr`, `by`, `hovedtlf`, `fax`, `email`, `wwwadresse`, `SSMA_TimeStamp`)  VALUES(2, 1, 0, 'Service', 'Rentskur', 'Skurevej 45', 2500, 'Valby', '11223344', '11223355', 'rentskur@rentskur.dk', 'rentskur.dk#http://rentskur.dk#', );
INSERT INTO `Stamdata_akt�r` (`id_akt�r`, `id_sag`, `id_pd`, `type_akt�r`, `Firmanavn`, `adresse`, `postnr`, `by`, `hovedtlf`, `fax`, `email`, `wwwadresse`, `SSMA_TimeStamp`)  VALUES(3, 1, 0, 'Arkitekt', 'Finstreg', 'Blyantgade 56', 2000, 'Frb.', '44332211', '44332222', 'fin@finstreg.dk', 'finstreg.dk#http://finstreg.dk#', );
INSERT INTO `Stamdata_akt�r` (`id_akt�r`, `id_sag`, `id_pd`, `type_akt�r`, `Firmanavn`, `adresse`, `postnr`, `by`, `hovedtlf`, `fax`, `email`, `wwwadresse`, `SSMA_TimeStamp`)  VALUES(4, 1, 0, 'Service', 'Hvemdeer', 'Pasergade 2', 2500, 'valby', '32112311', '90808788', 'stop@hvemdeer.dk', 'hvemdeer.dk#http://hvemdeer.dk#', );
INSERT INTO `Stamdata_akt�r` (`id_akt�r`, `id_sag`, `id_pd`, `type_akt�r`, `Firmanavn`, `adresse`, `postnr`, `by`, `hovedtlf`, `fax`, `email`, `wwwadresse`, `SSMA_TimeStamp`)  VALUES(5, 1, 0, 'Bygherre - Kunde', 'BoS', 'Bovej 1', 2000, 'Frb.', '34545345', '34534534', 'bo@bos.dk', 'bos.dk#http://bos.dk#', );
INSERT INTO `Stamdata_byggeplads_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(4, 1, 'Tegning', 'Byggepladsplan', '<tegningsnr>');
INSERT INTO `Stamdata_byggeplads_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(5, 1, 'Tidsplan', 'Hovedtidsplan', '<link>');
INSERT INTO `Stamdata_byggeplads_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(6, 1, 'Tidsplan', 'detajltidsplan', '<link>');
INSERT INTO `Stamdata_byggeplads_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(7, 1, 'Tegning', 'Byggeppladsindretning', '<tegningsnr>');
INSERT INTO `Stamdata_byggeplads_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(8, 1, NULL, NULL, NULL);
INSERT INTO `Stamdata_byggeplads_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(9, 1, NULL, NULL, NULL);
INSERT INTO `Stamdata_byggeplads_henvisninger` (`id_henvisning`, `id_sag`, `type_henvisning`, `henvisningstekst`, `henvisning`)  VALUES(10, 1, NULL, NULL, NULL);
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(4, 1, 'Solidbyg', 'Bent Olsen', 'Byggeplads generelt', '�verste Byggeledelse', NULL);
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(5, 1, 'Solidbyg', 'Bent Olsen', 'N�gleh�ndtering', 'Har de fleste n�gler', NULL);
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(6, 1, 'Hvemdeer', 'Hans Barsk', 'Sikkerhedsoverv�gning', 'Nattevagt', NULL);
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(7, 1, 'Rentskur', NULL, 'Skurby', 'Drift og vedligehold', NULL);
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(8, 1, 'finstreg', 'Gert Bank', 'Sikkerhed - arbejdsmilj�', '�verste sikkerhedsansvar', NULL);
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(9, 1, 'Solidbyg', 'Bent Olsen', 'N�gleh�ndtering', 'Idkort', 'Der kr�ves ID kort for adgang til pladsen.');
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(10, 1, NULL, NULL, 'Parkering', 'Der m� kun parkeres p� �vej', NULL);
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(11, 1, NULL, NULL, 'Adgangsforhold', 'Al adgang skal ske via port', NULL);
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(12, 1, NULL, NULL, 'Skiltning', 'Oversigt findes ved port', NULL);
INSERT INTO `Stamdata_byggepladsansvar` (`id_byggepladsansvar`, `id_sag`, `akt�r`, `person`, `type_byggepladsansvar`, `tekst_byggepladsansvar`, `tekst_uddybende`)  VALUES(14, 1, 'BoS', NULL, 'Vinterforanstaltninger', 'Alle generelle forantstaltninger', 'Se byggepladsdrift for detaljer');
INSERT INTO `Stamdata_byggepladsdrift` (`id_byggepladsdrift`, `id_sag`, `type_byggepladsdrift`, `tekst_byggepladsdrift`)  VALUES(1, 1, 'Vinterforanstaltning', 'K�reveje bliver ryddet');
INSERT INTO `Stamdata_byggepladsdrift` (`id_byggepladsdrift`, `id_sag`, `type_byggepladsdrift`, `tekst_byggepladsdrift`)  VALUES(2, 1, 'Vinterforanstaltning', 'Der saltes ved indgange');
INSERT INTO `Stamdata_byggepladsdrift` (`id_byggepladsdrift`, `id_sag`, `type_byggepladsdrift`, `tekst_byggepladsdrift`)  VALUES(3, 1, 'Udlejningsservice', 'H�ndv�rkt�j kan lejes');
INSERT INTO `Stamdata_byggepladsdrift` (`id_byggepladsdrift`, `id_sag`, `type_byggepladsdrift`, `tekst_byggepladsdrift`)  VALUES(4, 1, 'Affaldssortering', 'F�lles containere t�mmes dagligt');
INSERT INTO `stamdata_byggepladsfokus` (`id_byggepladsfokus`, `id_sag`, `type_byggepladsfokus`, `byggepladsfokus_tekst`, `Seneste_kontrol`)  VALUES(1, 1, 'Belysning', 'Gangarealer', 20051212000000);
INSERT INTO `stamdata_byggepladsfokus` (`id_byggepladsfokus`, `id_sag`, `type_byggepladsfokus`, `byggepladsfokus_tekst`, `Seneste_kontrol`)  VALUES(2, 1, 'Kabler, tavler og ledninger', NULL, NULL);
INSERT INTO `stamdata_byggepladsfokus` (`id_byggepladsfokus`, `id_sag`, `type_byggepladsfokus`, `byggepladsfokus_tekst`, `Seneste_kontrol`)  VALUES(3, 1, 'Oplagsplads', NULL, NULL);
INSERT INTO `stamdata_byggepladsfokus` (`id_byggepladsfokus`, `id_sag`, `type_byggepladsfokus`, `byggepladsfokus_tekst`, `Seneste_kontrol`)  VALUES(4, 1, 'V�rksteder/ pr�fabrikationspladser', NULL, NULL);
INSERT INTO `stamdata_byggepladsfokus` (`id_byggepladsfokus`, `id_sag`, `type_byggepladsfokus`, `byggepladsfokus_tekst`, `Seneste_kontrol`)  VALUES(5, 1, 'Blandeplads', NULL, NULL);
INSERT INTO `stamdata_byggepladsfokus` (`id_byggepladsfokus`, `id_sag`, `type_byggepladsfokus`, `byggepladsfokus_tekst`, `Seneste_kontrol`)  VALUES(6, 1, 'Kraner og anhugningsgrej', NULL, NULL);
INSERT INTO `stamdata_byggepladsfokus` (`id_byggepladsfokus`, `id_sag`, `type_byggepladsfokus`, `byggepladsfokus_tekst`, `Seneste_kontrol`)  VALUES(7, 1, 'Stillads', NULL, NULL);
INSERT INTO `stamdata_byggepladsfokus` (`id_byggepladsfokus`, `id_sag`, `type_byggepladsfokus`, `byggepladsfokus_tekst`, `Seneste_kontrol`)  VALUES(8, 1, 'Stiger', NULL, NULL);
INSERT INTO `Stamdata_godkendelser` (`id_godkendelse`, `id_sag`, `type_godkendelse`, `godkendelsetekst`, `tid`)  VALUES(1, 1, 'Byggetilladelse', 'Foreligger', '2005.01.02');
INSERT INTO `Stamdata_godkendelser` (`id_godkendelse`, `id_sag`, `type_godkendelse`, `godkendelsetekst`, `tid`)  VALUES(2, 1, 'Statiske beregninger', 'Projekt godkendt', '2005.01.01');
INSERT INTO `Stamdata_godkendelser` (`id_godkendelse`, `id_sag`, `type_godkendelse`, `godkendelsetekst`, `tid`)  VALUES(3, 1, 'Geoteknisk rapport', 'Projekt godkendt', '2005.01.01');
INSERT INTO `Stamdata_hensyn` (`id_hensyn`, `id_sag`, `type_hensyn`, `hensyntekst`, `tid`)  VALUES(1, 1, 'Beboere', 'St�j forbudt', '20.00 - 08.00');
INSERT INTO `Stamdata_hensyn` (`id_hensyn`, `id_sag`, `type_hensyn`, `hensyntekst`, `tid`)  VALUES(2, 1, 'Skole', 'Pas p� nye i trafikken', 'Ved skolestart');
INSERT INTO `Stamdata_hensyn` (`id_hensyn`, `id_sag`, `type_hensyn`, `hensyntekst`, `tid`)  VALUES(3, 1, 'Trafikken', 'Kran kun tilladt', '23.00 - 05.00');
INSERT INTO `Stamdata_m�der` (`id_m�de`, `id_sag`, `type_m�de`, `tid`)  VALUES(1, 1, 'Projektm�de', 'hver onsdag');
INSERT INTO `Stamdata_m�der` (`id_m�de`, `id_sag`, `type_m�de`, `tid`)  VALUES(2, 1, 'Byggem�de', 'hver mandag');
INSERT INTO `Stamdata_m�der` (`id_m�de`, `id_sag`, `type_m�de`, `tid`)  VALUES(3, 1, 'Formandsm�de', NULL);
INSERT INTO `Stamdata_person` (`id_person`, `id_akt�r`, `id_sag`, `type_person`, `navn`, `adresse`, `postnr`, `by`, `hovedtlf`, `direktetlf`, `mobiltlf`, `fax`, `email`, `wwwadresse`, `SSMA_TimeStamp`)  VALUES(1, 2, 0, 'Kontaktperson', 'Gert Bank', 'Kulvej', 2500, 'Valby', '44331122', '44331155', '12312312', '12312312', 'gb@finstreg.dk', 'finstreg.dk#http://finstreg.dk#', );
INSERT INTO `Stamdata_person` (`id_person`, `id_akt�r`, `id_sag`, `type_person`, `navn`, `adresse`, `postnr`, `by`, `hovedtlf`, `direktetlf`, `mobiltlf`, `fax`, `email`, `wwwadresse`, `SSMA_TimeStamp`)  VALUES(2, 1, 0, 'Kontaktperson', 'Bent Olsen', 'Bytorvet 3', 2500, 'Valby', '33221122', '33221144', '12221144', '33221123', 'bo@firma1.dk', 'firma1.dk#http://firma1.dk#', );
INSERT INTO `Stamdata_person` (`id_person`, `id_akt�r`, `id_sag`, `type_person`, `navn`, `adresse`, `postnr`, `by`, `hovedtlf`, `direktetlf`, `mobiltlf`, `fax`, `email`, `wwwadresse`, `SSMA_TimeStamp`)  VALUES(3, 4, 1, 'Kontaktperson', 'Hans Barsk', 'pansergade 2', 2500, 'valby', '567567567', '567567567', '567567567', '678678678', 'ingen', 'hvemdeer.dk#http://hvemdeer.dk#', );
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Bygherre - Kunde', 1);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('R�dgiver', 2);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Entrepren�r', 3);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Underentrepren�r', 4);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Fagentrepren�r', 5);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Grossist', 6);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Leverand�r', 7);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Producent', 8);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Landm�ler', 9);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Service', 10);
INSERT INTO `type_akt�r` (`type_akt�r`, `id`)  VALUES('Arkitekt', 11);
INSERT INTO `type_byggepladsansvar` (`type_byggepladsansvar`, `id`)  VALUES('Byggeplads generelt', 1);
INSERT INTO `type_byggepladsansvar` (`type_byggepladsansvar`, `id`)  VALUES('Skurby', 2);
INSERT INTO `type_byggepladsansvar` (`type_byggepladsansvar`, `id`)  VALUES('N�gleh�ndtering', 3);
INSERT INTO `type_byggepladsansvar` (`type_byggepladsansvar`, `id`)  VALUES('Sikkerhed - arbejdsmilj�', 4);
INSERT INTO `type_byggepladsansvar` (`type_byggepladsansvar`, `id`)  VALUES('Sikkerhedsoverv�gning', 5);
INSERT INTO `type_byggepladsansvar` (`type_byggepladsansvar`, `id`)  VALUES('Adgangsforhold', 7);
INSERT INTO `type_byggepladsansvar` (`type_byggepladsansvar`, `id`)  VALUES('Parkering', 8);
INSERT INTO `type_byggepladsansvar` (`type_byggepladsansvar`, `id`)  VALUES('Skiltning', 9);
INSERT INTO `type_byggepladsansvar` (`type_byggepladsansvar`, `id`)  VALUES('Vinterforanstaltninger', 10);
INSERT INTO `type_byggepladsdrift` (`type_byggepladsdrift`, `id`)  VALUES('Vinterforanstaltning', 1);
INSERT INTO `type_byggepladsdrift` (`type_byggepladsdrift`, `id`)  VALUES('Indvendig reng�ring', 2);
INSERT INTO `type_byggepladsdrift` (`type_byggepladsdrift`, `id`)  VALUES('Udvendig reng�ring', 3);
INSERT INTO `type_byggepladsdrift` (`type_byggepladsdrift`, `id`)  VALUES('Affaldssortering', 4);
INSERT INTO `type_byggepladsdrift` (`type_byggepladsdrift`, `id`)  VALUES('Udlejningsservice', 5);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Belysning', 1);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Kabler, tavler og ledninger', 2);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Oplagsplads', 3);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('V�rksteder/ pr�fabrikationspladser', 4);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Blandeplads', 5);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Kraner og anhugningsgrej', 6);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Stillads', 7);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Stiger', 8);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Arbejdsplatform/ lift', 9);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Afsp�rringer og afd�kninger', 10);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Udgravninger', 11);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Oprydning og reng�ring', 12);
INSERT INTO `type_byggepladsfokus` (`type_byggepladsfokus`, `id`)  VALUES('Mobilarbejdsplads', 13);
INSERT INTO `type_foruds�tning` (`type_foruds�tning`, `id`)  VALUES('PD specifik vinterforanstaltning', 1);
INSERT INTO `type_godkendelse` (`type_godkendelse`, `ID`)  VALUES('Byggetilladelse', 1);
INSERT INTO `type_godkendelse` (`type_godkendelse`, `ID`)  VALUES('Geoteknisk rapport', 2);
INSERT INTO `type_godkendelse` (`type_godkendelse`, `ID`)  VALUES('Statiske beregninger', 3);
INSERT INTO `type_godkendelse` (`type_godkendelse`, `ID`)  VALUES('Milj�godkendelse', 4);
INSERT INTO `type_gruppe` (`gruppe`, `id`)  VALUES('Stamdata', 0);
INSERT INTO `type_gruppe` (`gruppe`, `id`)  VALUES('Byggeplads', 1);
INSERT INTO `type_gruppe` (`gruppe`, `id`)  VALUES('Planl�gning og opf�lgning', 2);
INSERT INTO `type_gruppe` (`gruppe`, `id`)  VALUES('Aktivitet', 3);
INSERT INTO `type_gruppe` (`gruppe`, `id`)  VALUES('Arbejdsmetode', 4);
INSERT INTO `type_gruppe` (`gruppe`, `id`)  VALUES('Materiel', 5);
INSERT INTO `type_gruppe` (`gruppe`, `id`)  VALUES('Materialer', 6);
INSERT INTO `type_gruppe` (`gruppe`, `id`)  VALUES('Mandskab', 7);
INSERT INTO `type_hensyn` (`type_hensyn`, `id`)  VALUES('Beboere', 1);
INSERT INTO `type_hensyn` (`type_hensyn`, `id`)  VALUES('Hospital', 2);
INSERT INTO `type_hensyn` (`type_hensyn`, `id`)  VALUES('Skole', 3);
INSERT INTO `type_hensyn` (`type_hensyn`, `id`)  VALUES('B�rnehave', 4);
INSERT INTO `type_hensyn` (`type_hensyn`, `id`)  VALUES('Plejehjem', 5);
INSERT INTO `type_hensyn` (`type_hensyn`, `id`)  VALUES('Trafikken', 6);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('Tegning', 1);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('3-D model/objekter', 2);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('Referencenavn', 3);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('Detaljetegning', 4);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('Beskrivelse', 5);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('Tidsplan', 6);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('mockup', 7);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('F�lgeseddel', 8);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('Faktura', 9);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('Returseddel', 10);
INSERT INTO `type_henvisning` (`type_henvisning`, `Id`)  VALUES('Produktcertificat', 11);
INSERT INTO `Type_kompetence` (`type_kompetence`, `kompetenceovergruppe`, `id`)  VALUES('K�rekort', 'arbejdsrelateret', 1);
INSERT INTO `Type_kompetence` (`type_kompetence`, `kompetenceovergruppe`, `id`)  VALUES('Truckcertificat', 'arbejdsrelateret', 2);
INSERT INTO `Type_kompetence` (`type_kompetence`, `kompetenceovergruppe`, `id`)  VALUES('Svejsecertifikat', 'arbejdsrelateret', 3);
INSERT INTO `Type_kompetence` (`type_kompetence`, `kompetenceovergruppe`, `id`)  VALUES('produktviden asfalt', 'arbejdsrelateret', 4);
INSERT INTO `Type_kompetence` (`type_kompetence`, `kompetenceovergruppe`, `id`)  VALUES('Produktviden epoxy', 'arbejdsrelateret', 5);
INSERT INTO `Type_kompetenceovergruppe` (`kompetenceovergruppe`, `id`)  VALUES('Udannelse', 1);
INSERT INTO `Type_kompetenceovergruppe` (`kompetenceovergruppe`, `id`)  VALUES('Arbejdsrealateret kompetencer', 2);
INSERT INTO `Type_kompetenceovergruppe` (`kompetenceovergruppe`, `id`)  VALUES('Samarbejdskompetencer', 3);
INSERT INTO `Type_kompetenceovergruppe` (`kompetenceovergruppe`, `id`)  VALUES('Personlige kompetencer', 4);
INSERT INTO `type_kontrol` (`type_kontrol`, `id`)  VALUES('Startkontrol', 1);
INSERT INTO `type_kontrol` (`type_kontrol`, `id`)  VALUES('Proceskontrol', 2);
INSERT INTO `type_kontrol` (`type_kontrol`, `id`)  VALUES('Slutkontrol', 3);
INSERT INTO `type_kontrol` (`type_kontrol`, `id`)  VALUES('Modtagekontrol', 4);
INSERT INTO `type_kontrol_dokumentation` (`type_kontroldokumentation`, `id`)  VALUES('Billede', 1);
INSERT INTO `type_kontrol_dokumentation` (`type_kontroldokumentation`, `id`)  VALUES('F�lgeseddel', 2);
INSERT INTO `type_kontrol_dokumentation` (`type_kontroldokumentation`, `id`)  VALUES('Faktura', 3);
INSERT INTO `type_kontrol_dokumentation` (`type_kontroldokumentation`, `id`)  VALUES('Returseddel', 4);
INSERT INTO `type_kontrol_dokumentation` (`type_kontroldokumentation`, `id`)  VALUES('Produktcertifikat', 5);
INSERT INTO `Type_kontrolmetodetype` (`type_kontrolmetode`, `id`)  VALUES('visuel', 1);
INSERT INTO `Type_kontrolmetodetype` (`type_kontrolmetode`, `id`)  VALUES('lod', 2);
INSERT INTO `Type_kontrolmetodetype` (`type_kontrolmetode`, `id`)  VALUES('m�l', 3);
INSERT INTO `type_krav` (`type_krav`, `ID`)  VALUES('Udfald', 1);
INSERT INTO `type_krav` (`type_krav`, `ID`)  VALUES('Funktion', 2);
INSERT INTO `type_krav` (`type_krav`, `ID`)  VALUES('Finish', 3);
INSERT INTO `type_krav` (`type_krav`, `ID`)  VALUES('Holdbarhed', 4);
INSERT INTO `type_krav` (`type_krav`, `ID`)  VALUES('Milj�', 5);
INSERT INTO `type_krav_overgruppe` (`kravgruppe`, `ID`)  VALUES('Udfald', 1);
INSERT INTO `type_krav_overgruppe` (`kravgruppe`, `ID`)  VALUES('Funktion', 2);
INSERT INTO `type_krav_overgruppe` (`kravgruppe`, `ID`)  VALUES('Finish', 3);
INSERT INTO `type_krav_overgruppe` (`kravgruppe`, `ID`)  VALUES('Holdbarhed', 4);
INSERT INTO `type_krav_overgruppe` (`kravgruppe`, `ID`)  VALUES('Milj�', 5);
INSERT INTO `type_materiale` (`type_materiale`, `Materialekode`, `id`)  VALUES('Mursten', 0, 1);
INSERT INTO `type_materiale` (`type_materiale`, `Materialekode`, `id`)  VALUES('Maling', 0, 2);
INSERT INTO `Type_materiel` (`type_materiel`, `materielkode`, `id`)  VALUES('Kran', NULL, 1);
INSERT INTO `Type_materiel` (`type_materiel`, `materielkode`, `id`)  VALUES('Mobilkran', NULL, 2);
INSERT INTO `Type_materiel` (`type_materiel`, `materielkode`, `id`)  VALUES('Stillads', NULL, 3);
INSERT INTO `Type_materiel` (`type_materiel`, `materielkode`, `id`)  VALUES('F�llesmateriel', NULL, 4);
INSERT INTO `Type_materiel` (`type_materiel`, `materielkode`, `id`)  VALUES('Hejs', NULL, 5);
INSERT INTO `Type_materiel` (`type_materiel`, `materielkode`, `id`)  VALUES('Arbejdsplatform', NULL, 6);
INSERT INTO `Type_materiel` (`type_materiel`, `materielkode`, `id`)  VALUES('Lift', NULL, 7);
INSERT INTO `type_m�de` (`type_m�de`, `ID`)  VALUES('Projektm�de', 1);
INSERT INTO `type_m�de` (`type_m�de`, `ID`)  VALUES('Opstartm�de', 2);
INSERT INTO `type_m�de` (`type_m�de`, `ID`)  VALUES('Byggem�de', 3);
INSERT INTO `type_m�de` (`type_m�de`, `ID`)  VALUES('Formandsm�de', 4);
INSERT INTO `type_m�de` (`type_m�de`, `ID`)  VALUES('Sikkerhedsm�de', 5);
INSERT INTO `type_person` (`type_person`, `id`)  VALUES('Kontaktperson', 1);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Hjelm', 1);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('H�rev�rn', 2);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Sikkerhedsbriller', 3);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Sikkerhedssko', 4);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Handsker', 5);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Kn�beskytter', 6);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Bekl�dning', 7);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Forkl�de', 8);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Sk�rebukser', 9);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('St�vdragter/engangsdragt', 10);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Regnt�j', 11);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Termodragt', 12);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Syrefast t�j', 13);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('Faldseler', 14);
INSERT INTO `Type_v�rnemiddel` (`type_v�rnemiddel`, `id`)  VALUES('�ndedr�tsv�rn', 15);
