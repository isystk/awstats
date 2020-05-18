
for file in `ls ./target | grep '.gz$'`; do
    gzip -d ./target/$file -d ./target
done

for file in `ls ./target`; do
    docker exec -it docker_apache_1 /usr/bin/perl /var/www/html/awstats.pl -updates -config=localhost -logfile=./target/$file
done
