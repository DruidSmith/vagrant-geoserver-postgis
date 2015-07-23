# Install PostGIS
echo *** Installing PostGIS ***
	sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt trusty-pgdg main" >> /etc/apt/sources.list'
	wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
	sudo apt-add-repository -y ppa:georepublic/pgrouting
    sudo apt-get update
	sudo apt-get install -y postgresql-9.4-postgis-2.1 pgadmin3 postgresql-contrib
# Enable Adminpack
#	sudo -u postgres psql
#	CREATE EXTENSION adminpack;
#	service postgresql restart 
#	SELECT pg_reload_conf();
#	SELECT name, setting FROM pg_settings where category='File Locations';
#	\q
#	sudo su - postgres
# Create user - note change it from postgisuser	
#	createuser -d -E -i -l -P -r -s postgisuser
#	echo "default postgres user <postgisuser> created - please change"

# Install pgRouting package (for Ubuntu 14.04)
# sudo apt-get install postgresql-9.4-pgrouting
echo ' '
echo --- PostGIS Installed - note there will be post-configuration steps needed ---

# Install JRE for GeoServer
echo ' '
echo --- Installing JRE ---
sudo apt-get install -y default-jre

# Config JRE
JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
export JAVA_HOME

echo ' '
echo --- Installing unzip ---

# Install unzip
sudo apt-get install -y unzip

echo ' '
echo --- Setting Up for GeoServer ---
echo "export GEOSERVER_HOME=/usr/local/geoserver/" >> ~/.profile
. ~/.profile

sudo rm -rf /usr/local/geoserver/

mkdir /usr/local/geoserver/

sudo chown -R vagrant /usr/local/geoserver/

cd /usr/local

echo ' '
echo --- Downloading GeoServer package - please wait ---

wget -nv -O tmp.zip http://sourceforge.net/projects/geoserver/files/GeoServer/2.7.1.1/geoserver-2.7.1.1-bin.zip && unzip tmp.zip -d /usr/local/ && rm tmp.zip

echo ' '
echo --- Package unzipped - configuring GeoServer directory ---
cp -r /usr/local/geoserver-2.7.1.1/* /usr/local/geoserver && sudo rm -rf /usr/local/geoserver-2.7.1.1/

echo ' '
echo --- GeoServer Installed ---

echo ' '
echo --- Getting ready to run GeoServer ---

sudo chown -R vagrant /usr/local/geoserver/

cd /usr/local/geoserver/bin

# Geoserver configuration - use /etc/default/geoserver to override these vars
# user that shall run GeoServer
USER=geoserver
GEOSERVER_DATA_DIR=/home/$USER/data_dir
#GEOSERVER_HOME=/home/$USER/geoserver
GEOSERVER_HOME=/usr/local/geoserver/

PATH=/usr/sbin:/usr/bin:/sbin:/bin
DESC="GeoServer daemon"
NAME=geoserver
JAVA_OPTS="-Xms128m -Xmx512m"
DAEMON="$JAVA_HOME/bin/java"
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

DAEMON_ARGS="$JAVA_OPTS $DEBUG_OPTS -DGEOSERVER_DATA_DIR=$GEOSERVER_DATA_DIR -Djava.awt.headless=true -jar start.jar"

# Load the VERBOSE setting and other rcS variables
[ -f /etc/default/rcS ] && . /etc/default/rcS

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

echo ' '
echo --- Launching GeoServer startup script ---
echo --- This will run in the background with nohup mode ---
echo --- To access the server, use vagrant ssh ---
echo --- To view the web client go to http://localhost:8080/geoserver ---
echo ' '

# run startup script and have it run in the background - output logged to nohup.out

sh /usr/local/geoserver/bin/startup.sh 0<&- &>/dev/null &
