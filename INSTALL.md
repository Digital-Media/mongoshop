# Installation of fhooe-mongo-dock

Open Powershell (PS) or other Terminal (prompt my be different then).

## Docker

See [fhooe-mongo-dock](https://github.com/Digital-Media/fhooe-mongo-dock)

### Using Docker to get Repo

If you use private repos built by [Upper Austria University of Applied Sciences (FH Oberösterreich), Hagenberg Campus](https://www.fh-ooe.at/en/hagenberg-campus/).

```shell
docker exec -it webapp /bin/bash -c "cd /var/www/html && git clone https://github.com/Digital-Media/mongoshop.git"
```
```shell
docker exec -it webapp /bin/bash -c "cd /var/www/html/webshop && composer install"
```
```shell
docker exec -it webapp /bin/bash -c "cd /var/www/html/webshop && composer update"