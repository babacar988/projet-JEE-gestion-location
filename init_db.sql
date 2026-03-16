-- Script d'initialisation de la base de données ImmoGest
-- PostgreSQL

CREATE DATABASE gestion_locations;
\c gestion_locations;

-- Les tables sont créées automatiquement par Hibernate (hbm2ddl.auto=update)
-- Ce script insère les données de démonstration

-- Mot de passe hashé avec BCrypt pour tous : password = "admin123" etc.
-- Utiliser l'application pour créer via l'inscription, ou remplacer les hash ci-dessous

INSERT INTO utilisateurs (email, mot_de_passe, nom, prenom, telephone, role, actif, date_creation)
VALUES 
  ('admin@immogest.fr', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMUUqVRZMEMH5Z1G8Nb3L5W1T2', 
   'Admin', 'Super', '01 00 00 00 00', 'ADMIN', true, NOW()),
  ('proprio@immogest.fr', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMUUqVRZMEMH5Z1G8Nb3L5W1T2',
   'Dupont', 'Pierre', '06 10 20 30 40', 'PROPRIETAIRE', true, NOW()),
  ('locataire@immogest.fr', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMUUqVRZMEMH5Z1G8Nb3L5W1T2',
   'Martin', 'Sophie', '06 50 60 70 80', 'LOCATAIRE', true, NOW());

COMMIT;
