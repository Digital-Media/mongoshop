# Installation of fhooe-mongo-dock

Open Powershell (PS) or other Terminal (prompt my be different then).

## Docker

For installation of Docker environment see [fhooe-mongo-dock](https://github.com/Digital-Media/fhooe-mongo-dock)

## Get Repo

```shell
docker exec -it mongoapp /bin/bash -c "cd /var/www/html && git clone https://github.com/Digital-Media/mongoshop.git"
```
```shell
docker exec -it mongoapp /bin/bash -c "cd /var/www/html/mongoshop && composer install && chmod -R 777 *"
```
```shell
docker exec -it mongoapp /bin/bash -c "cd /var/www/html/mongoshop && composer update"
```

## Cloud

Get a free MongoDB Atlas account or sign in with Google [HERE](https://www.mongodb.com/cloud/atlas/register).
