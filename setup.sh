#!/bin/bash
yum update -y
yum install -y java-1.8.0-openjdk-headless.x86_64 wget lsof
mkdir /install
cd /install

# add JAVA_HOME
echo "export JAVA_HOME=/usr/lib/jvm/jre-1.8.0" >> /etc/profile

# download and install Solr
wget https://apache.claz.org/lucene/solr/6.6.5/solr-6.6.5.tgz
tar -xzf solr-6.6.5.tgz
mv solr-6.6.5 /opt/solr

#download and install Nutch 1.15
wget https://www.apache.org/dist/nutch/1.15/apache-nutch-1.15-bin.tar.gz
tar -xzf apache-nutch-1.15-bin.tar.gz
mv apache-nutch-1.15 /opt/nutch


# Configure Solr
# choose a name for your solr core (this creates a variable with the core name; in this example intouchsearch)
core=intouchsearch
cd /opt/solr
cp -r server/solr/configsets/basic_configs server/solr/configsets/${core}
#copy the schema file over from the nutch install
cp /opt/nutch/conf/schema.xml /opt/solr/server/solr/configsets/${core}/conf
rm /opt/solr/server/solr/configsets/${core}/conf/managed-schema -f
bin/solr start -force
bin/solr create -c ${core} -d server/solr/configsets/${core}/conf/ -force

# add a hosts file entry for solr
echo "127.0.0.1   solr" >> /etc/hosts

# expects a mounted point at /mnt/install_files
cd /mnt/install_files
\cp conf/* /opt/nutch/conf/
cd /opt/nutch
echo "Changing the index writer to write to ${core}"
sed -i -e "s/8983\/solr\/nutch/8983\/solr\/${core}/" ./conf/index-writers.xml
mkdir urls
cp /mnt/install_files/seed.txt urls
