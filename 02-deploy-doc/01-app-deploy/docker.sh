docker pull mysql:8.0.36
docker pull nacos/nacos-server:1.4.1
docker pull rabbitmq:3.8.34
docker pull redis:6.2.7
docker pull xuxueli/xxl-job-admin:2.3.1
docker pull bitnami/minio:2022.9.7
docker pull elasticsearch:7.12.1
docker pull kibana:7.12.1
docker pull gogs:0.13.0
docker pull nginx:1.12.2



docker network create --driver bridge --subnet 172.199.0.0/24  --gateway 172.199.0.1 localdev_net

docker run --restart=unless-stopped -d --name mysql -v /d/work/repository/docker/app/mysql/conf/my.cnf -v  /d/work/repository/docker/app/mysql/data:/var/lib/mysql --network localdev_net --ip 172.199.0.2 -p 3306:3306  -e MYSQL_ROOT_PASSWORD='mysql@123456789!'  mysql:8.0.36



docker run -d -p 8848:8848  -e MODE=standalone -e PREFER_HOST_MODE=hostname -e SPRING_DATASOURCE_PLATFORM=mysql -e MYSQL_SERVICE_HOST=172.199.0.2 -e MYSQL_SERVICE_PORT=3306 -e  MYSQL_SERVICE_DB_NAME=nacos_config -e MYSQL_SERVICE_USER=root -e MYSQL_SERVICE_PASSWORD='mysql@123456789!' -e MYSQL_DATABASE_NUM=1  --network localdev_net --ip 172.199.0.3 --restart always --name nacos  nacos/nacos-server:1.4.1