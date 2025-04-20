# Utilisation de l'image Node.js
FROM node:18-alpine

# Définition du répertoire de travail
WORKDIR /app

# Copier les fichiers package.json et yarn.lock
COPY package.json yarn.lock ./

# Installer les dépendances
RUN yarn install

# Copier le reste des fichiers Strapi
COPY . .

# Exposer le port 1337 utilisé par Strapi
EXPOSE 1337

# Démarrer Strapi
CMD ["yarn", "develop"]
