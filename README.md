# Centos Solr configuration

    yum update -y
    yum install samba samba-client cifs-utils -y

Mount a folder containing setup files at /mnt/install #

    mkdir /mnt/install_files
    cp -r /mnt/install* /mnt/install_files
    cd /mnt/install_files
    chmod +x setup.sh
    chmod +x crawlsites.sh
    ./setup.sh

add JAVA_HOME to point to /usr/lib/jvm/java-1.8.0.../jre
add solr to hosts with echo "127.0.0.1   solr" >> /etc/hosts

set the retry interval (db.fetch.interval.default) in nutch-site.xml to a number of seconds.  nutch won't re-fetch a url before that time expires.  Default: 30 days
configure which URLs to crawl using seed.txt and regex-urlfilter.txt