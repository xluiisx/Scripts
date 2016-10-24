#!/bin/sh

##########################################
## Odoo Backup
## Backup databases: BASE_DE_DATOS
##########################################

# Stop OpenERP Server
# docker exec -it carbotecnia sudo service odoo-server stop
# Dump DBs
path=/Users/Jahkahyah/Downloads
databases=`docker exec -it -u odoo carbotecnia psql -l -t | cut -d'|' -f1`
for i in $databases
echo 'Estas son las bases de datos' $i
do
        if [ "$i" != "template0" ] && [ "$i" != "template1" ] && [ "$i" != "postgres" ] && [ "$i" != "?" ] && [ "$i" != " " ] ; then
        	date=`date +"%d%m%Y_%H%M%N"`
            if [ ! -d ${path}/${i} ]; then
                echo "No hay directorio"
              mkdir /Users/Jahkahyah/Downloads/${i}
            fi
            filename="${path}/${i}/${i}_${date}.sql"
            echo Dumping $i to $path $i
            echo "Dumping" $i "to" $path $i
            docker exec -t -u odoo carbotecnia pg_dump -E UTF-8 -p 5432 -F p -b --no-owner > $filename $i
            gzip $filename      	
                
        fi
done

# Start OpenERP Server
# docker exec -it carbotecnia sudo service odoo-server start

exit 0
