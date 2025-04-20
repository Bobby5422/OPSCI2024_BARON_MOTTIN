#arret des conteneurs topics
cd topics 
docker-compose stop
echo "arrêt des conteneurs topic en cours"

#attente que les conteneurs topics s'arretent
sleep 20


#arret du frontend
echo "arreter le frontend sur le terminal corresondant avec q+enter"

#arret des conteneurs primaires
cd ..
docker-compose stop
echo "arrêt des conteneurs primaires en cours"