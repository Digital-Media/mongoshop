# Installation of fhooe-mongo-dock

Open Powershell (PS) or other Terminal (prompt my be different then).

## Docker

See [fhooe-mongo-dock](https://github.com/Digital-Media/fhooe-mongo-dock)

## Get Repo

If you use private repos built by [Upper Austria University of Applied Sciences (FH Oberösterreich), Hagenberg Campus](https://www.fh-ooe.at/en/hagenberg-campus/).

```shell
docker exec -it mongoapp /bin/bash -c "cd /var/www/html && git clone https://github.com/Digital-Media/mongoshop.git"
```
```shell
docker exec -it mongoapp /bin/bash -c "cd /var/www/html/mongoshop && composer install && chmod -R 777 *"
```
```shell
docker exec -it mongoapp /bin/bash -c "cd /var/www/html/mongoshop && composer update"
```
access mongodb via commandline in container
```
docker exec -it mongo /bin/bash -c mongo
```
access container mongo-express via commandline
```
docker exec -it mongo-express /bin/bash
```
access mongo-express vis browser: `http://localhost:8083`
or [download](https://www.mongodb.com/try/download/compass) and install MongoDB Compass for a GUI.

## Cloud

Get a free MongoDB Atlas account or sign in with Google [HERE](https://www.mongodb.com/cloud/atlas/register).
