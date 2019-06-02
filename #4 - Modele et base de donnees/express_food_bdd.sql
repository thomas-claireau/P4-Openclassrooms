DROP DATABASE IF EXISTS express_food;
-- -----------------------------------------------------
-- Schema Express_Food
-- -----------------------------------------------------
CREATE DATABASE `Express_Food` CHARACTER SET UTF8 ;
USE `Express_Food` ;

-- -----------------------------------------------------
-- Table `Express_Food`.`acheteur`
-- -----------------------------------------------------
CREATE TABLE `Express_Food`.`acheteur` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`),
  `nom` VARCHAR(70),
  `prenom` VARCHAR(70),
  `raison_sociale` VARCHAR(70),
  `email` VARCHAR(70),
  `telephone` VARCHAR(70),
  `identifiant` VARCHAR(70),
  `mdp` VARCHAR(70)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Express_Food`.`adresse_acheteur`
-- -----------------------------------------------------
CREATE TABLE `Express_Food`.`adresse_acheteur` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`),
  `num_voie` SMALLINT,
  `voie` VARCHAR(70),
  `code_postal` MEDIUMINT,
  `id_acheteur` SMALLINT NOT NULL,
  CONSTRAINT `fk_adresse_acheteur_acheteur`
    FOREIGN KEY (`id_acheteur`)
    REFERENCES `Express_Food`.`acheteur` (`id`)
)
ENGINE = InnoDB;

CREATE INDEX `fk_adresse_acheteur_acheteur_idx` ON `Express_Food`.`adresse_acheteur` (`id_acheteur` ASC);


-- -----------------------------------------------------
-- Table `Express_Food`.`plat_jour`
-- -----------------------------------------------------
CREATE TABLE `Express_Food`.`plat_jour` (
  `reference_plats` MEDIUMINT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`reference_plats`),
  `date_ajout` DATE NOT NULL,
  `nom_plat_1` VARCHAR(70) NOT NULL,
  `description_plat_1` TEXT NOT NULL,
  `prix_plat_1` DECIMAL(5,2) NOT NULL,
  `nom_plat_2` VARCHAR(70) NOT NULL,
  `description_plat_2` TEXT NOT NULL,
  `prix_plat_2` DECIMAL(5,2) NOT NULL
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Express_Food`.`dessert_jour`
-- -----------------------------------------------------
CREATE TABLE `Express_Food`.`dessert_jour` (
  `reference_desserts` MEDIUMINT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`reference_desserts`),
  `date_ajout` DATE NOT NULL,
  `nom_dessert_1` VARCHAR(70) NOT NULL,
  `description_dessert_1` TEXT NOT NULL,
  `prix_dessert_1` DECIMAL(5,2) NOT NULL,
  `nom_dessert_2` VARCHAR(70) NOT NULL,
  `description_dessert_2` TEXT NOT NULL,
  `prix_dessert_2` DECIMAL(5,2) NOT NULL
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Express_Food`.`commande`
-- -----------------------------------------------------
CREATE TABLE `Express_Food`.`commande` (
  `id` MEDIUMINT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`),
  `date_commande` DATE,
  `prix_commande` DECIMAL(5,2),
  `nb_plat_1` SMALLINT,
  `nb_plat_2` SMALLINT,
  `nb_dessert_1` SMALLINT,
  `nb_dessert_2` SMALLINT,
  `id_acheteur` SMALLINT NOT NULL,
  `reference_plats` MEDIUMINT NOT NULL,
  `reference_desserts` MEDIUMINT NOT NULL,
  CONSTRAINT `fk_commande_acheteur1`
    FOREIGN KEY (`id_acheteur`)
    REFERENCES `Express_Food`.`acheteur` (`id`),
  CONSTRAINT `fk_commande_plat_jour1`
    FOREIGN KEY (`reference_plats`)
    REFERENCES `Express_Food`.`plat_jour` (`reference_plats`),
  CONSTRAINT `fk_commande_dessert_jour1`
    FOREIGN KEY (`reference_desserts`)
    REFERENCES `Express_Food`.`dessert_jour` (`reference_desserts`)
)
ENGINE = InnoDB;

CREATE INDEX `fk_commande_acheteur1_idx` ON `Express_Food`.`commande` (`id_acheteur` ASC);

CREATE INDEX `fk_commande_plat_jour1_idx` ON `Express_Food`.`commande` (`reference_plats` ASC);

CREATE INDEX `fk_commande_dessert_jour1_idx` ON `Express_Food`.`commande` (`reference_desserts` ASC);


-- -----------------------------------------------------
-- Table `Express_Food`.`livreur`
-- -----------------------------------------------------
CREATE TABLE `Express_Food`.`livreur` (
  `id` TINYINT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`),
  `nom` VARCHAR(70) NOT NULL,
  `prenom` VARCHAR(70) NOT NULL,
  `latitude` DECIMAL(8,6) NOT NULL,
  `longitude` DECIMAL(8,6) NOT NULL,
  `id_commande` MEDIUMINT,
  CONSTRAINT `fk_livreur_commande1`
    FOREIGN KEY (`id_commande`)
    REFERENCES `Express_Food`.`commande` (`id`)
)
ENGINE = InnoDB;

CREATE INDEX `fk_livreur_commande1_idx` ON `Express_Food`.`livreur` (`id_commande` ASC);


-- -----------------------------------------------------
-- Table `Express_Food`.`statut_commande`
-- -----------------------------------------------------
CREATE TABLE `Express_Food`.`statut_commande` (
  `en_cours` TINYINT(1) NOT NULL,
  `livree` TINYINT(1) NOT NULL,
  `reglee` TINYINT(1) NOT NULL,
  `id_commande` MEDIUMINT NOT NULL,
  `id_livreur` TINYINT,
  CONSTRAINT `fk_statut_commande_livreur1`
    FOREIGN KEY (`id_livreur`)
    REFERENCES `Express_Food`.`livreur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_statut_commande_commande1`
    FOREIGN KEY (`id_commande`)
    REFERENCES `Express_Food`.`commande` (`id`)
)
ENGINE = InnoDB;

CREATE INDEX `fk_statut_commande_livreur1_idx` ON `Express_Food`.`statut_commande` (`id_livreur` ASC);

CREATE INDEX `fk_statut_commande_commande1_idx` ON `Express_Food`.`statut_commande` (`id_commande` ASC);


-- -----------------------------------------------------
-- Table `Express_Food`.`statut_livreur`
-- -----------------------------------------------------
CREATE TABLE `Express_Food`.`statut_livreur` (
  `libre` TINYINT(1) NOT NULL,
  `en_cours_livraison` TINYINT(1) NOT NULL,
  `livraison_terminee` TINYINT(1) NOT NULL,
  `indisponible` TINYINT(1) NOT NULL,
  `id_livreur` TINYINT NOT NULL,
  CONSTRAINT `fk_statut_livreur_livreur1`
    FOREIGN KEY (`id_livreur`)
    REFERENCES `Express_Food`.`livreur` (`id`)
)
ENGINE = InnoDB;

CREATE INDEX `fk_statut_livreur_livreur1_idx` ON `Express_Food`.`statut_livreur` (`id_livreur` ASC);

-- -----------------------------------------------------
-- Insertion Valeurs Par défaut pour la bdd express_food
-- -----------------------------------------------------
INSERT INTO `acheteur` (`id`, `nom`, `prenom`, `raison_sociale`, `email`, `telephone`, `identifiant`, `mdp`) VALUES (NULL, 'Claireau', 'Thomas', 'Particulier', 'thomas.claireau@gmail.com', '0600000000', 'tclaireau', 'test'), (NULL, 'Dupont', 'Jean', 'Particulier', 'jean.dupont@gmail.com', '0600000000', 'jdupont', 'test'), (NULL, 'Maillé', 'Carole', 'Particulier', 'carolle.maille@outlook.com', '0600000000', 'cmaille', 'test'), (NULL, 'Orange', NULL, 'Entreprise', 'contact@orange.fr', '0200000000', 'orange', 'test'), (NULL, 'Fridich', 'Damien', 'Particulier', 'damien.fridich', '0600000000', 'dfridich', 'test');

INSERT INTO `adresse_acheteur` (`id`, `num_voie`, `voie`, `code_postal`, `id_acheteur`) VALUES (NULL, '3', 'Rue Rennée Prevert', '35000', '1'), (NULL, '2', 'Rue des Maures', '44000', '2'), (NULL, '45', 'Avenue Charles de Gaulle', '85000', '3'), (NULL, '10', 'Rue Halévy', '75009', '4'), (NULL, '14', 'Boulevard du Massacre', '44240', '5');

INSERT INTO `plat_jour` (`reference_plats`, `date_ajout`, `nom_plat_1`, `description_plat_1`, `prix_plat_1`, `nom_plat_2`, `description_plat_2`, `prix_plat_2`) VALUES (NULL, '2019-05-01', 'Blanquette de veau', 'Description du plat n°1', '7.20', 'Filet mignon en croute', 'Description du plat n°2', '6.50'), (NULL, '2019-05-04', 'Lasagne a la bolognaise', 'Description du plat n°1', '6.30', 'Sauté de veau au chorizo', 'Description du plat n°2', '7.30'), (NULL, '2019-05-02', 'Hachis Parmentier', 'Description du plat n°1', '7.60', 'Boeuf bourguignon', 'Description du plat n°2', '6.10'), (NULL, '2019-05-03', 'Poulet a la moutarde', 'Description du plat n°1', '7.0', 'Chili con carne', 'Description du plat n°2', '8.0'), (NULL, '2019-04-30', 'Couscous poulet merguez', 'Description du plat n°1', '8.10', 'Quiche lorraine', 'Description du plat n°2', '6.70');

INSERT INTO `dessert_jour` (`reference_desserts`, `date_ajout`, `nom_dessert_1`, `description_dessert_1`, `prix_dessert_1`, `nom_dessert_2`, `description_dessert_2`, `prix_dessert_2`) VALUES (NULL, '2019-05-01', 'Tiramisu', 'Description dessert n°1', '3.50', 'Meringue', 'Description dessert n°2', '3.40'), (NULL, '2019-05-04', 'Crumble aux pommes', 'Description dessert n°1', '3.70', 'Pancakes', 'Description dessert n°2', '3.20'), (NULL, '2019-05-02', 'Tarte aux pommes', 'Description dessert n°1', '3.10', 'Cake au chocolat', 'Description dessert n°2', '3.80'), (NULL, '2019-05-03', 'Cannelés bordelais', 'Description dessert n°1', '4.10', 'Panna cotta', 'Description dessert n°2', '3.0'), (NULL, '2019-04-30', 'Tiramisu aux spéculoos', 'Description dessert n°1', '4.20', 'Fondant au chocolat', 'Description dessert n°2', '3.30');

INSERT INTO `commande` (`id`, `date_commande`, `prix_commande`, `nb_plat_1`, `nb_plat_2`, `nb_dessert_1`, `nb_dessert_2`, `id_acheteur`, `reference_plats`, `reference_desserts`) VALUES (NULL, '2019-05-01', '10.70', '1', '0', '1', '0', '2', '1', '1'), (NULL, '2019-05-04', '20.50', '1', '1', '1', '1', '3', '2', '2'), (NULL, '2019-05-02', '9.90', '0', '1', '0', '1', '1', '3', '3'), (NULL, '2019-05-03', '10', '1', '0', '0', '1', '5', '4', '4'), (NULL, '2019-04-30', '66.90', '3', '3', '3', '3', '4', '5', '5');

INSERT INTO `livreur` (`id`, `nom`, `prenom`, `latitude`, `longitude`, `id_commande`) VALUES (NULL, 'Phaneuf', 'Christophe', '-1.556897', '47.218371', NULL), (NULL, 'Hétu', 'Denis', '-1.556897', '47.218371', '2'), (NULL, 'Blais', 'Jules', '-1.556897', '47.218371', '3'), (NULL, 'Artois', 'Marc', '-1.556897', '47.218371', NULL), (NULL, 'Richard', 'Maxime', '-1.556897', '47.218371', '5');

INSERT INTO `statut_livreur` (`libre`, `en_cours_livraison`, `livraison_terminee`, `indisponible`, `id_livreur`) VALUES ('1', '0', '0', '0', '1'), ('0', '1', '0', '0', '2'), ('0', '1', '0', '0', '3'), ('0', '0', '1', '1', '4'), ('0', '1', '0', '0', '5');

INSERT INTO `statut_commande` (`en_cours`, `livree`, `reglee`, `id_commande`, `id_livreur`) VALUES ('0', '1', '1', '1', '1'), ('1', '0', '1', '2', '2'), ('1', '0', '0', '3', '3'), ('0', '1', '1', '4', '5'), ('1', '0', '1', '5', '5');