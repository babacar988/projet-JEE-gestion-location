# 🏢 ImmoGest — Application Web JEE de Gestion des Locations d'Immeubles

![Java](https://img.shields.io/badge/Java-17-orange?logo=java)
![Jakarta EE](https://img.shields.io/badge/Jakarta_EE-10-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql)
![Hibernate](https://img.shields.io/badge/Hibernate-6.4-59666C?logo=hibernate)
![License](https://img.shields.io/badge/License-MIT-green)

**ImmoGest** est une application web complète développée en Java Enterprise Edition (Jakarta EE) pour la gestion de locations d'immeubles. Elle offre des interfaces dédiées aux **administrateurs**, **propriétaires** et **locataires**.

---

## 📋 Table des matières

- [Fonctionnalités](#fonctionnalités)
- [Architecture](#architecture)
- [Technologies](#technologies)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Configuration](#configuration)
- [Structure du projet](#structure-du-projet)
- [Comptes de démo](#comptes-de-démo)
- [API & Endpoints](#api--endpoints)

---

## ✨ Fonctionnalités

### 👔 Administration
- Tableau de bord avec statistiques en temps réel
- Gestion complète des immeubles (CRUD)
- Gestion des unités de location (CRUD)
- Gestion des contrats avec génération de références
- Suivi des paiements et relances automatiques
- Gestion des utilisateurs (propriétaires, locataires)
- Validation des demandes de location
- Rapports et statistiques

### 🏗️ Propriétaire
- Vue de ses immeubles et unités
- Suivi des contrats actifs
- Tableau de bord financier

### 🏠 Locataire
- Recherche de logements avec filtres avancés
- Envoi de demandes de location
- Consultation et suivi des contrats
- Historique des paiements

---
## 🏛️ Architecture

L'application suit le pattern **MVC** avec une architecture en couches :

```
┌─────────────────────────────────────────────┐
│  VUES (JSP + HTML/CSS/JS)                   │
│  views/admin/ · views/locataire/ · shared/  │
├─────────────────────────────────────────────┤
│  CONTRÔLEURS (Servlets Jakarta EE)          │
│  LoginServlet · AdminDashboard · Offres...  │
├─────────────────────────────────────────────┤
│  SERVICES (Business Logic)                  │
│  UtilisateurService · ImmeubleService ...   │
├─────────────────────────────────────────────┤
│  DAO (Data Access Objects)                  │
│  GenericDAO · ImmeubleDAO · PaiementDAO ... │
├─────────────────────────────────────────────┤
│  ENTITÉS JPA (Hibernate ORM)                │
│  Utilisateur · Immeuble · UniteLocation ... │
├─────────────────────────────────────────────┤
│  BASE DE DONNÉES (PostgreSQL 16)            │
└─────────────────────────────────────────────┘
```

---

## 🛠️ Technologies

| Composant | Technologie | Version |
|-----------|-------------|---------|
| Langage | Java | 17 |
| Framework | Jakarta EE | 10.0 |
| Serveur | Apache Tomcat | 10.1 |
| ORM | Hibernate | 6.4.4 |
| Base de données | PostgreSQL | 16 |
| Build | Maven | 3.9+ |
| Sécurité (hash) | jBCrypt | 0.4 |
| Sérialisation JSON | Jackson | 2.16 |
| Logs | Logback | 1.4 |
| Tests | JUnit 5 + Mockito | 5.10 |
| IDE recommandé | IntelliJ IDEA | 2024+ |

---

## ⚙️ Prérequis

- **JDK 17** ou supérieur
- **Maven 3.9+**
- **PostgreSQL 14+**
- **Apache Tomcat 10.1+**
- **IntelliJ IDEA** (recommandé)

---

## 🚀 Installation

### 1. Cloner le projet

```bash
git clone https://github.com/votre-user/gestion-locations.git
cd gestion-locations
```

### 2. Créer la base de données PostgreSQL

```sql
CREATE DATABASE gestion_locations;
CREATE USER immogest_user WITH ENCRYPTED PASSWORD 'votre_mdp';
GRANT ALL PRIVILEGES ON DATABASE gestion_locations TO immogest_user;
```

### 3. Configurer la connexion

Éditer `src/main/resources/META-INF/persistence.xml` :

```xml
<property name="jakarta.persistence.jdbc.url" 
          value="jdbc:postgresql://localhost:5432/gestion_locations"/>
<property name="jakarta.persistence.jdbc.user" value="immogest_user"/>
<property name="jakarta.persistence.jdbc.password" value="votre_mdp"/>
```

### 4. Compiler et déployer

```bash
# Compiler le projet
mvn clean package

# Déployer sur Tomcat
cp target/gestion-locations.war $TOMCAT_HOME/webapps/
```

### 5. Démarrer Tomcat

```bash
$TOMCAT_HOME/bin/startup.sh  # Linux/Mac
$TOMCAT_HOME\bin\startup.bat # Windows
```

### 6. Accéder à l'application

```
http://localhost:8080/gestion-locations/
```

---

## ⚙️ Configuration IntelliJ IDEA

1. **Ouvrir le projet** : `File → Open` → sélectionner le dossier racine
2. **Configurer Tomcat** : `Run → Edit Configurations → + → Tomcat Server → Local`
   - Server tab : sélectionner Tomcat 10.1
   - Deployment tab : ajouter le artifact `gestion-locations:war`
   - Application context : `/gestion-locations`
3. **Configurer JDK** : `File → Project Structure → SDK → Java 17`
4. **Importer Maven** : Maven s'importe automatiquement

---

## 📂 Structure du projet

```
gestion-locations/
├── src/
│   ├── main/
│   │   ├── java/com/gestionlocations/
│   │   │   ├── entities/          # Entités JPA
│   │   │   │   ├── Utilisateur.java
│   │   │   │   ├── Immeuble.java
│   │   │   │   ├── UniteLocation.java
│   │   │   │   ├── ContratLocation.java
│   │   │   │   ├── Paiement.java
│   │   │   │   └── DemandeLocation.java
│   │   │   ├── dao/               # Couche accès données
│   │   │   │   ├── GenericDAO.java
│   │   │   │   ├── UtilisateurDAO.java
│   │   │   │   ├── ImmeubleDAO.java
│   │   │   │   ├── UniteLocationDAO.java
│   │   │   │   ├── ContratLocationDAO.java
│   │   │   │   ├── PaiementDAO.java
│   │   │   │   └── DemandeLocationDAO.java
│   │   │   ├── services/          # Logique métier
│   │   │   │   ├── UtilisateurService.java
│   │   │   │   ├── ImmeubleService.java
│   │   │   │   ├── UniteLocationService.java
│   │   │   │   ├── ContratLocationService.java
│   │   │   │   └── PaiementService.java
│   │   │   ├── servlets/          # Contrôleurs HTTP
│   │   │   │   ├── LoginServlet.java
│   │   │   │   ├── LogoutServlet.java
│   │   │   │   ├── RegisterServlet.java
│   │   │   │   ├── AdminDashboardServlet.java
│   │   │   │   ├── LocataireDashboardServlet.java
│   │   │   │   ├── ImmeubleServlet.java
│   │   │   │   └── OffresServlet.java
│   │   │   ├── filters/
│   │   │   │   └── AuthFilter.java
│   │   │   └── utils/
│   │   │       ├── HibernateUtil.java
│   │   │       ├── PasswordUtil.java
│   │   │       └── ReferenceGenerator.java
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       ├── assets/
│   │       │   ├── css/main.css   # Design System complet
│   │       │   └── js/
│   │       ├── views/
│   │       │   ├── shared/
│   │       │   │   ├── login.jsp
│   │       │   │   ├── register.jsp
│   │       │   │   └── navbar.jsp
│   │       │   ├── admin/
│   │       │   │   ├── dashboard.jsp
│   │       │   │   ├── immeubles-list.jsp
│   │       │   │   └── immeuble-form.jsp
│   │       │   └── locataire/
│   │       │       ├── dashboard.jsp
│   │       │       └── offres.jsp
│   │       └── index.jsp
│   └── test/
│       └── java/com/gestionlocations/
├── init_db.sql              # Script SQL de démo
├── pom.xml
└── README.md
```

---

## 👤 Comptes de démo

| Rôle | Email | Mot de passe |
|------|-------|--------------|
| Administrateur | admin@immogest.fr | admin123 |
| Propriétaire | proprio@immogest.fr | proprio123 |
| Locataire | locataire@immogest.fr | locataire123 |

---

## 🔐 Sécurité

- Mots de passe hashés avec **BCrypt** (facteur 12)
- Protection des routes par **Filtre Jakarta** (AuthFilter)
- Contrôle des rôles sur chaque route
- Sessions sécurisées (expiration 60 min)
- Pas de mots de passe en clair

---

## 🌐 Endpoints principaux

| URL | Méthode | Description |
|-----|---------|-------------|
| `/login` | GET/POST | Connexion |
| `/logout` | GET | Déconnexion |
| `/register` | GET/POST | Inscription locataire |
| `/admin/dashboard` | GET | Tableau de bord admin |
| `/admin/immeubles` | GET/POST | Gestion immeubles |
| `/admin/unites` | GET/POST | Gestion unités |
| `/admin/contrats` | GET/POST | Gestion contrats |
| `/admin/paiements` | GET/POST | Gestion paiements |
| `/admin/utilisateurs` | GET/POST | Gestion utilisateurs |
| `/locataire/dashboard` | GET | Espace locataire |
| `/locataire/offres` | GET | Offres disponibles |
| `/locataire/demande` | GET/POST | Demande de location |

---

## 🎨 Design

L'interface utilise un **design system** sur mesure :
- **Palette** : Deep Navy (#0F1B2D) + Gold (#C9A84C) + Cream (#FAF7F2)
- **Typographie** : Playfair Display (titres) + DM Sans (texte)
- **Composants** : Cards, badges, tables, formulaires, barres de navigation
- **Responsive** : Adaptatif mobile/tablette/desktop

---

## 📄 Licence

Projet développé dans le cadre d'un cours JEE — Usage éducatif.

---

*Développé avec ❤️ en Jakarta EE · Hibernate · PostgreSQL*
