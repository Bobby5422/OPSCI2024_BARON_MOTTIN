#lancement des conteneurs primaires (strapiDB, strapi, zookeeper, kafka)
docker-compose up -d

#attente que strapi se lance
echo "conteneurs principaux en cours de lancement"
sleep 20

#lancement du frontend (sur fedora KDE)
echo "ouverture d'un terminal pour le frontend"
konsole --noclose -e bash -c "cd frontend && yarn run dev" &


#lancement des topics pour l'ajout des nouveaux produits
cd ../topics
docker-compose up -d
echo "lancement des conteneurs topic pour la mise à jour"