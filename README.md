# OPSCI2024

> Infrastructure complète avec objets connectés et architecture événementielle

## Table des matières

- [Description](#description)  
- [Objectifs](#objectifs)  
- [Structure du projet](#structure-du-projet)  
- [Prérequis](#prérequis)  
- [Installation & Déploiement](#installation--déploiement)  
  - [Configuration des variables d’environnement](#configuration-des-variables-denvironnement)  
  - [Déploiement de l’infrastructure](#déploiement-de-linfrastructure)  
  - [Lancement du frontend React](#lancement-du-frontend-react)  
  - [Lancement des Producers & Consumers](#lancement-des-producers--consumers)  
- [Usage](#usage)  
- [Auteurs](#auteurs)

---

## Description

Le projet **OPSCI2024** est une plateforme de gestion de produits combinant :
1. Une infrastructure dockerisée (Strapi CMS + base de données PostgreSQL + Frontend React)  
2. Une architecture événementielle basée sur Kafka pour traiter des flux de données en temps réel.

## Objectifs

- **Déployer** une infrastructure complète backend (Strapi), base de données et frontend UI.  
- **Mettre en place** un bus d’événements Kafka (topics, producers, consumers).  
- **Orchestrer** les flux de données produits & stock.

## Structure du projet

```plaintext
OPSCI2024-main/
├── .env                     # variables d’environnement Strapi & DB
├── .gitignore
├── docker-compose.yml       # orchestration Strapi, Postgres, Kafka, Zookeeper
├── backend/                 # projet Strapi (CMS)
│   ├── .env                 # env Strapi
│   ├── config/              # configuration Strapi (admin, api, db, plugins)
│   ├── src/api/product/     # contenu du Content Type "product" (schema, controllers, services)
│   ├── database/migrations/ # migrations SQL
│   └── dockerfile           # build de l’image Strapi
├── data/                    # mise à jour des données (en plus de celle déjà existante dans la DB)
│   ├── products.csv
│   ├── events.csv
│   └── stocks.csv
├── frontend/                # application React + Vite
│   ├── src/
│   │   ├── App.tsx
│   │   ├── conf.ts          # URL Strapi & TOKEN API
│   │   └── assets/          # images et styles
│   └── vite.config.ts
└── topics/                  # configuration & Docker Compose pour producers/consumers
    ├── .env                 # BROKER_URL & STRAPI_TOKEN
    └── docker-compose.yml   # conteneurs topics
```

##  Prérequis

- **Docker** ≥ 20.10 & **Docker Compose** ≥ 1.29  
- **Node.js** ≥ 16 & **Yarn** ou **npm**  
- Copier/adapter le fichier `.env` à la racine et le fichier `topics/.env`  

## Installation & Déploiement

### Configuration des variables d’environnement

1. À la racine du projet, créez ou dupliquez le fichier `.env` et renseignez :
   ```env
   # Server
   HOST=0.0.0.0
   PORT=1337

   # Secrets
   APP_KEYS=<valeurs_cryptographiques>
   API_TOKEN_SALT=<token_salt>
   ADMIN_JWT_SECRET=<admin_jwt_secret>
   TRANSFER_TOKEN_SALT=<transfer_token_salt>

   # Database
   DATABASE_CLIENT=postgres
   DATABASE_HOST=strapiDB
   DATABASE_PORT=5432
   DATABASE_NAME=strapiDB
   DATABASE_USERNAME=strapiDB
   DATABASE_PASSWORD=opsci2024
   DATABASE_SSL=false

   # Application
   NODE_ENV=development
   JWT_SECRET=<jwt_secret>
   ```
2. Dans `topics/.env`, vérifiez ou mettez à jour :
   ```env
   BROKER_URL=kafka:9092
   STRAPI_TOKEN=<votre_api_token_strapi>
   ```

### Déploiement de l’infrastructure

Lancez Strapi, PostgreSQL, Zookeeper et Kafka en une seule commande :

```bash
docker-compose up -d
```

> **Endpoints**  
> - Strapi : http://localhost:1337  
> - PostgreSQL : port 5432  
> - Zookeeper : port 2181  
> - Kafka : port 9092

### Lancement du frontend React

```bash
cd frontend
npm install       # ou yarn install
npm run dev       # démarre Vite sur http://localhost:5173
```

### Lancement des Producers & Consumers

```bash
cd topics
docker-compose up -d
```

> Les containers vont publier/consommer des messages sur les topics : `product`, `event`, `stock`, `errors`.

---

## Usage

1. Ouvrez l’admin Strapi : http://localhost:1337/admin  
2. Vérifiez la collection **Product** (schéma défini dans `backend/src/api/product/content-types/schema.json`).  
3. Ajoutez/modifiez/supprimez des produits (avec un déclenchemant des events Kafka).  
4. Surveillez les logs des producers et consumers (`docker-compose logs -f product-consumer`, etc.).  
5. Accédez au frontend React pour visualiser la liste des produits en temps réel.

---

## Résultats attendus

- **Interface Strapi** opérationnelle pour CRUD produits.  
- **Frontend React** affichant dynamiquement les produits via l’API Strapi + token.  
- **Architecture Kafka** fonctionnelle pour traiter en temps réel :  
  - `product` – création de produits  
  - `event` – enregistrement d’événements  
  - `stock` – mises à jour de stock  
  - `errors` – gestion des erreurs

## Auteurs

- Binôme : Ludovic BARON 21127210, Elliot MOTTIN 21206296
- Références externes :  
  - Frontend : [arthurescriou/opsci-strapi-frontend](https://github.com/arthurescriou/opsci-strapi-frontend)  
  - Producers/Consumers : organisation [opsci-su](https://github.com/opsci-su)  

