#! /bin/bash

source <(grep = settings.ini | sed 's/ *= */=/g')

echo "Setting up DATABASE"
docker run \
      	--name mysql \
      	--detach \
	-v $(pwd)/data/:/var/lib/mysql \
	-v $(pwd)/etc/:/etc/mysql/conf.d \
	--net host \
	mysql/mysql-server:latest

echo "Waiting for startup"
sleep 60
OLD_PASS=$(docker logs mysql 2>&1 | grep PASSWORD | awk '{print $5}')


echo FIRST TIME? In another console, manually execute:
echo " docker exec -it --env OLD_PASS='$(docker logs mysql 2>&1 | grep PASSWORD | awk '{print $5}')' mysql bash"
echo '   mysql -uroot -p${OLD_PASS} --connect-expired-password'
echo "      ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';"
echo "      CREATE DATABASE ysd;"
echo "      CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}';"
echo "      GRANT ALL PRIVILEGES on ysd.* TO '${DB_USER}'@'%' WITH GRANT OPTION;"
echo "      FLUSH PRIVILEGES;"
echo "      quit"
echo "   exit"
echo "Then hit enter"
read





