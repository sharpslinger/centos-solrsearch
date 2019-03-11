# Centos Solr configuration

Setup a CentOS VM or machine.  Install prerequisites for file sharing:

    yum update -y
    yum install samba samba-client cifs-utils -y

### Installing files and tools
Mount a folder containing setup files at /mnt/install #

    mkdir /mnt/install_files
    cp -r /mnt/install* /mnt/install_files
    cd /mnt/install_files
    chmod +x setup.sh
    chmod +x crawlsites.sh
    ./setup.sh

Alternatively, archive these files and SCP them to the target machine
    git archive -o searchfiles.tar.gz --format=tar.gz
    scp searchfiles.tar.gz name@SERVER_NAME_OR_IP:/mnt/install_files/
    ssh name@SERVER_NAME_OR_IP
    $> cd /mnt/install_files
    $> tar -xzf searchfiles.tar.gz
    $> chmod +x setup.sh
    $> chmod +x crawlsites.sh

### Customization / Troubleshooting
Ensure JAVA_HOME points to a valid JRE if a separate JDK/JRE was installed.  The following has been set in /etc/profile:
    export JAVA_HOME=/usr/lib/jvm/jre-1.8.0
    
Ensure hosts entry exists; the following was run during setup:
    echo "127.0.0.1   solr" >> /etc/hosts

Set the retry interval (db.fetch.interval.default) by adding the following to /opt/nutch/conf/nutch-site.xml as a number of seconds.  Nutch won't re-fetch a url before that time expires.  By default, Nutch sets this to 30 days.  This setup script drops it to 30 seconds for testing purposes.  Below is an example of a setting for 1 day.

    <property>
      <name>db.fetch.interval.default</name>
      <value>86000</value>
      <description>The default number of seconds between re-fetches of a page.  86400 is 1 day.
      </description>
    </property>

By default, the crawl runs for 3 passes.  Change the line at the bottom of /mnt/install_files/crawlsites.sh

### To run a search:
Configure which URLs to crawl using /opt/nutch/urls/seed.txt and /opt/nutch/conf/regex-urlfilter.txt
Run the script located at /mnt/install_files/crawlsites.sh

### NOTES
This machine needs port 80/443 access to the target machine in order to crawl it.  If there is a host name without DNS, the appropriate entry must be made in /etc/hosts.