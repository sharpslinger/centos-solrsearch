# Centos Solr configuration

Setup a CentOS VM or machine.  Install prerequisites for file sharing:

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

set the retry interval (db.fetch.interval.default) by adding the following to nutch-site.xml as a number of seconds.  nutch won't re-fetch a url before that time expires.  Default: 30 days

    <property>
      <name>db.fetch.interval.default</name>
      <value>86000</value>
      <description>The default number of seconds between re-fetches of a page.  86400 is 1 day.
      </description>
    </property>

### To run a search:
Configure which URLs to crawl using seed.txt and regex-urlfilter.txt